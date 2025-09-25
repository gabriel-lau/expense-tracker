using System;
using Backend.Application;
using Backend.Domain.Models;

namespace Backend.Infrastructure;

public class ExpenseListRepository : IExpenseRepository
{
    public static List<Expense> expensesList = new List<Expense>()
        {
           new Expense{  Id = Guid.NewGuid(), Description= "Office Supplies", Amount= 100.00M, Date= DateTime.Now},
           new Expense{  Id = Guid.NewGuid(), Description= "Travel", Amount= 500.00M, Date= DateTime.Now},
           new Expense{  Id = Guid.NewGuid(), Description= "Meals", Amount= 200.00M, Date= DateTime.Now},
           new Expense{  Id = Guid.NewGuid(), Description= "Utilities", Amount= 300.00M, Date= DateTime.Now}
        };
    public Task<List<Expense>> GetAllExpenses()
    {
        return Task.FromResult(expensesList);
    }

    public Task<Expense> CreateExpense(Expense expense)
    {
        expense.Id = Guid.NewGuid();
        expensesList.Add(expense);
        return Task.FromResult(expense);
    }
    public Task<bool> UpdateExpense(Expense expense)
    {
        var existingExpense = expensesList.FirstOrDefault(e => e.Id == expense.Id);
        if (existingExpense == null)
            return Task.FromResult(false);

        existingExpense.Description = expense.Description;
        existingExpense.Amount = expense.Amount;
        existingExpense.Date = expense.Date;
        return Task.FromResult(true);
    }
    public Task<bool> DeleteExpense(Guid id)
    {
        var expense = expensesList.FirstOrDefault(e => e.Id == id);
        if (expense == null)
            return Task.FromResult(false);

        expensesList.Remove(expense);
        return Task.FromResult(true);
    }
}
