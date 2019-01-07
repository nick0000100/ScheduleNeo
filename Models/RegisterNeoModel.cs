using System;
using System.Collections.Generic;
using System.ComponentModel.DataAnnotations;

namespace scheduleNEO.Models
{
    public class RegisterNeoModel : BaseEntity
    {
        [Required(ErrorMessage = "Number of Attendees is required")]
        // [RegularExpression(@"^[0-9]*$", ErrorMessage="Only input numbers.")]
        [Display(Name="Number of Attendees")]
        public int? Attendees {get;set;}
        
        [Required(ErrorMessage = "Date is required")]
        [DataType(DataType.Date)]
        [Display(Name="Date of NEO")]
        public DateTime? Date {get;set;}
    }
}