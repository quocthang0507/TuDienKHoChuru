using System.ComponentModel;
using System.ComponentModel.DataAnnotations;
using System.Text.Json.Serialization;

namespace WebTuDienKHoChuru.Models.User
{
	public class Account
	{
		[Key]
		public int Id { get; set; }

		[DisplayName("Họ và tên")]
		[Required(ErrorMessage = "Họ và tên là bắt buộc")]
		[StringLength(100, ErrorMessage = "Họ và tên của bạn phải ít hơn 100 ký tự")]
		public string Fullname { get; set; }

		[DisplayName("Tên đăng nhập")]
		[Required(ErrorMessage = "Tên đăng nhập là bắt buộc")]
		[StringLength(50, MinimumLength = 5, ErrorMessage = "Tên đăng nhập phải có độ dài từ 5 đến 50 ký tự")]
		[Key]
		public string Username { get; set; }

		[JsonIgnore]
		[DisplayName("Mật khẩu")]
		[StringLength(100, MinimumLength = 5, ErrorMessage = "Mật khẩu phải có độ dài từ 5 đến 100 ký tự")]
		public string Password { get; set; }

		[DisplayName("Vai trò")]
		[StringLength(100, ErrorMessage = "Vai trò phải có ít hơn 100 ký tự")]
		public string Role { get; set; }

		public string Token { get; set; }

		[DisplayName("Địa chỉ email")]
		[StringLength(100, ErrorMessage = "Địa chỉ email của bạn phải ít hơn 100 ký tự")]
		[DataType(DataType.EmailAddress)]
		public string Email { get; set; }

		[DisplayName("Số điện thoại")]
		[StringLength(10, ErrorMessage = "Số điện thoại của bạn phải 10 ký tự")]
		[DataType(DataType.PhoneNumber)]
		public string PhoneNumber { get; set; }

		[DisplayName("Địa chỉ")]
		[Required(ErrorMessage = "Địa chỉ là bắt buộc")]
		[StringLength(200, ErrorMessage = "Địa chỉ của bạn phải ít hơn 200 ký tự")]
		public string Address { get; set; }

		[DisplayName("Kích hoạt")]
		[DefaultValue(true)]
		public bool Active { get; set; }

		public Account WithoutPassword()
		{
			if (this == null)
				return null;
			Password = null;
			return this;
		}
	}
}