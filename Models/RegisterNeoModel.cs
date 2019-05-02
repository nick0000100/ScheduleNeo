using System;
using System.Collections.Generic;
using System.ComponentModel.DataAnnotations;

namespace scheduleNEO.Models
{
    public class RegisterNeoModel : BaseEntity
    {
        [Required(ErrorMessage = "Number of Attendees is required")]
        [Range(1, int.MaxValue, ErrorMessage = "Attendees must be a positive number.")]
        [Display(Name="Number of Attendees")]
        public int? Attendees {get;set;}
        
        [Required(ErrorMessage = "Date is required")]
        [DataType(DataType.Date)]
        [Display(Name="Date of NEO")]
        public DateTime? Date {get;set;}

        public List<int> PreInvited {get; set;}
    }
}