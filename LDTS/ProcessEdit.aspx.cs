using System;
using System.Collections.Generic;
using System.Linq;
using System.Web;
using System.Web.UI;
using System.Web.UI.WebControls;
using LDTS.Models;
using LDTS.Service;
using LDTS.Utils;

namespace LDTS
{
    public partial class ProcessEdit1 : System.Web.UI.Page
    {
        protected void Page_Load(object sender, EventArgs e)
        {
            if (!Page.IsPostBack)
            {
                Admin loginAdmin = (Admin)Session["LDTSAdmin"];
                int PID = Convert.ToInt32(Request.QueryString["pid"]);
                string Pname = ProcessService.GetProceById(PID).Pname;
                title.InnerText = Pname;
                download.HRef = "Upload/" + ProcessService.GetProceById(PID).new_filename;
                ProcessName.Text = Pname;
                proName.Text = Pname;
                desc.Text = ProcessService.GetProceById(PID).Description;
                proIndex.Text = ProcessService.GetProceById(PID).Pindex.ToString();

            }
        }

        protected void DeletePro_Click(object sender, EventArgs e)
        {

        }

        protected void SaveButton_Click(object sender, EventArgs e)
        {

        }
    }
}