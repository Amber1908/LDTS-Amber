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
    public class StandarWorkBookService
    {
        static readonly Logger logger = new Logger("StandarWorkBookService");

        public static bool DeleteStandarwookBookById(int sid)
        {
            bool result = false;
            try
            {
                using (SqlConnection sqc = new SqlConnection(WebConfigurationManager.ConnectionStrings["LDTSConnectionString"].ToString()))
                {
                    SqlCommand sqlCommand = new SqlCommand("", sqc);
                    sqc.Open();
                    sqlCommand.CommandText = @"DELETE from StandardWorkBook WHERE SID=@SID ";
                    sqlCommand.Parameters.Add("@SID", System.Data.SqlDbType.NVarChar);
                    sqlCommand.Parameters["@SID"].Value = sid;
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
        public static bool InsterStandarwookbook(StandardWorkBook standardWorkBook)
        {
            bool result = false;
            try
            {
                using (SqlConnection sqc = new SqlConnection(WebConfigurationManager.ConnectionStrings["LDTSConnectionString"].ToString()))
                {
                    SqlCommand sqlCommand = new SqlCommand("", sqc);
                    sqc.Open();
                    sqlCommand.CommandText = @"INSERT INTO StandardWorkBook (Sname,Description,Sindex,old_filename,new_filename,CreateMan) VALUES(@Sname,@Description,@Sindex,@old_filename,@new_filename,@CreateMan)";
                    sqlCommand.Parameters.AddWithValue("@Sname", standardWorkBook.Sname);
                    sqlCommand.Parameters.AddWithValue("@Description", standardWorkBook.Description);
                    sqlCommand.Parameters.AddWithValue("@Sindex", standardWorkBook.Sindex);
                    sqlCommand.Parameters.AddWithValue("@old_filename", standardWorkBook.old_filename);
                    sqlCommand.Parameters.AddWithValue("@new_filename", standardWorkBook.new_filename);
                    sqlCommand.Parameters.AddWithValue("@CreateMan", standardWorkBook.CreateMan);
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
                return result;
            }
            return result;

        }
        public static bool UpdateStandarwookbook(StandardWorkBook standardWorkBook)
        {
            bool result = false;
            try
            {
                using (SqlConnection sqc = new SqlConnection(WebConfigurationManager.ConnectionStrings["LDTSConnectionString"].ToString()))
                {
                    SqlCommand sqlCommand = new SqlCommand("", sqc);
                    sqc.Open();
                    
                    sqlCommand.CommandText = @"UPDATE StandardWorkBook SET Sname=@Sname,Description=@Description,Sindex=@Sindex,old_filename=@old_filename,new_filename=@new_filename WHERE SID=@SID ";
                    sqlCommand.Parameters.AddWithValue("@SID", standardWorkBook.SID);
                    sqlCommand.Parameters.AddWithValue("@Sname", standardWorkBook.Sname);
                    sqlCommand.Parameters.AddWithValue("@Description", standardWorkBook.Description);
                    sqlCommand.Parameters.AddWithValue("@Sindex", standardWorkBook.Sindex);
                    sqlCommand.Parameters.AddWithValue("@old_filename", standardWorkBook.old_filename);
                    sqlCommand.Parameters.AddWithValue("@new_filename", standardWorkBook.new_filename);
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
                return result;
            }
            return result;
        }
        public static List<StandardWorkBook> GetAllStandarwookbooks()
        {
            List<StandardWorkBook> standardWorkBooks = new List<StandardWorkBook>();
            try
            {
                using (SqlConnection sqc = new SqlConnection(WebConfigurationManager.ConnectionStrings["LDTSConnectionString"].ToString()))
                {
                    SqlCommand sqlCommand = new SqlCommand("", sqc);
                    sqc.Open();
                    sqlCommand.CommandText = @"Select * from StandardWorkBook";
                    SqlDataReader sd = sqlCommand.ExecuteReader();
                    while (sd.Read())
                    {
                        standardWorkBooks.Add(new StandardWorkBook()
                        {
                            SID = sd.IsDBNull(sd.GetOrdinal("SID")) ? 0 : sd.GetInt32(sd.GetOrdinal("SID")),
                            Sname= sd.IsDBNull(sd.GetOrdinal("Sname")) ? "" : sd.GetString(sd.GetOrdinal("Sname")),
                            Sindex = sd.IsDBNull(sd.GetOrdinal("Sindex")) ? 0 : sd.GetInt32(sd.GetOrdinal("Sindex")),
                            old_filename= sd.IsDBNull(sd.GetOrdinal("old_filename")) ? "" : sd.GetString(sd.GetOrdinal("old_filename")),
                            new_filename= sd.IsDBNull(sd.GetOrdinal("new_filename")) ? "" : sd.GetString(sd.GetOrdinal("new_filename")),
                            Description = sd.IsDBNull(sd.GetOrdinal("Description")) ? "" : sd.GetString(sd.GetOrdinal("Description")),
                            CreateDate = sd.IsDBNull(sd.GetOrdinal("CreateDate")) ? (DateTime)SqlDateTime.Null : sd.GetDateTime(sd.GetOrdinal("CreateDate")),
                            CreateMan = sd.IsDBNull(sd.GetOrdinal("CreateMan")) ? "" : sd.GetString(sd.GetOrdinal("CreateMan")),
                        }); 
                    }
                    sqc.Close();
                }
            }
            catch (Exception e)
            {
                logger.FATAL(e.Message);
                return standardWorkBooks =null;
            }
            return standardWorkBooks;
        }
    }
}