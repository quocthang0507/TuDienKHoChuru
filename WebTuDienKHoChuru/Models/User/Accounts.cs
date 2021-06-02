using DataAccess;
using System;
using System.Collections.Generic;
using System.Linq;

namespace WebTuDienKHoChuru.Models.User
{
	public class Accounts
	{
		public static List<Account> GetAccounts()
		{
			try
			{
				return CBO.FillCollection<Account>(SqlDataProvider.Instance.ExecuteReader("GET_ACCOUNTS"));
			}
			catch (Exception)
			{
				return new List<Account>();
			}
		}

		public static List<Account> GetAccWithoutPass()
		{
			return GetAccounts().Select(a => a.WithoutPassword()).ToList();
		}

		public static bool UpdateAccount(Account account)
		{
			try
			{
				int result = SqlDataProvider.Instance.ExecuteNonQuery("UPDATE_ACCOUNT",
					account.Id, account.Fullname, account.Username, account.Password, account.Role, account.Email, account.PhoneNumber, account.Address);
				return result > 0;
			}
			catch (Exception)
			{
				return false;
			}
		}

		public static Account FindOne(string username)
		{
			try
			{
				var account = GetAccounts().Single(acc => acc.Username.Equals(username, StringComparison.OrdinalIgnoreCase));
				return account;
			}
			catch (Exception)
			{
				return null;
			}
		}
	}
}