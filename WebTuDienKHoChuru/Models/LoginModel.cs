using System.ComponentModel;
using System.ComponentModel.DataAnnotations;

namespace WebTuDienKHoChuru.Models
{
	public class LoginModel
	{
		[DisplayName("Tên đăng nhập")]
		[Required(ErrorMessage = "Tên đăng nhập là bắt buộc")]
		[StringLength(50, MinimumLength = 5, ErrorMessage = "Tên đăng nhập phải có độ dài từ 5 đến 50 ký tự")]
		public string Username { get; set; }

		[DisplayName("Mật khẩu")]
		[Required(ErrorMessage = "Mật khẩu là bắt buộc")]
		[StringLength(100, MinimumLength = 5, ErrorMessage = "Mật khẩu phải có độ dài từ 5 đến 100 ký tự")]
		[DataType(DataType.Password)]
		public string Password { get; set; }
	}
}