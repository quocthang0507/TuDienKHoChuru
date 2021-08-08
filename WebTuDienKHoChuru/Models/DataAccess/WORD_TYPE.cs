using DataAccess;
using System;
using System.Collections.Generic;
using System.ComponentModel;
using System.ComponentModel.DataAnnotations;
using System.Threading.Tasks;

namespace WebTuDienKHoChuru.Models.DataAccess
{
	public enum WordTypeEnum
	{
		Noun,
		Verb,
		Adjective,
		Adverb,
		Pronoun,
		Prep,
		Others
	}

	public class WORD_TYPE
	{
		[Key]
		[DisplayName("ID")]
		[StringLength(10)]
		public string WordType { get; set; }

		[Required]
		[DisplayName("Mô tả")]
		public string Description { get; set; }
	}

	public class WORD_TYPEs
	{
		public static async Task<List<WORD_TYPE>> GetWordTypes()
		{
			try
			{
				return CBO.FillCollection<WORD_TYPE>(await SqlDataProvider.Instance.ExecuteReader("proc_GET_WORD_TYPES"));
			}
			catch (Exception)
			{
				return new List<WORD_TYPE>();
			}
		}
	}
}
