using Microsoft.AspNetCore.Http;
using System;
using System.Collections.Generic;
using System.Linq;
using System.Threading.Tasks;

namespace WebTuDienKHoChuru.Models.FormModel
{
	public class PassageFormModel
	{
		public int ID { get; set; }
		public int DictType { get; set; }
		public string PassageType { get; set; }
		public string Source { get; set; }
		public string Destination { get; set; }
		public IFormFile AudioFile { get; set; }
	}
}
