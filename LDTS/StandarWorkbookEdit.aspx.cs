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
    public partial class StandarWorkbookEdit : System.Web.UI.Page
    {
        protected void Page_Load(object sender, EventArgs e)
        {
            if (!Page.IsPostBack)
            {
                Admin loginAdmin = (Admin)Session["LDTSAdmin"];
                int SID = Convert.ToInt32(Request.QueryString["sid"]);
                if (SID == 0)
                {
                    Response.Redirect("StandarWorkbookAdd.aspx");
                }
                StandardWorkBook standard = StandarWorkBookService.GetStandardWorkBookById(SID);
                string Sname = standard.Sname;
                title.InnerText = Sname;
                SwbName.Text = Sname;
                sName.Text = Sname;
                desc.Text = standard.Description;
                sIndex.Text = standard.Sindex.ToString();
                download.HRef = "Upload/" + standard.new_filename.ToString();
            }
        }

        protected void SaveButton_Click(object sender, EventArgs e)
        {
            //修改
        }
    }
}