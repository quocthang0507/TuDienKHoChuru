using Microsoft.AspNetCore.Authorization;
using Microsoft.AspNetCore.Http;
using Microsoft.AspNetCore.Mvc;
using System.Collections.Generic;
using System.Linq;
using System.Threading.Tasks;
using WebTuDienKHoChuru.Models.DataAccess;
using WebTuDienKHoChuru.Utils;

namespace WebTuDienKHoChuru.Controllers
{
	[Authorize]
	public class PassageController : Controller
	{
		private const string tempData = "UpdatedPassage";

		[HttpGet("Passage/{dictTypeID?}/{pageNumber?}")]
		[ProducesResponseType(StatusCodes.Status400BadRequest)]
		public async Task<IActionResult> Index(int dictTypeID = 1, int pageNumber = 1)
		{
			List<DICT_TYPE> dictTypes = await DictionaryController.GetDictTypes();
			DICT_TYPE dict = dictTypes.FirstOrDefault(d => d.DictType == dictTypeID);
			if (dict == null)
				return BadRequest("Mã loại từ điển không hợp lệ");

			int pageNumbers = await GetPassagePageNumbers(dictTypeID);
			if (pageNumber <= 0 || pageNumber > pageNumbers)
				return BadRequest("Số trang không hợp lệ");

			List<BILINGUAL_PASSAGE> passageList = await GetPassagesWithPagination(dictTypeID, pageNumber);

			ViewBag.DictTypes = dictTypes;
			ViewBag.SelectedDictTypeID = dictTypeID;
			ViewBag.SelectedPage = pageNumber;
			ViewBag.PageNumbers = pageNumbers;
			ViewBag.PassageTypes = await GetPassageTypes();
			ViewBag.PassageList = passageList;
			return View();
		}

		#region APIs
		[HttpGet("api/GetPassages/{passageID}")]
		public async Task<BILINGUAL_PASSAGE> GetPassage(int passageID) => await BILINGUAL_PASSAGEs.GetPassage(passageID);

		[HttpGet("api/GetPassagesWithPagination/{dictTypeID}/{pageNumber}")]
		public async Task<List<BILINGUAL_PASSAGE>> GetPassagesWithPagination(int dictTypeID, int pageNumber) => await BILINGUAL_PASSAGEs.GetPassagesWithPagination(dictTypeID, pageNumber);

		[HttpGet("api/GetPassagePageNumbers/{dictTypeID}")]
		public async Task<int> GetPassagePageNumbers(int dictTypeID) => await BILINGUAL_PASSAGEs.GetPassagePageNumbers(dictTypeID);

		[HttpGet("api/GetPassageTypes")]
		public async Task<List<PASSAGE_TYPE>> GetPassageTypes() => await PASSAGE_TYPEs.GetPassageTypes();

		[HttpPost("api/InsertPassage")]
		public async Task<bool> InsertPassage(BILINGUAL_PASSAGE passage)
		{
			passage.Creator = HttpContext.Session.GetString(Constants.USERNAME);
			if (passage.ID == 0)
				return await BILINGUAL_PASSAGEs.InsertPassage(passage);
			return await BILINGUAL_PASSAGEs.UpdatePassage(passage);
		}

		[HttpPost("api/UpdatePassage")]
		public async Task<bool> UpdatePassage(BILINGUAL_PASSAGE passage) => await BILINGUAL_PASSAGEs.UpdatePassage(passage);

		[HttpGet("api/DeletePassage/{passageID}")]
		public async Task<bool> DeletePassage(int passageID) => await BILINGUAL_PASSAGEs.DeletePassage(passageID);
		#endregion
	}
}
