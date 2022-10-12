using System;
using System.Collections.Generic;
using System.Data.SqlClient;
using System.Linq;
using System.Web;
using System.Web.Configuration;
using System.Web.UI;
using System.Web.UI.WebControls;
using LDTS.Models;
using LDTS.Service;

namespace LDTS
{
    public partial class ShowAdminImg : System.Web.UI.Page
    {
        protected void Page_Load(object sender, EventArgs e)
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
                    sqlCommand.Parameters["@image_id"].Value = Request.QueryString["id"];
                    SqlDataReader sqlDataReader = sqlCommand.ExecuteReader();
                    while (sqlDataReader.Read())
                    {
                        img.image_bytes = (byte[])sqlDataReader["image_bytes"];
                        img.image_id = Convert.ToInt32(sqlDataReader["image_id"]);
                        img.memo = sqlDataReader["image_id"].ToString();
                    }
                }
            }
            catch (Exception ex)
            {
                string err = ex.ToString();
                img = null;
            }
            if (img.image_bytes == null) return;
            Response.ContentType = img.image_bytes.ToString(); 
            Response.BinaryWrite(img.image_bytes);
        }
    }
}