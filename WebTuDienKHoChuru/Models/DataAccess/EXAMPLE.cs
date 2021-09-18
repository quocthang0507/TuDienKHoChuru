using DataAccess;
using System;
using System.Collections.Generic;
using System.ComponentModel;
using System.ComponentModel.DataAnnotations;
using System.Threading.Tasks;
using WebTuDienKHoChuru.Utils;

namespace WebTuDienKHoChuru.Models.DataAccess
{
	public class EXAMPLE
	{
		[Key]
		[DisplayName("ID")]
		public int ID { get; set; }

		[DisplayName("ID nghĩa từ")]
		[Required]
		public int MeaningID { get; set; }

		[Required]
		[DisplayName("Ví dụ")]
		public string Example { get; set; }

		[Required]
		[DisplayName("Nghĩa ví dụ")]
		public string Meaning { get; set; }

		[DisplayName("Phát âm")]
		public string PronouncePath { get; set; }

		[DisplayName("Đã xóa")]
		[DefaultValue(false)]
		public bool Deleted { get; set; }

	}

	public class EXAMPLEs
	{
		public static async Task<List<EXAMPLE>> GetExamplesWithPagination(int dictTypeID, int pageNumber)
		{
			try
			{
				return CBO.FillCollection<EXAMPLE>(await SqlDataProvider.Instance.ExecuteReader("proc_GET_EXAMPLES_PAGINATION", dictTypeID, pageNumber, Constants.RowsOfPage));
			}
			catch (Exception)
			{
				return new List<EXAMPLE>();
			}
		}

		public static async Task<int> GetExamplePageNumbers(int dictTypeID)
		{
			try
			{
				return (int)await SqlDataProvider.Instance.ExecuteScalar("proc_GET_EXAMPLE_PAGE_NUMBERS", dictTypeID, Constants.RowsOfPage);
			}
			catch (Exception)
			{
				return 1;
			}
		}

		public static async Task<List<EXAMPLE>> GetExamples(int meaningID)
		{
			try
			{
				return CBO.FillCollection<EXAMPLE>(await SqlDataProvider.Instance.ExecuteReader("proc_GET_EXAMPLES", meaningID));
			}
			catch (Exception)
			{
				return new List<EXAMPLE>();
			}
		}

		public static async Task<bool> InsertExample(EXAMPLE example)
		{
			try
			{
				int result = await SqlDataProvider.Instance.ExecuteNonQuery("proc_INSERT_EXAMPLE", example.MeaningID, example.Example, example.Meaning, example.PronouncePath);
				return result > 0;
			}
			catch (Exception)
			{
				return false;
			}
		}

		public static async Task<bool> InsertExamples(List<EXAMPLE> examples)
		{
			try
			{
				foreach (var example in examples)
				{
					await InsertExample(example);
				}
				return true;
			}
			catch (Exception)
			{
				return false;
			}
		}

		public static async Task<bool> UpdateAudioExample(int exampleID, string pronunPath)
		{
			try
			{
				int result = await SqlDataProvider.Instance.ExecuteNonQuery("proc_UPDATE_AUDIO_EXAMPLE", exampleID, pronunPath);
				return result > 0;
			}
			catch (Exception)
			{
				return false;
			}
		}

		public static async Task<bool> DeleteExample(int exampleID)
		{
			try
			{
				int result = await SqlDataProvider.Instance.ExecuteNonQuery("proc_DELETE_EXAMPLE", exampleID);
				return result > 0;
			}
			catch (Exception)
			{
				return false;
			}
		}
		
		public static async Task<bool> DeleteAllExamples(int wordID)
		{
			try
			{
				int result = await SqlDataProvider.Instance.ExecuteNonQuery("proc_DELETE_ALL_EXAMPLES", wordID);
				return result > 0;
			}
			catch (Exception)
			{
				return false;
			}
		}
	}
}
