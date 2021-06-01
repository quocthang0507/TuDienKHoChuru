using Microsoft.AspNetCore.Authorization;
using Microsoft.AspNetCore.Http;
using Microsoft.AspNetCore.Mvc;
using System.Text;
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
		public IActionResult ChangeInfo()
		{
			return View();
		}

		[HttpPost]
		[ValidateAntiForgeryToken]
		public IActionResult Login(LoginModel model)
		{
			if (ModelState.IsValid)
			{
				var result = userService.Authenticate(model.Username, model.Password);
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
		public IActionResult ChangePassword(ChangePasswordModel model)
		{
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