namespace WebTuDienKHoChuru.Models.User
{
	public class Account
	{
		public int Id { get; set; }
		public string Fullname { get; set; }
		public string Username { get; set; }
		public string Password { get; set; }
		public string Role { get; set; }
		public string Token { get; set; }

		public Account WithoutPassword()
		{
			if (this == null)
				return null;
			this.Password = null;
			return this;
		}
	}
}