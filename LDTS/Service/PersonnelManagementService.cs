using System;
using System.Collections.Generic;
using System.Data.SqlClient;
using System.Linq;
using System.Web;
using System.Web.Configuration;
using LDTS.Models;
using LDTS.Utils;

namespace LDTS.Service
{
    public class PersonnelManagementService
    {
        static readonly Logger logger = new Logger("PersonnelManagementService");
        public static bool DeleteAdmin(string Id)
        {
            bool result = false;
            try
            {
                using (SqlConnection sqc = new SqlConnection(WebConfigurationManager.ConnectionStrings["LDTSConnectionString"].ToString()))
                {
                    SqlCommand sqlCommand = new SqlCommand("", sqc);
                    sqc.Open();
                    sqlCommand.CommandText = @"DELETE from Admin WHERE admin_id=@admin_id ";
                    sqlCommand.Parameters.Add("@admin_id", System.Data.SqlDbType.NVarChar);
                    sqlCommand.Parameters["@admin_id"].Value = Id;
                    if (sqlCommand.ExecuteNonQuery() > 0)
                        result = true;
                    sqc.Close();
                }
            }
            catch (Exception e)
            {
                result = false;
                logger.FATAL(e.Message);
                return result;

            }
            return result;


        }
        public static bool UpdatePassword(Admin admin)
        {
            bool result = false;
            try
            {
                using (SqlConnection sqc = new SqlConnection(WebConfigurationManager.ConnectionStrings["LDTSConnectionString"].ToString()))
                {
                    SqlCommand sqlCommand = new SqlCommand("", sqc);
                    sqc.Open();
                    sqlCommand.CommandText = @"UPDATE Admin SET admin_password=@admin_password WHERE admin_id=@admin_id ";
                    sqlCommand.Parameters.AddWithValue("@admin_id", admin.admin_id);
                    sqlCommand.Parameters.AddWithValue("@admin_password", admin.admin_password);
                    if (sqlCommand.ExecuteNonQuery() > 0)
                    {
                        result = true;
                    }
                }
            }
            catch (Exception e)
            {
                logger.FATAL(e.Message);
                result = false;
            }
            return result;
        }
        public static Admin GetAdminById(string Id)
        {
            Admin admin = new Admin();
            try
            {
                using (SqlConnection sqc = new SqlConnection(WebConfigurationManager.ConnectionStrings["LDTSConnectionString"].ToString()))
                {
                    SqlCommand sqlCommand = new SqlCommand("", sqc);
                    sqc.Open();
                    sqlCommand.CommandText = @"Select * from Admin where admin_id=@admin_id";
                    sqlCommand.Parameters.Add("@admin_id", System.Data.SqlDbType.NVarChar);
                    sqlCommand.Parameters["@admin_id"].Value = Id;
                    SqlDataReader sqlDataReader = sqlCommand.ExecuteReader();

                    while (sqlDataReader.Read())
                    {
                        admin.admin_id = sqlDataReader.IsDBNull(sqlDataReader.GetOrdinal("admin_id")) ? "" : sqlDataReader.GetString(sqlDataReader.GetOrdinal("admin_id"));
                        admin.admin_name = sqlDataReader.IsDBNull(sqlDataReader.GetOrdinal("admin_name")) ? "" : sqlDataReader.GetString(sqlDataReader.GetOrdinal("admin_name"));
                        admin.admin_ao = sqlDataReader.IsDBNull(sqlDataReader.GetOrdinal("admin_ao")) ? "" : sqlDataReader.GetString(sqlDataReader.GetOrdinal("admin_ao"));
                        admin.admin_phone = sqlDataReader.IsDBNull(sqlDataReader.GetOrdinal("admin_phone")) ? "" : sqlDataReader.GetString(sqlDataReader.GetOrdinal("admin_phone"));
                        admin.admin_job = sqlDataReader.IsDBNull(sqlDataReader.GetOrdinal("admin_job")) ? "" : sqlDataReader.GetString(sqlDataReader.GetOrdinal("admin_job"));
                        admin.admin_image = sqlDataReader.IsDBNull(sqlDataReader.GetOrdinal("admin_image")) ? 0 : sqlDataReader.GetInt32(sqlDataReader.GetOrdinal("admin_image"));
                        admin.admin_sign = sqlDataReader.IsDBNull(sqlDataReader.GetOrdinal("admin_sign")) ? 0 : sqlDataReader.GetInt32(sqlDataReader.GetOrdinal("admin_sign"));
                        admin.status = sqlDataReader.IsDBNull(sqlDataReader.GetOrdinal("status")) ? 0 : sqlDataReader.GetInt32(sqlDataReader.GetOrdinal("status"));
                        admin.admin_email = sqlDataReader.IsDBNull(sqlDataReader.GetOrdinal("admin_email")) ? "" : sqlDataReader.GetString(sqlDataReader.GetOrdinal("admin_email"));
                        admin.admin_password = sqlDataReader.IsDBNull(sqlDataReader.GetOrdinal("admin_password")) ? "" : sqlDataReader.GetString(sqlDataReader.GetOrdinal("admin_password"));
                        admin.memo = sqlDataReader.IsDBNull(sqlDataReader.GetOrdinal("memo")) ? "" : sqlDataReader.GetString(sqlDataReader.GetOrdinal("memo"));

                    }
                    sqc.Close();
                }
            }
            catch (Exception e)
            {
                logger.FATAL(e.Message);
                return admin = null;
            }
            return admin;
        }
        public static List<Admin> GetAllLazyAdmin()
        {
            List<Admin> admins = new List<Admin>();
            try
            {
                using (SqlConnection sqc = new SqlConnection(WebConfigurationManager.ConnectionStrings["LDTSConnectionString"].ToString()))
                {
                    SqlCommand sqlCommand = new SqlCommand("", sqc);
                    sqc.Open();
                    sqlCommand.CommandText = @"Select * from Admin";
                    SqlDataReader sqlDataReader = sqlCommand.ExecuteReader();
                    while (sqlDataReader.Read())
                    {
                        admins.Add(new Admin()
                        {
                            admin_id = sqlDataReader.IsDBNull(sqlDataReader.GetOrdinal("admin_id")) ? "" : sqlDataReader.GetString(sqlDataReader.GetOrdinal("admin_id")),
                            admin_name = sqlDataReader.IsDBNull(sqlDataReader.GetOrdinal("admin_name")) ? "" : sqlDataReader.GetString(sqlDataReader.GetOrdinal("admin_name")),
                            admin_job = sqlDataReader.IsDBNull(sqlDataReader.GetOrdinal("admin_job")) ? "" : sqlDataReader.GetString(sqlDataReader.GetOrdinal("admin_job")),
                            admin_ao = sqlDataReader.IsDBNull(sqlDataReader.GetOrdinal("admin_ao")) ? "" : sqlDataReader.GetString(sqlDataReader.GetOrdinal("admin_ao")),
                            admin_image = sqlDataReader.IsDBNull(sqlDataReader.GetOrdinal("admin_image")) ? 0 : sqlDataReader.GetInt32(sqlDataReader.GetOrdinal("admin_image")),
                            status = sqlDataReader.IsDBNull(sqlDataReader.GetOrdinal("status")) ? 0 : sqlDataReader.GetInt32(sqlDataReader.GetOrdinal("status")),
                        });
                    }
                    sqc.Close();
                }
            }
            catch (Exception e)
            {
                logger.FATAL(e.Message);
                return admins = null;
            }
            return admins;
        }

        public static bool InsertAdmin(Admin admin)
        {
            bool result = false;
            try
            {
                using (SqlConnection sqc = new SqlConnection(WebConfigurationManager.ConnectionStrings["LDTSConnectionString"].ToString()))
                {
                    SqlCommand sqlCommand = new SqlCommand("", sqc);
                    sqc.Open();
                    sqlCommand.CommandText = @"INSERT INTO Admin(admin_id, admin_name,admin_phone,admin_email,admin_ao,admin_image,admin_sign,status,memo) VALUES(@admin_id,@admin_name,@admin_phone,@admin_email,@admin_ao,@admin_image,@admin_sign,@status,@memo)";
                    sqlCommand.Parameters.AddWithValue("@admin_id", admin.admin_id);
                    sqlCommand.Parameters.AddWithValue("@admin_name", admin.admin_name);
                    sqlCommand.Parameters.AddWithValue("@admin_phone", admin.admin_phone);
                    sqlCommand.Parameters.AddWithValue("@admin_ao", admin.admin_ao);
                    sqlCommand.Parameters.AddWithValue("@admin_image", admin.admin_image);
                    sqlCommand.Parameters.AddWithValue("@admin_sign", admin.admin_sign);
                    sqlCommand.Parameters.AddWithValue("@admin_email", admin.admin_email);
                    sqlCommand.Parameters.AddWithValue("@status", admin.status);
                    sqlCommand.Parameters.AddWithValue("@memo", admin.memo);
                    if (sqlCommand.ExecuteNonQuery() > 0)
                    {
                        result = true;
                    }
                    sqc.Close();
                }
            }
            catch (Exception e)
            {
                logger.FATAL(e.Message);
                result = false;
            }
            return result;
        }
        public static bool UpdateAdmin(Admin admin)
        {
            bool result = false;
            try
            {
                using (SqlConnection sqc = new SqlConnection(WebConfigurationManager.ConnectionStrings["LDTSConnectionString"].ToString()))
                {
                    SqlCommand sqlCommand = new SqlCommand("", sqc);
                    sqc.Open();
                    sqlCommand.CommandText = @"UPDATE Admin SET admin_name=@admin_name,admin_phone=@admin_phone,admin_email=@admin_email,admin_ao=@admin_ao,status=@status,memo=@memo,admin_image=@admin_image,admin_sign=@admin_sign WHERE admin_id=@admin_id ";
                    sqlCommand.Parameters.AddWithValue("@admin_id", admin.admin_id);
                    sqlCommand.Parameters.AddWithValue("@admin_name", admin.admin_name);
                    sqlCommand.Parameters.AddWithValue("@admin_phone", admin.admin_phone);
                    sqlCommand.Parameters.AddWithValue("@admin_email", admin.admin_email);
                    sqlCommand.Parameters.AddWithValue("@admin_ao", admin.admin_ao);
                    sqlCommand.Parameters.AddWithValue("@status", admin.status);
                    sqlCommand.Parameters.AddWithValue("@admin_image", admin.admin_image);
                    sqlCommand.Parameters.AddWithValue("@admin_sign", admin.admin_sign);

                    sqlCommand.Parameters.AddWithValue("@memo", string.IsNullOrEmpty(admin.memo) ? " " : admin.memo);

                    if (sqlCommand.ExecuteNonQuery() > 0)
                        result = true;
                    sqc.Close();
                }
            }
            catch (Exception e)
            {
                logger.FATAL(e.Message);
                result = false;
            }
            return result;
        }
        public static bool ResetPassword(string id)
        {
            bool result = false;
            try
            {
                using (SqlConnection sqc = new SqlConnection(WebConfigurationManager.ConnectionStrings["LDTSConnectionString"].ToString()))
                {
                    SqlCommand sqlCommand = new SqlCommand("", sqc);
                    sqc.Open();
                    sqlCommand.CommandText = @"UPDATE Admin SET admin_password=@admin_password WHERE admin_id=@admin_id ";
                    sqlCommand.Parameters.AddWithValue("@admin_id", id);
                    sqlCommand.Parameters.AddWithValue("@admin_password", DBNull.Value);
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
    }
}