using System;
using Backend.Domain;

namespace Backend.Application;

public class ExpenseService : IExpenseService
{
        private readonly IExpenseRepository expenseRepository;
        public ExpenseService(IExpenseRepository expenseRepository)
        {
            this.expenseRepository = expenseRepository;
        }
        List<Expense> IExpenseService.GetAllExpenses()
        {
            return expenseRepository.GetAllExpenses();
        }
}
