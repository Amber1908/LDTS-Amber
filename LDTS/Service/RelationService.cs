using System;
using System.Collections.Generic;
using System.Data.SqlClient;
using System.Linq;
using System.Web.Configuration;
using LDTS.Models;
using System.Runtime.Serialization;
using System.Text;
using LDTS.Utils;
using System.Data.SqlTypes;

namespace LDTS.Service
{
    public class RelationService
    {
        static readonly Logger logger = new Logger("RelationService");
        /// <summary>
        ///InsertReSworkbookForm 新增標準作業書跟表單關聯
        /// </summary>
        public static bool InsertReSworkbookForm(ReStandarWorkBookForm reStandarWorkBookForm)
        {
            bool result = false;
            try
            {
                using (SqlConnection sqc = new SqlConnection(WebConfigurationManager.ConnectionStrings["LDTSConnectionString"].ToString()))
                {
                    SqlCommand sqlCommand = new SqlCommand("", sqc);
                    sqc.Open();
                    sqlCommand.CommandText = @"INSERT INTO ReStandarWorkBookForm(SID, QID) VALUES(@SID,@QID)";
                    sqlCommand.Parameters.AddWithValue("@SID", reStandarWorkBookForm.SID);
                    sqlCommand.Parameters.AddWithValue("@QID", reStandarWorkBookForm.QID);
                    if (sqlCommand.ExecuteNonQuery() > 0)
                    {
                        result = true;
                    }
                }
            }
            catch (Exception e)
            {
                logger.FATAL(e.Message);
                return result = false;
            }
            return result;
        }
        /// <summary>
        ///InsertReProcessStandardWorkBooks 新增標準作業書跟程序書關聯
        /// </summary>
        public static bool InsertReProcessStandardWorkBook(ReProcessStandardWorkBook standardWorkBook)
        {
            bool result = false;
            try
            {
                using (SqlConnection sqc = new SqlConnection(WebConfigurationManager.ConnectionStrings["LDTSConnectionString"].ToString()))
                {
                    SqlCommand sqlCommand = new SqlCommand("", sqc);
                    sqc.Open();
                    sqlCommand.CommandText = @"INSERT INTO ReProcessStandardWorkBook(PID, SID) VALUES(@PID,@SID)";
                    sqlCommand.Parameters.AddWithValue("@PID", standardWorkBook.PID);
                    sqlCommand.Parameters.AddWithValue("@SID", standardWorkBook.SID);
                    if (sqlCommand.ExecuteNonQuery() > 0)
                    {
                        result = true;
                    }
                }
            }
            catch (Exception e)
            {
                logger.FATAL(e.Message);
                return result = false;
            }
            return result;
        }
        public static bool InsertReAdminProcesses(List<ReAdminProcess> reAdminProcesses)
        {
            bool result = true;
            List<ReAdminProcess> processes = reAdminProcesses;
            try
            {
                using (SqlConnection sqc = new SqlConnection(WebConfigurationManager.ConnectionStrings["LDTSConnectionString"].ToString()))
                {
                    foreach (var processe in processes)
                    {
                        SqlCommand sqlCommand = new SqlCommand("", sqc);
                        sqc.Open();
                        sqlCommand.CommandText = @"INSERT INTO ReAdminProcess(admin_id, PID) VALUES(@admin_id,@PID)";
                        sqlCommand.Parameters.AddWithValue("@PID", processe.PID);
                        sqlCommand.Parameters.AddWithValue("@admin_id", processe.admin_id);
                        if (sqlCommand.ExecuteNonQuery() > 0)
                        {
                            result = true;
                        }
                        sqc.Close();
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
        public static bool InsertReProcessQuestions(List<ReProcessQuestion> reProcessForms)
        {
            bool result = true;
            List<ReProcessQuestion> reProcesses = reProcessForms;
            try
            {
                using (SqlConnection sqc = new SqlConnection(WebConfigurationManager.ConnectionStrings["LDTSConnectionString"].ToString()))
                {
                    foreach (var reProcesse in reProcesses)
                    {

                        SqlCommand sqlCommand = new SqlCommand("", sqc);
                        sqc.Open();
                        sqlCommand.CommandText = @"INSERT INTO ReProcessQuestion(PID, QID) VALUES(@PID,@QID)";
                        sqlCommand.Parameters.AddWithValue("@PID", reProcesse.PID);
                        sqlCommand.Parameters.AddWithValue("@QID", reProcesse.QID);
                        if (sqlCommand.ExecuteNonQuery() > 0)
                        {
                            result = true;
                        }
                        sqc.Close();
                    }
                }
            }
            catch (Exception e)
            {
                logger.FATAL(e.Message);
                return result = false;
            }
            return result;
        }

        public static bool InsertReProcessQuestion(ReProcessQuestion ReProcessQuestion)
        {
            bool result = true;
            try
            {
                using (SqlConnection sqc = new SqlConnection(WebConfigurationManager.ConnectionStrings["LDTSConnectionString"].ToString()))
                {
                    SqlCommand sqlCommand = new SqlCommand("", sqc);
                    sqc.Open();
                    sqlCommand.CommandText = @"INSERT INTO ReProcessQuestion(PID, QID) VALUES(@PID,@QID)";
                    sqlCommand.Parameters.AddWithValue("@PID", ReProcessQuestion.PID);
                    sqlCommand.Parameters.AddWithValue("@QID", ReProcessQuestion.QID);
                    if (sqlCommand.ExecuteNonQuery() > 0)
                    {
                        result = true;
                    }
                }
            }
            catch (Exception e)
            {
                logger.FATAL(e.Message);
                return result = false;
            }
            return result;
        }
        public static List<ReProcessStandardWorkBook> GetAllReProcessStandardWorkBooks()
        {
            List<ReProcessStandardWorkBook> reProcessStandardWorkBooks = new List<ReProcessStandardWorkBook>();
            try
            {
                using (SqlConnection sqc = new SqlConnection(WebConfigurationManager.ConnectionStrings["LDTSConnectionString"].ToString()))
                {
                    SqlCommand sqlCommand = new SqlCommand("", sqc);
                    sqc.Open();
                    sqlCommand.CommandText = @"Select * from ReProcessStandardWorkBook";
                    SqlDataReader sqlDataReader = sqlCommand.ExecuteReader();
                    while (sqlDataReader.Read())
                    {
                        reProcessStandardWorkBooks.Add(new ReProcessStandardWorkBook()
                        {
                            SID = sqlDataReader.IsDBNull(sqlDataReader.GetOrdinal("SID")) ? 0 : sqlDataReader.GetInt32(sqlDataReader.GetOrdinal("SID")),
                            PID = sqlDataReader.IsDBNull(sqlDataReader.GetOrdinal("PID")) ? 0 : sqlDataReader.GetInt32(sqlDataReader.GetOrdinal("PID"))
                        });
                    }
                    sqc.Close();
                }
            }
            catch (Exception e)
            {
                logger.FATAL(e.Message);
                return reProcessStandardWorkBooks = null;
            }

            return reProcessStandardWorkBooks;
        }
        /// <summary>
        /// 取得所有Admin相關的表單 
        /// </summary>
        /// <returns></returns>
        public  static List<ReAdminForm> GetAllreAdminFormByAdminId(string AdminId)
        {
            List<ReAdminForm> reAdminForms = new List<ReAdminForm>();
            try
            {
                using (SqlConnection sqc = new SqlConnection(WebConfigurationManager.ConnectionStrings["LDTSConnectionString"].ToString()))
                {
                    SqlCommand sqlCommand = new SqlCommand("", sqc);
                    sqc.Open();
                    sqlCommand.CommandText = @"Select * from ReAdminForm where admin_id=@admin_id";
                    sqlCommand.Parameters.AddWithValue("@admin_id", AdminId);
                    SqlDataReader sqlDataReader = sqlCommand.ExecuteReader();
                    while (sqlDataReader.Read())
                    {
                        reAdminForms.Add(new ReAdminForm()
                        {
                            admin_id = sqlDataReader.IsDBNull(sqlDataReader.GetOrdinal("admin_id")) ? "" : sqlDataReader.GetString(sqlDataReader.GetOrdinal("admin_id")),
                            QID=sqlDataReader.IsDBNull(sqlDataReader.GetOrdinal("QID"))?0:sqlDataReader.GetInt32(sqlDataReader.GetOrdinal("QID")),
                            status=sqlDataReader.IsDBNull(sqlDataReader.GetOrdinal("status"))?1:sqlDataReader.GetInt32(sqlDataReader.GetOrdinal("status"))
                        }) ;
                    }
                    sqc.Close();
                }
            } 
            catch (Exception e)
            {
                logger.FATAL(e.Message);
                return reAdminForms;
            }
            return reAdminForms;
        }
        public static List<ReStandarWorkBookForm> GetAllreSWorkBookForm()
        {
            List<ReStandarWorkBookForm> reStandarWorkBookForms = new List<ReStandarWorkBookForm>();
            try
            {
                using (SqlConnection sqc = new SqlConnection(WebConfigurationManager.ConnectionStrings["LDTSConnectionString"].ToString()))
                {
                    SqlCommand sqlCommand = new SqlCommand("", sqc);
                    sqc.Open();
                    sqlCommand.CommandText = @"Select * from ReStandarWorkBookForm";
                    SqlDataReader sqlDataReader = sqlCommand.ExecuteReader();
                    while (sqlDataReader.Read())
                    {
                        reStandarWorkBookForms.Add(new ReStandarWorkBookForm()
                        {
                            SID = sqlDataReader.IsDBNull(sqlDataReader.GetOrdinal("SID")) ? 0 : sqlDataReader.GetInt32(sqlDataReader.GetOrdinal("SID")),
                            QID = sqlDataReader.IsDBNull(sqlDataReader.GetOrdinal("QID")) ? 0 : sqlDataReader.GetInt32(sqlDataReader.GetOrdinal("QID"))
                        });
                    }
                    sqc.Close();
                }
            }
            catch (Exception e)
            {
                logger.FATAL(e.Message);
                return reStandarWorkBookForms = null;
            }

            return reStandarWorkBookForms;
        }
        public static bool DeleteReStandarWorkBookFormByID(int sid)
        {
            bool result = false;
            List<ReStandarWorkBookForm> forms = GetAllreSWorkBookForm();
            if (forms.Count != 0)
            {
                try
                {
                    using (SqlConnection sqc = new SqlConnection(WebConfigurationManager.ConnectionStrings["LDTSConnectionString"].ToString()))
                    {
                        SqlCommand sqlCommand = new SqlCommand("", sqc);
                        sqc.Open();
                        sqlCommand.CommandText = @"DELETE from ReStandarWorkBookForm WHERE SID=@SID ";
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
                    return result = false;
                }
            }
            return result;
        }
        public static bool DeleteReProcessFormByID(int pid)
        {
            bool result = false;
            List<ReProcessQuestion> forms = GetAllReProcesssQuestion().Where(X => X.PID == pid).ToList();
            if (forms.Count != 0)
            {
                try
                {
                    using (SqlConnection sqc = new SqlConnection(WebConfigurationManager.ConnectionStrings["LDTSConnectionString"].ToString()))
                    {
                        SqlCommand sqlCommand = new SqlCommand("", sqc);
                        sqc.Open();
                        sqlCommand.CommandText = @"DELETE from ReProcessQuestion WHERE PID=@PID ";
                        sqlCommand.Parameters.Add("@PID", System.Data.SqlDbType.Int);
                        sqlCommand.Parameters["@PID"].Value = pid;
                        if (sqlCommand.ExecuteNonQuery() > 0)
                            result = true;
                        sqc.Close();

                    }
                }
                catch (Exception e)
                {
                    logger.FATAL(e.Message);
                    return result = false;
                }
            }
            return result;
        }
        /// <summary>
        /// 刪除程序書跟表單關聯By qid
        /// </summary>
        /// <param name="qid"></param>
        /// <returns></returns>
        public static bool DeleteReProcessQuestionByQID(int qid)
        {
            List<ReProcessQuestion> processQuestions = GetAllReProcesssQuestion();
            bool result = false;
            if (processQuestions.Count!=0)
            {
                try
                {
                    using (SqlConnection sqc = new SqlConnection(WebConfigurationManager.ConnectionStrings["LDTSConnectionString"].ToString()))
                    {
                        SqlCommand sqlCommand = new SqlCommand("", sqc);
                        sqc.Open();
                        sqlCommand.CommandText = @"DELETE from ReProcessQuestion WHERE QID=@QID ";
                        sqlCommand.Parameters.Add("@QID", System.Data.SqlDbType.NVarChar);
                        sqlCommand.Parameters["@QID"].Value = qid;
                        if (sqlCommand.ExecuteNonQuery() > 0)
                            result = true;
                        sqc.Close();
                    }
                }
                catch (Exception e)
                {
                    logger.FATAL(e.Message);
                    return result = false;
                }

            }
            return result;
        }
        /// <summary>
        /// 刪除標準作業書跟表單關聯By qid
        /// </summary>
        /// <param name="qid"></param>
        /// <returns></returns>
        /// 
        public static bool DeleteReStandardWorkBookFormByQid(int qid)
        {
            List<ReStandarWorkBookForm> reStandarWorkBookForms = GetAllreSWorkBookForm();
            bool result = false;
            if (reStandarWorkBookForms.Count!=0)
            {
                try
                {
                    using (SqlConnection sqc = new SqlConnection(WebConfigurationManager.ConnectionStrings["LDTSConnectionString"].ToString()))
                    {
                        SqlCommand sqlCommand = new SqlCommand("", sqc);
                        sqc.Open();
                        sqlCommand.CommandText = @"DELETE from ReStandarWorkBookForm WHERE QID=@QID ";
                        sqlCommand.Parameters.Add("@QID", System.Data.SqlDbType.NVarChar);
                        sqlCommand.Parameters["@QID"].Value = qid;
                        if (sqlCommand.ExecuteNonQuery() > 0)
                            result = true;
                        sqc.Close();
                    }
                }
                catch (Exception e)
                {
                    logger.FATAL(e.Message);
                    return result = false;
                }

            }
            return result;

        }
        public static bool DeleteReProcessStandardWorkBookByID(int pid)
        {
            bool result = false;
            try
            {
                using (SqlConnection sqc = new SqlConnection(WebConfigurationManager.ConnectionStrings["LDTSConnectionString"].ToString()))
                {
                    SqlCommand sqlCommand = new SqlCommand("", sqc);
                    sqc.Open();
                    sqlCommand.CommandText = @"DELETE from ReProcessStandardWorkBook WHERE PID=@PID ";
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
                return result = false;
            }
            return result;
        }
        public static List<ReProcessQuestion> GetAllReProcesssQuestion()
        {
            List<ReProcessQuestion> reProcessForms = new List<ReProcessQuestion>();
            try
            {
                using (SqlConnection sqc = new SqlConnection(WebConfigurationManager.ConnectionStrings["LDTSConnectionString"].ToString()))
                {
                    SqlCommand sqlCommand = new SqlCommand("", sqc);
                    sqc.Open();
                    sqlCommand.CommandText = @"Select * from ReProcessQuestion";
                    SqlDataReader sqlDataReader = sqlCommand.ExecuteReader();
                    while (sqlDataReader.Read())
                    {
                        reProcessForms.Add(new ReProcessQuestion()
                        {
                            PID = sqlDataReader.IsDBNull(sqlDataReader.GetOrdinal("PID")) ? 0 : sqlDataReader.GetInt32(sqlDataReader.GetOrdinal("PID")),
                            QID = sqlDataReader.IsDBNull(sqlDataReader.GetOrdinal("QID")) ? 0 : sqlDataReader.GetInt32(sqlDataReader.GetOrdinal("QID")),
                            CreateDate = sqlDataReader.IsDBNull(sqlDataReader.GetOrdinal("CreateDate")) ? (DateTime)SqlDateTime.Null : sqlDataReader.GetDateTime(sqlDataReader.GetOrdinal("CreateDate"))
                        });
                    }
                    sqc.Close();
                }
            }
            catch (Exception e)
            {
                logger.FATAL(e.Message);
                return reProcessForms = null;
            }
            return reProcessForms;
        }
    }
}