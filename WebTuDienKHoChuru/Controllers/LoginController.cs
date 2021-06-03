using Microsoft.AspNetCore.Authorization;
using Microsoft.AspNetCore.Http;
using Microsoft.AspNetCore.Mvc;
using System.Text;
using System.Threading.Tasks;
using WebTuDienKHoChuru.Models;
using WebTuDienKHoChuru.Models.User;
using WebTuDienKHoChuru.Services;
using WebTuDienKHoChuru.Utils;

namespace WebTuDienKHoChuru.Controllers
{
	public class LoginController : Controller
	{
		private readonly IUserService userService;

		public LoginController(IUserService userService)
		{
			this.userService = userService;
		}

		// GET: Login
		public IActionResult Index()
		{
			if (Extensions.IsAllNullOrEmpty(HttpContext.Session.GetString(Constants.FULLNAME), HttpContext.Session.GetString(Constants.ROLE)))
				return View();
			else
				return RedirectToAction("Index", "Home");
		}

		public IActionResult Login()
		{
			return View();
		}

		[Authorize]
		public IActionResult ChangePassword()
		{
			return View();
		}

		[Authorize]
		public async Task<IActionResult> ChangeInfo()
		{
			string username = HttpContext.Session.GetString(Constants.USERNAME);
			return View(await Accounts.FindOne(username));
		}

		[HttpPost]
		[ValidateAntiForgeryToken]
		public async Task<IActionResult> Login(LoginModel model)
		{
			if (ModelState.IsValid)
			{
				var result = await userService.Authenticate(model.Username, model.Password);
				if (result.Key == -1)
				{
					ViewBag.Message = "Không được bỏ trống thông tin đăng nhập bắt buộc";
					return View("Index", model);
				}
				else if (result.Key == 0)
				{
					ViewBag.Message = "Sai tên đăng nhập hoặc mật khẩu";
					return View("Index", model);
				}
				var user = result.Value;
				HttpContext.Session.Set(Constants.FULLNAME, Encoding.UTF8.GetBytes(user.Fullname));
				HttpContext.Session.Set(Constants.ROLE, Encoding.UTF8.GetBytes(user.Role));
				HttpContext.Session.Set(Constants.USERNAME, Encoding.UTF8.GetBytes(user.Username));
				HttpContext.Response.Cookies.Append(Constants.TOKEN, user.Token, new CookieOptions { HttpOnly = true });
				return user.Role switch
				{
					Role.Admin => RedirectToAction("Index", "Admin"),
					Role.Collaborator => RedirectToAction("Index", "Collaborator"),
					_ => RedirectToAction("Index", "Home"),
				};
			}
			return View("Index", model);
		}

		[HttpPost]
		[ValidateAntiForgeryToken]
		public async Task<IActionResult> ChangePassword(ChangePasswordModel model)
		{
			if (ModelState.IsValid)
			{
				string username = HttpContext.Session.GetString(Constants.USERNAME);
				var result = await userService.Authenticate(username, model.OldPassword);
				if (result.Key == -1)
				{
					ViewBag.Message = "Không được bỏ trống thông tin đăng nhập bắt buộc";
					return View();
				}
				else if (result.Key == 0)
				{
					ViewBag.Message = "Mật khẩu cũ không đúng";
					return View();
				}
				var user = result.Value;
				user.Password = SHA256.Instance.GetSHA256(model.NewPassword);
				user.Token = null;
				if (await Accounts.UpdateAccount(user))
				{
					ViewBag.Message = "Đổi mật khẩu thành công";
				}
				else
				{
					ViewBag.Message = "Đổi mật khẩu không thành công";
				}
				return View();
			}
			return View();
		}

		[HttpPost]
		[ValidateAntiForgeryToken]
		public async Task<IActionResult> ChangeInfo(Account account)
		{
			if (ModelState.IsValid)
			{
				string username = HttpContext.Session.GetString(Constants.USERNAME);
				var oldAccount = await Accounts.FindOne(username);
				if (oldAccount != null)
				{
					account.Password = oldAccount.Password;
					account.Id = oldAccount.Id;
					account.Role = oldAccount.Role;
					if (await Accounts.UpdateAccount(account))
					{
						HttpContext.Session.Set(Constants.FULLNAME, Encoding.UTF8.GetBytes(account.Fullname));
						HttpContext.Session.Set(Constants.USERNAME, Encoding.UTF8.GetBytes(account.Username));
						ViewBag.Message = "Cập nhật thông tin thành công";
					}
					else
					{
						ViewBag.Message = "Cập nhật không thông tin thành công";
					}
					return View(account);
				}
			}
			return View();
		}

		[Route("Logout")]
		public IActionResult Logout()
		{
			HttpContext.Session.Remove(Constants.FULLNAME);
			HttpContext.Session.Remove(Constants.ROLE);
			HttpContext.Response.Cookies.Delete(Constants.TOKEN);
			return RedirectToAction("Index", "Home");
		}
	}
}