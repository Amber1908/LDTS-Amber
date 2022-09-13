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
                if (PID==0)
                {
                    Response.Redirect("ProcessAdd.aspx");
                }
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
                Response.Redirect("Relation.aspx");
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

        protected void uploadfile_Click(object sender, EventArgs e)
        {
            Literal AlertMsg = new Literal();
            Admin admin = (Admin)Session["LDTSAdmin"];


            int pid = Convert.ToInt32(Request.QueryString["pid"]);
            Process process = ProcessService.GetProceById(Convert.ToInt32(pid));

            // Update 檔案而已
            if (process != null)
            {
                Process UpdateProcess = new Process();
                UpdateProcess.old_filename = process.old_filename;
                UpdateProcess.new_filename = process.new_filename;
                UpdateProcess.PID = process.PID;
                UpdateProcess.CreateDate = process.CreateDate;
                UpdateProcess.CreateMan = process.CreateMan;
                UpdateProcess.Description = process.Description;
                UpdateProcess.Pindex = process.Pindex;
                UpdateProcess.Pname = process.Pname;
                //Update
                //抓檔案
                //檔案格式
                if (processesUpload.HasFile)
                {
                    string serverPath = Server.MapPath("~/Upload/");
                    string fileName = processesUpload.FileName;
                    string fileType = System.IO.Path.GetExtension(fileName);
                    if (fileType.Contains(".docx") || fileType.Contains(".doc") || fileType.Contains(".pdf"))
                    {
                        UpdateProcess.old_filename = fileName;
                        string now = DateTime.Now.ToString("yyyyMMddHHmmssfff");
                        UpdateProcess.new_filename = now + "_" + fileName;
                        serverPath = serverPath + UpdateProcess.new_filename;
                        processesUpload.SaveAs(serverPath);
                    }
                    else
                    {
                        AlertMsg.Text = "<script language='javascript'>alert( '檔案格式錯誤!請上傳doc檔、docx檔或pdf檔。');</script>";
                        this.Page.Controls.Add(AlertMsg);
                        return;
                    }
                }

                //程序書基本資料

                bool isUpdate = ProcessService.UpdateProcess(UpdateProcess);
                if (!isUpdate)
                {
                    AlertMsg.Text = "<script language='javascript'>alert('更換程序書檔案失敗!');</script>";
                    this.Page.Controls.Add(AlertMsg);
                    return;
                }
                download.HRef = "Upload/" + ProcessService.GetProceById(pid).new_filename;
                LDTSservice.InsertRecord(admin, "更換程序書檔案:" + proName.Text);
                AlertMsg.Text = "<script language='javascript'>alert('更換程序書檔案成功!');</script>";
                this.Page.Controls.Add(AlertMsg);
            }

        }
    }
}