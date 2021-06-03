using System;
using System.ComponentModel;
using System.ComponentModel.DataAnnotations;

namespace WebTuDienKHoChuru.Models.DataAccess
{
	public class WORD
	{
		[Key]
		[DisplayName("ID")]
		public int ID { get; set; }

		[Required]
		[DisplayName("Từ")]
		public string Word { get; set; }

		[Required]
		[DisplayName("Loại từ điển")]
		public int DictType { get; set; }

		[DisplayName("Phát âm")]
		public string PronunPath { get; set; }

		[DisplayName("Hình ảnh")]
		public string ImgPath { get; set; }

		[DisplayName("Ngày thêm")]
		public DateTime AddedDate { get; set; }

		[DisplayName("Ngày cập nhật")]
		public DateTime UpdatedDate { get; set; }

		[Required]
		[DisplayName("Người tạo")]
		[StringLength(50)]
		public string Creator { get; set; }
	}
}
