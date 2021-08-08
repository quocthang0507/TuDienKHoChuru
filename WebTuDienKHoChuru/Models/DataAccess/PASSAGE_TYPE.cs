using DataAccess;
using System;
using System.Collections.Generic;
using System.ComponentModel;
using System.ComponentModel.DataAnnotations;
using System.Threading.Tasks;

namespace WebTuDienKHoChuru.Models.DataAccess
{
	public class PASSAGE_TYPE
	{
		[Key]
		[DisplayName("Thể loại")]
		public string PassageType { get; set; }

		[DisplayName("Mô tả")]
		[Required]
		public string Description { get; set; }
	}

	public class PASSAGE_TYPEs
	{
		public static async Task<List<PASSAGE_TYPE>> GetPassageTypes()
		{
			try
			{
				return CBO.FillCollection<PASSAGE_TYPE>(await SqlDataProvider.Instance.ExecuteReader("proc_GET_PASSAGE_TYPES"));
			}
			catch (Exception)
			{
				return new List<PASSAGE_TYPE>();
			}
		}
	}
}
