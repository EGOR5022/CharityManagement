using System.Data;
using Microsoft.Data.SqlClient;

namespace CharityManagementApp
{
    /// <summary>
    /// Единая точка подключения к базе данных CharityDB.
    /// Использовать этот класс во всех формах, чтобы не прописывать строку подключения заново.
    /// </summary>
    public static class DatabaseConnection
    {
        // !!! При необходимости поменяйте Server / Catalog / пароли под свой SQL Server !!!
        private const string ConnectionString =
            "Server=localhost;Database=CharityDB;Trusted_Connection=True;TrustServerCertificate=True;";

        /// <summary>Строка подключения (только для чтения).</summary>
        public static string Connection => ConnectionString;

        /// <summary>Возвращает открытое соединение с БД.</summary>
        public static SqlConnection GetConnection()
        {
            var connection = new SqlConnection(ConnectionString);
            connection.Open();
            return connection;
        }

        /// <summary>Проверка доступности базы данных.</summary>
        public static bool TestConnection(out string error)
        {
            error = string.Empty;
            try
            {
                using var conn = GetConnection();
                return true;
            }
            catch (Exception ex)
            {
                error = ex.Message;
                return false;
            }
        }

        /// <summary>Выполняет запрос, возвращающий таблицу (SELECT).</summary>
        public static DataTable ExecuteQuery(string sql, params SqlParameter[] parameters)
        {
            using var conn = GetConnection();
            using var cmd = new SqlCommand(sql, conn);
            if (parameters.Length > 0) cmd.Parameters.AddRange(parameters);
            using var adapter = new SqlDataAdapter(cmd);
            var table = new DataTable();
            adapter.Fill(table);
            return table;
        }

        /// <summary>Выполняет INSERT / UPDATE / DELETE. Возвращает число затронутых строк.</summary>
        public static int ExecuteNonQuery(string sql, params SqlParameter[] parameters)
        {
            using var conn = GetConnection();
            using var cmd = new SqlCommand(sql, conn);
            if (parameters.Length > 0) cmd.Parameters.AddRange(parameters);
            return cmd.ExecuteNonQuery();
        }

        /// <summary>Выполняет запрос, возвращающий одно значение (например, COUNT, MAX).</summary>
        public static object? ExecuteScalar(string sql, params SqlParameter[] parameters)
        {
            using var conn = GetConnection();
            using var cmd = new SqlCommand(sql, conn);
            if (parameters.Length > 0) cmd.Parameters.AddRange(parameters);
            return cmd.ExecuteScalar();
        }
    }
}
