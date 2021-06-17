using DataAccess;
using System;
using System.Collections.Generic;
using System.ComponentModel;
using System.ComponentModel.DataAnnotations;
using System.Threading.Tasks;
using WebTuDienKHoChuru.Utils;

namespace WebTuDienKHoChuru.Models.DataAccess
{
	public class WORD
	{
		[Key]
		[DisplayName("ID")]
		public int ID { get; set; }

		[Required]
		[DisplayName("Từ")]
		public string Word { get; set; }

		[Required]
		[DisplayName("Loại từ điển")]
		public int DictType { get; set; }

		[Required]
		[DefaultValue("Others")]
		[StringLength(10)]
		public string WordType { get; set; }

		[DisplayName("Phát âm")]
		public string PronunPath { get; set; }

		[DisplayName("Hình ảnh")]
		public string ImgPath { get; set; }

		[DisplayName("Ngày thêm")]
		public DateTime AddedDate { get; set; }

		[DisplayName("Ngày cập nhật")]
		public DateTime UpdatedDate { get; set; }

		[Required]
		[DisplayName("Người tạo")]
		[StringLength(50)]
		public string Creator { get; set; }

		public List<MEANING> Meanings { get; set; }
	}

	public class WORDs
	{
		public static async Task<List<WORD>> GetWords(int dictTypeID, int pageNumber)
		{
			try
			{
				return CBO.FillCollection<WORD>(await SqlDataProvider.Instance.ExecuteReader("proc_GET_WORDS", dictTypeID, pageNumber, Constants.RowsOfPage));
			}
			catch (Exception)
			{
				return new List<WORD>();
			}
		}

		public static async Task<int> GetPageNumbers(int dictTypeID)
		{
			try
			{
				return (int)await SqlDataProvider.Instance.ExecuteScalar("proc_GET_PAGE_NUMBERS", dictTypeID, Constants.RowsOfPage);
			}
			catch (Exception)
			{
				return 0;
			}
		}

		public static async Task<bool> InsertOrUpdateWord(WORD word)
		{
			try
			{
				int result = 0;
				if (Extensions.IsAllNullOrEmpty(word.PronunPath, word.ImgPath))
					result = await SqlDataProvider.Instance.ExecuteNonQuery("proc_INSERT_UPDATE_WORD", word.ID, word.Word, word.DictType, word.WordType, null, null, word.Creator);
				else if (Extensions.IsAllNullOrEmpty(word.PronunPath))
					result = await SqlDataProvider.Instance.ExecuteNonQuery("proc_INSERT_UPDATE_WORD", word.ID, word.Word, word.DictType, word.WordType, null, word.ImgPath, word.Creator);
				else if (Extensions.IsAllNullOrEmpty(word.ImgPath))
					result = await SqlDataProvider.Instance.ExecuteNonQuery("proc_INSERT_UPDATE_WORD", word.ID, word.Word, word.DictType, word.WordType, word.PronunPath, null, word.Creator);
				else
					result = await SqlDataProvider.Instance.ExecuteNonQuery("proc_INSERT_UPDATE_WORD", word.ID, word.Word, word.DictType, word.WordType, word.PronunPath, word.ImgPath, word.Creator);
				return result > 0;
			}
			catch (Exception)
			{
				return false;
			}
		}

		public static async Task<bool> DeleteWord(int wordID)
		{
			try
			{
				int result = await SqlDataProvider.Instance.ExecuteNonQuery("proc_DELETE_WORD", wordID);
				return result > 0;
			}
			catch (Exception)
			{
				return false;
			}
		}
	}
}
