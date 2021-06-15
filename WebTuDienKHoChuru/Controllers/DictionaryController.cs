using Microsoft.AspNetCore.Authorization;
using Microsoft.AspNetCore.Hosting;
using Microsoft.AspNetCore.Http;
using Microsoft.AspNetCore.Mvc;
using System;
using System.Collections.Generic;
using System.Drawing.Imaging;
using System.IO;
using System.Linq;
using System.Threading.Tasks;
using WebTuDienKHoChuru.Models;
using WebTuDienKHoChuru.Models.DataAccess;
using WebTuDienKHoChuru.Utils;

namespace WebTuDienKHoChuru.Controllers
{
	public class DictionaryController : Controller
	{
		private readonly IWebHostEnvironment _appEnvironment;

		public DictionaryController(IWebHostEnvironment hostingEnvironment)
		{
			_appEnvironment = hostingEnvironment;
		}

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
			model.SelectedWord.ImgPath = ConvertRelativePath(model.SelectedWord.ImgPath);
			model.SelectedWord.PronunPath = ConvertRelativePath(model.SelectedWord.PronunPath);

			ViewBag.ViewModel = model;
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
		[HttpPost("api/AddOrUpdateWord"), Authorize]
		[ValidateAntiForgeryToken]
		[ProducesResponseType(StatusCodes.Status200OK)]
		[ProducesResponseType(StatusCodes.Status415UnsupportedMediaType)]
		[ProducesResponseType(StatusCodes.Status400BadRequest)]
		public async Task<IActionResult> AddOrUpdateWord([FromForm] SubmitWordFormModel form)
		{
			if (ModelState.IsValid && form != null)
			{
				string imagePath = string.Empty, audioPath = string.Empty;
				// Kiểm tra âm thanh và hình ảnh có nằm trong form không, nếu có thì lưu lại và lấy đường dẫn
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
				bool result = await WORDs.InsertOrUpdateWord(new WORD
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
					return BadRequest("Lỗi khi cập nhật các từ vựng vào cơ sở dữ liệu");

				// Cập nhật vào cơ sở dữ liệu bảng MEANING
				result = await MEANINGS.InsertMeanings(form.Meanings);
				if (!result)
					return BadRequest("Lỗi khi thêm các nghĩa vào cơ sở dữ liệu");

				return Ok("Lưu thành công");
			}
			return BadRequest("URL này chỉ dùng cho phương thức POST mà thôi");
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

		/// <summary>
		/// Save uploaded audio file to disk and return its full filepath
		/// </summary>
		/// <param name="audio"></param>
		/// <returns></returns>
		private async Task<string> SaveAudio(IFormFile audio)
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
		private async Task<string> SaveImage(IFormFile image)
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

		private string ConvertRelativePath(string absolutePath)
		{
			return absolutePath.Replace(_appEnvironment.WebRootPath, "").Replace(@"\", "/");
		}
	}
}
