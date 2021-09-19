using DataAccess;
using System;
using System.Collections.Generic;
using System.ComponentModel;
using System.ComponentModel.DataAnnotations;
using System.Data;
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
		public string PronouncePath { get; set; }

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

		[DisplayName("Đã xóa")]
		[DefaultValue(false)]
		public bool Deleted { get; set; }

		public List<MEANING> Meanings { get; set; }

		public static WORD NullObject(int dictTypeID)
		{
			return new WORD
			{
				ID = 0,
				Word = string.Empty,
				DictType = dictTypeID,
				WordType = "Others",
				PronouncePath = string.Empty,
				ImgPath = string.Empty,
				AddedDate = DateTime.Now,
				UpdatedDate = DateTime.Now,
				Creator = string.Empty,
				Meanings = new List<MEANING>()
			};
		}
	}

	public class WORDs
	{
		public static async Task<int> GetTotalWords(int dictTypeID)
		{
			try
			{
				int result = Convert.ToInt32(await SqlDataProvider.Instance.ExecuteNonQueryWithoutAffectedRowsWithOutput("@Total", "proc_GET_TOTAL_WORDS", dictTypeID, null));
				return result;
			}
			catch (Exception)
			{
				return 0;
			}
		}

		public static async Task<List<WORD>> GetWordsWithPagination(int dictTypeID, int pageNumber)
		{
			try
			{
				return CBO.FillCollection<WORD>(await SqlDataProvider.Instance.ExecuteReader("proc_GET_WORDS_PAGINATION", dictTypeID, pageNumber, Constants.RowsOfPage));
			}
			catch (Exception)
			{
				return new List<WORD>();
			}
		}

		public static async Task<int> GetWordPageNumbers(int dictTypeID)
		{
			try
			{
				return (int)await SqlDataProvider.Instance.ExecuteScalar("proc_GET_WORD_PAGE_NUMBERS", dictTypeID, Constants.RowsOfPage);
			}
			catch (Exception)
			{
				return 1;
			}
		}

		public static async Task<bool> UpdateWord(WORD word)
		{
			try
			{
				int result = await SqlDataProvider.Instance.ExecuteNonQuery("proc_UPDATE_WORD", word.ID, word.Word, word.DictType, word.WordType, word.PronouncePath, word.ImgPath, word.Creator);
				return result > 0;
			}
			catch (Exception)
			{
				return false;
			}
		}

		public static async Task<bool> InsertWord(WORD word)
		{
			try
			{
				int result = await SqlDataProvider.Instance.ExecuteNonQuery("proc_INSERT_WORD", word.Word, word.DictType, word.WordType, word.PronouncePath, word.ImgPath, word.Creator);
				return result > 0;
			}
			catch (Exception)
			{
				return false;
			}
		}

		public static async Task<WORD> InsertAndReturnWordWithID(WORD word)
		{
			try
			{
				int id = Convert.ToInt32(await SqlDataProvider.Instance.ExecuteNonQueryWithoutAffectedRowsWithOutput("@ID", "proc_INSERT_WORD_OUTPUT", null, word.Word, word.DictType, word.WordType, word.PronouncePath, word.ImgPath, word.Creator));
				word.ID = id;
				return word;
			}
			catch (Exception)
			{
				return null;
			}
		}

		public static async Task<int> GetMaxID()
		{
			try
			{
				return Convert.ToInt32(await SqlDataProvider.Instance.ExecuteNonQueryWithoutAffectedRowsWithOutput("@MAX", "proc_GET_MAX_ID_WORD", null));
			}
			catch (Exception)
			{
				return -1;
			}
		}

		public static async Task<bool> ResetID(int newIdentity)
		{
			try
			{
				int result = await SqlDataProvider.Instance.ExecuteNonQuery("proc_RESET_IDENTITY_WORD", newIdentity);
				return result > 0;
			}
			catch (Exception)
			{
				return false;
			}
		}

		public static List<WORD> ConvertDtToWordList(DataTable dt, int dictTypeID, string creator)
		{
			List<WORD> wordList = new();
			foreach (DataRow row in dt.Rows)
			{
				EXAMPLE ex1, ex2;
				MEANING meaning;
				WORD word;
				string ex1_e, ex1_m, ex2_e, ex2_m, word_w, word_m;
				switch (dt.Columns.Count)
				{
					case 6:
						// Thêm hai ví dụ
						word_w = row[0].ToString();
						word_m = row[1].ToString();
						ex1_e = row[2].ToString();
						ex1_m = row[3].ToString();
						ex2_e = row[4].ToString();
						ex2_m = row[5].ToString();
						ex2 = new()
						{
							Example = ex2_e,
							Meaning = ex2_m
						};
						ex1 = new()
						{
							Example = ex1_e,
							Meaning = ex1_m
						};
						// Thêm nghĩa cùng với hai ví dụ ở trên
						meaning = new()
						{
							Meaning = word_m,
							Examples = new()
						};
						if (!Extensions.IsAllNullOrEmpty(ex1_e, ex1_m))
							meaning.Examples.Add(ex1);
						if (!Extensions.IsAllNullOrEmpty(ex2_e, ex2_m))
							meaning.Examples.Add(ex2);
						// Thêm từ cùng với nghĩa ở trên
						word = new()
						{
							Word = word_w,
							WordType = Enum.GetName(typeof(WordTypeEnum), 6),
							Meanings = new(),
							Creator = creator,
							DictType = dictTypeID
						};
						word.Meanings.Add(meaning);
						break;
					case 4:
						// Thêm ví dụ
						word_w = row[0].ToString();
						word_m = row[1].ToString();
						ex1_e = row[2].ToString();
						ex1_m = row[3].ToString();
						ex1 = new()
						{
							Example = ex1_e,
							Meaning = ex1_m
						};
						// Thêm nghĩa cùng với ví dụ ở trên
						meaning = new()
						{
							Meaning = word_m,
							Examples = new()
						};
						if (!Extensions.IsAllNullOrEmpty(ex1_e, ex1_m))
							meaning.Examples.Add(ex1);
						// Thêm từ cùng với nghĩa ở trên
						word = new()
						{
							Word = word_w,
							WordType = Enum.GetName(typeof(WordTypeEnum), 6),
							Meanings = new(),
							Creator = creator,
							DictType = dictTypeID
						};
						word.Meanings.Add(meaning);
						break;
					case 2:
						// Thêm nghĩa
						word_w = row[0].ToString();
						word_m = row[1].ToString();
						meaning = new()
						{
							Meaning = word_m
						};
						// Thêm từ cùng với nghĩa ở trên
						word = new()
						{
							Word = word_w,
							WordType = Enum.GetName(typeof(WordTypeEnum), 6),
							Meanings = new(),
							Creator = creator,
							DictType = dictTypeID
						};
						word.Meanings.Add(meaning);
						break;
					default:
						return null;
				}
				wordList.Add(word);
			}
			return wordList;
		}

		/// <summary>
		/// Try inserting a word into Word table but not store anything
		/// </summary>
		/// <param name="word"></param>
		/// <returns></returns>
		public static async Task<bool> TryInsertingWord(WORD word)
		{
			try
			{
				int result = await SqlDataProvider.Instance.ExecuteNonQuery("proc_INSERT_WORD_TEST", word.Word, word.DictType, word.WordType, word.PronouncePath, word.ImgPath, word.Creator);
				return result > 0;
			}
			catch (Exception)
			{
				return false;
			}
		}

		/// <summary>
		/// 
		/// </summary>
		/// <param name="wordList"></param>
		/// <returns>Return a list of row indexes that can't be inserted into Word table</returns>
		public static async Task<List<int>> TryInsertingWords(List<WORD> wordList)
		{
			int oldMaxID = await GetMaxID();
			if (oldMaxID == -1)
				return null;
			List<int> result = new();
			for (int i = 0; i < wordList.Count; i++)
			{
				if (!await TryInsertingWord(wordList[i]))
					result.Add(i);
			}
			await ResetID(oldMaxID);
			return result;
		}

		public static void InsertWords(ref List<WORD> wordList)
		{
			try
			{
				for (int i = 0; i < wordList.Count; i++)
				{
					WORD @new = InsertAndReturnWordWithID(wordList[i]).Result;
					wordList[i] = @new;
				}
			}
			catch (Exception)
			{
				wordList = null;
			}
		}

		public static async Task<int> DeleteWord(int wordID)
		{
			try
			{
				int result = Convert.ToInt32(await SqlDataProvider.Instance.ExecuteNonQueryWithOutput("@OutputID", "proc_DELETE_WORD", wordID, null));
				return result;
			}
			catch (Exception)
			{
				return -1;
			}
		}
	}
}
