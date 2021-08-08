using DataAccess;
using System;
using System.Collections.Generic;
using System.ComponentModel;
using System.ComponentModel.DataAnnotations;
using System.Threading.Tasks;
using WebTuDienKHoChuru.Utils;

namespace WebTuDienKHoChuru.Models.DataAccess
{
	public class BILINGUAL_PASSAGE
	{
		[Key]
		[DisplayName("ID")]
		public int ID { get; set; }

		[Required]
		[DisplayName("Loại từ điển")]
		public int DictType { get; set; }

		[DisplayName("Thể loại")]
		public string PassageType { get; set; }

		[DisplayName("Đoạn ngôn ngữ nguồn")]
		public string Source { get; set; }

		[Required]
		[DisplayName("Đoạn ngôn ngữ đích")]
		public string Destination { get; set; }

		[DisplayName("Ngày thêm")]
		public DateTime AddedDate { get; set; }

		[DisplayName("Ngày cập nhật")]
		public DateTime UpdatedDate { get; set; }

		[Required]
		[DisplayName("Người tạo")]
		[StringLength(50)]
		public string Creator { get; set; }

		[DisplayName("Đã xóa")]
		[DefaultValue(false)]
		public bool Deleted { get; set; }
	}

	public class BILINGUAL_PASSAGEs
	{
		public static async Task<BILINGUAL_PASSAGE> GetPassage(int passageID)
		{
			try
			{
				return CBO.FillObject<BILINGUAL_PASSAGE>(await SqlDataProvider.Instance.ExecuteReader("proc_GET_PASSAGE", passageID));
			}
			catch (Exception)
			{
				return null;
			}
		}

		public static async Task<List<BILINGUAL_PASSAGE>> GetPassagesWithPagination(int dictTypeID, int pageNumber)
		{
			try
			{
				return CBO.FillCollection<BILINGUAL_PASSAGE>(await SqlDataProvider.Instance.ExecuteReader("proc_GET_PASSAGES_PAGINATION", dictTypeID, pageNumber, Constants.RowsOfPage));
			}
			catch (Exception)
			{
				return new List<BILINGUAL_PASSAGE>();
			}
		}

		public static async Task<int> GetPassagePageNumbers(int dictTypeID)
		{
			try
			{
				return (int)await SqlDataProvider.Instance.ExecuteScalar("proc_GET_PASSAGES_PAGE_NUMBERS", dictTypeID, Constants.RowsOfPage);
			}
			catch (Exception)
			{
				return 1;
			}
		}

		public static async Task<int> GetTotalPassages(int dictTypeID)
		{
			try
			{
				int result = Convert.ToInt32(await SqlDataProvider.Instance.ExecuteNonQueryWithoutAffectedRowsWithOutput("@Total", "proc_GET_TOTAL_PASSAGES", dictTypeID, null));
				return result;
			}
			catch (Exception)
			{
				return 0;
			}
		}

		public static async Task<bool> InsertPassage(BILINGUAL_PASSAGE passage)
		{
			try
			{
				int result = await SqlDataProvider.Instance.ExecuteNonQuery("proc_INSERT_PASSAGE", passage.DictType, passage.PassageType, passage.Source, passage.Destination, passage.Creator);
				return result > 0;
			}
			catch (Exception)
			{
				return false;
			}
		}

		public static async Task<bool> UpdatePassage(BILINGUAL_PASSAGE passage)
		{
			try
			{
				int result = await SqlDataProvider.Instance.ExecuteNonQuery("proc_UPDATE_PASSAGE", passage.ID, passage.PassageType, passage.Source, passage.Destination);
				return result > 0;
			}
			catch (Exception)
			{
				return false;
			}
		}

		public static async Task<bool> DeletePassage(int passageID)
		{
			try
			{
				int result = await SqlDataProvider.Instance.ExecuteNonQuery("proc_DELETE_PASSAGE", passageID);
				return result > 0;
			}
			catch (Exception)
			{
				return false;
			}
		}
	}
}
