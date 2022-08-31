﻿ using System;
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
        public static bool InsertReProcessStandardWorkBooks(List<ReProcessStandardWorkBook> standardWorkBooks)
        {
            bool result = false;
            List<ReProcessStandardWorkBook> reProcessStandardWorkBooks = new List<ReProcessStandardWorkBook>();
                try
            {
                using (SqlConnection sqc = new SqlConnection(WebConfigurationManager.ConnectionStrings["LDTSConnectionString"].ToString()))
                {
                    foreach (var standardWorkBook in standardWorkBooks)
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
                        sqc.Close();
                    }

                }
            }
            catch (Exception e)
            {
                logger.FATAL(e.Message);
            }
            return result;

        }

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
        public static bool InsertReAdminProcesses(List<ReAdminProcess>reAdminProcesses)
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
            List<ReProcessQuestion> forms =GetAllReProcesssQuestion().Where(X=>X.PID==pid).ToList();
            if (forms.Count!=0)
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
                return result =false;
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
                return reProcessForms =null;
            }
            return reProcessForms;
        }


    }
}