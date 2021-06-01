#nullable disable

namespace WebTuDienKHoChuru.Models
{
	public partial class BilingualPassage
	{
		public int Id { get; set; }
		public byte? DictType { get; set; }
		public string Source { get; set; }
		public string Destination { get; set; }

		public virtual DictType DictTypeNavigation { get; set; }
	}
}
