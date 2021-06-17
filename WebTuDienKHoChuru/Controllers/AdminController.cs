using Microsoft.AspNetCore.Authorization;
using Microsoft.AspNetCore.Http;
using Microsoft.AspNetCore.Mvc;
using System.Collections.Generic;
using System.Threading.Tasks;
using WebTuDienKHoChuru.Models.User;
using WebTuDienKHoChuru.Utils;

namespace WebTuDienKHoChuru.Controllers
{
	[Authorize(Roles = Role.Admin)]
	public class AdminController : Controller
	{
		// GET: Admin
		public async Task<IActionResult> Index(string errorMessage = null)
		{
			List<Account> accounts = await Accounts.GetAccountsWithoutPass();
			ViewBag.ListAccounts = accounts;
			if (errorMessage == null)
				ViewBag.Message = errorMessage;
			return View();
		}

		[HttpGet]
		public async Task<IActionResult> DeactivateAccount(string username)
		{
			string currentAcc = HttpContext.Session.GetString(Constants.USERNAME);
			if (currentAcc != username)
			{
				await Accounts.Deactivate(username);
				return RedirectToAction("Index");
			}
			return RedirectToAction("Index", new { errorMessage = "Bạn không thể tự hủy kích hoạt chính tài khoản của mình" });
		}

		[HttpGet]
		public async Task<IActionResult> ActivateAccount(string username)
		{
			await Accounts.Activate(username);
			return RedirectToAction("Index");
		}

		[HttpPost]
		[ValidateAntiForgeryToken]
		public async Task<IActionResult> AddNewAccount(Account account)
		{
			string message = null;
			if (ModelState.IsValid)
			{
				bool result = await Accounts.InsertAccount(account);
				message = result ? "" : "Lỗi thêm tài khoản mới vào cơ sở dữ liệu, vui lòng kiểm tra dữ liệu đầu vào";
			}
			else
				message = "Lỗi do form không hợp lệ";
			return RedirectToAction("Index", new { errorMessage = message });
		}
	}
}