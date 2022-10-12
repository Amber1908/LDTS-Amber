using System;
using System.Collections.Generic;
using System.Data.SqlClient;
using System.Data.SqlTypes;
using System.Linq;
using System.Web;
using System.Web.Configuration;
using LDTS.Models;
using LDTS.Service;
using LDTS.Utils;

namespace LDTS.Service
{
    public class ProcessService
    {
        static readonly Logger logger = new Logger("ProcessService");
        public static bool DeleteProcessById(int pid)
        {
            bool result = false;
            try
            {
                using (SqlConnection sqc = new SqlConnection(WebConfigurationManager.ConnectionStrings["LDTSConnectionString"].ToString()))
                {
                    SqlCommand sqlCommand = new SqlCommand("", sqc);
                    sqc.Open();
                    sqlCommand.CommandText = @"DELETE from Process WHERE PID=@PID ";
                    sqlCommand.Parameters.Add("@PID", System.Data.SqlDbType.NVarChar);
                    sqlCommand.Parameters["@PID"].Value = pid;
                    if (sqlCommand.ExecuteNonQuery() > 0)
                        result = true;
                    sqc.Close();

                }

            }
            catch (Exception e)
            {
                logger.FATAL(e.Message);
                return result;
            }
            return result;

        }
        public static bool UpdateProcess(Process process)
        {
            bool result = false;
            try
            {
                using (SqlConnection sqc = new SqlConnection(WebConfigurationManager.ConnectionStrings["LDTSConnectionString"].ToString()))
                {
                    SqlCommand sqlCommand = new SqlCommand("", sqc);
                    sqc.Open();
                    sqlCommand.CommandText = @"UPDATE Process SET Pname=@Pname,Description=@Description,Pindex=@Pindex,old_filename=@old_filename,new_filename=@new_filename WHERE PID=@PID ";
                    sqlCommand.Parameters.AddWithValue("@PID", process.PID);
                    sqlCommand.Parameters.AddWithValue("@Pname", process.Pname);
                    sqlCommand.Parameters.AddWithValue("@Description", process.Description);
                    sqlCommand.Parameters.AddWithValue("@Pindex", process.Pindex);
                    sqlCommand.Parameters.AddWithValue("@old_filename", process.old_filename);
                    sqlCommand.Parameters.AddWithValue("@new_filename", process.new_filename);
                    if (sqlCommand.ExecuteNonQuery() > 0)
                    {
                        result = true;
                    }
                }
            }
            catch (Exception e)
            {
                logger.FATAL(e.Message);
                return result;
            }
            return result;
        }
        public static bool InsertProcess(Process process)
        {
            bool result = false;
            try
            {
                using (SqlConnection sqc = new SqlConnection(WebConfigurationManager.ConnectionStrings["LDTSConnectionString"].ToString()))
                {
                    SqlCommand sqlCommand = new SqlCommand("", sqc);
                    sqc.Open();
                    sqlCommand.CommandText = @"INSERT INTO Process (Pname,Description,Pindex,old_filename,new_filename,CreateMan) VALUES(@Pname,@Description,@Pindex,@old_filename,@new_filename,@CreateMan)";
                    sqlCommand.Parameters.AddWithValue("@Pname", process.Pname);
                    sqlCommand.Parameters.AddWithValue("@Description", process.Description);
                    sqlCommand.Parameters.AddWithValue("@Pindex", process.Pindex);
                    sqlCommand.Parameters.AddWithValue("@old_filename", process.old_filename);
                    sqlCommand.Parameters.AddWithValue("@new_filename", process.new_filename);
                    sqlCommand.Parameters.AddWithValue("@CreateMan", process.CreateMan);
                    if (sqlCommand.ExecuteNonQuery() > 0)
                    {
                        result = true;
                    }
                }
            }
            catch (Exception e)
            {
                logger.FATAL(e.Message);
                return result;
            }
            return result;
        }
        public static Process GetProceById(int PID)
        {
            Process process = new Process();
            try
            {
                using (SqlConnection sqc = new SqlConnection(WebConfigurationManager.ConnectionStrings["LDTSConnectionString"].ToString()))
                {
                    SqlCommand sqlCommand = new SqlCommand("", sqc);
                    sqc.Open();
                    sqlCommand.CommandText = @"Select * from Process where PID=@PID";
                    sqlCommand.Parameters.Add("@PID", System.Data.SqlDbType.Int);
                    sqlCommand.Parameters["@PID"].Value = PID;
                    SqlDataReader sqlDataReader = sqlCommand.ExecuteReader();
                    while (sqlDataReader.Read())
                    {
                        process.PID = sqlDataReader.IsDBNull(sqlDataReader.GetOrdinal("PID")) ? 0 : sqlDataReader.GetInt32(sqlDataReader.GetOrdinal("PID"));
                        process.Pname = sqlDataReader.IsDBNull(sqlDataReader.GetOrdinal("Pname")) ? "" : sqlDataReader.GetString(sqlDataReader.GetOrdinal("Pname"));
                        process.Description = sqlDataReader.IsDBNull(sqlDataReader.GetOrdinal("Description")) ? "" : sqlDataReader.GetString(sqlDataReader.GetOrdinal("Description"));
                        process.Pindex = sqlDataReader.IsDBNull(sqlDataReader.GetOrdinal("Pindex")) ? 0 : sqlDataReader.GetInt32(sqlDataReader.GetOrdinal("Pindex"));
                        process.old_filename = sqlDataReader.IsDBNull(sqlDataReader.GetOrdinal("old_filename")) ? "" : sqlDataReader.GetString(sqlDataReader.GetOrdinal("old_filename"));
                        process.new_filename = sqlDataReader.IsDBNull(sqlDataReader.GetOrdinal("new_filename")) ? "" : sqlDataReader.GetString(sqlDataReader.GetOrdinal("new_filename"));
                        process.CreateMan = sqlDataReader.IsDBNull(sqlDataReader.GetOrdinal("CreateMan")) ? "" : sqlDataReader.GetString(sqlDataReader.GetOrdinal("CreateMan"));
                        process.CreateDate = sqlDataReader.IsDBNull(sqlDataReader.GetOrdinal("CreateDate")) ? (DateTime)SqlDateTime.Null : sqlDataReader.GetDateTime(sqlDataReader.GetOrdinal("CreateDate"));
                    }
                    sqc.Close();
                }
            }
            catch (Exception e)
            {
                logger.FATAL(e.Message);
                return process = new Process(); 
            }
            return process;
        }
        public static List<Process> GetAllProcesses()
        {
            List<Process> processes = new List<Process>();
            try
            {
                using (SqlConnection sqc = new SqlConnection(WebConfigurationManager.ConnectionStrings["LDTSConnectionString"].ToString()))
                {
                    SqlCommand sqlCommand = new SqlCommand("", sqc);
                    sqc.Open();
                    sqlCommand.CommandText = @"Select * from Process";
                    SqlDataReader sqlDataReader = sqlCommand.ExecuteReader();
                    while (sqlDataReader.Read())
                    {
                        processes.Add(new Process()
                        {
                            PID = sqlDataReader.IsDBNull(sqlDataReader.GetOrdinal("PID")) ? 0 : sqlDataReader.GetInt32(sqlDataReader.GetOrdinal("PID")),
                            Pname = sqlDataReader.IsDBNull(sqlDataReader.GetOrdinal("Pname")) ? "" : sqlDataReader.GetString(sqlDataReader.GetOrdinal("Pname")),
                            Description = sqlDataReader.IsDBNull(sqlDataReader.GetOrdinal("Description")) ? "" : sqlDataReader.GetString(sqlDataReader.GetOrdinal("Description")),
                            Pindex = sqlDataReader.IsDBNull(sqlDataReader.GetOrdinal("Pindex")) ? 0 : sqlDataReader.GetInt32(sqlDataReader.GetOrdinal("Pindex")),
                            old_filename = sqlDataReader.IsDBNull(sqlDataReader.GetOrdinal("old_filename")) ? "" : sqlDataReader.GetString(sqlDataReader.GetOrdinal("old_filename")),
                            new_filename = sqlDataReader.IsDBNull(sqlDataReader.GetOrdinal("new_filename")) ? "" : sqlDataReader.GetString(sqlDataReader.GetOrdinal("new_filename")),
                            CreateMan = sqlDataReader.IsDBNull(sqlDataReader.GetOrdinal("CreateMan")) ? "" : sqlDataReader.GetString(sqlDataReader.GetOrdinal("CreateMan")),
                            CreateDate = sqlDataReader.IsDBNull(sqlDataReader.GetOrdinal("CreateDate")) ? (DateTime)SqlDateTime.Null : sqlDataReader.GetDateTime(sqlDataReader.GetOrdinal("CreateDate"))
                        });
                    }
                    sqc.Close();
                }
            }
            catch (Exception e)
            {
                logger.FATAL(e.Message);
                return processes =null;
            }
            return processes;
        }
    }
}