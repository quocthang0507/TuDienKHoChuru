using Microsoft.AspNetCore.Authorization;
using Microsoft.AspNetCore.Mvc;
using WebTuDienKHoChuru.Models.User;

namespace WebTuDienKHoChuru.Controllers
{
	[Authorize(Roles = Role.Admin)]
	public class AdminController : Controller
	{
		// GET: Admin
		public ActionResult Index()
		{
			return View();
		}
	}
}