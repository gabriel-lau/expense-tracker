using Backend.Domain;

namespace Backend.Application;

public interface IExpenseRepository
{
        List<Expense> GetAllExpenses();
}
