using Microsoft.AspNetCore.Authorization;
using Microsoft.AspNetCore.Mvc;
using System.Collections.Generic;
using System.Threading.Tasks;
using WebTuDienKHoChuru.Models.DataAccess;

namespace WebTuDienKHoChuru.Controllers
{
	public class DictionaryController : Controller
	{
		public IActionResult Index()
		{
			return View();
		}

		[Authorize]
		public async Task<IActionResult> Manage(int dictTypeID = 1, int pageNumber = 1)
		{
			ViewBag.DictTypes = await GetDictTypes();
			ViewBag.DictTypeID = dictTypeID;
			ViewBag.PageNumbers = await WORDs.GetPageNumbers(dictTypeID);
			ViewBag.SelectedPage = pageNumber;
			return View();
		}

		[HttpGet]
		public async Task<List<DICT_TYPE>> GetDictTypes() => await DICT_TYPEs.GetDictTypes();

		[HttpGet]
		public async Task<List<WORD>> GetWords(int dictTypeID, int pageNumber) => await WORDs.GetWords(dictTypeID, pageNumber);

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
