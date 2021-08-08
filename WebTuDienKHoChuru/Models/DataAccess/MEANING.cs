using DataAccess;
using Newtonsoft.Json;
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

		[DisplayName("Đã xóa")]
		[DefaultValue(false)]
		public bool Deleted { get; set; }

		public List<EXAMPLE> Examples { get; set; }
	}

	public class MEANINGs
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

		private static async Task<bool> InsertMeaning(MEANING meaning)
		{
			try
			{
				int result = await SqlDataProvider.Instance.ExecuteNonQuery("proc_INSERT_MEANING", meaning.WordID, meaning.Meaning);
				return result > 0;
			}
			catch (Exception)
			{
				return false;
			}
		}

		public static async Task<bool> InsertMeanings(List<MEANING> meanings, int wordID = 0)
		{
			try
			{
				// Xoá hết các nghĩa cũ 
				if (wordID == 0)
					await DeleteAllMeanings(meanings[0].WordID);
				else
					await DeleteAllMeanings(wordID);

				// Thêm các nghĩa mới vào
				foreach (var meaning in meanings)
				{
					await InsertMeaning(meaning);
				}
				return true;
			}
			catch (Exception)
			{
				return false;
			}
		}

		public static async Task<MEANING> InsertAndReturnMeaningWithID(MEANING meaning)
		{
			try
			{
				int id = Convert.ToInt32(await SqlDataProvider.Instance.ExecuteNonQueryWithOutput("@ID", "proc_INSERT_MEANING_OUTPUT", null, meaning.WordID, meaning.Meaning));
				meaning.ID = id;
				return meaning;
			}
			catch (Exception)
			{
				return null;
			}
		}

		public static void InsertMeanings(ref List<MEANING> meaningList)
		{
			try
			{
				for (int i = 0; i < meaningList.Count; i++)
				{
					MEANING @new = InsertAndReturnMeaningWithID(meaningList[i]).Result;
					meaningList[i] = @new;
				}
			}
			catch (Exception)
			{
				meaningList = null;
			}
		}

		private static async Task<bool> DeleteAllMeanings(int wordID)
		{
			try
			{
				int result = await SqlDataProvider.Instance.ExecuteNonQuery("proc_DELETE_ALL_MEANINGS", wordID);
				return result > 0;
			}
			catch (Exception)
			{
				return false;
			}
		}
	}
}
