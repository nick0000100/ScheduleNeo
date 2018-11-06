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
        public IActionResult calculate(int attendees)
        {
            // Gets the amount of completers needed
            int neededCompleters = attendees / 18;

            List<Employee> attending = new List<Employee>();

            // Gets all vendors and adds them to the attending list
            attending.AddRange(_context.Employees.Where(e => e.IsCela == 0).ToList());

            if(neededCompleters <= attending.Count) 
            {
                ViewBag.attendees = attending;
                return View("Attending");
            }else
            {
                List<Employee> CELA = _context.Employees.Where(e => e.IsCela != 0)
                                                        .OrderBy(e=> e.TimesAttended)
                                                        .ThenBy(e => e.LastAttended)
                                                        .ToList();
            }
            return View("Attending");
        }

    }
}
//grab all venders
//do checks