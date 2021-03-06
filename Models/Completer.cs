using System;
using System.Collections.Generic;
using System.ComponentModel.DataAnnotations;
using System.ComponentModel.DataAnnotations.Schema;

namespace scheduleNEO.Models
{
    public class Completer : BaseEntity
    {
        public int Id {get; set;}

        public int NeoId {get; set;}
        public Neo Neo {get; set;}

        public int EmployeeId {get; set;}
        public Employee Employee {get; set;}

        public DateTime AttendedTime {get; set;}

        public int Attended {get; set;}
    }
}