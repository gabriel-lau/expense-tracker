using System.ComponentModel.DataAnnotations;
using backend.Validation;

namespace backend.Models
{
    public class Expense
    {
        [Key]
        public Guid Id { get; set; }
        [Required]
        public string Description { get; set; }
        [Required]
        [Range(0, (double)decimal.MaxValue, ErrorMessage = "Amount must be a positive value.")]
        public decimal Amount { get; set; }
        [Required]
        [UTCFormat(ErrorMessage = "Date must be in UTC format.")]
        public DateTime Date { get; set; }
    }
}
