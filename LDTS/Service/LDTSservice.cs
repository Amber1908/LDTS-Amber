using System;
using System.Collections.Generic;
using System.Data.SqlClient;
using System.Data.SqlTypes;
using System.IO;
using System.Linq;
using System.Security.Cryptography;
using System.Text;
using System.Web;
using System.Web.Configuration;
using LDTS.Models;
using LDTS.Utils;

namespace LDTS.Service
{
    public class LDTSservice
    {
        static readonly Logger logger = new Logger("LDTSservice");
        /// <summary>
        /// SHA256 加密
        /// </summary>
        /// <param name="pwd">欲加密字串</param>
        /// <returns>加密後字串</returns>
        public static string toSha256(string pwd)
        {
            SHA256 sha256 = new SHA256CryptoServiceProvider();
            return Convert.ToBase64String(sha256.ComputeHash(Encoding.Default.GetBytes(pwd)));
        }
        //把圖片轉二進位
        public static Byte[] SetImgToByte(string imgPath)
        {
            FileStream file = new FileStream(imgPath, FileMode.Open, FileAccess.Read);
            Byte[] byteData = new Byte[file.Length];
            file.Read(byteData, 0, byteData.Length);
            file.Close();
            return byteData;
        }
        //編輯圖片
        public static bool UpdatImge(Images img)
        {
            bool result = false;
            try
            {
                using (SqlConnection sqc = new SqlConnection(WebConfigurationManager.ConnectionStrings["LDTSConnectionString"].ToString()))
                {
                    SqlCommand sqlCommand = new SqlCommand("", sqc);
                    sqc.Open();

                    sqlCommand.CommandText = @"UPDATE Images SET image_bytes=@image_bytes WHERE image_id=@image_id";
                    sqlCommand.Parameters.AddWithValue("@image_id", img.image_id);
                    sqlCommand.Parameters.AddWithValue("@image_bytes", img.image_bytes);
                    sqlCommand.Parameters.AddWithValue("@memo", string.IsNullOrEmpty(img.memo)?" ":img.memo);

                    if (sqlCommand.ExecuteNonQuery() > 0)
                        result = true;

                }
            }
            catch (Exception e)
            {
                logger.FATAL(e.Message);
                result = false;
            }

            return result;
        }
        //讀出資料庫的圖
        public static System.Drawing.Image GetImagefromDBb(Images imgs)
        {
            System.Drawing.Image img = null;
            try
            {
                Stream stream = new MemoryStream(imgs.image_bytes);
                img=System.Drawing.Image.FromStream(stream, false);
            }
            catch (Exception e)
            {
                logger.FATAL(e.Message);
                img = null;
            }
            return img;
        }

        public static bool DeleteImg(int id)
        {
            bool result = false;
            try
            {
                using (SqlConnection sqc = new SqlConnection(WebConfigurationManager.ConnectionStrings["LDTSConnectionString"].ToString()))
                {
                    SqlCommand sqlCommand = new SqlCommand("", sqc);
                    sqc.Open();
                    sqlCommand.CommandText = "delete from Images where image_id=@image_id";
                    sqlCommand.Parameters.Add("@image_id", System.Data.SqlDbType.Int);
                    sqlCommand.Parameters["@image_id"].Value = id;
                    if (sqlCommand.ExecuteNonQuery() > 0)
                        result = true;
                    sqc.Close();
                }
            }
            catch (Exception e)
            {
                logger.ERROR(e.Message);
                return result;
            }
            return result;
        }
        /// <summary>
        /// 新增操作紀錄
        /// </summary>
        public static bool InsertRecord(Admin admin, string workContent)
        {
            bool result = false;
            try
            {
                using (SqlConnection sqc = new SqlConnection(WebConfigurationManager.ConnectionStrings["LDTSConnectionString"].ToString()))
                {
                    SqlCommand sqmm = new SqlCommand("", sqc);
                    sqc.Open();

                    sqmm.CommandText = @"INSERT INTO AdminWorkRecord(admin_id,admin_name,work_content) VALUES(@adminId,@adminName,@workContent)";

                    sqmm.Parameters.AddWithValue("@adminId", admin.admin_id);
                    sqmm.Parameters.AddWithValue("@adminName", admin.admin_name);
                    sqmm.Parameters.AddWithValue("@workContent", workContent);

                    if (sqmm.ExecuteNonQuery() > 0)
                        result = true;
                }
            }
            catch (Exception e)
            {
                logger.FATAL(e.Message);
                result = false;
            }
            return result;
        }
        public static List<Models.AdminWorkRecord> GetAdminWorks()
        {
            List<Models.AdminWorkRecord> adminWorkRecords = new List<Models.AdminWorkRecord>();

            try
            {
                using (SqlConnection sqc = new SqlConnection(WebConfigurationManager.ConnectionStrings["LDTSConnectionString"].ToString()))
                {
                    SqlCommand sqmm = new SqlCommand("", sqc);
                    sqc.Open();

                    sqmm.CommandText = @"select * from AdminWorkRecord";
                    SqlDataReader sqlDataReader = sqmm.ExecuteReader();
                    while (sqlDataReader.Read())
                    {
                            adminWorkRecords.Add(new Models.AdminWorkRecord() {
                            sn = sqlDataReader.IsDBNull(sqlDataReader.GetOrdinal("sn")) ? 0 : sqlDataReader.GetInt32(sqlDataReader.GetOrdinal("sn")),
                            admin_id = sqlDataReader.IsDBNull(sqlDataReader.GetOrdinal("admin_id")) ? " " : sqlDataReader.GetString(sqlDataReader.GetOrdinal("admin_id")),
                            work_content= sqlDataReader.IsDBNull(sqlDataReader.GetOrdinal("work_content")) ? string.Empty : sqlDataReader.GetString(sqlDataReader.GetOrdinal("work_content")),
                            createtime = sqlDataReader.IsDBNull(sqlDataReader.GetOrdinal("createtime")) ? (DateTime)SqlDateTime.Null : sqlDataReader.GetDateTime(sqlDataReader.GetOrdinal("createtime"))
                    });
                     
                    }
                    sqc.Close();
                }
            }
            catch (Exception e)
            {
                logger.ERROR(e.Message);
                adminWorkRecords = null;
            }
            

            return adminWorkRecords;
        }
        //取圖片By ID
        public static Images GetImageById(int imgId)
        {
            Images img = new Images();
            try
            {
                using (SqlConnection sqc = new SqlConnection(WebConfigurationManager.ConnectionStrings["LDTSConnectionString"].ToString()))
                {
                    SqlCommand sqlCommand = new SqlCommand("", sqc);
                    sqc.Open();
                    sqlCommand.CommandText = @"Select * from Images where image_id=@image_id";
                    sqlCommand.Parameters.Add("@image_id", System.Data.SqlDbType.Int);
                    sqlCommand.Parameters["@image_id"].Value = imgId;
                    SqlDataReader sqlDataReader = sqlCommand.ExecuteReader();//sqlDataReader["image_bytes"] as byte[];
                    while (sqlDataReader.Read())
                    {
                        img.image_bytes = sqlDataReader["image_bytes"] as byte[];
                        img.image_id = sqlDataReader.IsDBNull(sqlDataReader.GetOrdinal("image_id")) ? 0 : sqlDataReader.GetInt32(sqlDataReader.GetOrdinal("image_id"));
                        img.memo = sqlDataReader.IsDBNull(sqlDataReader.GetOrdinal("memo")) ? " " : sqlDataReader.GetString(sqlDataReader.GetOrdinal("memo"));
                    }
                    sqc.Close();
                }
            }
            catch (Exception e)
            {
                logger.ERROR(e.Message);
                return img;
            }
            return img;
        }

    }
}