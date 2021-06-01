#nullable disable

namespace WebTuDienKHoChuru.Models.DataAccess
{
	public partial class Dictionary
	{
		public int Id { get; set; }
		public int? WordId { get; set; }
		public string Meaning { get; set; }

		public virtual Word Word { get; set; }
	}
}
