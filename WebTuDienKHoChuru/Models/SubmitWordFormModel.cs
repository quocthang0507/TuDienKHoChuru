using Microsoft.AspNetCore.Http;
using System.Collections.Generic;
using WebTuDienKHoChuru.Models.DataAccess;

namespace WebTuDienKHoChuru.Models
{
	public class SubmitWordFormModel
	{
		public int WordID { get; set; }
		public string Word { get; set; }
		public int WordTypeID { get; set; }
		public IFormFile ImageFile { get; set; }
		public IFormFile AudioFile { get; set; }
		public List<MEANING> Meanings { get; set; }
	}
}
