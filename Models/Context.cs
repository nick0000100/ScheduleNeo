using Microsoft.EntityFrameworkCore;
 
namespace scheduleNEO.Models
{
    public class ScheduleContext : DbContext
    {
        public ScheduleContext(DbContextOptions<ScheduleContext> options) : base(options) { }

        public DbSet<User> Users {get;set;}

        public DbSet<Employee> Employees {get;set;}

        public DbSet<Neo> Neos {get;set;}

        public DbSet<Completers> Completers {get;set;}

    }
}