using System.Collections.Generic;

#nullable disable

namespace WebTuDienKHoChuru.Models
{
	public partial class Word
	{
		public Word()
		{
			Dictionaries = new HashSet<Dictionary>();
			Examples = new HashSet<Example>();
		}

		public int Id { get; set; }
		public string Word1 { get; set; }
		public byte? DictType { get; set; }
		public string PronunPath { get; set; }
		public string ImgPath { get; set; }

		public virtual DictType DictTypeNavigation { get; set; }
		public virtual ICollection<Dictionary> Dictionaries { get; set; }
		public virtual ICollection<Example> Examples { get; set; }
	}
}
