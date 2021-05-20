using System.Collections.Generic;
using WebTuDienKHoChuru.Models.User;

namespace WebTuDienKHoChuru.Services
{
	public interface IUserService
	{
		KeyValuePair<int, Account> Authenticate(string username, string password);
	}
}
