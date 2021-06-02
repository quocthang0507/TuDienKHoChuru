﻿using Microsoft.Extensions.Logging;
using Microsoft.Extensions.Options;
using Microsoft.IdentityModel.Tokens;
using System;
using System.Collections.Generic;
using System.IdentityModel.Tokens.Jwt;
using System.Linq;
using System.Security.Claims;
using System.Text;
using WebTuDienKHoChuru.Models.User;
using WebTuDienKHoChuru.Utils;

namespace WebTuDienKHoChuru.Services
{
	public class UserService : IUserService
	{
		private readonly ILogger<UserService> logger;
		private readonly AppSettings appSettings;

		public UserService(ILogger<UserService> logger, IOptions<AppSettings> appSettings)
		{
			this.logger = logger;
			this.appSettings = appSettings.Value;
		}

		/// <summary>
		/// Returns a key-value pair whose key is one of:
		/// -1: Empty login info
		/// 0: Wrong user login info
		/// 1: Actual user login info
		/// </summary>
		/// <param name="username"></param>
		/// <param name="password"></param>
		/// <returns></returns>
		public KeyValuePair<int, Account> Authenticate(string username, string password)
		{
			logger.LogInformation($"Validating user {username}");

			if (Extensions.IsOneNullOrEmpty(username, password))
				return new KeyValuePair<int, Account>(-1, null);

			List<Account> list = Accounts.GetAccounts();

			Account account = list.SingleOrDefault(a => a.Username.Equals(username, StringComparison.OrdinalIgnoreCase) && SHA256.Instance.Equals(a.Password, password));
			if (account == null)
				return new KeyValuePair<int, Account>(0, null);

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
			return new KeyValuePair<int, Account>(1, account.WithoutPassword());
		}
	}
}