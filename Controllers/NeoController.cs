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

    }
}
