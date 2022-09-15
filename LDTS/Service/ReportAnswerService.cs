using System;
using System.Collections.Generic;
using System.Data;
using System.Data.SqlClient;
using System.Data.SqlTypes;
using System.Web.Configuration;
using LDTS.Models;
using LDTS.Utils;

namespace LDTS.Service
{
    public class ReportAnswerService
    {
        static readonly Logger logger = new Logger("ReportAnswerService");

        public static List<ReportAnswer> GetAnswers()
        {
            List<ReportAnswer> reportAnswers = new List<ReportAnswer>();
            try
            {
                using (SqlConnection sqc = new SqlConnection(WebConfigurationManager.ConnectionStrings["LDTSConnectionString"].ToString()))
                {
                    SqlCommand sqlCommand = new SqlCommand("", sqc);
                    sqc.Open();
                    sqlCommand.CommandText = @"Select * from ReportAnswer";
                    SqlDataReader sd = sqlCommand.ExecuteReader();
                    while (sd.Read())
                    {
                        reportAnswers.Add(new ReportAnswer()
                        {
                            AID = sd.IsDBNull(sd.GetOrdinal("AID")) ? 0 : sd.GetInt32(sd.GetOrdinal("AID")),
                            QID = sd.IsDBNull(sd.GetOrdinal("QID")) ? 0 : sd.GetInt32(sd.GetOrdinal("QID")),
                            Title = sd.IsDBNull(sd.GetOrdinal("Title")) ? "" : sd.GetString(sd.GetOrdinal("Title")),
                            ExtendName = sd.IsDBNull(sd.GetOrdinal("ExtendName")) ?string.Empty : sd.GetString(sd.GetOrdinal("ExtendName")),
                            Description = sd.IsDBNull(sd.GetOrdinal("Description")) ? "" : sd.GetString(sd.GetOrdinal("Description")),
                            OutputJson = sd.IsDBNull(sd.GetOrdinal("OutputJson")) ? "" : sd.GetString(sd.GetOrdinal("OutputJson")),
                            CreateDate = sd.IsDBNull(sd.GetOrdinal("CreateDate")) ? (DateTime)SqlDateTime.Null : sd.GetDateTime(sd.GetOrdinal("CreateDate")),
                            CreateMan = sd.IsDBNull(sd.GetOrdinal("CreateMan")) ? "" : sd.GetString(sd.GetOrdinal("CreateMan")),
                            AppendFile = sd.IsDBNull(sd.GetOrdinal("AppendFile")) ? "" : sd.GetString(sd.GetOrdinal("AppendFile")),
                            OutputTemplate = sd.IsDBNull(sd.GetOrdinal("OutputTemplate")) ? "" : sd.GetString(sd.GetOrdinal("OutputTemplate")),
                            Version = sd.IsDBNull(sd.GetOrdinal("Version")) ? "" : sd.GetString(sd.GetOrdinal("Version")),
                            Keyword = sd.IsDBNull(sd.GetOrdinal("Keyword")) ? "" : sd.GetString(sd.GetOrdinal("Keyword")),
                            Status = sd.IsDBNull(sd.GetOrdinal("Status")) ? 0 : sd.GetInt32(sd.GetOrdinal("Status")),
                            LastupDate=sd.IsDBNull(sd.GetOrdinal("LastupDate"))? (DateTime)SqlDateTime.Null : sd.GetDateTime(sd.GetOrdinal("LastupDate")),
                            LastupMan=sd.IsDBNull(sd.GetOrdinal("LastupMan"))? string.Empty : sd.GetString(sd.GetOrdinal("LastupMan"))
                        });
                    }
                }
            }
            catch (Exception e)
            {
                logger.ERROR(e.Message);
            }
            return reportAnswers;
        }
        public static bool UpdateReportAnswer(ReportAnswer reportAnswer)
        {
            bool result = false;
            try
            {
                using (SqlConnection sqc = new SqlConnection(WebConfigurationManager.ConnectionStrings["LDTSConnectionString"].ToString()))
                {
                    SqlCommand sqlCommand = new SqlCommand("", sqc);
                    sqc.Open();
                    sqlCommand.CommandText = @"UPDATE ReportAnswer SET Title=@Title,ExtendName=@ExtendName,Description=@Description,OutputJson=@OutputJson,AppendFile=@AppendFile,OutputTemplate=@OutputTemplate,Status=@Status,Keyword=@Keyword,LastupDate=@LastupDate,LastupMan=@LastupMan WHERE AID=@AID";
                    if (reportAnswer.Keyword == null)
                    {
                        sqlCommand.Parameters.AddWithValue("@Keyword", DBNull.Value);
                    }
                    else
                    {
                        sqlCommand.Parameters.AddWithValue("@Keyword", reportAnswer.Keyword);
                    }
                    if (reportAnswer.AppendFile == null)
                    {
                        sqlCommand.Parameters.AddWithValue("@AppendFile", DBNull.Value);
                    }
                    else
                    {
                        sqlCommand.Parameters.AddWithValue("@AppendFile", reportAnswer.AppendFile);
                    }

                    if (reportAnswer.OutputTemplate == null)
                    {
                        sqlCommand.Parameters.AddWithValue("@OutputTemplate", DBNull.Value);
                    }
                    else
                    {
                        sqlCommand.Parameters.AddWithValue("@OutputTemplate", reportAnswer.OutputTemplate);
                    }
                    sqlCommand.Parameters.AddWithValue("@Status", reportAnswer.Status);
                    if (reportAnswer.LastupMan == null)
                    {
                        sqlCommand.Parameters.AddWithValue("@LastupMan", DBNull.Value);
                    }
                    else
                    {
                        sqlCommand.Parameters.AddWithValue("@LastupMan", reportAnswer.LastupMan);
                    }
                    sqlCommand.Parameters.AddWithValue("@AID", reportAnswer.AID);
                    sqlCommand.Parameters.AddWithValue("@Description", reportAnswer.Description);
                    sqlCommand.Parameters.AddWithValue("@Title", reportAnswer.Title);
                    sqlCommand.Parameters.AddWithValue("@ExtendName", reportAnswer.ExtendName);
                    sqlCommand.Parameters.AddWithValue("@LastupDate", reportAnswer.LastupDate);
                    sqlCommand.Parameters.AddWithValue("@OutputJson", reportAnswer.OutputJson);

                    if (sqlCommand.ExecuteNonQuery() > 0)
                    {
                        result = true;
                    }

                }
            }
            catch (Exception e)
            {
                logger.ERROR(e.Message);
                result = false;
            }
            return result;
        }
        public static int InsertReportAnswer(ReportAnswer reportAnswer)
        {
            int result = 0;
            try
            {
                using (SqlConnection sqc = new SqlConnection(WebConfigurationManager.ConnectionStrings["LDTSConnectionString"].ToString()))
                {
                    SqlCommand sqlCommand = new SqlCommand("", sqc);
                    sqc.Open();
                    sqlCommand.CommandText = @"INSERT INTO ReportAnswer ( QID,Title,ExtendName,Description,OutputJson,CreateMan,AppendFile,OutputTemplate,Status,Keyword,LastupMan,Version) VALUES(@QID,@Title,@ExtendName,@Description,@OutputJson,@CreateMan,@AppendFile,@OutputTemplate,@Status,@Keyword,@LastupMan,@Version);SET @AID=SCOPE_IDENTITY()";
                    sqlCommand.Parameters.AddWithValue("@QID", reportAnswer.QID);
                    sqlCommand.Parameters.AddWithValue("@Description", reportAnswer.Description);
                    sqlCommand.Parameters.AddWithValue("@Title", reportAnswer.Title);
                    sqlCommand.Parameters.AddWithValue("@ExtendName", reportAnswer.ExtendName);
                    sqlCommand.Parameters.AddWithValue("@OutputJson", reportAnswer.OutputJson);
                    sqlCommand.Parameters.AddWithValue("@CreateMan", reportAnswer.CreateMan);
                    sqlCommand.Parameters.AddWithValue("@Version", reportAnswer.Version);

                    if (reportAnswer.Keyword == null)
                    {
                        sqlCommand.Parameters.AddWithValue("@Keyword", DBNull.Value);
                    }
                    else
                    {
                        sqlCommand.Parameters.AddWithValue("@Keyword", reportAnswer.Keyword);
                    }
                    if (reportAnswer.AppendFile == null)
                    {
                        sqlCommand.Parameters.AddWithValue("@AppendFile", DBNull.Value);
                    }
                    else
                    {
                        sqlCommand.Parameters.AddWithValue("@AppendFile", reportAnswer.AppendFile);
                    }

                    if (reportAnswer.OutputTemplate == null)
                    {
                        sqlCommand.Parameters.AddWithValue("@OutputTemplate", DBNull.Value);
                    }
                    else
                    {
                        sqlCommand.Parameters.AddWithValue("@OutputTemplate", reportAnswer.OutputTemplate);
                    }
                    sqlCommand.Parameters.AddWithValue("@Status", reportAnswer.Status);
                    if (reportAnswer.LastupMan ==null)
                    {
                        sqlCommand.Parameters.AddWithValue("@LastupMan", DBNull.Value);
                    }
                    else
                    {
                        sqlCommand.Parameters.AddWithValue("@LastupMan", reportAnswer.LastupMan);
                    }
                    SqlParameter AID = new SqlParameter("@AID", SqlDbType.Int)
                    {
                        Direction = ParameterDirection.Output
                    };
                    sqlCommand.Parameters.Add(AID);

                    if (sqlCommand.ExecuteNonQuery() > 0)
                    {
                        result = (int)AID.Value;
                    }

                }

            }
            catch (Exception e)
            {
                result = 0;
                logger.ERROR(e.Message);
            }
            return result;
        }

        /// <summary>
        /// 取得單筆表單
        /// </summary>
        public static ReportAnswer GetReportAnswer(string AID)
        {
            ReportAnswer reportAnswer = new ReportAnswer();
            try
            {
                using (SqlConnection sqc = new SqlConnection(WebConfigurationManager.ConnectionStrings["LDTSConnectionString"].ToString()))
                {
                    SqlCommand sqlCommand = new SqlCommand(@"Select * from ReportAnswer where AID=@AID", sqc);
                    sqc.Open();

                    sqlCommand.Parameters.AddWithValue("@AID", AID);
                    SqlDataReader sd = sqlCommand.ExecuteReader();
                    if (sd.Read())
                    {
                        reportAnswer = new ReportAnswer()
                        {
                            AID = sd.IsDBNull(sd.GetOrdinal("AID")) ? 0 : sd.GetInt32(sd.GetOrdinal("AID")),
                            QID = sd.IsDBNull(sd.GetOrdinal("QID")) ? 0 : sd.GetInt32(sd.GetOrdinal("QID")),
                            Title = sd.IsDBNull(sd.GetOrdinal("Title")) ? "" : sd.GetString(sd.GetOrdinal("Title")),
                            ExtendName = sd.IsDBNull(sd.GetOrdinal("ExtendName")) ? "" : sd.GetString(sd.GetOrdinal("ExtendName")),
                            Description = sd.IsDBNull(sd.GetOrdinal("Description")) ? "" : sd.GetString(sd.GetOrdinal("Description")),
                            OutputJson = sd.IsDBNull(sd.GetOrdinal("OutputJson")) ? "" : sd.GetString(sd.GetOrdinal("OutputJson")),
                            CreateDate = sd.IsDBNull(sd.GetOrdinal("CreateDate")) ? (DateTime)SqlDateTime.Null : sd.GetDateTime(sd.GetOrdinal("CreateDate")),
                            CreateMan = sd.IsDBNull(sd.GetOrdinal("CreateMan")) ? "" : sd.GetString(sd.GetOrdinal("CreateMan")),
                            AppendFile = sd.IsDBNull(sd.GetOrdinal("AppendFile")) ? "" : sd.GetString(sd.GetOrdinal("AppendFile")),
                            OutputTemplate = sd.IsDBNull(sd.GetOrdinal("OutputTemplate")) ? "" : sd.GetString(sd.GetOrdinal("OutputTemplate")),
                            Version = sd.IsDBNull(sd.GetOrdinal("Version")) ? "" : sd.GetString(sd.GetOrdinal("Version")),
                            Keyword = sd.IsDBNull(sd.GetOrdinal("Keyword")) ? "" : sd.GetString(sd.GetOrdinal("Keyword")),
                            Status = sd.IsDBNull(sd.GetOrdinal("Status")) ? 0 : sd.GetInt32(sd.GetOrdinal("Status")),
                            LastupDate = sd.IsDBNull(sd.GetOrdinal("LastupDate")) ? (DateTime)SqlDateTime.Null : sd.GetDateTime(sd.GetOrdinal("LastupDate")),
                            LastupMan = sd.IsDBNull(sd.GetOrdinal("LastupMan")) ? string.Empty : sd.GetString(sd.GetOrdinal("LastupMan"))
                        };
                    }

                    sd.Close();
                }
            }
            catch (Exception ex)
            {
                logger.ERROR(ex.Message);
                reportAnswer = new ReportAnswer();
            }
            return reportAnswer;
        }
        public static string MatchStatus(int status)
        {
            switch (status)
            {
                case 0:
                    return "作廢";
                case 1:
                    return "正常";
                case 2:
                    return "待簽核";
                case 3:
                    return "已簽核";
                case 4:
                    return "結案";
                default:
                    return "";
            }
        }
        public static List<ReportAnswer> GetAnswersByKey(string key)
        {
            List<ReportAnswer> reportAnswers = new List<ReportAnswer>();
            try
            {
                using (SqlConnection sqc = new SqlConnection(WebConfigurationManager.ConnectionStrings["LDTSConnectionString"].ToString()))
                {
                    SqlCommand sqlCommand = new SqlCommand("", sqc);
                    sqc.Open();
                    sqlCommand.CommandText = @"Select * from ReportAnswer where Status > 0 and (Keyword like @Keyword or Title like @Keyword or ExtendName like @Keyword)";
                    sqlCommand.Parameters.AddWithValue("@Keyword", "%" + key + "%");
                    SqlDataReader sd = sqlCommand.ExecuteReader();
                    while (sd.Read())
                    {
                        reportAnswers.Add(new ReportAnswer()
                        {
                            AID = sd.IsDBNull(sd.GetOrdinal("AID")) ? 0 : sd.GetInt32(sd.GetOrdinal("AID")),
                            QID = sd.IsDBNull(sd.GetOrdinal("QID")) ? 0 : sd.GetInt32(sd.GetOrdinal("QID")),
                            Title = sd.IsDBNull(sd.GetOrdinal("Title")) ? "" : sd.GetString(sd.GetOrdinal("Title")),
                            ExtendName = sd.IsDBNull(sd.GetOrdinal("ExtendName")) ? string.Empty : sd.GetString(sd.GetOrdinal("ExtendName")),
                            Description = sd.IsDBNull(sd.GetOrdinal("Description")) ? "" : sd.GetString(sd.GetOrdinal("Description")),
                            OutputJson = sd.IsDBNull(sd.GetOrdinal("OutputJson")) ? "" : sd.GetString(sd.GetOrdinal("OutputJson")),
                            CreateDate = sd.IsDBNull(sd.GetOrdinal("CreateDate")) ? (DateTime)SqlDateTime.Null : sd.GetDateTime(sd.GetOrdinal("CreateDate")),
                            CreateMan = sd.IsDBNull(sd.GetOrdinal("CreateMan")) ? "" : sd.GetString(sd.GetOrdinal("CreateMan")),
                            AppendFile = sd.IsDBNull(sd.GetOrdinal("AppendFile")) ? "" : sd.GetString(sd.GetOrdinal("AppendFile")),
                            OutputTemplate = sd.IsDBNull(sd.GetOrdinal("OutputTemplate")) ? "" : sd.GetString(sd.GetOrdinal("OutputTemplate")),
                            Version = sd.IsDBNull(sd.GetOrdinal("Version")) ? "" : sd.GetString(sd.GetOrdinal("Version")),
                            Keyword = sd.IsDBNull(sd.GetOrdinal("Keyword")) ? "" : sd.GetString(sd.GetOrdinal("Keyword")),
                            Status = sd.IsDBNull(sd.GetOrdinal("Status")) ? 0 : sd.GetInt32(sd.GetOrdinal("Status")),
                            LastupDate = sd.IsDBNull(sd.GetOrdinal("LastupDate")) ? (DateTime)SqlDateTime.Null : sd.GetDateTime(sd.GetOrdinal("LastupDate")),
                            LastupMan = sd.IsDBNull(sd.GetOrdinal("LastupMan")) ? string.Empty : sd.GetString(sd.GetOrdinal("LastupMan"))
                        });
                    }
                }
            }
            catch (Exception e)
            {
                logger.ERROR(e.Message);
            }
            return reportAnswers;
        }

    }
}