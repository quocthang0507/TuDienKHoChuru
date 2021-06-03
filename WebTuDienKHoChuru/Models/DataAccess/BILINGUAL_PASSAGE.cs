using System.ComponentModel;
using System.ComponentModel.DataAnnotations;

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

		[Required]
		[DisplayName("Đoạn ngôn ngữ nguồn")]
		public string Source { get; set; }

		[Required]
		[DisplayName("Đoạn ngôn ngữ đích")]
		public string Destination { get; set; }
	}
}
