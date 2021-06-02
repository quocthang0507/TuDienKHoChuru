using System.ComponentModel;
using System.ComponentModel.DataAnnotations;

namespace WebTuDienKHoChuru.Models
{
	public class ChangePasswordModel
	{
		[DisplayName("Mật khẩu cũ")]
		[Required(ErrorMessage = "Mật khẩu cũ là bắt buộc")]
		[StringLength(100, MinimumLength = 5, ErrorMessage = "Mật khẩu phải có độ dài từ 5 đến 100 ký tự")]
		[DataType(DataType.Password)]
		public string OldPassword { get; set; }

		[DisplayName("Mật khẩu mới")]
		[Required(ErrorMessage = "Mật khẩu mới là bắt buộc")]
		[StringLength(100, MinimumLength = 5, ErrorMessage = "Mật khẩu phải có độ dài từ 5 đến 100 ký tự")]
		[DataType(DataType.Password)]
		public string NewPassword { get; set; }

		[DisplayName("Mật khẩu xác nhận")]
		[Required(ErrorMessage = "Mật khẩu xác nhận là bắt buộc")]
		[StringLength(100, MinimumLength = 5, ErrorMessage = "Mật khẩu phải có độ dài từ 5 đến 100 ký tự")]
		[DataType(DataType.Password)]
		[Compare("NewPassword", ErrorMessage = "Mật khẩu xác nhận không khớp mật khẩu mới")]
		public string ConfirmedPassword { get; set; }
	}
}
