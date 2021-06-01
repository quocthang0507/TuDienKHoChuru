#nullable disable

namespace WebTuDienKHoChuru.Models.DataAccess
{
	public partial class Example
	{
		public int Id { get; set; }
		public int? WordId { get; set; }
		public string Example1 { get; set; }
		public string PronunPath { get; set; }

		public virtual Word Word { get; set; }
	}
}
