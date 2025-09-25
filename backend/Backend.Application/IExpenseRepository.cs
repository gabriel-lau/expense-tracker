using Backend.Domain;

namespace Backend.Application;

public interface IExpenseRepository
{
        Task<List<Expense>> GetAllExpenses();
        Task<Expense?> GetExpenseById(Guid id);
        Task<Expense> CreateExpense(Expense expense);
        Task<bool> UpdateExpense(Expense expense);
        Task<bool> DeleteExpense(Guid id);
}
