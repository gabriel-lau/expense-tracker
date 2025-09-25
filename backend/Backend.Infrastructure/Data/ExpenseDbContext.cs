using Microsoft.EntityFrameworkCore;
using Backend.Domain.Models;

namespace Backend.Infrastructure.Data
{
    public class ExpenseDbContext : DbContext
    {
        public ExpenseDbContext(DbContextOptions<ExpenseDbContext> options) : base(options) { }

        public DbSet<Expense> Expenses { get; set; }

        protected override void OnModelCreating(ModelBuilder modelBuilder)
        {
            modelBuilder.Entity<Expense>(entity =>
            {
                entity.HasKey(e => e.Id);
                entity.Property(e => e.Description).IsRequired().HasMaxLength(500);
                entity.Property(e => e.Amount).IsRequired().HasColumnType("decimal(18,2)");
                entity.Property(e => e.Date).IsRequired();
            });
        }
    }
}