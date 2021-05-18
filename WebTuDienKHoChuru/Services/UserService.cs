using Microsoft.Extensions.Logging;
using Microsoft.IdentityModel.Tokens;
using System;
using System.Collections.Generic;
using System.IdentityModel.Tokens.Jwt;
using System.Linq;
using System.Security.Claims;
using System.Text;
using WebTuDienKHoChuru.Models.User;

namespace WebTuDienKHoChuru.Services
{
	public class UserService : IUserService
	{
		private readonly ILogger<UserService> logger;
		private readonly AppSettings appSettings;

		public UserService(ILogger<UserService> logger, AppSettings appSettings)
		{
			this.logger = logger;
			this.appSettings = appSettings;
		}

		public Account Authenticate(string username, string password)
		{
			logger.LogInformation($"Validating user {username}");
			Accounts users = new Accounts();
			List<Account> list = users.GetAccounts();
			Account account = list.SingleOrDefault(a =>
			  a.Username.Equals(username, StringComparison.OrdinalIgnoreCase) &&
			  a.Password.Equals(password));
			if (account == null)
				return null;

			var tokenHandler = new JwtSecurityTokenHandler();
			var key = Encoding.UTF8.GetBytes(appSettings.Secret);
			var tokenDescriptor = new SecurityTokenDescriptor
			{
				Subject = new ClaimsIdentity(new Claim[]
				{
					new Claim(ClaimTypes.Name, account.Username),
					new Claim(ClaimTypes.Role, account.Role)
				}),
				Expires = DateTime.UtcNow.AddDays(1),
				SigningCredentials = new SigningCredentials(new SymmetricSecurityKey(key), SecurityAlgorithms.HmacSha256Signature)
			};
			var token = tokenHandler.CreateToken(tokenDescriptor);
			account.Token = tokenHandler.WriteToken(token);
			return account.WithoutPassword();
		}
	}
}