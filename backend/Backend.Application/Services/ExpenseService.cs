using System;
using Backend.Domain.Models;
using Backend.Application.Interfaces;

namespace Backend.Application.Services;

public class ExpenseService : IExpenseService
{
    private readonly IExpenseRepository _expenseRepository;

    public ExpenseService(IExpenseRepository expenseRepository)
    {
        _expenseRepository = expenseRepository;
    }

    public async Task<List<Expense>> GetAllExpenses()
    {
        return await _expenseRepository.GetAllExpenses();
    }

    public async Task<Expense> CreateExpense(Expense expense)
    {
        return await _expenseRepository.CreateExpense(expense);
    }

    public async Task<bool> UpdateExpense(Expense expense)
    {
        return await _expenseRepository.UpdateExpense(expense);
    }

    public async Task<bool> DeleteExpense(Guid id)
    {
        return await _expenseRepository.DeleteExpense(id);
    }
}
