using Microsoft.AspNetCore.Http;
using System.Collections.Generic;
using WebTuDienKHoChuru.Models.DataAccess;

namespace WebTuDienKHoChuru.Models
{
	public class ManageWordFormModel
	{
		public int WordID;
		public int DictTypeID;
		public IFormFile Image;
		public IFormFile Pronun;
		public List<WORD> Meanings;
	}
}
