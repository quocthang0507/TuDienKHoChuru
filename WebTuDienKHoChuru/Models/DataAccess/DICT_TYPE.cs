using DataAccess;
using System;
using System.Collections.Generic;
using System.ComponentModel;
using System.ComponentModel.DataAnnotations;
using System.Threading.Tasks;

namespace WebTuDienKHoChuru.Models.DataAccess
{
	public class DICT_TYPE
	{
		[Key]
		[DisplayName("ID")]
		public int DictType { get; set; }

		[Required]
		[DisplayName("Mô tả")]
		public string Description { get; set; }
	}

	public class DICT_TYPEs
	{
		public static async Task<List<DICT_TYPE>> GetDictTypes()
		{
			try
			{
				return CBO.FillCollection<DICT_TYPE>(await SqlDataProvider.Instance.ExecuteReader("proc_GET_DICT_TYPES"));
			}
			catch (Exception)
			{
				return new List<DICT_TYPE>();
			}
		}
	}
}
