using System;
using Backend.Domain;

namespace Backend.Application;

public interface IExpenseService
{
        List<Expense> GetAllExpenses();
}
