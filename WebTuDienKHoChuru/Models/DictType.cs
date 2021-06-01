using System.Collections.Generic;

#nullable disable

namespace WebTuDienKHoChuru.Models
{
	public partial class DictType
	{
		public DictType()
		{
			BilingualPassages = new HashSet<BilingualPassage>();
			Words = new HashSet<Word>();
		}

		public byte DictType1 { get; set; }
		public string Description { get; set; }

		public virtual ICollection<BilingualPassage> BilingualPassages { get; set; }
		public virtual ICollection<Word> Words { get; set; }
	}
}
