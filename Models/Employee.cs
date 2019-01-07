using System;
using System.Collections.Generic;
using System.ComponentModel.DataAnnotations;
using System.ComponentModel.DataAnnotations.Schema;

namespace scheduleNEO.Models
{
    public class Employee : IComparable<Employee>
    {
        public int Id {get; set;}

        public string FirstName {get; set;}

        public string LastName {get; set;}

        public string Alias {get; set;}

        public int TimesAttended {get; set;}

        public int IsCela {get; set;}

        public int IsCelaVendor {get; set;}

        public int IsRobertHalf {get; set;}

        public int Skipped {get; set;}

        public int OOF {get; set;}

        public List<Completer> Completers {get; set;}

        public Employee()
        {
            Completers = new List<Completer>();
        }

        public DateTime LastAttended { get; set; }
        
        public DateTime TimeShowedUp { get; set; }

        [DatabaseGenerated(DatabaseGeneratedOption.Computed)]
        public DateTime CreatedAt { get; set; }

        [DatabaseGenerated(DatabaseGeneratedOption.Computed)]
        public DateTime UpdatedAt { get; set; }

        public int CompareTo(Employee other)
        {
            if(this.TimesAttended == other.TimesAttended)
            {
                // Earlier -> same -> later
                if(DateTime.Compare(this.LastAttended, other.LastAttended) < 0)
                {
                    return -1;
                }
                else if(DateTime.Compare(this.LastAttended, other.LastAttended) == 0)
                {
                    return 0;
                }else
                {
                    return 1;
                }
            }else if(this.TimesAttended < other.TimesAttended)
            {
                return -1;
            }
            else {
                return 1;
            }
        }

    }
}