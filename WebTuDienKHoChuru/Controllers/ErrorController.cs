using Microsoft.AspNetCore.Mvc;

namespace WebTuDienKHoChuru.Controllers
{
	public class ErrorController : Controller
	{
		public IActionResult Index()
		{
			return View();
		}
	}
}
