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
    public class FormService
    {
        static readonly Logger logger = new Logger("FormService");

        /// <summary>
        /// 取得單筆表單範本 
        /// </summary>
        
        public static ReportQuestion GetReportQuestionById(int qid)
        {
            ReportQuestion reportQuestion = new ReportQuestion();
            try
            {
                using (SqlConnection sqc = new SqlConnection(WebConfigurationManager.ConnectionStrings["LDTSConnectionString"].ToString()))
                {
                    SqlCommand sqlCommand = new SqlCommand("", sqc);
                    sqc.Open();
                    sqlCommand.CommandText = @"Select * from ReportQuestion where QID=@QID";
                    sqlCommand.Parameters.Add("@QID", System.Data.SqlDbType.Int);
                    sqlCommand.Parameters["@QID"].Value = qid;
                    SqlDataReader sqlDataReader = sqlCommand.ExecuteReader();
                    while (sqlDataReader.Read())
                    {
                        reportQuestion.QID = sqlDataReader.IsDBNull(sqlDataReader.GetOrdinal("QID")) ? 0 : sqlDataReader.GetInt32(sqlDataReader.GetOrdinal("QID"));
                        reportQuestion.Title = sqlDataReader.IsDBNull(sqlDataReader.GetOrdinal("Title")) ? "" : sqlDataReader.GetString(sqlDataReader.GetOrdinal("Title"));
                        reportQuestion.Description = sqlDataReader.IsDBNull(sqlDataReader.GetOrdinal("Description")) ? "" : sqlDataReader.GetString(sqlDataReader.GetOrdinal("Description"));
                        reportQuestion.OutputJson = sqlDataReader.IsDBNull(sqlDataReader.GetOrdinal("OutputJson")) ? "" : sqlDataReader.GetString(sqlDataReader.GetOrdinal("OutputJson"));
                        reportQuestion.CreateDate = sqlDataReader.IsDBNull(sqlDataReader.GetOrdinal("CreateDate")) ? (DateTime)SqlDateTime.Null : sqlDataReader.GetDateTime(sqlDataReader.GetOrdinal("CreateDate"));
                        reportQuestion.CreateMan = sqlDataReader.IsDBNull(sqlDataReader.GetOrdinal("CreateMan")) ? "" : sqlDataReader.GetString(sqlDataReader.GetOrdinal("CreateMan"));
                        reportQuestion.Version = sqlDataReader.IsDBNull(sqlDataReader.GetOrdinal("Version")) ? "" : sqlDataReader.GetString(sqlDataReader.GetOrdinal("Version"));
                        reportQuestion.Status = sqlDataReader.IsDBNull(sqlDataReader.GetOrdinal("Status")) ? 0 : sqlDataReader.GetInt32(sqlDataReader.GetOrdinal("Status"));
                    }
                    sqc.Close();
                }
            }
            catch (Exception ex)
            {
                logger.ERROR(ex.Message);
                return reportQuestion=null;
            }
            return reportQuestion;
        }
        /// <summary>
        /// 取得單筆表單
        /// </summary>
        /// 
        public static ReportAnswer GetReportAnswerById(int aid)
        {
            ReportAnswer reportAnswer = new ReportAnswer();
            try
            {
                using (SqlConnection sqc = new SqlConnection(WebConfigurationManager.ConnectionStrings["LDTSConnectionString"].ToString()))
                {
                    SqlCommand sqlCommand = new SqlCommand("", sqc);
                    sqc.Open();
                    sqlCommand.CommandText = @"Select * from ReportAnswer where AID=@AID";
                    sqlCommand.Parameters.Add("@AID", System.Data.SqlDbType.Int);
                    sqlCommand.Parameters["@AID"].Value = aid;
                    SqlDataReader sqlDataReader = sqlCommand.ExecuteReader();
                    while (sqlDataReader.Read())
                    {
                        reportAnswer.AID = sqlDataReader.IsDBNull(sqlDataReader.GetOrdinal("AID")) ? 0 : sqlDataReader.GetInt32(sqlDataReader.GetOrdinal("AID"));
                        reportAnswer.QID = sqlDataReader.IsDBNull(sqlDataReader.GetOrdinal("QID")) ? 0 : sqlDataReader.GetInt32(sqlDataReader.GetOrdinal("QID"));
                        reportAnswer.Title = sqlDataReader.IsDBNull(sqlDataReader.GetOrdinal("Title")) ? "" : sqlDataReader.GetString(sqlDataReader.GetOrdinal("Title"));
                        reportAnswer.Description = sqlDataReader.IsDBNull(sqlDataReader.GetOrdinal("Description")) ? "" : sqlDataReader.GetString(sqlDataReader.GetOrdinal("Description"));
                        reportAnswer.ExtendName = sqlDataReader.IsDBNull(sqlDataReader.GetOrdinal("ExtendName")) ? "" : sqlDataReader.GetString(sqlDataReader.GetOrdinal("ExtendName"));
                        reportAnswer.AppendFile = sqlDataReader.IsDBNull(sqlDataReader.GetOrdinal("AppendFile")) ? "" : sqlDataReader.GetString(sqlDataReader.GetOrdinal("AppendFile"));
                        reportAnswer.OutputJson = sqlDataReader.IsDBNull(sqlDataReader.GetOrdinal("OutputJson")) ? "" : sqlDataReader.GetString(sqlDataReader.GetOrdinal("OutputJson"));
                        reportAnswer.OutputTemplate = sqlDataReader.IsDBNull(sqlDataReader.GetOrdinal("OutputTemplate")) ? "" : sqlDataReader.GetString(sqlDataReader.GetOrdinal("OutputTemplate"));
                        reportAnswer.CreateDate = sqlDataReader.IsDBNull(sqlDataReader.GetOrdinal("CreateDate")) ? (DateTime)SqlDateTime.Null : sqlDataReader.GetDateTime(sqlDataReader.GetOrdinal("CreateDate"));
                        reportAnswer.CreateMan = sqlDataReader.IsDBNull(sqlDataReader.GetOrdinal("CreateMan")) ? "" : sqlDataReader.GetString(sqlDataReader.GetOrdinal("CreateMan"));
                        reportAnswer.Version = sqlDataReader.IsDBNull(sqlDataReader.GetOrdinal("Version")) ? "" : sqlDataReader.GetString(sqlDataReader.GetOrdinal("Version"));
                        reportAnswer.Status = sqlDataReader.IsDBNull(sqlDataReader.GetOrdinal("Status")) ? 0 : sqlDataReader.GetInt32(sqlDataReader.GetOrdinal("Status"));

                    }
                    sqc.Close();
                }
            }
            catch (Exception ex)
            {
                logger.ERROR(ex.Message);
                return reportAnswer = null;
            }
            return reportAnswer;
        }
    }
}