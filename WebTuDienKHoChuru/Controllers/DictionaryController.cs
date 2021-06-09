using Microsoft.AspNetCore.Authorization;
using Microsoft.AspNetCore.Mvc;
using System.Collections.Generic;
using System.Linq;
using System.Threading.Tasks;
using WebTuDienKHoChuru.Models;
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
		[HttpGet("ManageDictionary")]
		public async Task<IActionResult> Manage(int dictTypeID = 1, int pageNumber = 1, int wordID = 1)
		{
			ManageViewModel model = new ManageViewModel();
			model.DictTypes = await GetDictTypes();
			model.PageNumbers = await WORDs.GetPageNumbers(dictTypeID);
			model.WordList = await GetWords(dictTypeID, pageNumber);
			model.WordTypes = await GetWordTypes();
			model.SelectedDictTypeID = dictTypeID;
			model.SelectedWord = model.WordList.First(w => w.ID == wordID);
			model.SelectedWord.Meanings = await GetMeanings(wordID);
			model.SelectedPage = pageNumber;
			return View(model);
		}

		[HttpPost()]
		[Authorize]
		[ValidateAntiForgeryToken]
		public async Task<IActionResult> AddOrUpdateWord(ManageWordFormModel model)
		{
			if (ModelState.IsValid)
			{

			}
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

		#region APIs

		[HttpGet]
		public async Task<List<DICT_TYPE>> GetDictTypes() => await DICT_TYPEs.GetDictTypes();

		[HttpGet]
		public async Task<List<WORD>> GetWords(int dictTypeID, int pageNumber) => await WORDs.GetWords(dictTypeID, pageNumber);

		[HttpGet]
		public async Task<List<WORD_TYPE>> GetWordTypes() => await WORD_TYPEs.GetWordTypes();

		[HttpGet]
		public async Task<List<MEANING>> GetMeanings(int wordID) => await MEANINGS.GetMeanings(wordID);

		#endregion
	}
}
