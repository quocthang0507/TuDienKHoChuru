using System.ComponentModel;
using System.ComponentModel.DataAnnotations;

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
}
