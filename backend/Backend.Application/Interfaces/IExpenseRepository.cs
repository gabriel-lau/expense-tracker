using Backend.Domain.Models;

namespace Backend.Application.Interfaces;

public interface IExpenseRepository
{
        Task<List<Expense>> GetAllExpenses();
        Task<Expense> CreateExpense(Expense expense);
        Task<bool> UpdateExpense(Expense expense);
        Task<bool> DeleteExpense(Guid id);
}
