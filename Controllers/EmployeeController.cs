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
        public IActionResult addEmployee(RegisterEmployeeModel NewEmployee, string Organization)
        {
            if(ModelState.IsValid)
            {
                // Check to see if there is an employee with the existing alias
                var existing = _context.Employees.Where(e => e.Alias == NewEmployee.Alias).SingleOrDefault();

                if(existing == null) {

                    int CelaCheck = 0;
                    int CelaVendorCheck = 0;
                    int RobertHalfCheck = 0;
                    
                    // Assigned Organization to new employee
                    if(Organization == "Attorney" || Organization == "Immigration Specialist" || Organization == "Immigration Specialist")
                    {
                        CelaCheck = 1;
                    }else if(Organization == "CELA Vendor")
                    {
                        CelaVendorCheck = 1;
                    }else {
                        RobertHalfCheck = 1;
                    }

                    // Assigns job title to new employee if they are CELA FTE
                    int RoleCheck = 0;
                    if(CelaCheck == 1)
                    {
                        if(Organization == "Attorney")
                        {
                            RoleCheck = 2;
                        }
                        else if(Organization == "Immigration Specialist")
                        {
                            RoleCheck = 1;
                        }
                    }
                    Employee NewE = new Employee
                    {
                        FirstName = NewEmployee.FirstName,
                        LastName = NewEmployee.LastName,
                        Alias = NewEmployee.Alias,
                        IsCela = CelaCheck,
                        IsCelaVendor = CelaVendorCheck,
                        Role = RoleCheck,
                        IsRobertHalf = RobertHalfCheck
                    };

                    // Addes new employee to db
                    _context.Employees.Add(NewE);
                    _context.SaveChanges();
                    TempData["Success"]= "Employee Added";

                }else {
                    TempData["Error"] = "An employee with the same alias already exists.";
                }
            }
            // ModelState.Clear();
            return View("NewEmployee");
        }

        [HttpGet]
        [Route("employeeList")]
        public IActionResult EmployeeList()
        {
            List<Employee> Employees = _context.Employees.OrderBy(e => e.FirstName).Include(e => e.Completers).ThenInclude(c => c.Neo).ToList();
            ViewBag.Employees = Employees;
            return View("EmployeeList");
        }

        // Never used
        [HttpPost]
        [Route("Attended")]
        public IActionResult Attended(int Id)
        {
            Employee employee = _context.Employees.Where(e => e.Id == Id).SingleOrDefault();

            employee.TimesAttended++;
            employee.Skipped = 0;
            employee.LastAttended = DateTime.Today;
            _context.SaveChanges();

            return RedirectToAction("EmployeeList");
        }

        [HttpGet]
        [Route("employee/{Id}")]
        public IActionResult EmployeePage(int Id)
        {
            Employee Employee = _context.Employees.Where(e => e.Id == Id)
                                                    .Include(e => e.Completers)
                                                        .ThenInclude(c => c.Neo)
                                                    .SingleOrDefault();
            ViewBag.Attened = Employee.Completers.Where(c => c.Attended == 1).Count();
            ViewBag.Employee = Employee;

            ViewBag.Notes = _context.Notes.Where(n => n.EmployeeId == Id).ToList();
            return View();
        }

        [HttpPost]
        [Route("OOF")]
        public IActionResult OOF(int Id)
        {
            Employee employee = _context.Employees.Where(e => e.Id == Id).SingleOrDefault();
            if(employee.OOF == 1)
            {
                employee.OOF = 0;
            }else{
                employee.OOF = 1;
            }
            _context.SaveChanges();

            return RedirectToAction("EmployeeList");
        }

        // Never used
        [HttpPost]
        [Route("Skipped")]
        public IActionResult Skipped(int Id)
        {
            Employee employee = _context.Employees.Where(e => e.Id == Id).SingleOrDefault();
            if(employee.Skipped == 1)
            {
                employee.Skipped = 0;
            }else{
                employee.Skipped = 1;
            }
            _context.SaveChanges();

            return RedirectToAction("EmployeeList");
        }

        [HttpPost]
        [Route("deleteEmployee/{Id}")]
        public IActionResult Delete(int Id)
        {
            Employee employee = _context.Employees.Where(e => e.Id == Id).SingleOrDefault();
            _context.Employees.Remove(employee);
            _context.SaveChanges();

            return RedirectToAction("EmployeeList");
        }
    }
}