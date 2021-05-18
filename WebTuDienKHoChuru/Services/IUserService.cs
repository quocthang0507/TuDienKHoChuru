using WebTuDienKHoChuru.Models.User;

namespace WebTuDienKHoChuru.Services
{
	public interface IUserService
	{
		Account Authenticate(string username, string password);
	}
}
