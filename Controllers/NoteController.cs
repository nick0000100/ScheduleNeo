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
    public class NoteController : Controller
    {

        // Allows access to db
        private ScheduleContext _context;

        public NoteController(ScheduleContext context)
        {
            _context = context;
        }

        [HttpPost]
        [Route("addNote/{Id}")]
        public IActionResult AddNote(int Id, string NoteContent)
        {
            Note NewNote = new Note 
            {
                NoteMessage = NoteContent,
                EmployeeId = Id
            };
            _context.Notes.Add(NewNote);
            _context.SaveChanges();

            return RedirectToAction("EmployeePage", "Employee", new {Id = Id});
        }

        [HttpPost]
        [Route("DeleteNote/{Id}")]
        public IActionResult DeleteNote(int NoteId, int EmployeeId)
        {
            Note Note = _context.Notes.Where(n => n.Id == NoteId).SingleOrDefault();
            _context.Notes.Remove(Note);
            _context.SaveChanges();

            return RedirectToAction("EmployeePage", "Employee", new {Id = EmployeeId});
        }
    }
}