using Microsoft.AspNetCore.Authorization;
using Microsoft.AspNetCore.Mvc;
using WebTuDienKHoChuru.Models.User;

namespace WebTuDienKHoChuru.Controllers
{
	[Authorize(Roles = Role.Colaborator)]
	public class CollaboratorController : Controller
	{
		// GET: Collaborator
		public ActionResult Index()
		{
			return View();
		}
	}
}