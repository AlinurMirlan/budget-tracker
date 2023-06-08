using BudgetTracker.Models;
using BudgetTracker.Models.ViewModels;
using BudgetTracker.Repositories;
using Microsoft.AspNetCore.Identity;
using Microsoft.AspNetCore.Mvc;

namespace BudgetTracker.Controllers
{
    public class BalanceViewComponent : ViewComponent
    {
        private readonly UserManager<User> userManager;

        public BalanceViewComponent(UserManager<User> userManager)
        {
            this.userManager = userManager;
        }

        public async Task<IViewComponentResult> InvokeAsync()
        {
            var currentUser = await userManager.GetUserAsync(HttpContext.User);
            if (currentUser is null)
            {
                throw new InvalidOperationException("User is null");
            }

            // Pass the balance to the view
            var model = new BalanceVm
            {
                Balance = currentUser.AccountBalance
            };

            return View(model);
        }
    }
}
