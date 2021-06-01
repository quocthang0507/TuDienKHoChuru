using Microsoft.AspNetCore.Mvc;
using Microsoft.EntityFrameworkCore;
using System.Threading.Tasks;
using WebTuDienKHoChuru.Models;

namespace WebTuDienKHoChuru.Controllers
{
	public class DictionaryController : Controller
	{
		private readonly TuDienContext _context;

		public DictionaryController(TuDienContext context)
		{
			_context = context;
		}

		public IActionResult Index()
		{
			return View();
		}

		public async Task<IActionResult> KHo_Viet()
		{
			return View(await _context.KhoVietViews.ToListAsync());
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
			return View(await _context.ChuruVietViews.ToListAsync());
		}
	}
}
