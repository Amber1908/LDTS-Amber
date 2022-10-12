using System;
using System.Collections.Generic;
using System.Data.SqlClient;
using System.Linq;
using System.Web;
using System.Web.Configuration;
using LDTS.Models;
using LDTS.Service;
using LDTS.Utils;

namespace LDTS.Service
{
    public class AoService
    {
        static readonly Logger logger = new Logger("AoService");

        public static bool DeletereAdminFormByID(string admin_id)//刪除人員關聯表單
        {
            bool result = false;
            try
            {
                using (SqlConnection sqc = new SqlConnection(WebConfigurationManager.ConnectionStrings["LDTSConnectionString"].ToString()))
                {
                    SqlCommand sqlCommand = new SqlCommand("", sqc);
                    sqc.Open();
                    sqlCommand.CommandText = @"DELETE from ReAdminForm WHERE admin_id=@admin_id ";
                    sqlCommand.Parameters.Add("@admin_id", System.Data.SqlDbType.NVarChar);
                    sqlCommand.Parameters["@admin_id"].Value = admin_id;
                    if (sqlCommand.ExecuteNonQuery() > 0)
                        result = true;
                    sqc.Close();

                }
            }
            catch (Exception ex)
            {
                logger.ERROR(ex.Message);
                return result;
            }
            return result;
        }
        //新增多筆
        public static bool InsertreAdminForms(List<ReAdminForm> reAdminForms)
        {
            bool result = false;
            List<ReAdminForm> adminForms = reAdminForms;
            try
            {
                using (SqlConnection sqc = new SqlConnection(WebConfigurationManager.ConnectionStrings["LDTSConnectionString"].ToString()))
                {
                    foreach (var adminForm in adminForms)
                    {
                        SqlCommand sqlCommand = new SqlCommand("", sqc);
                        sqc.Open();
                        sqlCommand.CommandText = @"INSERT INTO ReAdminForm(admin_id,QID,status) VALUES(@admin_id,@QID,@status)";
                        sqlCommand.Parameters.AddWithValue("@admin_id", adminForm.admin_id);
                        sqlCommand.Parameters.AddWithValue("@QID", adminForm.QID);
                        sqlCommand.Parameters.AddWithValue("@status", adminForm.status);
                        if (sqlCommand.ExecuteNonQuery() > 0)
                        {
                            result = true;
                        }
                        sqc.Close();
                    }
                }
            }
            catch (Exception ex)
            {
                logger.ERROR(ex.Message);
                return result;
            }

            return result;
        }
        /// <summary>
        /// 新增單筆
        /// </summary>
        /// <param name="reAdminForm"></param>
        /// <returns></returns>
        public static bool InsertreAdminForm(ReAdminForm reAdminForm)
        {
            bool result = false;
            try
            {
                using (SqlConnection sqc = new SqlConnection(WebConfigurationManager.ConnectionStrings["LDTSConnectionString"].ToString()))
                {
                    SqlCommand sqlCommand = new SqlCommand("", sqc);
                    sqc.Open();
                    sqlCommand.CommandText = @"INSERT INTO ReAdminForm(admin_id,QID,status) VALUES(@admin_id,@QID,@status)";
                    sqlCommand.Parameters.AddWithValue("@admin_id", reAdminForm.admin_id);
                    sqlCommand.Parameters.AddWithValue("@QID", reAdminForm.QID);
                    sqlCommand.Parameters.AddWithValue("@status", reAdminForm.status);
                    if (sqlCommand.ExecuteNonQuery() > 0)
                    {
                        result = true;
                    }
                }
            }
            catch (Exception ex)
            {
                logger.ERROR("InsertreAdminForm:" + ex.Message);
                return result;
            }

            return result;
        }
        /// <summary>
        /// 查詢所有人員關係表單
        /// </summary>
        /// <returns></returns>
        public static List<ReAdminForm> GetReAdminForms()
        {
            List<ReAdminForm> reAdminForms = new List<ReAdminForm>();
            try
            {
                using (SqlConnection sqc = new SqlConnection(WebConfigurationManager.ConnectionStrings["LDTSConnectionString"].ToString()))
                {
                    SqlCommand sqlCommand = new SqlCommand("", sqc);
                    sqc.Open();
                    sqlCommand.CommandText = @"Select * from ReAdminForm";
                    SqlDataReader sqlDataReader = sqlCommand.ExecuteReader();
                    while (sqlDataReader.Read())
                    {
                        reAdminForms.Add(new ReAdminForm()
                        {
                            admin_id = sqlDataReader.IsDBNull(sqlDataReader.GetOrdinal("admin_id")) ?" ": sqlDataReader.GetString(sqlDataReader.GetOrdinal("admin_id")),
                            QID = sqlDataReader.IsDBNull(sqlDataReader.GetOrdinal("QID")) ? 0 : sqlDataReader.GetInt32(sqlDataReader.GetOrdinal("QID")),
                            status = sqlDataReader.IsDBNull(sqlDataReader.GetOrdinal("status")) ? 0 : sqlDataReader.GetInt32(sqlDataReader.GetOrdinal("status"))
                        });
                    }
                    sqc.Close();
                }
            }
            catch (Exception ex)
            {
                logger.ERROR(ex.Message);
                return reAdminForms;
            }
            return reAdminForms;
        }
        /// <summary>
        /// 查詢所有人員關係程序書
        /// </summary>
        /// <returns></returns>
        public static List<ReAdminProcess> GetReAdminProcesses()
        {
            List<ReAdminProcess> reAdminProcesses = new List<ReAdminProcess>();
            try
            {
                using (SqlConnection sqc = new SqlConnection(WebConfigurationManager.ConnectionStrings["LDTSConnectionString"].ToString()))
                {
                    SqlCommand sqlCommand = new SqlCommand("", sqc);
                    sqc.Open();
                    sqlCommand.CommandText = @"Select * from ReAdminProcess";
                    SqlDataReader sqlDataReader = sqlCommand.ExecuteReader();
                    while (sqlDataReader.Read())
                    {
                        reAdminProcesses.Add(new ReAdminProcess()
                        {
                            admin_id = sqlDataReader.IsDBNull(sqlDataReader.GetOrdinal("admin_id")) ? " " : sqlDataReader.GetString(sqlDataReader.GetOrdinal("admin_id")),
                            PID = sqlDataReader.IsDBNull(sqlDataReader.GetOrdinal("QID")) ? 0 : sqlDataReader.GetInt32(sqlDataReader.GetOrdinal("QID"))
                        });
                    }
                    sqc.Close();
                }
            }
            catch (Exception ex)
            {
                logger.ERROR(ex.Message);
                return reAdminProcesses;
            }
            return reAdminProcesses;
        }

    }
}