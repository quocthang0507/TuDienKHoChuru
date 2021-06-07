using DataAccess;
using System;
using System.Collections.Generic;
using System.Linq;
using System.Threading.Tasks;

namespace WebTuDienKHoChuru.Models.User
{
	public class Accounts
	{
		public static async Task<List<Account>> GetAccounts()
		{
			try
			{
				return CBO.FillCollection<Account>(await SqlDataProvider.Instance.ExecuteReader("proc_GET_ACCOUNTS"));
			}
			catch (Exception)
			{
				return new List<Account>();
			}
		}

		public static async Task<List<Account>> GetAccWithoutPass()
		{
			return (await GetAccounts()).Select(a => a.WithoutPassword()).ToList();
		}

		public static async Task<bool> InsertAccount(Account account)
		{
			try
			{
				int result = await SqlDataProvider.Instance.ExecuteNonQuery("proc_INSERT_ACCOUNT",
					account.Fullname, account.Username, account.Password, account.Role, account.Email, account.PhoneNumber, account.Address);
				return result > 0;
			}
			catch (Exception)
			{
				return false;
			}
		}

		public static async Task<bool> UpdateAccount(Account account)
		{
			try
			{
				int result = await SqlDataProvider.Instance.ExecuteNonQuery("proc_UPDATE_ACCOUNT",
					account.Id, account.Fullname, account.Username, account.Password, account.Role, account.Email, account.PhoneNumber, account.Address);
				return result > 0;
			}
			catch (Exception)
			{
				return false;
			}
		}

		public static async Task<Account> FindOne(string username)
		{
			try
			{
				var account = (await GetAccounts()).Single(acc => acc.Username.Equals(username, StringComparison.OrdinalIgnoreCase));
				return account;
			}
			catch (Exception)
			{
				return null;
			}
		}
	}
}