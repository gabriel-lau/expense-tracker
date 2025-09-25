using System;
using Backend.Domain.Models;

namespace Backend.Application;

public interface IExpenseService
{
        Task<List<Expense>> GetAllExpenses();
        Task<Expense> CreateExpense(Expense expense);
        Task<bool> UpdateExpense(Expense expense);
        Task<bool> DeleteExpense(Guid id);

}
