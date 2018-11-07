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
    public class EmployeeController : Controller
    {

        // Allows access to db
        private ScheduleContext _context;

        public EmployeeController(ScheduleContext context)
        {
            _context = context;
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

        [HttpGet]
        [Route("employeeList")]
        public IActionResult EmployeeList()
        {
            List<Employee> Employees = _context.Employees.ToList();
            ViewBag.Employees = Employees;
            return View("EmployeeList");
        }

        [HttpPost]
        [Route("update")]
        public IActionResult Update(int Id)
        {
            Employee employee = _context.Employees.Where(e => e.Id == Id).SingleOrDefault();

            employee.TimesAttended++;
            employee.LastAttended = DateTime.Today;
            _context.SaveChanges();


            return RedirectToAction("EmployeeList");
        }
    }
}