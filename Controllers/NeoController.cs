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

        [HttpGet]
        [Route("schedule")]
        public IActionResult Schedule()
        {
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
            
            // Puts all people invited into a list (Don't know why I can't access it from Neo in the view)
            List<Employee> Completers = new List<Employee>();
            for(int i = 0; i < Neo.Completers.Count; i++)
            {
                Completers.Add(_context.Employees.Where(e => e.Id == Neo.Completers[i].EmployeeId).SingleOrDefault());
            }
            ViewBag.Completers = Completers;
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
                int NeededCompleters = attendees / 15 + 1;

                List<Employee> Attending = new List<Employee>();

                // Gets all Robert Half members and adds them to the attending list
                Attending.AddRange(_context.Employees.Where(e => e.IsRobertHalf == 1).ToList());

                // If amount of vendors is enough invite them
                if(NeededCompleters <= Attending.Count) 
                {
                    ViewBag.attendees = Attending;
                    return View("Attending");
                }
                // Invite CELA vendors if need more people
                else
                {
                    List<Employee> CelaVendors = _context.Employees.Where(e => e.IsCelaVendor != 0)
                                                            .OrderByDescending(e=> e.TimesAttended)
                                                            .ToList();

                    Attending.AddRange(InviteMore(CelaVendors, NeededCompleters - Attending.Count, CurrentNeo.Date));

                    // Invite CELA if need more people
                    if(NeededCompleters >= Attending.Count)
                    {
                        List<Employee> Cela = _context.Employees.Where(e => e.IsCela != 0)
                                                            .OrderBy(e=> e.Role)
                                                                .ThenByDescending(e => e.TimesAttended)
                                                            .ToList();

                        Attending.AddRange(InviteMore(Cela, NeededCompleters - Attending.Count, CurrentNeo.Date));
                    }
                }

                // Creates association with the employees invited and the current NEO
                foreach(Employee EE in Attending)
                {
                    Completer NewCompleter = new Completer
                    {
                        NeoId = CurrentNeo.Id,
                        EmployeeId = EE.Id
                    };
                    _context.Completers.Add(NewCompleter);
                    _context.SaveChanges();
                }

                ViewBag.attendees = Attending;
                return View("Attending");
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
            // Adds remaining needed members based on times they have gone
            while(Attending.Count < NeededCompleters && EmployeeList.Count > 0)
            {
                Employee MinAttended = EmployeeList[EmployeeList.Count - 1];
                for(int i = EmployeeList.Count - 1; i >= 0; i--)
                {
                    if(EmployeeList[i].CompareTo(MinAttended) < 0 && EmployeeList[i].LastAttended >= NEODate.AddDays(-8))
                    {
                        MinAttended = EmployeeList[i];
                    }
                }
                Attending.Add(MinAttended);
                EmployeeList.Remove(MinAttended);
            }

            return Attending;
        }

        [HttpPost]
        [Route("Attended/{NeoId}")]
        public IActionResult Attended(int Id, int NeoId)
        {
            Employee employee = _context.Employees.Where(e => e.Id == Id).SingleOrDefault();

            employee.TimesAttended++;
            employee.Skipped = 0;
            employee.LastAttended = DateTime.Today;
            _context.SaveChanges();

            return RedirectToAction("NeoPage", new {Id = NeoId});
        }

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

        [HttpPost]
        [Route("Skipped/{NeoId}")]
        public IActionResult Skipped(int Id, int NeoId)
        {
            Employee employee = _context.Employees.Where(e => e.Id == Id).SingleOrDefault();
            if(employee.Skipped == 1)
            {
                employee.Skipped = 0;
            }else{
                employee.Skipped = 1;
            }
            _context.SaveChanges();

            return RedirectToAction("NeoPage", new {Id = NeoId});
        }

        [HttpPost]
        [Route("updateAttendees/{NeoId}")]
        public IActionResult updateAttendees(int attendees, int NeoId)
        {
            Neo Neo = _context.Neos.Where(n => n.Id == NeoId).SingleOrDefault();
            Neo.Attendees = attendees;
            _context.SaveChanges();
            return RedirectToAction("NeoPage", new {Id = NeoId});
        }

        [HttpPost]
        [Route("updateIncompletes/{NeoId}")]
        public IActionResult updateIncompletes(int incompletes, int NeoId)
        {
            Neo Neo = _context.Neos.Where(n => n.Id == NeoId).SingleOrDefault();
            Neo.Incompletes = incompletes;
            _context.SaveChanges();
            return RedirectToAction("NeoPage", new {Id = NeoId});
        }

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
        [Route("Delete/{Id}")]
        public IActionResult Delete(int Id)
        {
            Neo Neo = _context.Neos.Where(n => n.Id == Id).SingleOrDefault();
            _context.Neos.Remove(Neo);
            _context.SaveChanges();
            return RedirectToAction("showNeos");
        }

    }
}
