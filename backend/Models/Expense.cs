using System.ComponentModel.DataAnnotations;

namespace backend.Models
{
    public class Expense
    {
        [Key]
        public Guid Id { get; set; }
        public string Description { get; set; }
        public decimal Amount { get; set; }
        public DateTime Date { get; set; }
    }
}
