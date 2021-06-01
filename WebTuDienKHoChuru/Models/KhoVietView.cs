using System.ComponentModel;

#nullable disable

namespace WebTuDienKHoChuru.Models
{
	public partial class KhoVietView
	{
		public int Id { get; set; }
		[DisplayName("Từ K'Ho")]
		public string Word { get; set; }
		[DisplayName("Nghĩa tiếng Việt")]
		public string Meaning { get; set; }
		[DisplayName("Hình ảnh minh họa")]
		public string ImgPath { get; set; }
		[DisplayName("Phát âm")]
		public string WordPronun { get; set; }
		[DisplayName("Ví dụ")]
		public string Example { get; set; }
		[DisplayName("Phát âm ví dụ")]
		public string ExPronun { get; set; }
	}
}
