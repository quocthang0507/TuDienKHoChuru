using Microsoft.AspNetCore.Authorization;
using Microsoft.AspNetCore.Hosting;
using Microsoft.AspNetCore.Http;
using Microsoft.AspNetCore.Mvc;
using System;
using System.Collections.Generic;
using System.Data;
using System.Drawing.Imaging;
using System.IO;
using System.Linq;
using System.Threading.Tasks;
using WebTuDienKHoChuru.Models.DataAccess;
using WebTuDienKHoChuru.Models.FormModel;
using WebTuDienKHoChuru.Models.ViewModel;
using WebTuDienKHoChuru.Utils;

namespace WebTuDienKHoChuru.Controllers
{
	public class DictionaryController : Controller
	{
		private static IWebHostEnvironment _appEnvironment;

		public DictionaryController(IWebHostEnvironment hostingEnvironment)
		{
			_appEnvironment = hostingEnvironment;
		}

		public async Task<IActionResult> Index()
		{
			ViewBag.KHoVietWords = await GetTotalWords(1);
			ViewBag.VietKHoWords = await GetTotalWords(2);
			ViewBag.ChuruVietWords = await GetTotalWords(3);
			ViewBag.VietChuruWords = await GetTotalWords(4);
			ViewBag.KHoVietPassages = await GetTotalPassages(1);
			ViewBag.VietKHoPassages = await GetTotalPassages(2);
			ViewBag.ChuruVietPassages = await GetTotalPassages(3);
			ViewBag.VietChuruPassages = await GetTotalPassages(4);
			return View();
		}

		[Authorize]
		[ProducesResponseType(StatusCodes.Status400BadRequest)]
		public async Task<IActionResult> Word(int dictTypeID = 1, int pageNumber = 1, int wordID = 1)
		{
			int pageNumbers = await GetWordPageNumbers(dictTypeID);
			List<DICT_TYPE> dictTypes = await GetDictTypes();
			List<WORD> wordList = await GetWordsWithPagination(dictTypeID, pageNumber);
			WORD word = wordList.FirstOrDefault(w => w.ID == wordID);

			if (dictTypes.FirstOrDefault(d => d.DictType == dictTypeID) == null)
				return BadRequest("Mã loại từ điển không hợp lệ");
			else if (pageNumber <= 0 || pageNumber > pageNumbers)
				return BadRequest("Số trang không hợp lệ");

			ManageViewModel model = new()
			{
				DictTypes = dictTypes,
				PageNumbers = pageNumbers,
				WordList = wordList,
				WordTypes = await GetWordTypes(),
				SelectedDictTypeID = dictTypeID,
				SelectedPage = pageNumber,
				SelectedWord = word
			};

			if (word != null)
			{
				model.SelectedWord.Meanings = await GetMeanings(wordID);
				// Chuyển đường dẫn tuyệt đối sang đường dẫn tương đối
				model.SelectedWord.ImgPath = _appEnvironment.ConvertRelativePath(model.SelectedWord.ImgPath);
				model.SelectedWord.PronunPath = _appEnvironment.ConvertRelativePath(model.SelectedWord.PronunPath);
				// Get all meanings and its examples
				var meanings = await MEANINGs.GetMeanings(wordID);
				var meaningsWithExamples = new List<MEANING>();
				foreach (var meaning in meanings)
				{
					var examples = await EXAMPLEs.GetExamples(meaning.ID);
					meaning.Examples = examples;
					meaningsWithExamples.Add(meaning);
				}
				model.Meanings = meaningsWithExamples;
			}
			else
			{
				model.SelectedWord = WORD.NullObject(dictTypeID);
				model.Meanings = new List<MEANING>();
			}

			ViewBag.ViewModel = model;
			return View();
		}

		[Authorize]
		[ProducesResponseType(StatusCodes.Status400BadRequest)]
		public async Task<IActionResult> Example(int dictTypeID = 1, int pageNumber = 1)
		{
			List<DICT_TYPE> dictTypes = await GetDictTypes();
			DICT_TYPE dict = dictTypes.FirstOrDefault(d => d.DictType == dictTypeID);
			int pageNumbers = await GetExamplePageNumbers(dictTypeID);
			if (dict == null)
				return BadRequest("Mã loại từ điển không hợp lệ");

			if (pageNumber <= 0 || pageNumber > pageNumbers)
				return BadRequest("Số trang không hợp lệ");

			List<EXAMPLE> exampleList = await GetExamplesWithPagination(dictTypeID, pageNumber);
			if (exampleList.Count > 0)
				exampleList.ForEach(e => e.PronunPath = _appEnvironment.ConvertRelativePath(e.PronunPath));

			ViewBag.DictTypes = dictTypes;
			ViewBag.PageNumbers = pageNumbers;
			ViewBag.SelectedDictTypeID = dictTypeID;
			ViewBag.SelectedPage = pageNumber;
			ViewBag.ExampleList = exampleList;
			return View();
		}

		[Authorize]
		[ProducesResponseType(StatusCodes.Status400BadRequest)]
		public async Task<IActionResult> Import(int dictTypeID = 1)
		{
			List<DICT_TYPE> dictTypes = await GetDictTypes();
			DICT_TYPE dict = dictTypes.FirstOrDefault(d => d.DictType == dictTypeID);
			if (dict == null)
				return BadRequest("Mã loại từ điển không hợp lệ");
			ViewBag.SelectedDict = dict;
			return View();
		}

		#region APIs
		/// <summary>
		/// Cập nhật từ vựng thông qua form bằng phương thức POST
		/// </summary>
		/// <param name="form"></param>
		/// <returns>Mã trạng thái: 200 OK, 415 UnsupportedMediaType, 400 BadRequest</returns>
		[HttpPost("api/UpdateWord"), Authorize]
		[ValidateAntiForgeryToken]
		[ProducesResponseType(StatusCodes.Status200OK)]
		[ProducesResponseType(StatusCodes.Status415UnsupportedMediaType)]
		[ProducesResponseType(StatusCodes.Status400BadRequest)]
		public async Task<IActionResult> UpdateWord([FromForm] WordFormModel form)
		{
			if (ModelState.IsValid && form != null)
			{
				string imagePath = null, audioPath = null;
				// Kiểm tra âm thanh và hình ảnh có nằm trong form không, nếu có thì lưu lại và trả về đường dẫn của tập tin trên máy chủ
				if (form.ImageFile != null)
				{
					imagePath = await SaveImage(form.ImageFile);
					if (imagePath == null)
						return StatusCode(StatusCodes.Status415UnsupportedMediaType, "Định dạng hình ảnh không hợp lệ hoặc có vấn đề về tập tin");
				}
				if (form.AudioFile != null)
				{
					audioPath = await SaveAudio(form.AudioFile);
					if (audioPath == null)
						return StatusCode(StatusCodes.Status415UnsupportedMediaType, "Định dạng âm thanh không hợp lệ hoặc có vấn đề về tập tin");
				}
				// Cập nhật vào cơ sở dữ liệu bảng WORD
				bool result = await WORDs.UpdateWord(new WORD
				{
					ID = form.WordID,
					Word = form.Word,
					DictType = form.DictType,
					WordType = form.WordType,
					PronunPath = audioPath,
					ImgPath = imagePath,
					Creator = HttpContext.Session.GetString(Constants.USERNAME)
				});
				if (!result)
					return BadRequest("Lỗi khi cập nhật từ vựng vào cơ sở dữ liệu");

				// Chèn nghĩa vào bảng MEANING
				result = await MEANINGs.InsertMeanings(form.Meanings);
				if (!result)
					return BadRequest("Lỗi khi thêm các nghĩa vào cơ sở dữ liệu");

				return Ok("Cập nhật từ vựng thành công");
			}
			return BadRequest("URL này chỉ dùng cho phương thức POST hoặc form không hợp lệ");
		}

		/// <summary>
		/// Chèn một từ mới thông qua form bằng phương thức POST
		/// </summary>
		/// <param name="form"></param>
		/// <returns>Mã trạng thái: 200 OK, 400 BadRequest</returns>
		[HttpPost("api/InsertWord"), Authorize]
		[ProducesResponseType(StatusCodes.Status200OK)]
		[ProducesResponseType(StatusCodes.Status400BadRequest)]
		public async Task<IActionResult> InsertWord(WordFormModel form)
		{
			bool result = await WORDs.InsertWord(new WORD
			{
				ID = 0,
				Word = form.Word,
				DictType = form.DictType,
				WordType = "Others",
				PronunPath = null,
				ImgPath = null,
				Creator = HttpContext.Session.GetString(Constants.USERNAME)
			});
			if (!result)
				return BadRequest("Không thể thêm từ đó vào vì có thể đã tồn tại một từ như thế trong cơ sở dữ liệu hoặc đầu vào không hợp lệ");
			return Ok("Thêm từ vựng thành công");
		}

		/// <summary>
		/// Chèn ví dụ thông qua form bằng phương thức POST
		/// </summary>
		/// <param name="form"></param>
		/// <returns>Mã trạng thái: 200 OK, 400 BadRequest</returns>
		[HttpPost("api/InsertExample"), Authorize]
		[ProducesResponseType(StatusCodes.Status200OK)]
		[ProducesResponseType(StatusCodes.Status400BadRequest)]
		public async Task<IActionResult> InsertExample([FromForm] EXAMPLE form)
		{
			if (ModelState.IsValid && form != null)
			{
				bool result = await EXAMPLEs.InsertExample(form);
				if (!result)
					return BadRequest("Lỗi khi thêm các ví dụ của nghĩa này vào cơ sở dữ liệu");

				return Ok("Thêm ví dụ thành công");
			}
			return BadRequest("URL này chỉ dùng cho phương thức POST hoặc form không hợp lệ");
		}

		/// <summary>
		/// Cập nhật âm thanh của ví dụ
		/// </summary>
		/// <param name="exampleID"></param>
		/// <param name="audio"></param>
		/// <returns>Mã trạng thái: 200 OK, 415 UnsupportedMediaType, 400 BadRequest</returns>
		[HttpPost("api/UpdateAudioExample"), Authorize]
		[ProducesResponseType(StatusCodes.Status200OK)]
		[ProducesResponseType(StatusCodes.Status400BadRequest)]
		[ProducesResponseType(StatusCodes.Status415UnsupportedMediaType)]
		public async Task<IActionResult> UpdateAudioExample(int exampleID, IFormFile audio)
		{
			if (ModelState.IsValid && audio != null)
			{
				string audioPath = await SaveAudio(audio);
				if (audioPath == null)
					return StatusCode(StatusCodes.Status415UnsupportedMediaType, "Định dạng âm thanh không hợp lệ hoặc có vấn đề về tập tin âm thanh này");

				bool result = await EXAMPLEs.UpdateAudioExample(exampleID, audioPath);
				if (!result)
					return BadRequest("Lỗi khi cập nhật âm thanh ví dụ của nghĩa này vào cơ sở dữ liệu");

				return Ok("Cập nhật ví dụ thành công");
			}
			return BadRequest("URL này chỉ dùng cho phương thức POST hoặc không có một tập tin âm thanh trong yêu cầu này");
		}

		/// <summary>
		/// Xóa âm thanh ví dụ
		/// </summary>
		/// <param name="exampleID"></param>
		/// <returns>Mã trạng thái: 200 OK, 400 BadRequest</returns>
		[HttpGet("api/DeleteAudioExample/{exampleID}"), Authorize]
		[ProducesResponseType(StatusCodes.Status200OK)]
		[ProducesResponseType(StatusCodes.Status400BadRequest)]
		public async Task<IActionResult> DeleteAudioExample(int exampleID)
		{
			bool result = await EXAMPLEs.UpdateAudioExample(exampleID, null);
			if (!result)
				return BadRequest("Lỗi khi xóa âm thanh ví dụ của nghĩa này vào cơ sở dữ liệu hoặc không tìm thấy ID ví dụ nào như thế");

			return Ok("Xóa âm thanh ví dụ thành công");
		}

		/// <summary>
		/// Lấy danh sách loại từ điển
		/// </summary>
		/// <returns></returns>
		[HttpGet("api/GetDictTypes")]
		public async static Task<List<DICT_TYPE>> GetDictTypes() => await DICT_TYPEs.GetDictTypes();

		/// <summary>
		/// Lấy số lượng từ vựng (không bị đánh dấu xóa) thuộc về loại từ điển chỉ định
		/// </summary>
		/// <param name="dictTypeID"></param>
		/// <returns></returns>
		[HttpGet("api/GetTotalWords/{dictTypeID}")]
		public async Task<int> GetTotalWords(int dictTypeID) => await WORDs.GetTotalWords(dictTypeID);

		/// <summary>
		/// Lấy số lượng đoạn văn song ngữ (không bị đánh dấu xóa) thuộc về loại từ điển chỉ định
		/// </summary>
		/// <param name="dictTypeID"></param>
		/// <returns></returns>
		[HttpGet("api/GetTotalPassages/{dictTypeID}")]
		public async Task<int> GetTotalPassages(int dictTypeID) => await BILINGUAL_PASSAGEs.GetTotalPassages(dictTypeID);

		/// <summary>
		/// Lấy danh sách từ thuộc loại từ điển được chỉ định theo số trang
		/// </summary>
		/// <param name="dictTypeID"></param>
		/// <param name="pageNumber"></param>
		/// <returns></returns>
		[HttpGet("api/GetWordsWithPagination/{dictTypeID}/{pageNumber}")]
		public async static Task<List<WORD>> GetWordsWithPagination(int dictTypeID, int pageNumber) => await WORDs.GetWordsWithPagination(dictTypeID, pageNumber);

		/// <summary>
		/// Lấy danh sách ví dụ thuộc loại từ điển được chỉ định theo số trang
		/// </summary>
		/// <param name="dictTypeID"></param>
		/// <param name="pageNumber"></param>
		/// <returns></returns>
		[HttpGet("api/GetExamplesWithPagination/{dictTypeID}/{pageNumber}")]
		public async static Task<List<EXAMPLE>> GetExamplesWithPagination(int dictTypeID, int pageNumber) => await EXAMPLEs.GetExamplesWithPagination(dictTypeID, pageNumber);

		/// <summary>
		/// Lấy danh sách từ loại
		/// </summary>
		/// <returns></returns>
		[HttpGet("api/GetWordTypes")]
		public async static Task<List<WORD_TYPE>> GetWordTypes() => await WORD_TYPEs.GetWordTypes();

		/// <summary>
		/// Lấy các nghĩa của từ
		/// </summary>
		/// <param name="wordID"></param>
		/// <returns></returns>
		[HttpGet("api/GetMeanings/{wordID}")]
		public async Task<List<MEANING>> GetMeanings(int wordID) => await MEANINGs.GetMeanings(wordID);

		/// <summary>
		/// Lấy số trang từ vựng hiện có của loại từ điển được chỉ định, mặc định có 10 từ trên một trang
		/// </summary>
		/// <param name="dictTypeID"></param>
		/// <returns></returns>
		[HttpGet("api/GetWordPageNumbers/{dictTypeID}")]
		public async static Task<int> GetWordPageNumbers(int dictTypeID) => await WORDs.GetWordPageNumbers(dictTypeID);

		/// <summary>
		/// Lấy số trang ví dụ hiện có của loại từ điển được chỉ định, mặc định có 10 ví dụ trên một trang
		/// </summary>
		/// <param name="dictTypeID"></param>
		/// <returns></returns>
		[HttpGet("api/GetExamplePageNumbers/{dictTypeID}")]
		public async static Task<int> GetExamplePageNumbers(int dictTypeID) => await EXAMPLEs.GetExamplePageNumbers(dictTypeID);

		/// <summary>
		/// Xóa từ đó bằng cách đánh dấu là Deleted và bị bỏ qua trong kết quả truy vấn thông thường
		/// </summary>
		/// <param name="wordID"></param>
		/// <returns></returns>
		[HttpGet("api/DeleteWord/{wordID}"), Authorize]
		public async Task<int> DeleteWord(int wordID) => await WORDs.DeleteWord(wordID);

		/// <summary>
		/// Xóa ví dụ đó bằng cách đánh dấu là Deleted và bị bỏ qua trong kết quả truy vấn thông thường
		/// </summary>
		/// <param name="exampleID"></param>
		/// <returns></returns>
		[HttpGet("api/DeleteExample/{exampleID}"), Authorize]
		public async Task<bool> DeleteExample(int exampleID) => await EXAMPLEs.DeleteExample(exampleID);

		/// <summary>
		/// Đi đến số trang từ vựng được chỉ định
		/// </summary>
		/// <param name="dictTypeID"></param>
		/// <param name="pageNumber"></param>
		/// <returns></returns>
		[HttpGet("api/GoToWordPage/{dictTypeID}/{pageNumber}")]
		public async Task<IActionResult> GoToWordPage(int dictTypeID, int pageNumber)
		{
			var list = await GetWordsWithPagination(dictTypeID, pageNumber);
			if (list.Count > 0)
			{
				int wordID = list.First().ID;
				return RedirectToAction("Word", new { dictTypeID, wordID, pageNumber });
			}
			return RedirectToAction("Word", new { dictTypeID });
		}

		/// <summary>
		/// Đi đến số trang ví dụ được chỉ định
		/// </summary>
		/// <param name="dictTypeID"></param>
		/// <param name="pageNumber"></param>
		/// <returns></returns>
		[HttpGet("api/GoToExamplePage/{dictTypeID}/{pageNumber}")]
		public async Task<IActionResult> GoToExamplePage(int dictTypeID, int pageNumber)
		{
			var list = await GetExamplesWithPagination(dictTypeID, pageNumber);
			if (list.Count > 0)
			{
				return RedirectToAction("Example", new { dictTypeID, pageNumber });
			}
			return RedirectToAction("Example", new { dictTypeID });
		}

		/// <summary>
		/// Lấy thống kê từ điển, dùng cho vẽ biểu đồ trên web
		/// </summary>
		/// <returns></returns>
		[HttpGet("api/GetDictionaryStat"), Authorize]
		public async Task<ChartViewModel> GetDictionaryStat()
		{
			ChartViewModel model = new();
			List<DICT_TYPE> dictTypes = await GetDictTypes();
			model.Title = "Thống kê dữ liệu từ điển";
			model.ColumnTitle = new KeyValuePair<string, string>("Loại từ điển", "Số lượng từ");
			model.Data = new List<KeyValuePair<string, int>>();
			foreach (var dict in dictTypes)
			{
				KeyValuePair<string, int> data = new(dict.Description, await GetTotalWords(dict.DictType));
				model.Data.Add(data);
			}
			return model;
		}

		/// <summary>
		/// Nhập danh sách từ vựng từ tập tin CSV vào loại từ điển được chỉ định
		/// </summary>
		/// <param name="csvFile"></param>
		/// <param name="dictTypeID"></param>
		/// <returns>Mã trạng thái: 200 OK, 400 BadRequest</returns>
		[HttpPost("api/Import"), Authorize]
		[ProducesResponseType(StatusCodes.Status200OK)]
		[ProducesResponseType(StatusCodes.Status400BadRequest)]
		public async Task<IActionResult> ImportFromFile(IFormFile csvFile, int dictTypeID)
		{
			if (csvFile == null || csvFile.Length == 0)
				return StatusCode(StatusCodes.Status400BadRequest, "Không nhận được tập tin CSV");
			try
			{
				// Chuẩn bị dữ liệu
				DataTable dt = csvFile.ReadAsDataTable();
				List<WORD> words = WORDs.ConvertDtToWordList(dt, dictTypeID, HttpContext.Session.GetString(Constants.USERNAME));
				// Kiểm tra dữ liệu có thể chèn vào không
				List<int> errorIndexes = await WORDs.TryInsertingWords(words);
				if (errorIndexes == null)
					return StatusCode(StatusCodes.Status500InternalServerError, "Lỗi máy chủ, vui lòng thử lại sau");
				else if (errorIndexes.Count > 0)
					return BadRequest(errorIndexes);
				// Chèn từ
				WORDs.InsertWords(ref words);

				foreach (var word in words)
				{
					// Cập nhật ID từ vào các nghĩa và chèn nghĩa
					var wordMeanings = word.Meanings;
					wordMeanings.ForEach(m => m.WordID = word.ID);
					MEANINGs.InsertMeanings(ref wordMeanings);

					foreach (var meaning in wordMeanings)
					{
						// Cập nhật ID nghĩa vào các ví dụ và chèn ví dụ
						var meaningExamples = meaning.Examples;
						meaningExamples.ForEach(e => e.MeaningID = meaning.ID);
						await EXAMPLEs.InsertExamples(meaningExamples);
					}
				}
			}
			catch (NoNullAllowedException)
			{
				return StatusCode(StatusCodes.Status400BadRequest, "Hai cột đầu tiên không được để trống");
			}
			catch (InvalidDataException)
			{
				return StatusCode(StatusCodes.Status400BadRequest, "Cột Loại từ có chứa giá trị không hợp lệ, nó chỉ nên chứa các giá trị số từ 0 đến 6");
			}
			catch (FormatException)
			{
				return StatusCode(StatusCodes.Status400BadRequest, "Số lượng cột không đúng quy định");
			}
			catch (InvalidCastException)
			{
				return StatusCode(StatusCodes.Status400BadRequest, "Số cột tiêu đề không đúng với dữ liệu");
			}
			catch (Exception)
			{
				return StatusCode(StatusCodes.Status400BadRequest, "Vui lòng kiểm tra lại tập tin CSV");
			}
			return Ok();
		}
		#endregion

		/// <summary>
		/// Save uploaded audio file to disk and return its full filepath
		/// </summary>
		/// <param name="audio"></param>
		/// <returns></returns>
		public async static Task<string> SaveAudio(IFormFile audio)
		{
			if (audio != null && audio.Length != 0)
			{
				if (audio.ContentType != "audio/wav" && audio.ContentType != "audio/mpeg" && audio.ContentType != "audio/ogg")
					return null;
				else
				{
					// Create file name
					string extension = string.Empty;
					switch (audio.ContentType)
					{
						case "audio/wav":
							extension = "wav";
							break;
						case "audio/mpeg":
							extension = "mp3";
							break;
						case "audio/ogg":
							extension = "ogg";
							break;
					}
					string audioFolder = Path.Combine(_appEnvironment.WebRootPath, "data", "audio");
					string filePath = Path.Combine(audioFolder, Extensions.GetDateTimeFilename(extension));
					// Save to disk
					try
					{
						using FileStream stream = new(filePath, FileMode.Create);
						await audio.CopyToAsync(stream);
					}
					catch (Exception)
					{
						return null;
					}
					return filePath;
				}
			}
			return null;
		}

		/// <summary>
		/// Save uploaded image file to disk and return its full filepath
		/// </summary>
		/// <param name="image"></param>
		/// <returns></returns>
		private async static Task<string> SaveImage(IFormFile image)
		{
			if (image != null && image.Length != 0)
			{
				byte[] imageData = await Extensions.GetBytesFromUpload(image);
				// Create file name
				string extension = Extensions.GetImageFormat(imageData) != null ? (Extensions.GetImageFormat(imageData) == ImageFormat.Jpeg ? ".jpg" : ".png") : null;
				if (extension == null)
					return null;
				string imageFolder = Path.Combine(_appEnvironment.WebRootPath, "data", "images");
				string filePath = Path.Combine(imageFolder, Extensions.GetDateTimeFilename(extension));
				// Save to disk
				try
				{
					using FileStream stream = new(filePath, FileMode.Create);
					await stream.WriteAsync(imageData);
				}
				catch (Exception)
				{
					return null;
				}
				return filePath;
			}
			return null;
		}
	}
}
