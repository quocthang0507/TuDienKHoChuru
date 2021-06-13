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
		public async Task<IActionResult> Manage(int dictTypeID = 1, int pageNumber = 1, int wordID = 1)
		{
			ManageViewModel model = new()
			{
				DictTypes = await GetDictTypes(),
				PageNumbers = await GetPageNumber(dictTypeID),
				WordList = await GetWords(dictTypeID, pageNumber),
				WordTypes = await GetWordTypes(),
				SelectedDictTypeID = dictTypeID,
				SelectedPage = pageNumber
			};

			model.SelectedWord = model.WordList.First(w => w.ID == wordID);
			model.SelectedWord.Meanings = await GetMeanings(wordID);
			return View(model);
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
		[Authorize]
		[HttpPost("api/AddOrUpdateWord")]
		[ValidateAntiForgeryToken]
		[ProducesResponseType(200)]
		[ProducesResponseType(400)]
		[Consumes("multipart/form-data")]
		public async Task<IActionResult> AddOrUpdateWord([FromForm] SubmitWordFormModel form)
		{
			if (ModelState.IsValid || form != null)
			{

			}
			return BadRequest("This is used for POST method not GET method");
		}

		[HttpGet("api/GetDictTypes")]
		public async Task<List<DICT_TYPE>> GetDictTypes() => await DICT_TYPEs.GetDictTypes();

		[HttpGet("api/GetWords/{dictTypeID}/{pageNumber}")]
		public async Task<List<WORD>> GetWords(int dictTypeID, int pageNumber) => await WORDs.GetWords(dictTypeID, pageNumber);

		[HttpGet("api/GetWordTypes")]
		public async Task<List<WORD_TYPE>> GetWordTypes() => await WORD_TYPEs.GetWordTypes();

		[HttpGet("api/GetMeanings/{wordID}")]
		public async Task<List<MEANING>> GetMeanings(int wordID) => await MEANINGS.GetMeanings(wordID);

		[HttpGet("api/GetPageNumber/{dictTypeID}")]
		public async Task<int> GetPageNumber(int dictTypeID) => await WORDs.GetPageNumbers(dictTypeID);
		#endregion

	}
}
