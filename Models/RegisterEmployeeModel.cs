using System;
using System.Collections.Generic;
using System.ComponentModel.DataAnnotations;

namespace scheduleNEO.Models
{
    public class RegisterEmployeeModel : BaseEntity
    {
        [Required]
        [MinLength(2)]
        [RegularExpression(@"^[A-Za-z0-9\s-]+$", ErrorMessage="No special characters.")]
        [Display(Name="First Name")]
        public string FirstName {get;set;}
        
        [Required]
        [MinLength(2)]
        [RegularExpression(@"^[A-Za-z0-9\s-]+$", ErrorMessage="No special characters.")]
        [Display(Name="Last Name")]
        public string LastName {get;set;}

        [Required]
        [Display(Name="Alias")]
        public string Alias {get; set;}
        
        [Required]
        [Display(Name="Organization")]
        public string Organization {get; set;}

    }
}