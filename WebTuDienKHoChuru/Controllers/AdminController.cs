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
		public async Task<IActionResult> Index()
		{
			List<Account> accounts = await Accounts.GetAccountsWithoutPass();
			ViewBag.ListAccounts = accounts;
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
			ViewBag.Message = "Bạn không thể tự hủy kích hoạt chính tài khoản của mình";
			return View("Index");
		}

		[HttpGet]
		public async Task<IActionResult> ActivateAccount(string username)
		{
			await Accounts.Activate(username);
			return View("Index");
		}

		[HttpPost]
		[ValidateAntiForgeryToken]
		public async Task<IActionResult> AddNewAccount(Account account)
		{
			if (ModelState.IsValid)
			{
				account.Password = SHA256.Instance.GetSHA256(account.Password);
				bool result = await Accounts.InsertAccount(account);
				ViewBag.Message = result ? "" : "Lỗi thêm tài khoản mới vào cơ sở dữ liệu, vui lòng kiểm tra dữ liệu đầu vào";
			}
			else
				ViewBag.Message = "Lỗi do form không hợp lệ";
			return View("Index");
		}
	}
}