using Microsoft.AspNetCore.Hosting;
using Microsoft.AspNetCore.Http;
using Microsoft.AspNetCore.Mvc.Rendering;
using System;
using System.Collections.Generic;
using System.Data;
using System.Drawing.Imaging;
using System.IO;
using System.Linq;
using System.Text;
using System.Threading.Tasks;

namespace WebTuDienKHoChuru.Utils
{
	public static class Extensions
	{
		/// <summary>
		/// Return a CSS class if current page is the same as specific action in controller
		/// </summary>
		/// <param name="htmlHelper"></param>
		/// <param name="controller"></param>
		/// <param name="action"></param>
		/// <param name="cssClass"></param>
		/// <returns></returns>
		public static string IsSelected(this IHtmlHelper htmlHelper, string controller, string action, string cssClass = "active")
		=> IsThisPage(htmlHelper, controller, action) ? cssClass : string.Empty;

		/// <summary>
		/// Check current page is the same as specific action in controller
		/// </summary>
		/// <param name="htmlHelper"></param>
		/// <param name="controller"></param>
		/// <param name="action"></param>
		/// <returns></returns>
		public static bool IsThisPage(this IHtmlHelper htmlHelper, string controller, string action)
		{
			string currentAction = htmlHelper.ViewContext.RouteData.Values["action"] as string;
			string currentController = htmlHelper.ViewContext.RouteData.Values["controller"] as string;

			IEnumerable<string> acceptedActions = (action ?? currentAction).Split(',');
			IEnumerable<string> acceptedControllers = (controller ?? currentController).Split(',');

			return acceptedActions.Contains(currentAction) && acceptedControllers.Contains(currentController);
		}

		/// <summary>
		/// Check if all parameters have one null or empty
		/// </summary>
		/// <param name="strings"></param>
		/// <returns></returns>
		public static bool IsOneNullOrEmpty(params string[] strings)
		{
			foreach (var str in strings)
			{
				if (string.IsNullOrEmpty(str))
					return true;
			}
			return false;
		}

		/// <summary>
		/// Check if all parameters are null or empty
		/// </summary>
		/// <param name="strings"></param>
		/// <returns></returns>
		public static bool IsAllNullOrEmpty(params string[] strings)
		{
			foreach (var str in strings)
			{
				if (!string.IsNullOrEmpty(str))
					return false;
			}
			return true;
		}

		public static bool EqualOne<T>(this T obj, params T[] values)
		{
			foreach (var value in values)
			{
				if (obj.Equals(value))
					return true;
			}
			return false;
		}

		public static bool EqualAll<T>(this T obj, params T[] values)
		{
			foreach (var value in values)
			{
				if (!obj.Equals(value))
					return false;
			}
			return true;
		}

		/// <summary>
		/// Return a random filename with specifc length (with extension part)
		/// </summary>
		/// <param name="ext"></param>
		/// <param name="length"></param>
		/// <returns></returns>
		public static string GetRandomFilename(string ext, int length = 10)
		{
			Random random = new();
			string chars = "abcdefghijklmnopqrstuvwxyzABCDEFGHIJKLMNOPQRSTUVWXYZ0123456789";
			return string.Concat(new string(Enumerable.Repeat(chars, length)
			  .Select(s => s[random.Next(s.Length)]).ToArray()),
			  ext.Contains('.') ? ext : "." + ext);
		}

		/// <summary>
		/// Return a datetime filename with extension part
		/// </summary>
		/// <param name="ext"></param>
		/// <returns></returns>
		public static string GetDateTimeFilename(string ext)
		{
			return string.Concat(DateTime.Now.ToString("yyyyMMdd_HHmmss.fff"), ext.Contains('.') ? ext : "." + ext);
		}

		/// <summary>
		/// Transform a IFormFile to byte array
		/// </summary>
		/// <param name="file"></param>
		/// <returns></returns>
		public static async Task<byte[]> GetBytesFromUpload(IFormFile file)
		{
			MemoryStream stream = new();
			await file.CopyToAsync(stream);
			byte[] data = stream.ToArray();
			return data;
		}

		/// <summary>
		/// Get image format
		/// </summary>
		/// <param name="bytes"></param>
		/// <returns></returns>
		public static ImageFormat GetImageFormat(byte[] bytes)
		{
			byte[] bmp = Encoding.ASCII.GetBytes("BM");
			byte[] gif = Encoding.ASCII.GetBytes("GIF");
			byte[] png = new byte[] { 137, 80, 78, 71 };
			byte[] tiff = new byte[] { 73, 73, 42 };
			byte[] tiff2 = new byte[] { 77, 77, 42 };
			byte[] jpeg = new byte[] { 255, 216, 255, 224 };
			byte[] jpeg2 = new byte[] { 255, 216, 255, 225 };

			if (bmp.SequenceEqual(bytes.Take(bmp.Length)))
				return ImageFormat.Bmp;
			else if (gif.SequenceEqual(bytes.Take(gif.Length)))
				return ImageFormat.Gif;
			else if (png.SequenceEqual(bytes.Take(png.Length)))
				return ImageFormat.Png;
			else if (tiff.SequenceEqual(bytes.Take(tiff.Length)))
				return ImageFormat.Tiff;
			else if (tiff2.SequenceEqual(bytes.Take(tiff2.Length)))
				return ImageFormat.Tiff;
			else if (jpeg.SequenceEqual(bytes.Take(jpeg.Length)))
				return ImageFormat.Jpeg;
			else if (jpeg2.SequenceEqual(bytes.Take(jpeg2.Length)))
				return ImageFormat.Jpeg;

			return null;
		}

		public static string ConvertRelativePath(this IWebHostEnvironment webHost, string absolutePath)
		{
			return string.IsNullOrWhiteSpace(absolutePath) ? null : absolutePath.Replace(webHost.WebRootPath, "").Replace(@"\", "/");
		}

		public static DataTable ReadAsDataTable(this IFormFile file, char delimiter = '\t')
		{
			DataTable dt = new();
			using (StreamReader reader = new(file.OpenReadStream()))
			{
				for (int i = 0; reader.Peek() >= 0; i++)
				{
					string line = reader.ReadLine();
					if (!string.IsNullOrWhiteSpace(line))
					{
						string[] values = line.Split(delimiter);
						if (!values.Length.EqualOne(2, 4, 6))
							throw new FormatException("Accepts only these columns");
						// Column names
						if (i == 0)
						{
							DataColumn[] columns = values.Select(h => new DataColumn(h.Trim(), typeof(string))).ToArray();
							dt.Columns.AddRange(columns);
						}
						// Data
						else
						{
							if (values.Length != dt.Columns.Count)
								throw new InvalidCastException("There are row(s) that not fit the number of the headers");
							else if (Extensions.IsOneNullOrEmpty(values[0], values[1]))
								throw new NoNullAllowedException("Two first cells in this row should not be blank");
							else
							{
								DataRow row = dt.NewRow();
								for (int j = 0; j < values.Length; j++)
								{
									row[j] = values[j].Trim();
								}
								dt.Rows.Add(row);
							}
						}
					}
				}
			}
			return dt;
		}
	}
}