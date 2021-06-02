using Microsoft.Extensions.Configuration;
using System;
using System.Text;
using WebTuDienKHoChuru.Services;

namespace WebTuDienKHoChuru.Utils
{
	public class SHA256
	{
		private static SHA256 singleton;
		private readonly IConfiguration Configuration;

		public SHA256(IConfiguration configuration)
		{
			Configuration = configuration;
		}

		public static SHA256 Instance
		{
			get
			{
				if (singleton != null)
					return singleton;
				throw new ArgumentNullException("The object has not initialized in program!");
			}
			set
			{
				singleton = value;
			}
		}

		public string GetSHA256(string plain)
		{
			using System.Security.Cryptography.SHA256 sha256 = System.Security.Cryptography.SHA256.Create();
			byte[] bytes = sha256.ComputeHash(Encoding.UTF8.GetBytes(plain));
			StringBuilder builder = new();
			for (int i = 0; i < bytes.Length; i++)
			{
				builder.Append(bytes[i].ToString("x2"));
			}
			return builder.ToString();
		}

		public string GetSHA256WithSalt(string plain)
		{
			var appSettingsSection = Configuration.GetSection("AppSettings");
			var appSettings = appSettingsSection.Get<AppSettings>();
			return GetSHA256(plain + appSettings.Secret);
		}

		public bool Equals(string hash, string plain)
		{
			return hash.Equals(GetSHA256(plain), StringComparison.OrdinalIgnoreCase);
		}
	}
}
