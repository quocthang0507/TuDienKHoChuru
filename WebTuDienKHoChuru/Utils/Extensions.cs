using Microsoft.AspNetCore.Mvc.Rendering;
using System;
using System.Collections.Generic;
using System.Linq;

namespace WebTuDienKHoChuru.Utils
{
	public static class Extensions
	{
		public static string IsSelected(this IHtmlHelper htmlHelper, string controllers, string actions, string cssClass = "active")
		=> IsThisPage(htmlHelper, controllers, actions) ? cssClass : string.Empty;

		public static bool IsThisPage(this IHtmlHelper htmlHelper, string controllers, string actions)
		{
			string currentAction = htmlHelper.ViewContext.RouteData.Values["action"] as string;
			string currentController = htmlHelper.ViewContext.RouteData.Values["controller"] as string;

			IEnumerable<string> acceptedActions = (actions ?? currentAction).Split(',');
			IEnumerable<string> acceptedControllers = (controllers ?? currentController).Split(',');

			return acceptedActions.Contains(currentAction) && acceptedControllers.Contains(currentController);
		}


	}
}