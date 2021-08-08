using Microsoft.AspNetCore.Authorization;
using Microsoft.AspNetCore.Http;
using Microsoft.AspNetCore.Mvc;
using System.Text;
using System.Threading.Tasks;
using WebTuDienKHoChuru.Models.FormModel;
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
			if (Extensions.IsAllNullOrEmpty(HttpContext.Session.GetString(Constants.FULLNAME),
				HttpContext.Session.GetString(Constants.ROLE),
				HttpContext.Session.GetString(Constants.USERNAME),
				HttpContext.Request.Cookies[Constants.TOKEN]))
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
		[HttpGet]
		[ProducesResponseType(StatusCodes.Status400BadRequest)]
		public async Task<IActionResult> ChangeInfo()
		{
			string username = HttpContext.Session.GetString(Constants.USERNAME);
			Account account = await Accounts.FindOne(username);
			if (account != null)
			{
				return View(account);
			}
			return BadRequest("Không tìm thấy tài khoản có tên đăng nhập như thế");
		}

		[Authorize(Roles = Role.Admin)]
		[HttpGet]
		[ProducesResponseType(StatusCodes.Status400BadRequest)]
		public async Task<IActionResult> AdminChangeInfo(string username)
		{
			Account account = await Accounts.FindOne(username);
			if (account != null)
			{
				return View("ChangeInfo", account);
			}
			return BadRequest("Không tìm thấy tài khoản có tên đăng nhập như thế");
		}

		[HttpPost]
		[ValidateAntiForgeryToken]
		public async Task<IActionResult> Login(LoginFormModel model)
		{
			if (ModelState.IsValid)
			{
				var result = await userService.Authenticate(model.Username, model.Password);
				var user = result.Value;
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
				else if (!result.Value.Active)
				{
					ViewBag.Message = "Tài khoản vẫn còn nhưng không thể đăng nhập vì bị tạm ngưng kích hoạt, vui lòng liên hệ quản trị viên để biết thêm thông tin";
					return View("Index", model);
				}
				HttpContext.Session.Set(Constants.FULLNAME, Encoding.UTF8.GetBytes(user.Fullname));
				HttpContext.Session.Set(Constants.ROLE, Encoding.UTF8.GetBytes(user.Role));
				HttpContext.Session.Set(Constants.USERNAME, Encoding.UTF8.GetBytes(user.Username));
				HttpContext.Response.Cookies.Append(Constants.TOKEN, user.Token, new CookieOptions { HttpOnly = true });
				return RedirectToAction("Index", "Dictionary");
			}
			return View("Index", model);
		}

		[HttpPost]
		[ValidateAntiForgeryToken]
		[Authorize]
		public async Task<IActionResult> ChangeAccountPassword(ChangePasswordFormModel model)
		{
			if (ModelState.IsValid)
			{
				string username = HttpContext.Session.GetString(Constants.USERNAME);
				var result = await userService.Authenticate(username, model.OldPassword);
				if (result.Key == -1)
				{
					ViewBag.Message = "Không được bỏ trống thông tin đăng nhập bắt buộc";
				}
				else if (result.Key == 0)
				{
					ViewBag.Message = "Mật khẩu cũ không đúng";
				}
				else
				{
					var user = result.Value;
					user.Password = SHA256.Instance.GetSHA256(model.NewPassword);
					user.Token = null;
					ViewBag.Message = await Accounts.UpdateAccount(user) ? "Đổi mật khẩu thành công" : "Đổi mật khẩu không thành công";
				}
			}
			return BadRequest("Form không hợp lệ, vui lòng kiểm tra dữ liệu nhập vào");
		}

		[HttpPost]
		[ValidateAntiForgeryToken]
		[Authorize]
		public async Task<IActionResult> ChangeAccountInfo(Account account)
		{
			var oldAccount = await Accounts.FindOne(account.Username);
			if (oldAccount != null)
			{
				account.Password = oldAccount.Password;
				account.Id = oldAccount.Id;
				account.Role = oldAccount.Role;
				account.Username = oldAccount.Username;
				if (await Accounts.UpdateAccount(account))
				{
					if (HttpContext.Session.GetString(Constants.USERNAME) == oldAccount.Username)
					{
						HttpContext.Session.Set(Constants.FULLNAME, Encoding.UTF8.GetBytes(account.Fullname));
						HttpContext.Session.Set(Constants.USERNAME, Encoding.UTF8.GetBytes(account.Username));
					}
					ViewBag.Message = "Cập nhật thông tin thành công";
				}
				else
				{
					ViewBag.Message = "Cập nhật không thông tin thành công";
				}
				return View("ChangeInfo", account);
			}
			return BadRequest("Không tìm thấy tài khoản này");
		}

		[Route("Logout")]
		public IActionResult Logout()
		{
			HttpContext.Session.Remove(Constants.FULLNAME);
			HttpContext.Session.Remove(Constants.ROLE);
			HttpContext.Session.Remove(Constants.USERNAME);
			HttpContext.Response.Cookies.Delete(Constants.TOKEN);
			return RedirectToAction("Index", "Home");
		}
	}
}