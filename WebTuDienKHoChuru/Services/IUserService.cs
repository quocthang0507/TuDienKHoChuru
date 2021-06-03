using System.Collections.Generic;
using System.Threading.Tasks;
using WebTuDienKHoChuru.Models.User;

namespace WebTuDienKHoChuru.Services
{
	public interface IUserService
	{
		Task<KeyValuePair<int, Account>> Authenticate(string username, string password);
	}
}
