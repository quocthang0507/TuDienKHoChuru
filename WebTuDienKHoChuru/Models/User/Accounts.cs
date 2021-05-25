using System.Collections.Generic;
using System.Linq;

namespace WebTuDienKHoChuru.Models.User
{
	public class Accounts
	{
		public List<Account> GetAccounts()
		{
			return new List<Account>
			{
				new Account
				{
					Id=1, Fullname="La Quốc Thắng", Username="admin", Password="admin", Role=Role.Admin
				},
				new Account
				{
					Id=2, Fullname="La Quốc Thắng", Username="colab", Password="colab", Role=Role.Collaborator
				}
			};
		}

		public List<Account> GetAccWithoutPass()
		{
			return GetAccounts().Select(a => a.WithoutPassword()).ToList();
		}
	}
}