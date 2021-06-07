using DataAccess;
using System;
using System.ComponentModel;
using System.ComponentModel.DataAnnotations;
using System.Threading.Tasks;

namespace WebTuDienKHoChuru.Models.DataAccess
{
	public class GLOSSARY
	{
		[Key]
		[DisplayName("ID")]
		public int ID { get; set; }

		[DisplayName("ID từ")]
		[Required]
		public int WordID { get; set; }

		[DisplayName("Nghĩa")]
		public string Meaning { get; set; }
	}

	public class GLOSSARIES
	{
		public static async Task<bool> InsertGlossary(GLOSSARY glossary)
		{
			try
			{
				int result = await SqlDataProvider.Instance.ExecuteNonQuery("proc_INSERT_GLOSSARY", glossary.WordID, glossary.Meaning);
				return result > 0;
			}
			catch (Exception)
			{
				return false;
			}
		}
	}
}
