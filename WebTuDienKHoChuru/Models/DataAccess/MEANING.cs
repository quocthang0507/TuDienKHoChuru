using DataAccess;
using System;
using System.Collections.Generic;
using System.ComponentModel;
using System.ComponentModel.DataAnnotations;
using System.Threading.Tasks;

namespace WebTuDienKHoChuru.Models.DataAccess
{
	public class MEANING
	{
		[Key]
		[DisplayName("ID")]
		public int ID { get; set; }

		[DisplayName("ID từ")]
		[Required]
		public int WordID { get; set; }

		[DisplayName("Nghĩa")]
		public string Meaning { get; set; }
	}

	public class MEANINGS
	{
		public static async Task<List<MEANING>> GetMeanings(int wordID)
		{
			try
			{
				return CBO.FillCollection<MEANING>(await SqlDataProvider.Instance.ExecuteReader("proc_GET_MEANINGS", wordID));
			}
			catch (Exception)
			{
				return new List<MEANING>();
			}
		}

		public static async Task<bool> InsertMeaning(MEANING glossary)
		{
			try
			{
				int result = await SqlDataProvider.Instance.ExecuteNonQuery("proc_INSERT_MEANING", glossary.WordID, glossary.Meaning);
				return result > 0;
			}
			catch (Exception)
			{
				return false;
			}
		}
	}
}
