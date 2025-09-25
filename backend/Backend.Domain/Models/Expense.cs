using System.ComponentModel.DataAnnotations;
namespace Backend.Domain.Models;

public class Expense
{
    [Key]
    public Guid Id { get; set; }
    [Required]
    public string Description { get; set; }
    [Required]
    public decimal Amount { get; set; }
    [Required]
    public DateTime Date { get; set; } 
}

