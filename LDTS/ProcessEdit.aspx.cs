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
            //刪除
            int id =Convert.ToInt32( Request.QueryString["pid"]);
            Process process = ProcessService.GetProceById(Convert.ToInt32(id));

            if (ProcessService.DeleteProcessById(id))
            {
                Admin loginAdmin = (Admin)Session["LDTSAdmin"];
                string work = "刪除程序書:" + process.Pname;
                LDTSservice.InsertRecord(loginAdmin, work);
            }
            else
            {
                Literal AlertMsg = new Literal();
                AlertMsg.Text = "<script language='javascript'>alert('刪除失敗!');</script>";
                this.Page.Controls.Add(AlertMsg);
            }
        }

        protected void SaveButton_Click(object sender, EventArgs e)
        {
            //修改
            string id = Request.QueryString["pid"];
            Process process = ProcessService.GetProceById(Convert.ToInt32(id));
            process.Pname = proName.Text;
            process.Pindex = Convert.ToInt32(proIndex.Text);
            process.Description = desc.Text;
            if (ProcessService.UpdateProcess(process))
            {
                Admin loginAdmin = (Admin)Session["LDTSAdmin"];
                string work = "編輯程序書:" + process.Pname;
                LDTSservice.InsertRecord(loginAdmin, work);

                Literal AlertMsg = new Literal();
                AlertMsg.Text = "<script language='javascript'>alert('編輯成功!');</script>";
                this.Page.Controls.Add(AlertMsg);
            }
            else
            {
                Literal AlertMsg = new Literal();
                AlertMsg.Text = "<script language='javascript'>alert('編輯失敗!');</script>";
                this.Page.Controls.Add(AlertMsg);
            }

        }
    }
}