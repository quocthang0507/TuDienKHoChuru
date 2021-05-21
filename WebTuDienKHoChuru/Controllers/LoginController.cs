using Microsoft.AspNetCore.Http;
using Microsoft.AspNetCore.Mvc;
using System;
using System.Text;
using WebTuDienKHoChuru.Models;
using WebTuDienKHoChuru.Models.User;
using WebTuDienKHoChuru.Services;
using WebTuDienKHoChuru.Utils;

namespace WebTuDienKHoChuru.Controllers
{
	public class LoginController : Controller
	{
		public static readonly string TOKEN = "_Token_";
		public static readonly string FULLNAME = "_Fullname_";
		public static readonly string USERNAME = "_Username_";
		public static readonly string PASS = "_Password_";
		public static readonly string ROLE = "_Role_";

		private readonly IUserService userService;

		public LoginController(IUserService userService)
		{
			this.userService = userService;
		}

		// GET: Login
		public IActionResult Index()
		{
			if (Extensions.IsAllNullOrEmpty(HttpContext.Session.GetString(FULLNAME), HttpContext.Session.GetString(ROLE)))
				return View();
			else
				return RedirectToAction("Index", "Home");
		}

		public IActionResult Login()
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
				HttpContext.Session.Set(FULLNAME, Encoding.UTF8.GetBytes(user.Fullname));
				HttpContext.Session.Set(ROLE, Encoding.UTF8.GetBytes(user.Role));
				HttpContext.Response.Cookies.Append(TOKEN, user.Token, new CookieOptions { HttpOnly = true });
				return user.Role switch
				{
					Role.Admin => RedirectToAction("Index", "Admin"),
					Role.Colaborator => RedirectToAction("Index", "Colaborator"),
					_ => RedirectToAction("Index", "Home"),
				};
			}
			return View("Index", model);
		}

		[Route("Logout")]
		public IActionResult Logout()
		{
			HttpContext.Session.Remove(FULLNAME);
			HttpContext.Session.Remove(ROLE);
			HttpContext.Response.Cookies.Delete(TOKEN);
			return RedirectToAction("Index", "Home");
		}
	}
}