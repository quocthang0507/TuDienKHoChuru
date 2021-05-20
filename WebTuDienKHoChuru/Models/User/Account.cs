using System.Text.Json.Serialization;

namespace WebTuDienKHoChuru.Models.User
{
	public class Account
	{
		public int Id { get; set; }

		public string Fullname { get; set; }

		public string Username { get; set; }

		[JsonIgnore]
		public string Password { get; set; }

		public string Role { get; set; }

		public string Token { get; set; }

		public string Email { get; set; }

		public string PhoneNumber { get; set; }

		public string Address { get; set; }

		public Account WithoutPassword()
		{
			if (this == null)
				return null;
			this.Password = null;
			return this;
		}
	}
}