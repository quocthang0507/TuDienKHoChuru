using Microsoft.AspNetCore.Mvc;
using System.Threading.Tasks;

namespace WebTuDienKHoChuru.Controllers
{
	public class DictionaryController : Controller
	{
		public IActionResult Index()
		{
			return View();
		}

		public async Task<IActionResult> KHo_Viet()
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

		public async Task<IActionResult> Churu_Viet()
		{
			return View();
		}
	}
}
