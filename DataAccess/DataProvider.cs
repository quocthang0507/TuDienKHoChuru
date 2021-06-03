using System.Data;
using System.Threading.Tasks;

namespace DataAccess
{
	public abstract class DataProvider
	{
		public abstract Task<object> ExecuteNonQueryWithOutput(string outputParam, string spName, params object[] parameterValues);
		public abstract Task<int> ExecuteNonQuery(string spName, params object[] parameterValues);
		public abstract Task<DataSet> ExecuteDataset(string spName, params object[] parameterValues);
		public abstract Task<IDataReader> ExecuteReader(string spName, params object[] parameterValues);
		public abstract Task<object> ExecuteScalar(string spName, params object[] parameterValues);
	}
}
