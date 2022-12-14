using System;
using System.Collections;
using System.Collections.Generic;
using System.Data.SqlClient;
using System.Data.SqlTypes;
using System.Web.Configuration;
using LDTS.Models;
using LDTS.Utils;

namespace LDTS.Service
{
    /// <summary>
    /// 提醒設定元件
    /// </summary>
    public class AlertService
    {
        static readonly Logger logger = new Logger("AlertService");

        /// <summary>
        /// 新增提醒設定
        /// </summary>
        /// <param name="alt"></param>
        /// <returns></returns>
        public static bool InsertreAlert(AlertSetting alt)
        {
            bool result = false;
            try
            {
                using (SqlConnection sqc = new SqlConnection(WebConfigurationManager.ConnectionStrings["LDTSConnectionString"].ToString()))
                {
                    SqlCommand sqlCommand = new SqlCommand(@"INSERT INTO AlertSetting([ALTitle],[ALType],[ALFactor],[ALForm],[Status],[CreateMan]) VALUES(@ALTitle,@ALType,@ALFactor,@ALForm,@Status,@CreateMan)", sqc);
                    sqc.Open();

                    sqlCommand.Parameters.AddWithValue("@ALTitle", alt.ALTitle);
                    sqlCommand.Parameters.AddWithValue("@ALType", alt.ALType);
                    sqlCommand.Parameters.AddWithValue("@ALFactor", alt.ALFactor);
                    sqlCommand.Parameters.AddWithValue("@ALForm", alt.ALForm);
                    sqlCommand.Parameters.AddWithValue("@Status", alt.Status);
                    sqlCommand.Parameters.AddWithValue("@CreateMan", alt.CreateMan);

                    if (sqlCommand.ExecuteNonQuery() > 0)
                    {
                        result = true;
                    }
                }
            }
            catch (Exception ex)
            {
                logger.ERROR("InsertreAlert:" + ex.Message);
                return result;
            }

            return result;
        }

        /// <summary>
        /// 更新提醒設定
        /// </summary>
        public static bool UpdateAlert(AlertSetting als)
        {
            bool result = false;
            try
            {
                using (SqlConnection sqc = new SqlConnection(WebConfigurationManager.ConnectionStrings["LDTSConnectionString"].ToString()))
                {
                    SqlCommand sqmm = new SqlCommand("", sqc);
                    sqc.Open();

                    sqmm.CommandText = @"UPDATE [AlertSetting] SET ALTitle=@ALTitle,ALType=@ALType,ALFactor=@ALFactor,ALForm=@ALForm,Status=@Status WHERE ALID=@ALID ";

                    sqmm.Parameters.AddWithValue("@ALTitle", als.ALTitle);
                    sqmm.Parameters.AddWithValue("@ALType", als.ALType);
                    sqmm.Parameters.AddWithValue("@ALFactor", als.ALFactor);
                    sqmm.Parameters.AddWithValue("@ALForm", als.ALForm);
                    sqmm.Parameters.AddWithValue("@Status", als.Status);
                    sqmm.Parameters.AddWithValue("@ALID", als.ALID);

                    if (sqmm.ExecuteNonQuery() > 0)
                        result = true;
                }
            }
            catch (Exception e)
            {
                logger.FATAL("UpdateAlert: " + e.Message);
                result = false;
            }
            return result;
        }

        /// <summary>
        /// 刪除提醒設定
        /// </summary>
        public static bool DELETEAlert(int ALID)
        {
            bool result = false;
            try
            {
                using (SqlConnection sqc = new SqlConnection(WebConfigurationManager.ConnectionStrings["LDTSConnectionString"].ToString()))
                {
                    SqlCommand sqmm = new SqlCommand("", sqc);
                    sqc.Open();

                    sqmm.CommandText = @"DELETE [AlertSetting] WHERE ALID=@ALID ";

                    sqmm.Parameters.AddWithValue("@ALID", ALID);

                    if (sqmm.ExecuteNonQuery() > 0)
                        result = true;
                }
            }
            catch (Exception e)
            {
                logger.FATAL("DELETEAlert: " + e.Message);
                result = false;
            }
            return result;
        }

        /// <summary>
        /// 取得單筆提醒設定
        /// </summary>
        public static AlertSetting GetAlert(int ALID)
        {
            AlertSetting alt = null;
            try
            {
                using (SqlConnection sqc = new SqlConnection(WebConfigurationManager.ConnectionStrings["LDTSConnectionString"].ToString()))
                {
                    SqlCommand sqlCommand = new SqlCommand(@"Select * from AlertSetting where ALID=@ALID", sqc);
                    sqc.Open();

                    sqlCommand.Parameters.AddWithValue("@ALID", ALID);
                    SqlDataReader sd = sqlCommand.ExecuteReader();

                    if (sd.Read())
                    {
                        alt = new AlertSetting()
                        {
                            ALID = sd.IsDBNull(sd.GetOrdinal("ALID")) ? 0 : sd.GetInt32(sd.GetOrdinal("ALID")),
                            ALTitle = sd.IsDBNull(sd.GetOrdinal("ALTitle")) ? "" : sd.GetString(sd.GetOrdinal("ALTitle")),
                            ALType = sd.IsDBNull(sd.GetOrdinal("ALType")) ? 0 : sd.GetInt32(sd.GetOrdinal("ALType")),
                            ALFactor = sd.IsDBNull(sd.GetOrdinal("ALFactor")) ? "" : sd.GetString(sd.GetOrdinal("ALFactor")),
                            ALForm = sd.IsDBNull(sd.GetOrdinal("ALForm")) ? "" : sd.GetString(sd.GetOrdinal("ALForm")),
                            Status = sd.IsDBNull(sd.GetOrdinal("Status")) ? 0 : sd.GetInt32(sd.GetOrdinal("Status")),
                            CreateDate = sd.IsDBNull(sd.GetOrdinal("CreateDate")) ? (DateTime)SqlDateTime.Null : sd.GetDateTime(sd.GetOrdinal("CreateDate")),
                            CreateMan = sd.IsDBNull(sd.GetOrdinal("CreateMan")) ? "" : sd.GetString(sd.GetOrdinal("CreateMan"))
                        };
                    }

                    sd.Close();
                }
            }
            catch (Exception ex)
            {
                logger.ERROR(ex.Message);
                alt = null;
            }
            return alt;
        }

        /// <summary>
        /// 查詢所有提醒設定
        /// </summary>
        /// <returns></returns>
        public static List<AlertSetting> GetAllAlerts()
        {
            List<AlertSetting> alts = new List<AlertSetting>();
            try
            {
                using (SqlConnection sqc = new SqlConnection(WebConfigurationManager.ConnectionStrings["LDTSConnectionString"].ToString()))
                {
                    SqlCommand sqlCommand = new SqlCommand(@"select * from AlertSetting", sqc);
                    sqc.Open();
                    SqlDataReader sd = sqlCommand.ExecuteReader();

                    while (sd.Read())
                    {
                        alts.Add(new AlertSetting()
                        {
                            ALID = sd.IsDBNull(sd.GetOrdinal("ALID")) ? 0 : sd.GetInt32(sd.GetOrdinal("ALID")),
                            ALTitle = sd.IsDBNull(sd.GetOrdinal("ALTitle")) ? "" : sd.GetString(sd.GetOrdinal("ALTitle")),
                            ALType = sd.IsDBNull(sd.GetOrdinal("ALType")) ? 0 : sd.GetInt32(sd.GetOrdinal("ALType")),
                            ALFactor = sd.IsDBNull(sd.GetOrdinal("ALFactor")) ? "" : sd.GetString(sd.GetOrdinal("ALFactor")),
                            ALForm = sd.IsDBNull(sd.GetOrdinal("ALForm")) ? "" : sd.GetString(sd.GetOrdinal("ALForm")),
                            Status = sd.IsDBNull(sd.GetOrdinal("Status")) ? 0 : sd.GetInt32(sd.GetOrdinal("Status")),
                            CreateDate = sd.IsDBNull(sd.GetOrdinal("CreateDate")) ? (DateTime)SqlDateTime.Null : sd.GetDateTime(sd.GetOrdinal("CreateDate")),
                            CreateMan = sd.IsDBNull(sd.GetOrdinal("CreateMan")) ? "" : sd.GetString(sd.GetOrdinal("CreateMan"))
                        });
                    }

                    sd.Close();
                }
            }
            catch (Exception ex)
            {
                logger.ERROR("GetAllAlerts: " + ex.Message);
                alts = new List<AlertSetting>();
            }
            return alts;
        }

        /// <summary>
        /// 查詢顯示提醒設定
        /// </summary>
        /// <returns></returns>
        public static List<AlertSetting> checkAlerts(Admin admin)
        {
            List<AlertSetting> alts = new List<AlertSetting>();
            List<AlertSetting> altsTemp = new List<AlertSetting>();
            try
            {
                using (SqlConnection sqc = new SqlConnection(WebConfigurationManager.ConnectionStrings["LDTSConnectionString"].ToString()))
                {
                    SqlCommand sqlCommand = new SqlCommand(@"select * from AlertSetting where Status=1", sqc);
                    sqc.Open();
                    SqlDataReader sd = sqlCommand.ExecuteReader();

                    while (sd.Read())
                    {
                        alts.Add(new AlertSetting()
                        {
                            ALID = sd.IsDBNull(sd.GetOrdinal("ALID")) ? 0 : sd.GetInt32(sd.GetOrdinal("ALID")),
                            ALTitle = sd.IsDBNull(sd.GetOrdinal("ALTitle")) ? "" : sd.GetString(sd.GetOrdinal("ALTitle")),
                            ALType = sd.IsDBNull(sd.GetOrdinal("ALType")) ? 0 : sd.GetInt32(sd.GetOrdinal("ALType")),
                            ALFactor = sd.IsDBNull(sd.GetOrdinal("ALFactor")) ? "" : sd.GetString(sd.GetOrdinal("ALFactor")),
                            ALForm = sd.IsDBNull(sd.GetOrdinal("ALForm")) ? "" : sd.GetString(sd.GetOrdinal("ALForm")),
                            Status = sd.IsDBNull(sd.GetOrdinal("Status")) ? 0 : sd.GetInt32(sd.GetOrdinal("Status")),
                            CreateDate = sd.IsDBNull(sd.GetOrdinal("CreateDate")) ? (DateTime)SqlDateTime.Null : sd.GetDateTime(sd.GetOrdinal("CreateDate")),
                            CreateMan = sd.IsDBNull(sd.GetOrdinal("CreateMan")) ? "" : sd.GetString(sd.GetOrdinal("CreateMan"))
                        });
                    }

                    sd.Close();

                    // check showtime
                    string[] stt, sttt;
                    DateTime sdate, edate;
                    foreach (AlertSetting alt in alts)
                    {
                        switch (alt.ALType)
                        {
                            case 1:
                            case 2:
                                sttt = alt.ALFactor.Split(',');
                                foreach (var st1 in sttt)
                                {
                                    stt = st1.Split('-');
                                    sdate = DateTime.Parse($"{DateTime.Now.Year}/{stt[0]}");
                                    edate = DateTime.Parse($"{DateTime.Now.Year}/{stt[1]}");
                                    if (sdate.Date <= DateTime.Now.Date && DateTime.Now.Date <= edate.Date)
                                    {
                                        altsTemp.Add(alt);
                                        break;
                                    }
                                }
                                break;
                            case 3:
                                sttt = alt.ALFactor.Split(',');
                                foreach (var st1 in sttt)
                                {
                                    stt = st1.Split('-');
                                    if (int.Parse(stt[0]) <= DateTime.Now.Day && DateTime.Now.Day <= int.Parse(stt[1]))
                                    {
                                        altsTemp.Add(alt);
                                        break;
                                    }
                                }
                                break;
                            case 4:
                                stt = alt.ALFactor.Split(',');
                                foreach (string st in stt)
                                {
                                    if (int.Parse(st) == (int)DateTime.Now.DayOfWeek)
                                    {
                                        altsTemp.Add(alt);
                                        break;
                                    }
                                }
                                break;
                        }
                    }

                    // check user
                    alts = new List<AlertSetting>();
                    List<ReAdminForm> rafs = AoService.GetReAdminForms();
                    ArrayList rafss = new ArrayList();
                    foreach(var raf in rafs)
                    {
                        if(raf.admin_id.Equals(admin.admin_id))
                        {
                            rafss.Add(raf.QID.ToString());
                        }
                    }
                    foreach (AlertSetting alt in altsTemp)
                    {
                        if (alt.ALForm.Length < 1)
                            continue;

                        sttt = alt.ALForm.Split(',');
                        foreach(var st in sttt)
                        {
                            if(rafss.Contains(st))
                            {
                                alts.Add(alt);
                                break;
                            }
                        }
                    }
                }
            }
            catch (Exception ex)
            {
                logger.ERROR("checkAlerts: " + ex.Message);
                alts = new List<AlertSetting>();
            }
            return alts;
        }
    }
}