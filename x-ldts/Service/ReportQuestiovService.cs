using System;
using System.Collections.Generic;
using System.Data;
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
    public class ReportQuestiovService
    {
        static readonly Logger logger = new Logger("ReportQuestiovService");
        
        
        /// <summary>
        /// 新增表單範本 列印套版
        /// </summary>
        public static bool InsertReportQuestionFile(ReportQuestionFile Rf)
        {
            bool result = false;
            try
            {
                using (SqlConnection sqc = new SqlConnection(WebConfigurationManager.ConnectionStrings["LDTSConnectionString"].ToString()))
                {
                    SqlCommand sqmm = new SqlCommand("", sqc);
                    sqc.Open();

                    sqmm.CommandText = @"INSERT INTO [ReportQuestionFile]([QID],[Version],[TemplateFile]) VALUES(@QID,@Version,@TemplateFile);";
                    sqmm.Parameters.AddWithValue("@QID", Rf.QID);
                    sqmm.Parameters.AddWithValue("@Version", Rf.Version);
                    sqmm.Parameters.AddWithValue("@TemplateFile", Rf.TemplateFile);
                    if (sqmm.ExecuteNonQuery() > 0)
                    {
                        result = true;
                    }

                }
            }
            catch (Exception e)
            {
                logger.FATAL(e.Message);
            }
            return result;
        }

        /// <summary>
        /// 新增表單範本
        /// </summary>
        public static int InsertReportQuestion(ReportQuestion Rq)
        {
            int QID = 0;
            try
            {
                using (SqlConnection sqc = new SqlConnection(WebConfigurationManager.ConnectionStrings["LDTSConnectionString"].ToString()))
                {
                    SqlCommand sqmm = new SqlCommand("", sqc);
                    sqc.Open();

                    sqmm.CommandText = @"INSERT INTO [ReportQuestion]([Title],[Description],[OutputJson],[CreateMan],[Version],[Status]) VALUES(@Title,@Description,@OutputJson,@CreateMan,@Version,@Status); SET @QID = SCOPE_IDENTITY();";

                    sqmm.Parameters.AddWithValue("@Title", Rq.Title);
                    sqmm.Parameters.AddWithValue("@Description", Rq.Description);
                    sqmm.Parameters.AddWithValue("@OutputJson", Rq.OutputJson);
                    sqmm.Parameters.AddWithValue("@CreateMan", Rq.CreateMan);
                    sqmm.Parameters.AddWithValue("@Version", Rq.Version);
                    sqmm.Parameters.AddWithValue("@Status", Rq.Status);

                    SqlParameter pmtLogId = new SqlParameter("@QID", SqlDbType.Int)
                    {
                        Direction = ParameterDirection.Output
                    };

                    sqmm.Parameters.Add(pmtLogId);

                    sqmm.ExecuteNonQuery();

                    QID = (int)pmtLogId.Value;
                }
            }
            catch (Exception e)
            {
                logger.FATAL(e.Message);
                QID = 0;
            }
            return QID;
        }
        /// <summary>
        /// 更新表單範本 列印套版
        /// </summary>
        public static bool UpdateReportQuestionFile(ReportQuestionFile rf)
        {
            bool result = false;
            try
            {
                using (SqlConnection sqc = new SqlConnection(WebConfigurationManager.ConnectionStrings["LDTSConnectionString"].ToString()))
                {
                    SqlCommand sqmm = new SqlCommand("", sqc);
                    sqc.Open();

                    sqmm.CommandText = @"UPDATE [ReportQuestionFile] SET [Version]=@Version,[TemplateFile]=@TemplateFile WHERE QID=@QID and Version=@Version";
                    sqmm.Parameters.AddWithValue("@QID", rf.QID);
                    sqmm.Parameters.AddWithValue("@Version", rf.Version);
                    sqmm.Parameters.AddWithValue("@TemplateFile", rf.TemplateFile);
                    if (sqmm.ExecuteNonQuery() > 0)
                        result = true;
                    sqc.Close();
                }
            }
            catch (Exception e)
            {
                logger.FATAL(e.Message);
            }
            return result;
        }

        /// <summary>
        /// 更新表單範本
        /// </summary>
        public static bool UpdateReportQuestion(ReportQuestion Rq)
        {
            bool result = false;
            try
            {
                using (SqlConnection sqc = new SqlConnection(WebConfigurationManager.ConnectionStrings["LDTSConnectionString"].ToString()))
                {
                    SqlCommand sqmm = new SqlCommand("", sqc);
                    sqc.Open();

                    sqmm.CommandText = @"UPDATE [ReportQuestion] SET [Title]=@Title,[Description]=@Description,[OutputJson]=@OutputJson,[Version]=@Version,[Status]=@Status WHERE QID=@QID ";

                    sqmm.Parameters.AddWithValue("@Title", Rq.Title);
                    sqmm.Parameters.AddWithValue("@Description", Rq.Description);
                    sqmm.Parameters.AddWithValue("@OutputJson", Rq.OutputJson);
                    sqmm.Parameters.AddWithValue("@Version", Rq.Version);
                    sqmm.Parameters.AddWithValue("@Status", Rq.Status);
                    sqmm.Parameters.AddWithValue("@QID", Rq.QID);

                    if (sqmm.ExecuteNonQuery() > 0)
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
        /// <summary>
        /// 刪除表單範本By qid
        /// </summary>
        public static bool DeleteReportQuestionById(int qid)
        {
            bool result = false;
            try
            {
                using (SqlConnection sqc = new SqlConnection(WebConfigurationManager.ConnectionStrings["LDTSConnectionString"].ToString()))
                {
                    SqlCommand sqlCommand = new SqlCommand("", sqc);
                    sqc.Open();
                    sqlCommand.CommandText = @"DELETE from ReportQuestion WHERE QID=@QID ";
                    sqlCommand.Parameters.Add("@QID", System.Data.SqlDbType.NVarChar);
                    sqlCommand.Parameters["@QID"].Value = qid;
                    if (sqlCommand.ExecuteNonQuery() > 0)
                        result = true;
                }

            }
            catch (Exception e)
            {
                logger.FATAL(e.Message);
                return result;
            }
            return result;
        }
        /// <summary>
        /// 查詢所有表單範本
        /// </summary>
        /// <returns></returns>
        public static List<ReportQuestion> GetAllReportQuestions()
        {
            List<ReportQuestion> reportQuestions = new List<ReportQuestion>();
            try
            {
                using (SqlConnection sqc = new SqlConnection(WebConfigurationManager.ConnectionStrings["LDTSConnectionString"].ToString()))
                {
                    SqlCommand sqlCommand = new SqlCommand(@"Select * from ReportQuestion", sqc);
                    sqc.Open();
                    SqlDataReader sd = sqlCommand.ExecuteReader();
                    while (sd.Read())
                    {
                        reportQuestions.Add(new ReportQuestion()
                        {
                            QID = sd.IsDBNull(sd.GetOrdinal("QID")) ? 0 : sd.GetInt32(sd.GetOrdinal("QID")),
                            Title = sd.IsDBNull(sd.GetOrdinal("Title")) ? "" : sd.GetString(sd.GetOrdinal("Title")),
                            Description = sd.IsDBNull(sd.GetOrdinal("Description")) ? "" : sd.GetString(sd.GetOrdinal("Description")),
                            OutputJson = sd.IsDBNull(sd.GetOrdinal("OutputJson")) ? "" : sd.GetString(sd.GetOrdinal("OutputJson")),
                            CreateDate = sd.IsDBNull(sd.GetOrdinal("CreateDate")) ? (DateTime)SqlDateTime.Null : sd.GetDateTime(sd.GetOrdinal("CreateDate")),
                            CreateMan = sd.IsDBNull(sd.GetOrdinal("CreateMan")) ? "" : sd.GetString(sd.GetOrdinal("CreateMan")),
                            Version = sd.IsDBNull(sd.GetOrdinal("Version")) ? "" : sd.GetString(sd.GetOrdinal("Version")),
                            Status = sd.IsDBNull(sd.GetOrdinal("Status")) ? 0 : sd.GetInt32(sd.GetOrdinal("Status"))
                        });
                    }

                    sd.Close();
                }
            }
            catch (Exception ex)
            {
                logger.ERROR(ex.Message);
                reportQuestions = new List<ReportQuestion>();
            }
            return reportQuestions;
        }
        /// <summary>
        /// 取得單個QID表單範本 列印範本
        /// </summary>
        /// <returns></returns>
        public static List<ReportQuestionFile> GetReportQuestionFile(string QID,string Version)
        {
            List<ReportQuestionFile> files = new List<ReportQuestionFile>();
            try
            {
                using (SqlConnection sqc = new SqlConnection(WebConfigurationManager.ConnectionStrings["LDTSConnectionString"].ToString()))
                {
                    SqlCommand sqlCommand = new SqlCommand(@"Select * from ReportQuestionFile where QID=@QID and Version=@Version", sqc);
                    sqc.Open();
                    sqlCommand.Parameters.AddWithValue("@QID", QID);
                    sqlCommand.Parameters.AddWithValue("@Version", Version);
                    SqlDataReader sd = sqlCommand.ExecuteReader();
                    while (sd.Read())
                    {
                        files.Add(new ReportQuestionFile()
                        {
                            QID = sd.IsDBNull(sd.GetOrdinal("QID")) ? 0 : sd.GetInt32(sd.GetOrdinal("QID")),
                            Version = sd.IsDBNull(sd.GetOrdinal("Version")) ?" ": sd.GetString(sd.GetOrdinal("Version")),
                            CreateDate = sd.IsDBNull(sd.GetOrdinal("CreateDate")) ? (DateTime)SqlDateTime.Null : sd.GetDateTime(sd.GetOrdinal("CreateDate")),
                            TemplateFile=sd.IsDBNull(sd.GetOrdinal("TemplateFile")) ?" ":sd.GetString(sd.GetOrdinal("TemplateFile"))
                        });
                    }
                }
            }
            catch (Exception e)
            {
                logger.ERROR(e.Message);
                return files=new List<ReportQuestionFile>();
            }
            return files;
        }

        /// <summary>
        /// 取得單筆表單範本
        /// </summary>
        public static ReportQuestion GetReportQuestions(string QID)
        {
            ReportQuestion reportQuestion = new ReportQuestion();
            try
            {
                using (SqlConnection sqc = new SqlConnection(WebConfigurationManager.ConnectionStrings["LDTSConnectionString"].ToString()))
                {
                    SqlCommand sqlCommand = new SqlCommand(@"Select * from ReportQuestion where QID=@QID", sqc);
                    sqc.Open();

                    sqlCommand.Parameters.AddWithValue("@QID", QID);
                    SqlDataReader sd = sqlCommand.ExecuteReader();
                    if (sd.Read())
                    {
                        reportQuestion = new ReportQuestion()
                        {
                            QID = sd.IsDBNull(sd.GetOrdinal("QID")) ? 0 : sd.GetInt32(sd.GetOrdinal("QID")),
                            Title = sd.IsDBNull(sd.GetOrdinal("Title")) ? "" : sd.GetString(sd.GetOrdinal("Title")),
                            Description = sd.IsDBNull(sd.GetOrdinal("Description")) ? "" : sd.GetString(sd.GetOrdinal("Description")),
                            OutputJson = sd.IsDBNull(sd.GetOrdinal("OutputJson")) ? "" : sd.GetString(sd.GetOrdinal("OutputJson")),
                            CreateDate = sd.IsDBNull(sd.GetOrdinal("CreateDate")) ? (DateTime)SqlDateTime.Null : sd.GetDateTime(sd.GetOrdinal("CreateDate")),
                            CreateMan = sd.IsDBNull(sd.GetOrdinal("CreateMan")) ? "" : sd.GetString(sd.GetOrdinal("CreateMan")),
                            Version = sd.IsDBNull(sd.GetOrdinal("Version")) ? "" : sd.GetString(sd.GetOrdinal("Version")),
                            Status = sd.IsDBNull(sd.GetOrdinal("Status")) ? 0 : sd.GetInt32(sd.GetOrdinal("Status"))
                        };
                    }

                    sd.Close();
                }
            }
            catch (Exception ex)
            {
                logger.ERROR(ex.Message);
            }
            return reportQuestion;
        }
        /// <summary>
        /// 取得單筆表單範本 套印版本
        /// </summary>
        /// 
        public static List<ReportQuestionFile> GetAllReportFilesById(int QID)
        {
            List<ReportQuestionFile> reportQuestionFiles = new List<ReportQuestionFile>();
            try
            {
                using (SqlConnection sqc = new SqlConnection(WebConfigurationManager.ConnectionStrings["LDTSConnectionString"].ToString()))
                {
                    SqlCommand sqlCommand = new SqlCommand(@"Select * from ReportQuestionFile where QID=@QID", sqc);
                    sqc.Open();
                    sqlCommand.Parameters.AddWithValue("@QID", QID);
                    SqlDataReader sd = sqlCommand.ExecuteReader();
                    while (sd.Read())
                    {
                        reportQuestionFiles.Add(new ReportQuestionFile()
                        {
                            QID = sd.IsDBNull(sd.GetOrdinal("QID")) ? 0 : sd.GetInt32(sd.GetOrdinal("QID")),
                            Version = sd.IsDBNull(sd.GetOrdinal("Version")) ? "" : sd.GetString(sd.GetOrdinal("Version")),
                            CreateDate = sd.IsDBNull(sd.GetOrdinal("CreateDate")) ? (DateTime)SqlDateTime.Null : sd.GetDateTime(sd.GetOrdinal("CreateDate")),
                            TemplateFile = sd.IsDBNull(sd.GetOrdinal("TemplateFile")) ? "" : sd.GetString(sd.GetOrdinal("TemplateFile")),
                        });
                    }
                    sd.Close();

                }
            }
            catch (Exception e)
            {
                logger.FATAL(e.Message);
            }
            return reportQuestionFiles;
        }
    }
}