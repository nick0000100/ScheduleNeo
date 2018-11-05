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
        public IActionResult Schedule(int attendees)
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

        [HttpGet]
        [Route("newEmployee")]
        public IActionResult newEmployee()
        {
            //check if person has admin status
            return View("NewEmployee");
        }

        [HttpPost]
        [Route("addEmployee")]
        public IActionResult addEmployee(RegisterEmployeeModel NewEmployee, string Cela)
        {
            if(ModelState.IsValid)
            {
                // Check to see if there is an employee with the existing alias
                var existing = _context.Employees.Where(e => e.Alias == NewEmployee.Alias).SingleOrDefault();

                if(existing == null) {

                    int CelaCheck = 0;
                    if(Cela == "checked")
                    {
                        CelaCheck = 1;
                    }
                    
                    Employee NewE = new Employee
                    {
                        FirstName = NewEmployee.FirstName,
                        LastName = NewEmployee.LastName,
                        Alias = NewEmployee.Alias,
                        IsCela = CelaCheck
                    };

                    // Addes new employee to db
                    _context.Employees.Add(NewE);
                    _context.SaveChanges();
                    TempData["Success"]= "Employee Added";

                }else {
                    TempData["Error"] = "An employee with the same alias already exists.";
                }
            }
            return View("NewEmployee");
        }

    }
}
//grab all venders
//do checks