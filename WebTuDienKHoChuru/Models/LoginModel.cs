using System.ComponentModel.DataAnnotations;

namespace WebTuDienKHoChuru.Models
{
	public class LoginModel
	{
		[Required]
		[StringLength(50, MinimumLength = 5)]
		public string Username { get; set; }

		[Required]
		[StringLength(50, MinimumLength = 5)]
		public string Password { get; set; }
	}
}