using System.ComponentModel.DataAnnotations;
using Backend.Application.Validation;

namespace Backend.Application.DTOs;

public class CreateExpenseDto
{
    [Required]
    public string Description { get; set; } = string.Empty;

    [Required]
    [Range(0, (double)decimal.MaxValue, ErrorMessage = "Amount must be a positive value.")]
    public decimal Amount { get; set; }

    [Required]
    [UTCFormat(ErrorMessage = "Date must be in UTC format.")]
    [DateRange(ErrorMessage = "Date must be within one year from today.")]
    public DateTime Date { get; set; }
}
