using System;
using Backend.Domain.Models;
using Backend.Application.Interfaces;
using Backend.Application.DTOs;

namespace Backend.Application.Services;

public class ExpenseService : IExpenseService
{
    private readonly IExpenseRepository _expenseRepository;

    public ExpenseService(IExpenseRepository expenseRepository)
    {
        _expenseRepository = expenseRepository;
    }

    public async Task<List<ExpenseDto>> GetAllExpenses()
    {
        var expenses = await _expenseRepository.GetAllExpenses();
        return expenses.Select(MapToDto).ToList();
    }

    public async Task<ExpenseDto> CreateExpense(CreateExpenseDto createExpenseDto)
    {
        var expense = new Expense
        {
            Id = Guid.NewGuid(),
            Description = createExpenseDto.Description,
            Amount = createExpenseDto.Amount,
            Date = createExpenseDto.Date,
        };

        await _expenseRepository.CreateExpense(expense);
        return MapToDto(expense);
    }

    public async Task<bool> UpdateExpense(UpdateExpenseDto updateDto)
    {
        // Further validation can be added here if necessary
        // e.g., check if the ID exists before updating
        var existingExpense = new Expense
        {
            Id = updateDto.Id,
            Description = updateDto.Description,
            Amount = updateDto.Amount,
            Date = updateDto.Date,
        };
        return await _expenseRepository.UpdateExpense(existingExpense);
    }

    public async Task<bool> DeleteExpense(Guid id)
    {
        return await _expenseRepository.DeleteExpense(id);
    }

        private static ExpenseDto MapToDto(Expense expense)
    {
        return new ExpenseDto
        {
            Id = expense.Id,
            Description = expense.Description,
            Amount = expense.Amount,
            Date = expense.Date,
        };
    }
}
