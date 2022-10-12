using System;
using System.Collections.Generic;
using System.Configuration;
using System.Data.SqlClient;
using System.Linq;
using System.Web;
using System.Web.UI;
using System.Web.UI.WebControls;

namespace LDTS
{
    public partial class showimage : System.Web.UI.Page
    {
        protected void Page_Load(object sender, EventArgs e)
        {
            if (!IsPostBack)
            {
                string SN = Request.QueryString["SN"];
                Response.Clear();

                using (SqlConnection sqc = new SqlConnection(ConfigurationManager.ConnectionStrings["LDTSConnectionString"].ToString()))
                {
                    SqlCommand sqmm = new SqlCommand("SELECT * FROM Images WHERE image_id=@image_id", sqc);
                    sqc.Open();

                    sqmm.Parameters.AddWithValue("@image_id", SN);

                    SqlDataReader sd = sqmm.ExecuteReader();

                    if (sd.Read())
                    {
                        Response.ContentType = "image/jpeg";
                        Response.BinaryWrite((byte[])sd["image_bytes"]);
                        Response.Flush();
                    }
                    else
                    {
                        Response.ContentType = "image/jpeg";
                        string loc = Server.MapPath("Admin/images/noimage.png");
                        Response.WriteFile(loc);
                        Response.Flush();
                    }
                    sd.Close();
                }
            }
        }
    }
}