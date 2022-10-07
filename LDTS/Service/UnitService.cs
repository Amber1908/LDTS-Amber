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
    public class UnitService
    {
        static readonly Logger logger = new Logger("UnitService");

        public static UnitBasedata GetUnit()
        {
            UnitBasedata unitBasedata = new UnitBasedata();
            try
            {
                using (SqlConnection sqc = new SqlConnection(WebConfigurationManager.ConnectionStrings["LDTSConnectionString"].ToString()))
                {
                    SqlCommand sqlCommand = new SqlCommand("", sqc);
                    sqc.Open();
                    sqlCommand.CommandText = @"Select * from UnitBasedata";
                    SqlDataReader sqlDataReader = sqlCommand.ExecuteReader();
                    if (sqlDataReader.Read())
                    {
                        unitBasedata.UnitName = sqlDataReader.IsDBNull(sqlDataReader.GetOrdinal("UnitName")) ? " " : sqlDataReader.GetString(sqlDataReader.GetOrdinal("UnitName"));
                        unitBasedata.UnitDesc = sqlDataReader.IsDBNull(sqlDataReader.GetOrdinal("UnitDesc")) ? " " : sqlDataReader.GetString(sqlDataReader.GetOrdinal("UnitDesc"));
                        unitBasedata.UnitID = sqlDataReader.IsDBNull(sqlDataReader.GetOrdinal("UnitID")) ? "" : sqlDataReader.GetString(sqlDataReader.GetOrdinal("UnitID"));
                        unitBasedata.UnitPhone = sqlDataReader.IsDBNull(sqlDataReader.GetOrdinal("UnitPhone"))?" ":sqlDataReader.GetString(sqlDataReader.GetOrdinal("UnitPhone"));
                        unitBasedata.UnitAddr = sqlDataReader.IsDBNull(sqlDataReader.GetOrdinal("UnitAddr")) ? " " : sqlDataReader.GetString(sqlDataReader.GetOrdinal("UnitAddr"));
                        unitBasedata.UnitEmail = sqlDataReader.IsDBNull(sqlDataReader.GetOrdinal("UnitEmail")) ? " " : sqlDataReader.GetString(sqlDataReader.GetOrdinal("UnitEmail"));
                        unitBasedata.UnitContact = sqlDataReader.IsDBNull(sqlDataReader.GetOrdinal("UnitContact")) ? "" : sqlDataReader.GetString(sqlDataReader.GetOrdinal("UnitContact"));
                        unitBasedata.UnitBoss = sqlDataReader.IsDBNull(sqlDataReader.GetOrdinal("UnitBoss")) ? " " : sqlDataReader.GetString(sqlDataReader.GetOrdinal("UnitBoss"));
                        unitBasedata.UnitBossPhone = sqlDataReader.IsDBNull(sqlDataReader.GetOrdinal("UnitBossPhone")) ? "" : sqlDataReader.GetString(sqlDataReader.GetOrdinal("UnitBossPhone"));
                        unitBasedata.UnitContactPhone = sqlDataReader.IsDBNull(sqlDataReader.GetOrdinal("UnitContactPhone")) ? " " : sqlDataReader.GetString(sqlDataReader.GetOrdinal("UnitContactPhone"));
                        unitBasedata.UnitContactEmail = sqlDataReader.IsDBNull(sqlDataReader.GetOrdinal("UnitContactEmail")) ? " " : sqlDataReader.GetString(sqlDataReader.GetOrdinal("UnitContactEmail"));
                        unitBasedata.UnitBossEmail = sqlDataReader.IsDBNull(sqlDataReader.GetOrdinal("UnitBossEmail")) ? "" : sqlDataReader.GetString(sqlDataReader.GetOrdinal("UnitBossEmail"));
                        unitBasedata.UnitIcon = sqlDataReader.IsDBNull(sqlDataReader.GetOrdinal("UnitIcon")) ? 0 : sqlDataReader.GetInt32(sqlDataReader.GetOrdinal("UnitIcon"));
                        unitBasedata.UnitWatermark = sqlDataReader.IsDBNull(sqlDataReader.GetOrdinal("UnitWatermark")) ? 0 : sqlDataReader.GetInt32(sqlDataReader.GetOrdinal("UnitWatermark"));
                    }
                    sqc.Close();

                }
            }
            catch (Exception e)
            {
                logger.FATAL(e.Message);
                return unitBasedata;
            }
            return unitBasedata;
        }
        public static bool InsertUnit(UnitBasedata unit)
        {
            bool result = false;
            try
            {
                using (SqlConnection sqc = new SqlConnection(WebConfigurationManager.ConnectionStrings["LDTSConnectionString"].ToString()))
                {
                    SqlCommand sqlCommand = new SqlCommand("", sqc);
                    sqc.Open();
                    sqlCommand.CommandText = @"INSERT INTO UnitBasedata(UnitName,UnitDesc,UnitID,UnitPhone,UnitAddr,UnitEmail,UnitContact,UnitContactPhone,UnitContactEmail,UnitBoss,UnitBossPhone,UnitBossEmail,UnitIcon,UnitWatermark) VALUES(@UnitName,@UnitDesc,@UnitID,@UnitPhone,@UnitAddr,@UnitEmail,@UnitContact,@UnitContactPhone,@UnitContactEmail,@UnitBoss,@UnitBossPhone,@UnitBossEmail,@UnitIcon,@UnitWatermark)";
                    sqlCommand.Parameters.AddWithValue("@UnitID", unit.UnitID);
                    sqlCommand.Parameters.AddWithValue("@UnitName", unit.UnitName);
                    sqlCommand.Parameters.AddWithValue("@UnitDesc", unit.UnitDesc);
                    sqlCommand.Parameters.AddWithValue("@UnitPhone", unit.UnitPhone);
                    sqlCommand.Parameters.AddWithValue("@UnitAddr", unit.UnitAddr);
                    sqlCommand.Parameters.AddWithValue("@UnitEmail", unit.UnitEmail);
                    sqlCommand.Parameters.AddWithValue("@UnitContact", unit.UnitContact);
                    sqlCommand.Parameters.AddWithValue("@UnitContactPhone", unit.UnitContactPhone);
                    sqlCommand.Parameters.AddWithValue("@UnitContactEmail", unit.UnitContactEmail);
                    sqlCommand.Parameters.AddWithValue("@UnitBoss", unit.UnitBoss);
                    sqlCommand.Parameters.AddWithValue("@UnitBossPhone", unit.UnitBossPhone);
                    sqlCommand.Parameters.AddWithValue("@UnitBossEmail", unit.UnitBossEmail);
                    sqlCommand.Parameters.AddWithValue("@UnitIcon", unit.UnitIcon);
                    sqlCommand.Parameters.AddWithValue("@UnitWatermark", unit.UnitWatermark);
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
        public static bool UpdateUnit(UnitBasedata unitBasedata)
        {
            bool result = false;
            try
            {
                using (SqlConnection sqc = new SqlConnection(WebConfigurationManager.ConnectionStrings["LDTSConnectionString"].ToString()))
                {
                    SqlCommand sqlCommand = new SqlCommand("", sqc);
                    sqc.Open();
                    sqlCommand.CommandText = @"UPDATE TOP(1) UnitBasedata SET UnitName=@UnitName,UnitDesc=@UnitDesc,UnitID=@UnitID,UnitPhone=@UnitPhone,UnitAddr=@UnitAddr,UnitEmail=@UnitEmail,UnitContact=@UnitContact,UnitContactPhone=@UnitContactPhone,UnitContactEmail=@UnitContactEmail,UnitBoss=@UnitBoss,UnitBossPhone=@UnitBossPhone,UnitBossEmail=@UnitBossEmail,UnitIcon=@UnitIcon,UnitWatermark=@UnitWatermark ";
                    sqlCommand.Parameters.AddWithValue("@UnitName", unitBasedata.UnitName);
                    sqlCommand.Parameters.AddWithValue("@UnitDesc", unitBasedata.UnitDesc);
                    sqlCommand.Parameters.AddWithValue("@UnitID", unitBasedata.UnitID);
                    sqlCommand.Parameters.AddWithValue("@UnitPhone", unitBasedata.UnitPhone);
                    sqlCommand.Parameters.AddWithValue("@UnitAddr", unitBasedata.UnitAddr);
                    sqlCommand.Parameters.AddWithValue("@UnitEmail", unitBasedata.UnitEmail);
                    sqlCommand.Parameters.AddWithValue("@UnitContact", unitBasedata.UnitContact);
                    sqlCommand.Parameters.AddWithValue("@UnitContactPhone", unitBasedata.UnitContactPhone);
                    sqlCommand.Parameters.AddWithValue("@UnitContactEmail", unitBasedata.UnitContactEmail);
                    sqlCommand.Parameters.AddWithValue("@UnitBoss", unitBasedata.UnitBoss);
                    sqlCommand.Parameters.AddWithValue("@UnitBossPhone", unitBasedata.UnitBossPhone);
                    sqlCommand.Parameters.AddWithValue("@UnitBossEmail", unitBasedata.UnitBossEmail);
                    sqlCommand.Parameters.AddWithValue("@UnitIcon", unitBasedata.UnitIcon);
                    sqlCommand.Parameters.AddWithValue("@UnitWatermark", unitBasedata.UnitWatermark);
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
    }
}