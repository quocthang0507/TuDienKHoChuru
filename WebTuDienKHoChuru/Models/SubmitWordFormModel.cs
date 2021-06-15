using Microsoft.AspNetCore.Http;

namespace WebTuDienKHoChuru.Models
{
	public class SubmitWordFormModel
	{
		public int WordID { get; set; }
		public string Word { get; set; }
		public string WordType { get; set; }
		public IFormFile ImageFile { get; set; }
		public IFormFile AudioFile { get; set; }
		// JSON format
		public string Meanings { get; set; }
	}
}
