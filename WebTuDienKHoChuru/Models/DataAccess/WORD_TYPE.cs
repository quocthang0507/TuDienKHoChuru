using System.ComponentModel;
using System.ComponentModel.DataAnnotations;

namespace WebTuDienKHoChuru.Models.DataAccess
{
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
}
