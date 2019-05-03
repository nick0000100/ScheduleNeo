using System;
using System.Collections.Generic;
using System.Threading.Tasks;
using Microsoft.AspNetCore.Mvc;
using Microsoft.AspNetCore.Http;
using System.Linq;
using scheduleNEO.Models;
using Microsoft.EntityFrameworkCore;
using Microsoft.AspNetCore.Identity;

namespace scheduleNEO.Controllers
{
    public class NeoController : Controller
    {

        // Allows access to db
        private ScheduleContext _context;

        public NeoController(ScheduleContext context)
        {
            _context = context;
        }

        // Shows page for creating a new NEO.
        [HttpGet]
        [Route("schedule")]
        public IActionResult Schedule()
        {
            if(!CheckAdmin())
            {
                TempData["AccessError"] = "Your account does not have the neccessary credentials to access that page.";
                return RedirectToAction("showNeos");
            }

            // Gets list of people not invited -- Could probably do this with the list of compelters taken from Neo object.
            List<Employee> Volunteers = _context.Employees.OrderBy(e => e.FirstName)
                                                            .Where(e => e.IsOther == 1)
                                                            .ToList();

            ViewBag.Volunteers = Volunteers;

            return View("NewNeo");
        }

        [HttpGet]
        [Route("allNeos")]
        public IActionResult showNeos()
        {
            List<Neo> Neos = _context.Neos.OrderBy(n => n.Date)
                                            .Include(n => n.Completers)
                                            .ToList();
            ViewBag.Neos = Neos;
            ViewBag.Admin = CheckAdmin();
            return View("AllNeos");
        }

        [HttpGet]
        [Route("neos/{Id}")]
        public IActionResult NeoPage(int Id)
        {
            Neo Neo = _context.Neos.Where(n => n.Id == Id)
                                    .Include(n => n.Completers)
                                        .ThenInclude(c => c.Employee)
                                    .SingleOrDefault();
            ViewBag.Neo = Neo;
            
            // Puts all people invited into a list
            List<Employee> Completers = new List<Employee>();
            for(int i = 0; i < Neo.Completers.Count; i++)
            {
                Completers.Add(_context.Employees.Where(e => e.Id == Neo.Completers[i].EmployeeId).SingleOrDefault());
            }

            // Gets list of people not invited -- Could probably do this with the list of compelters taken from Neo object.
            List<Employee> NotInvited = _context.Employees.OrderBy(e => e.FirstName)
                                                            .ToList();
            foreach(Employee EE in Completers)
            {
                if(NotInvited.Contains(EE))
                {
                    NotInvited.Remove(EE);
                }
            }
            ViewBag.NotInvited = NotInvited;
            ViewBag.Admin = CheckAdmin();
            return View();
        }

        // Creates a new NEO and decides who to invite for the NEO
        [HttpPost]
        [Route("calculate")]
        public IActionResult Calculate(int attendees, RegisterNeoModel newNEO)
        {
            if(ModelState.IsValid)
            {
                ViewBag.date = (DateTime)newNEO.Date;

                // Creates a new Neo
                Neo NeoNeo = new Neo
                {
                    Attendees = (int)newNEO.Attendees,
                    Date = (DateTime)newNEO.Date,
                };

                // Addes new NEO to db
                _context.Neos.Add(NeoNeo);
                _context.SaveChanges();

                // Gets the current/just created NEO
                Neo CurrentNeo = _context.Neos.Last();

                // Gets the amount of completers needed
                int NeededCompleters = attendees / 15 + 1 - newNEO.PreInvited.Count;

                List<Employee> Attending = new List<Employee>();

                // Adds the preinvited people to attending list
                foreach(int VolunteerID in newNEO.PreInvited)
                {
                    Attending.Add(_context.Employees.Where(e => e.Id == VolunteerID).SingleOrDefault());
                }

                // Gets all Robert Half members and adds them to the attending list
                Attending.AddRange(_context.Employees.Where(e => e.IsRobertHalf == 1).ToList());

                // If amount of vendors is enough invite them
                if(NeededCompleters <= Attending.Count) 
                {
                    ViewBag.attendees = Attending;
                    CreateAssociation(Attending, CurrentNeo.Id);
                    return RedirectToAction("NeoPage", new {Id = CurrentNeo.Id});
                }
                else
                {
                    // Invite CELA vendors if need more people
                    List<Employee> CelaVendors = _context.Employees.Where(e => e.IsCelaVendor != 0)
                                                            .OrderBy(e => e.LastAttended.Date)
                                                            .ToList();

                    Attending.AddRange(InviteMore(CelaVendors, NeededCompleters - Attending.Count, CurrentNeo.Date));

                    // Invite CELA if need more people
                    if(NeededCompleters >= Attending.Count)
                    {
                        List<Employee> Cela = _context.Employees.Where(e => e.IsCela != 0)
                                                            .OrderBy(e => e.LastAttended.Date)
                                                            .ToList();

                        Attending.AddRange(InviteMore(Cela, NeededCompleters - Attending.Count, CurrentNeo.Date));
                    }

                    // Invite Volunteers if need more people
                    if(NeededCompleters >= Attending.Count)
                    {
                        List<Employee> Volunteers = _context.Employees.Where(e => e.IsOther != 0)
                                                            .OrderBy(e => e.LastAttended.Date)
                                                            .ToList();

                        Attending.AddRange(InviteMore(Volunteers, NeededCompleters - Attending.Count, CurrentNeo.Date));
                    }
                }

                CreateAssociation(Attending, CurrentNeo.Id);
                ViewBag.attendees = Attending;
                return RedirectToAction("NeoPage", new {Id = CurrentNeo.Id});
            }
            return View("NewNeo");
        }

        // Adds more people from specified organization if Robert Half is not enough
        public List<Employee> InviteMore(List<Employee> EmployeeList, int NeededCompleters, DateTime NEODate)
        {
            List<Employee> Attending = new List<Employee>();

            // If OOF remove from list
            for(int i = EmployeeList.Count - 1; i >= 0; i--)
            {
                if(EmployeeList[i].OOF == 1)
                {
                    EmployeeList.RemoveAt(i);
                }
            }
            
            // Adds all of the skippers to attending list until capacity
            Boolean SkipCheck = true;
            while(SkipCheck && (Attending.Count < NeededCompleters))
            {
                SkipCheck = false;
                Employee Skipper = null;
                for(int i = EmployeeList.Count - 1; i >= 0; i--)
                {
                    if(EmployeeList[i].Skipped == 1)
                    {
                        SkipCheck = true;

                        if(Skipper == null)
                        {
                            Skipper = EmployeeList[i];
                        }
                        else
                        {
                            if(EmployeeList[i].CompareTo(Skipper) < 0)
                            {
                                Skipper = EmployeeList[i];
                            }
                        }
                    }
                }
                if(Skipper != null)
                {
                    Attending.Add(Skipper);
                    EmployeeList.Remove(Skipper);
                }
            }

            // Removes people that attended the last NEO to be added to the invitee list if needed later on -- Skip and Take not working as intended
            List<Neo> AllNeos = _context.Neos.OrderBy(n => n.Id).ToList();
            List<Employee> AttendedLastNeo = new List<Employee>();

            if(AllNeos.Count >= 2)
            {
                Neo LastNeo = AllNeos[AllNeos.Count - 2];

                for(int i = EmployeeList.Count - 1; i >= 0; i--)
                {
                    if(EmployeeList[i].LastAttended.Date == LastNeo.Date.Date)
                    {
                        AttendedLastNeo.Add(EmployeeList[i]);
                        EmployeeList.RemoveAt(i);
                    }
                }
            }

            // Adds remaining needed members based on times they have gone
            while(Attending.Count < NeededCompleters && EmployeeList.Count > 0)
            {
                Employee MinAttended = EmployeeList[EmployeeList.Count - 1];
                for(int i = EmployeeList.Count - 1; i >= 0; i--)
                {
                    if(EmployeeList[i].CompareTo(MinAttended) < 0)
                    {
                        MinAttended = EmployeeList[i];
                    }
                }
                Attending.Add(MinAttended);
                EmployeeList.Remove(MinAttended);
            }

            // Adds all of the people who attended last week
            while(Attending.Count < NeededCompleters && AttendedLastNeo.Count > 0)
            {
                Employee MinAttended = AttendedLastNeo[AttendedLastNeo.Count - 1];
                for(int i = AttendedLastNeo.Count - 1; i >= 0; i--)
                {
                    if(AttendedLastNeo[i].CompareTo(MinAttended) < 0)
                    {
                        MinAttended = AttendedLastNeo[i];
                    }
                }
                Attending.Add(MinAttended);
                AttendedLastNeo.Remove(MinAttended);
            }
            return Attending;
        }

        // Creates association between attending employees and NEO.
        public void CreateAssociation(List<Employee> EmployeeList, int NeoId)
        {
            foreach(Employee EE in EmployeeList)
            {
                Completer NewCompleter = new Completer
                {
                    NeoId = NeoId,
                    EmployeeId = EE.Id
                };
                _context.Completers.Add(NewCompleter);
                _context.SaveChanges();
            }
        }

        // Marks that the employee has attended
        [HttpPost]
        [Route("Attended/{NeoId}")]
        public IActionResult Attended(int Id, int NeoId)
        {
            Employee employee = _context.Employees.Where(e => e.Id == Id).SingleOrDefault();

            employee.TimesAttended++;
            employee.Skipped = 0;
            employee.LastAttended = DateTime.Today;

            Completer completer = _context.Completers.Where(c => c.EmployeeId == Id && c.NeoId == NeoId).SingleOrDefault();
            completer.AttendedTime = DateTime.Now;
            completer.Attended = 1;

            _context.SaveChanges();

            return RedirectToAction("NeoPage", new {Id = NeoId});
        }

        // Marks that the employee is oof
        [HttpPost]
        [Route("OOF/{NeoId}")]
        public IActionResult OOF(int Id, int NeoId)
        {
            Employee employee = _context.Employees.Where(e => e.Id == Id).SingleOrDefault();
            if(employee.OOF == 1)
            {
                employee.OOF = 0;
            }else{
                employee.OOF = 1;
            }
            _context.SaveChanges();

            return RedirectToAction("NeoPage", new {Id = NeoId});
        }

        // Marks that the employee skipped.
        [HttpPost]
        [Route("Skipped/{NeoId}")]
        public IActionResult Skipped(int Id, int NeoId, int CompleterId)
        {
            Employee employee = _context.Employees.Where(e => e.Id == Id).SingleOrDefault();
            if(employee.Skipped == 1)
            {
                employee.Skipped = 0;
            }else{
                employee.Skipped = 1;
            }
            _context.SaveChanges();
            ResetAttendedNeo(Id, NeoId, CompleterId);

            return RedirectToAction("NeoPage", new {Id = NeoId});
        }

        // Uninvites an employee
        [HttpPost]
        [Route("Uninvite/{NeoId}")]
        public IActionResult Uninvite(int Id, int NeoId, int CompleterId)
        {
            ResetAttendedNeo(Id, NeoId, CompleterId);
            Completer completer = _context.Completers.Where(c => c.EmployeeId == Id && c.NeoId == NeoId).SingleOrDefault();
            _context.Completers.Remove(completer);
            _context.SaveChanges();

            return RedirectToAction("NeoPage", new {Id = NeoId});
        }

        // Updates total number of new employees
        [HttpPost]
        [Route("updateAttendees/{NeoId}")]
        public IActionResult updateAttendees(int attendees, int NeoId)
        {
            Neo Neo = _context.Neos.Where(n => n.Id == NeoId).SingleOrDefault();
            Neo.Attendees = attendees;
            _context.SaveChanges();
            return RedirectToAction("NeoPage", new {Id = NeoId});
        }

        // Updates total incompletes
        [HttpPost]
        [Route("updateIncompletes/{NeoId}")]
        public IActionResult updateIncompletes(int incompletes, int NeoId)
        {
            Neo Neo = _context.Neos.Where(n => n.Id == NeoId).SingleOrDefault();
            Neo.Incompletes = incompletes;
            _context.SaveChanges();
            return RedirectToAction("NeoPage", new {Id = NeoId});
        }

        // Updates no shows
        [HttpPost]
        [Route("updateNoShows/{NeoId}")]
        public IActionResult updateNoShows(int noShows, int NeoId)
        {
            Neo Neo = _context.Neos.Where(n => n.Id == NeoId).SingleOrDefault();
            Neo.NoShows = noShows;
            _context.SaveChanges();
            return RedirectToAction("NeoPage", new {Id = NeoId});
        }

        [HttpPost]
        [Route("inviteMore/{NeoId}")]
        public IActionResult inviteMore(int Id, int NeoId)
        {
            Employee NewInvited = _context.Employees.Where(e => e.Id == Id).SingleOrDefault();
            Completer NewCompleter = new Completer
            {
                NeoId = NeoId,
                EmployeeId = NewInvited.Id
            };
            _context.Completers.Add(NewCompleter);
            _context.SaveChanges();
            return RedirectToAction("NeoPage", new {Id = NeoId});
        }

        // Deletes a NEO
        [HttpPost]
        [Route("Delete/{Id}")]
        public IActionResult Delete(int Id)
        {
            Neo Neo = _context.Neos.Where(n => n.Id == Id).SingleOrDefault();
            _context.Neos.Remove(Neo);
            _context.SaveChanges();
            return RedirectToAction("showNeos");
        }

        // Resets time showed up and times attended
        public void ResetAttendedNeo(int EmployeeId, int NeoId, int CompleterId)
        {
            Employee employee = _context.Employees.Where(e => e.Id == EmployeeId).SingleOrDefault();
            Completer completer = _context.Completers.Where(c => c.Id == CompleterId).SingleOrDefault();
            if(completer.AttendedTime.TimeOfDay != TimeSpan.Zero)
            {
                employee.TimesAttended--;
                completer.Attended = 0;
                completer.AttendedTime = default(DateTime);
            }
            _context.SaveChanges();
        }

        // Checks to see if the person logged in is as an Admin
        public Boolean CheckAdmin()
        {
            int? Id = HttpContext.Session.GetInt32("Id");
            User user = _context.Users.Where(u => u.Id == Id).SingleOrDefault();
            return (Id != null && user.Admin == 1);
        }

    }
}