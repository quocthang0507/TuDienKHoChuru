using Microsoft.AspNetCore.Authorization;
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
		public static readonly string TOKEN = "token";
		public static readonly string FULLNAME = "Fullname";
		public static readonly string NAME = "Username";
		public static readonly string PASS = "Password";
		public static readonly string ROLE = "Role";

		private readonly IUserService userService;

		public LoginController(IUserService userService)
		{
			this.userService = userService;
		}

		// GET: Login
		public IActionResult Index()
		{
			if (Extensions.IsAllNullOrEmpty(HttpContext.Session.GetString(NAME), HttpContext.Session.GetString(ROLE)))
				return View();
			else
				return RedirectToAction("Index", "Home");
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
				if (model.RememberMe)
				{
					HttpContext.Response.Cookies.Append(NAME, user.Username, new CookieOptions { Expires = DateTime.UtcNow.AddDays(14) });
					HttpContext.Response.Cookies.Append(PASS, user.Password, new CookieOptions { Expires = DateTime.UtcNow.AddDays(14) });
				}
				else
				{
					HttpContext.Response.Cookies.Delete(NAME);
					HttpContext.Response.Cookies.Delete(PASS);
				}
				HttpContext.Session.Set(FULLNAME, Encoding.UTF8.GetBytes(user.Fullname));
				HttpContext.Session.Set(ROLE, Encoding.UTF8.GetBytes(user.Role));
				HttpContext.Response.Cookies.Append(TOKEN, user.Token, new CookieOptions { HttpOnly = true });
				return RedirectToAction("Index", "Home");
			}
			// return Unauthorized();
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