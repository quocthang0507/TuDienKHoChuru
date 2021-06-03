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
	}
}
