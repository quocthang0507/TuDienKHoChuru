using System.ComponentModel;
using System.ComponentModel.DataAnnotations;

namespace WebTuDienKHoChuru.Models.DataAccess
{
	public class EXAMPLE
	{
		[DisplayName("ID nghĩa từ")]
		public int GlossaryID { get; set; }

		[Required]
		[DisplayName("Ví dụ")]
		public string Example { get; set; }

		[Required]
		[DisplayName("Nghĩa ví dụ")]
		public string Meaning { get; set; }

		[DisplayName("Phát âm")]
		public string PronunPath { get; set; }
	}
}
