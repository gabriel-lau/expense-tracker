using System;
using Backend.Domain;

namespace Backend.Application;

public interface IExpenseService
{
        Task<List<Expense>> GetAllExpenses();
}
