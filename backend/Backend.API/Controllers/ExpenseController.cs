using Backend.Application;
using Backend.Domain;
using Microsoft.AspNetCore.Http;
using Microsoft.AspNetCore.Mvc;

namespace Backend.API.Controllers
{
    [Route("api/[controller]")]
    [ApiController]
    public class ExpenseController : ControllerBase
    {
        private readonly IExpenseService expenseService;

        public ExpenseController(IExpenseService expenseService)
        {
            this.expenseService = expenseService;
        }
        // GET: api/<MembersController>
        [HttpGet]
        public async Task<ActionResult<IList<Expense>>> Get()
        {
            var expenses = await this.expenseService.GetAllExpenses();
            return Ok(expenses);
        }
    }
}
