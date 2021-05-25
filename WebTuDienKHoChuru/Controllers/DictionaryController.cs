using Microsoft.AspNetCore.Mvc;

namespace WebTuDienKHoChuru.Controllers
{
	public class DictionaryController : Controller
	{
		public IActionResult Index()
		{
			return View();
		}

		public IActionResult KHo_Viet()
		{
			return View();
		}

		public IActionResult Viet_KHo()
		{
			return View();
		}

		public IActionResult Viet_Churu()
		{
			return View();
		}

		public IActionResult Churu_Viet()
		{
			return View();
		}
	}
}
