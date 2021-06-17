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
		private const string tempMessage = "errorMessage";

		// GET: Admin
		public async Task<IActionResult> Index()
		{
			List<Account> accounts = await Accounts.GetAccountsWithoutPass();
			ViewBag.ListAccounts = accounts;
			if (TempData[tempMessage] != null)
				ViewBag.Message = TempData[tempMessage].ToString();
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
			TempData[tempMessage] = "Bạn không thể tự hủy kích hoạt chính tài khoản của mình";
			return RedirectToAction("Index");
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
			if (ModelState.IsValid)
			{
				account.Password = SHA256.Instance.GetSHA256(account.Password);
				bool result = await Accounts.InsertAccount(account);
				TempData[tempMessage] = result ? "" : "Lỗi thêm tài khoản mới vào cơ sở dữ liệu, vui lòng kiểm tra dữ liệu đầu vào";
			}
			else
				TempData[tempMessage] = "Lỗi do form không hợp lệ";
			return RedirectToAction("Index");
		}
	}
}