using Microsoft.AspNetCore.Http;
using Microsoft.AspNetCore.Mvc;
using System;
using System.Text;
using WebTuDienKHoChuru.Models;
using WebTuDienKHoChuru.Services;

namespace WebTuDienKHoChuru.Controllers
{
	public class LoginController : Controller
	{
		public static readonly string TOKEN = "token";
		public static readonly string NAME = "Username";
		public static readonly string PASS = "Password";
		public static readonly string ROLE = "Role";
		
		private readonly IUserService userService;

		public LoginController(IUserService userService)
		{
			this.userService = userService;
		}

		// GET: Login
		public ActionResult Index()
		{
			return View();
		}

		[HttpPost]
		[ValidateAntiForgeryToken]
		public IActionResult Login(LoginModel model)
		{
			if (ModelState.IsValid)
			{
				var user = userService.Authenticate(model.Username, model.Password);
				if (user == null)
				{
					ViewBag.Message = "Sai tên đăng nhập hoặc mật khẩu";
					return Index();
				}
				if (model.RememberMe)
				{
					HttpContext.Response.Cookies.Append(NAME, user.Username, new CookieOptions { Expires = DateTimeOffset.Now.AddDays(14) });
					HttpContext.Response.Cookies.Append(PASS, user.Password, new CookieOptions { Expires = DateTimeOffset.Now.AddDays(14) });
				}
				else
				{
					HttpContext.Response.Cookies.Delete(NAME);
					HttpContext.Response.Cookies.Delete(PASS);
				}
				HttpContext.Session.Set(NAME, Encoding.UTF8.GetBytes(user.Username));
				HttpContext.Session.Set(ROLE, Encoding.UTF8.GetBytes(user.Role));
				HttpContext.Response.Cookies.Append(TOKEN, user.Token, new CookieOptions { HttpOnly = true });
				return RedirectToAction("Index", "Home");
			}
			return Unauthorized();
		}

		[Route("Logout")]
		public IActionResult Logout()
		{
			HttpContext.Session.Remove("Username");
			HttpContext.Session.Remove("Role");
			HttpContext.Response.Cookies.Delete(TOKEN);
			return RedirectToAction("Index", "Home");
		}
	}
}