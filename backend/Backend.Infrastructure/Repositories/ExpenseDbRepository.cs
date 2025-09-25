using System;
using Backend.Application.Interfaces;
using Backend.Domain.Models;
using Backend.Infrastructure.Data;
using Microsoft.EntityFrameworkCore;

namespace Backend.Infrastructure.Repositories;

public class ExpenseDbRepository : IExpenseRepository
{
        private readonly ExpenseDbContext _context;

        public ExpenseDbRepository(ExpenseDbContext context)
        {
            _context = context;
        }

        public async Task<List<Expense>> GetAllExpenses()
        {
            return await _context.Expenses
                .OrderByDescending(e => e.Date)
                .ToListAsync();
        }

        public async Task<Expense> CreateExpense(Expense expense)
        {
            expense.Id = Guid.NewGuid();
            _context.Expenses.Add(expense);
            await _context.SaveChangesAsync();
            return expense;
        }

        public async Task<bool> UpdateExpense(Expense expense)
        {
            _context.Entry(expense).State = EntityState.Modified;
            try
            {
                await _context.SaveChangesAsync();
                return true;
            }
            catch (DbUpdateConcurrencyException)
            {
                if (!await ExpenseExistsAsync(expense.Id))
                    return false;
                throw;
            }
        }

        public async Task<bool> DeleteExpense(Guid id)
        {
            var expense = await _context.Expenses.FindAsync(id);
            if (expense == null)
                return false;

            _context.Expenses.Remove(expense);
            await _context.SaveChangesAsync();
            return true;
        }

        private async Task<bool> ExpenseExistsAsync(Guid id)
        {
            return await _context.Expenses.AnyAsync(e => e.Id == id);
        }
}
