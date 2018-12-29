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
    public class ScheduleController : Controller
    {

        // Allows access to db
        private ScheduleContext _context;

        public ScheduleController(ScheduleContext context)
        {
            _context = context;
        }


        [HttpGet]
        [Route("schedule")]
        public IActionResult Schedule()
        {
            return View();
        }

        [HttpPost]
        [Route("calculate")]
        public IActionResult Calculate(int attendees, DateTime NEODate)
        {
            // Gets the amount of completers needed
            int NeededCompleters = attendees / 18;

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

                Attending.AddRange(CheckWho(CelaVendors, NeededCompleters - Attending.Count, NEODate));

                // Invite CELA if need more people
                if(NeededCompleters >= Attending.Count)
                {
                    List<Employee> Cela = _context.Employees.Where(e => e.IsCela != 0)
                                                        .OrderByDescending(e=> e.TimesAttended)
                                                        .ToList();

                    Attending.AddRange(CheckWho(Cela, NeededCompleters - Attending.Count, NEODate));
                }
            }
            ViewBag.attendees = Attending;
            return View("Attending");
        }

        // Adds CELAs more people if Robert Half is not enough
        public List<Employee> CheckWho(List<Employee> EmployeeList, int NeededCompleters, DateTime NEODate)
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
    }
}