using Microsoft.AspNetCore.Hosting;
using Microsoft.AspNetCore.Mvc;
using Microsoft.Extensions.Logging;
using System.Collections.Generic;
using System.Diagnostics;
using System.IO;
using System.Linq;
using WebTuDienKHoChuru.Models.ViewModel;
using WebTuDienKHoChuru.Utils;

namespace WebTuDienKHoChuru.Controllers
{
	public class HomeController : Controller
	{
		private readonly ILogger<HomeController> _logger;
		private readonly IWebHostEnvironment _appEnvironment;

		public HomeController(ILogger<HomeController> logger, IWebHostEnvironment webHostEnvironment)
		{
			_logger = logger;
			_appEnvironment = webHostEnvironment;
		}

		public IActionResult Index()
		{
			string imageFolder = Path.Combine(_appEnvironment.WebRootPath, "img");
			List<string> files = Directory.GetFiles(imageFolder, "*.jpg", SearchOption.TopDirectoryOnly).Select(f => _appEnvironment.ConvertRelativePath(f)).ToList();
			ViewBag.Carousel = files;
			return View();
		}

		[ResponseCache(Duration = 0, Location = ResponseCacheLocation.None, NoStore = true)]
		public IActionResult Error()
		{
			return View(new ErrorViewModel { RequestId = Activity.Current?.Id ?? HttpContext.TraceIdentifier });
		}
	}
}
