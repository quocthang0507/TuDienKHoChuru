﻿using System.Collections.Generic;
using WebTuDienKHoChuru.Models.DataAccess;

namespace WebTuDienKHoChuru.Models.ViewModel
{
	public class ManageViewModel
	{
		public List<DICT_TYPE> DictTypes { get; set; }
		public int SelectedDictTypeID { get; set; }
		public int PageNumbers { get; set; }
		public int SelectedPage { get; set; }
		public List<WORD> WordList { get; set; }
		public WORD SelectedWord { get; set; }
		public List<WORD_TYPE> WordTypes { get; set; }
		public List<MEANING> Meanings { get; set; }
	}
}
