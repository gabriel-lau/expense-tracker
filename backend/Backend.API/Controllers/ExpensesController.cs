using Backend.Application.DTOs;
using Backend.Application.Interfaces;
using Backend.Domain.Models;
using Microsoft.AspNetCore.Http;
using Microsoft.AspNetCore.Mvc;

namespace Backend.API.Controllers
{
    [Route("api/[controller]")]
    [ApiController]
    public class ExpensesController : ControllerBase
    {
        private readonly IExpenseService expenseService;

        public ExpensesController(IExpenseService expenseService)
        {
            this.expenseService = expenseService;
        }
        // GET: api/<MembersController>
        [HttpGet]
        public async Task<ActionResult<IList<ExpenseDto>>> Get()
        {
            var expenses = await expenseService.GetAllExpenses();
            return Ok(expenses);
        }

        // POST api/<ExpensesController>
                // POST: api/expenses
        [HttpPost]
        public async Task<ActionResult<ExpenseDto>> CreateExpense(CreateExpenseDto createExpenseDto)
        {
            if (!ModelState.IsValid)
                return BadRequest(ModelState);

            var expense = await expenseService.CreateExpense(createExpenseDto);
            return CreatedAtAction(nameof(Get), new { id = expense.Id }, expense);
        }

        // PUT: api/expenses/{id}
        [HttpPut("{id}")]
        public async Task<IActionResult> UpdateExpense(Guid id, UpdateExpenseDto updateExpenseDto)
        {
            if (!ModelState.IsValid)
                return BadRequest(ModelState);

            if (id != updateExpenseDto.Id)
                return BadRequest();

            var result = await expenseService.UpdateExpense(updateExpenseDto);
            if (!result)
                return NotFound();

            return NoContent();
        }

        // DELETE: api/expenses/{id}
        [HttpDelete("{id}")]
        public async Task<IActionResult> DeleteExpense(Guid id)
        {
            var result = await expenseService.DeleteExpense(id);
            if (!result)
                return NotFound();

            return NoContent();
        }
    }
}
