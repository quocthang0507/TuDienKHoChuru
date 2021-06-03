﻿using System;
using System.Data;
using System.Data.SqlClient;
using System.Threading.Tasks;

namespace DataAccess
{
	public class SqlDataProvider : DataProvider
	{
		private readonly string connectionString;
		private static SqlDataProvider instance;

		public static SqlDataProvider Instance
		{
			get
			{
				if (instance != null)
					return instance;
				throw new ArgumentNullException("Please initialize before calling this object!");
			}
			set
			{
				instance = value;
			}
		}

		public SqlDataProvider(string connectionString)
		{
			this.connectionString = connectionString;
		}

		private static void AssignParameterValues(SqlParameter[] commandParameters, object[] parameterValues)
		{
			if (commandParameters == null || parameterValues == null) return;
			if (commandParameters.Length != parameterValues.Length)
				throw new ArgumentException("Command parameters do not match parameter values!");
			for (int i = 0, j = commandParameters.Length; i < j; i++)
				commandParameters[i].Value = parameterValues[i];
		}

		public override async Task<DataSet> ExecuteDataset(string spName, params object[] parameterValues)
		{
			return await Task.Run(() => SqlHelper.ExecuteDataset(connectionString, spName, parameterValues));
		}

		public override async Task<int> ExecuteNonQuery(string spName, params object[] parameterValues)
		{
			return await Task.Run(() => SqlHelper.ExecuteNonQuery(connectionString, spName, parameterValues));
		}

		public override async Task<object> ExecuteNonQueryWithOutput(string outputParam, string spName, params object[] parameterValues)
		{
			if (string.IsNullOrEmpty(outputParam))
				throw new ArgumentException("OutputParam can't be null or empty!");
			SqlParameter[] parameters = SqlHelperParameterCache.GetSpParameterSet(connectionString, spName);
			SqlParameter sqlParameter = null;
			foreach (var item in parameters)
			{
				if (string.Compare(item.ParameterName, outputParam, true) == 0)
				{
					sqlParameter = item;
					break;
				}
			}
			if (sqlParameter == null)
				throw new Exception("Parameter not found!");
			AssignParameterValues(parameters, parameterValues);
			int result = await Task.Run(() => SqlHelper.ExecuteNonQuery(connectionString, CommandType.StoredProcedure, spName, parameters));
			if (result > 0)
				return sqlParameter.Value;
			return null;
		}

		public override async Task<IDataReader> ExecuteReader(string spName, params object[] parameterValues)
		{
			return await Task.Run(() => SqlHelper.ExecuteReader(connectionString, spName, parameterValues));
		}

		public override async Task<object> ExecuteScalar(string spName, params object[] parameterValues)
		{
			return await Task.Run(() => SqlHelper.ExecuteScalar(connectionString, spName, parameterValues));
		}
	}
}