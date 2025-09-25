using System;
using Backend.Application.DTOs;
using Backend.Domain.Models;

namespace Backend.Application.Interfaces;

public interface IExpenseService
{
        Task<List<ExpenseDto>> GetAllExpenses();
        Task<ExpenseDto> CreateExpense(CreateExpenseDto expense);
        Task<bool> UpdateExpense(UpdateExpenseDto expense);
        Task<bool> DeleteExpense(Guid id);

}
