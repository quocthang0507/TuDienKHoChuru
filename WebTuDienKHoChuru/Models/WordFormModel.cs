using Microsoft.AspNetCore.Http;
using Newtonsoft.Json;
using System;
using System.Collections.Generic;
using WebTuDienKHoChuru.Models.DataAccess;

namespace WebTuDienKHoChuru.Models
{
	public class WordFormModel
	{
		public int WordID { get; set; }
		public string Word { get; set; }
		public string WordType { get; set; }
		public int DictType { get; set; }
		public IFormFile ImageFile { get; set; }
		public IFormFile AudioFile { get; set; }
		public string JMeanings { get; set; }
		public List<MEANING> Meanings
		{
			get
			{
				try
				{
					return JsonConvert.DeserializeObject<List<MEANING>>(JMeanings);
				}
				catch (Exception)
				{
					return new List<MEANING>();
				}
			}
		}
	}
}
