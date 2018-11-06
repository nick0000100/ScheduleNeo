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
        public IActionResult calculate(int attendees, DateTime NEODate)
        {
            // Gets the amount of completers needed
            int NeededCompleters = attendees / 18;

            List<Employee> Attending = new List<Employee>();

            // Gets all vendors and adds them to the attending list
            Attending.AddRange(_context.Employees.Where(e => e.IsCela == 0).ToList());

            // If amount of vendors is enough just invite them
            if(NeededCompleters <= Attending.Count) 
            {
                ViewBag.attendees = Attending;
                return View("Attending");
            }
            // Invite CELA if need more people
            else
            {
                List<Employee> CELA = _context.Employees.Where(e => e.IsCela != 0)
                                                        .OrderByDescending(e=> e.TimesAttended)
                                                        .ToList();

                // If OOF remove from list
                for(int i = CELA.Count - 1; i >= 0; i--)
                {
                    if(CELA[i].OOF == 1)
                    {
                        CELA.RemoveAt(i);
                    }
                }
                
                // Adds all of the skippers to attending list until capacity
                Boolean SkipCheck = true;
                while(SkipCheck && (Attending.Count < NeededCompleters))
                {
                    SkipCheck = false;
                    Employee Skipper = null;
                    for(int i = CELA.Count - 1; i >= 0; i--)
                    {
                        if(CELA[i].Skipped == 1)
                        {
                            SkipCheck = true;

                            if(Skipper == null)
                            {
                                Skipper = CELA[i];
                            }
                            else
                            {
                                if(CELA[i].CompareTo(Skipper) < 0)
                                {
                                    Skipper = CELA[i];
                                }
                            }
                        }
                    }
                    if(Skipper != null)
                    {
                        Attending.Add(Skipper);
                        CELA.Remove(Skipper);
                    }
                }
                // Adds remaining needed members based on times they have gone
                while(Attending.Count < NeededCompleters && CELA.Count > 0)
                {
                    Employee MinAttended = CELA[0];
                    for(int i = CELA.Count - 1; i >= 0; i--)
                    {
                        if(CELA[i].CompareTo(MinAttended) < 0 && CELA[i].LastAttended >= DateTime.Today.AddDays(-8))
                        {
                            MinAttended = CELA[i];
                        }
                    }
                    Attending.Add(MinAttended);
                    CELA.Remove(MinAttended);
                }

            }
            ViewBag.attendees = Attending;
            return View("Attending");
        }

    }
}