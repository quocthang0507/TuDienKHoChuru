using Microsoft.AspNetCore.Authorization;
using Microsoft.AspNetCore.Hosting;
using Microsoft.AspNetCore.Http;
using Microsoft.AspNetCore.Mvc;
using System.Collections.Generic;
using System.Data;
using System.Linq;
using System.Threading.Tasks;
using WebTuDienKHoChuru.Models.DataAccess;
using WebTuDienKHoChuru.Models.FormModel;
using WebTuDienKHoChuru.Utils;

namespace WebTuDienKHoChuru.Controllers
{
	[Authorize]
	public class PassageController : Controller
	{
		private const string tempData = "UpdatedPassage";
		private static IWebHostEnvironment _appEnvironment;

		public PassageController(IWebHostEnvironment appEnvironment)
		{
			_appEnvironment = appEnvironment;
		}

		[HttpGet("Passage/{dictTypeID:int?}/{pageNumber:int?}")]
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
			if (passageList.Count > 0)
				passageList.ForEach(p => p.PronouncePath = _appEnvironment.ConvertRelativePath(p.PronouncePath));

			ViewBag.DictTypes = dictTypes;
			ViewBag.SelectedDictTypeID = dictTypeID;
			ViewBag.SelectedPage = pageNumber;
			ViewBag.PageNumbers = pageNumbers;
			ViewBag.PassageTypes = await GetPassageTypes();
			ViewBag.PassageList = passageList;
			return View();
		}

		[HttpGet("Passage/Import")]
		[ProducesResponseType(StatusCodes.Status400BadRequest)]
		public async Task<IActionResult> Import(int dictTypeID = 1)
		{
			List<DICT_TYPE> dictTypes = await DictionaryController.GetDictTypes();
			DICT_TYPE dict = dictTypes.FirstOrDefault(d => d.DictType == dictTypeID);
			if (dict == null)
				return BadRequest("Mã loại từ điển không hợp lệ");
			ViewBag.SelectedDict = dict;
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
		public async Task<bool> InsertPassage([FromForm] PassageFormModel form)
		{
			if (ModelState.IsValid && form != null)
			{
				string audioPath = null;
				if (form.AudioFile != null)
				{
					audioPath = await DictionaryController.SaveAudio(form.AudioFile);
					if (audioPath == null)
						return false;
				}
				BILINGUAL_PASSAGE passage = new()
				{
					ID = form.ID,
					DictType = form.DictType,
					PassageType = form.PassageType,
					Source = form.Source,
					Destination = form.Destination,
					PronouncePath = audioPath,
					Creator = HttpContext.Session.GetString(Constants.USERNAME)
				};

				if (form.ID == 0)
					return await BILINGUAL_PASSAGEs.InsertPassage(passage);
				return await BILINGUAL_PASSAGEs.UpdatePassage(passage);
			}
			return false;
		}

		[HttpPost("api/UpdatePassage")]
		public async Task<bool> UpdatePassage(BILINGUAL_PASSAGE passage) => await BILINGUAL_PASSAGEs.UpdatePassage(passage);

		[HttpGet("api/DeletePassage/{passageID}")]
		public async Task<bool> DeletePassage(int passageID) => await BILINGUAL_PASSAGEs.DeletePassage(passageID);

		/// <summary>
		/// Nhập danh sách đoạn song ngữ từ tập tin CSV vào loại từ điển được chỉ định
		/// </summary>
		/// <param name="tsvFile"></param>
		/// <param name="dictTypeID"></param>
		/// <returns>Mã trạng thái: 200 OK, 400 BadRequest</returns>
		[HttpPost("api/ImportPassage"), Authorize]
		[ProducesResponseType(StatusCodes.Status200OK)]
		[ProducesResponseType(StatusCodes.Status400BadRequest)]
		public async Task<IActionResult> ImportFromFile(IFormFile tsvFile, int dictTypeID)
		{
			if (tsvFile == null || tsvFile.Length == 0)
				return StatusCode(StatusCodes.Status400BadRequest, "Không nhận được tập tin CSV");
			try
			{
				// Chuẩn bị dữ liệu
				DataTable dt = tsvFile.ReadAsDataTable();
				List<BILINGUAL_PASSAGE> passages = BILINGUAL_PASSAGEs.ConvertDtToPassageList(dt, dictTypeID, HttpContext.Session.GetString(Constants.USERNAME));
				// Kiểm tra dữ liệu có thể chèn vào không
				if (passages.Count == 0)
					return StatusCode(StatusCodes.Status400BadRequest, "Dữ liệu trống!");
				List<int> errorIndexes = await BILINGUAL_PASSAGEs.TryInsertingPassages(passages);
				if (errorIndexes == null)
					return StatusCode(StatusCodes.Status500InternalServerError, "Lỗi máy chủ, vui lòng thử lại sau");
				else if (errorIndexes.Count > 0)
					return BadRequest(errorIndexes);
				// Chèn
				BILINGUAL_PASSAGEs.InsertPassages(passages);
			}
			catch { }
			return Ok();
		}
		#endregion
	}
}
