using System;
using System.Collections.Generic;
using System.ComponentModel.DataAnnotations;
using System.ComponentModel.DataAnnotations.Schema;

namespace scheduleNEO.Models
{
    public class Neo : BaseEntity
    {
        public int Id {get; set;}

        public DateTime Date {get; set;}

        public int Incompletes {get; set;}

        public int NoShows {get; set;}

        public List<Completers> Completers {get; set;}

        public Neo()
        {
            Completers = new List<Completers>();
        }

        [DatabaseGenerated(DatabaseGeneratedOption.Computed)]
        public DateTime CreatedAt { get; set; }

        [DatabaseGenerated(DatabaseGeneratedOption.Computed)]
        public DateTime UpdatedAt { get; set; }

    }
}