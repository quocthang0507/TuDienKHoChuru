using System.ComponentModel;
using System.ComponentModel.DataAnnotations;

namespace WebTuDienKHoChuru.Models.DataAccess
{
	public class DICTIONARY
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
}
