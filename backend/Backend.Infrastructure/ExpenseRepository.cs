using System;
using Backend.Application;
using Backend.Domain;

namespace Backend.Infrastructure;

public class ExpenseRepository : IExpenseRepository
{
public static List<Expense> expensesList = new List<Expense>()
        {
           new Expense{  Id = Guid.NewGuid(), Description= "Office Supplies", Amount= 100.00M, Date= DateTime.Now},
           new Expense{  Id = Guid.NewGuid(), Description= "Travel", Amount= 500.00M, Date= DateTime.Now},
           new Expense{  Id = Guid.NewGuid(), Description= "Meals", Amount= 200.00M, Date= DateTime.Now},
           new Expense{  Id = Guid.NewGuid(), Description= "Utilities", Amount= 300.00M, Date= DateTime.Now}
        };
        public List<Expense> GetAllExpenses()
        {
            return expensesList;
        }
}
