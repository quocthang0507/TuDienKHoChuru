using System.Collections.Generic;

namespace WebTuDienKHoChuru.Models.ViewModel
{
	public class ChartViewModel
	{
		public string Title { get; set; }
		public KeyValuePair<string, string> ColumnTitle { get; set; }
		public List<KeyValuePair<string, int>> Data { get; set; }
	}
}
