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
    public class UserController : Controller
    {

        // Allows access to db
        private ScheduleContext _context;

        public UserController(ScheduleContext context)
        {
            _context = context;
        }


        // Displays home page
        [HttpGet]
        [Route("")]
        public IActionResult Index()
        {
            return View();
        }

        // Registers a new user
        [HttpPost]
        [Route("Register")]
        public IActionResult Register(RegisterUserModel newUser, string AdminCode)
        {
            if(ModelState.IsValid)
            {
                // Check to see if there is a user with the existing username
                var existing = _context.Users.Where(u => u.Username == newUser.Username).SingleOrDefault();

                if(existing == null) {
                    // Checks to see if admin code is correct
                    int AdminCheck;
                    if(AdminCode == "Admin") 
                    {
                        AdminCheck = 1;
                    }else if(AdminCode == null)
                    {
                        AdminCheck = 0;
                    }
                    else
                    {
                        TempData["Error"] = "Admin code incorrect, account not created.";
                        return View("Index");
                    }

                    User NewU = new User
                    {
                        FirstName = newUser.FirstName,
                        LastName = newUser.LastName,
                        Username = newUser.Username,
                        Password = newUser.Password,
                        Admin = AdminCheck
                    };

                    // Hashes pw
                    PasswordHasher<User> Hasher = new PasswordHasher<User>();
                    NewU.Password = Hasher.HashPassword(NewU, NewU.Password);

                    // Addes new user to db
                    _context.Users.Add(NewU);
                    _context.SaveChanges();

                    // Sets the current user as logged in
                    int UserId = _context.Users.Last().Id;
                    HttpContext.Session.SetInt32("Id", UserId);

                }else {
                    TempData["Error"] = "A user with that username already exists.";
                }
            }
            ModelState.Clear();
            return View("Index");
        }

        // Logs in a user
        // Redirects to scheduling page if successful
        // Redirects to home page is fails
        [HttpPost]
        [Route("Login")]
        public IActionResult Login(string Username, string Password)
        {
            User user = _context.Users.Where(u => u.Username == Username).SingleOrDefault();
            if(user != null && Password != null)
            {
                var Hasher = new PasswordHasher<User>();
                if(Hasher.VerifyHashedPassword(user, user.Password, Password) != 0)
                {
                    HttpContext.Session.SetInt32("Id", user.Id);
                    return RedirectToAction("schedule", "Schedule");
                }
            }
            TempData["Error"] = "Incorrect login information.";
            ModelState.Clear();
            return RedirectToAction("Index");
        }

        // Logs out a user
        // Brings them to home page
        [HttpGet]
        [Route("Logout")]
        public IActionResult Logout()
        {
            HttpContext.Session.Clear();
            return RedirectToAction("Index");
        }
    }
}
