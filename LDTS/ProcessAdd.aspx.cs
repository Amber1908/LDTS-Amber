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
    public partial class ProcessEdit : System.Web.UI.Page
    {
        protected void Page_Load(object sender, EventArgs e)
        {
            Session["MsgResult"] = "NoMsg";
            int id = Convert.ToInt32(Request.QueryString["pid"]);
            Process process = new Process();
            process = ProcessService.GetProceById(id);
            if (!Page.IsPostBack)
            {
                if (process != null)
                {
                    proName.Text = process.Pname;
                    desc.Text = process.Description;
                    proIndex.Text = process.Pindex.ToString();
                }
            }

        }
        protected void SaveButton_Click(object sender, EventArgs e)
        {
            Literal AlertMsg = new Literal();
            Admin admin = (Admin)Session["LDTSAdmin"];


            int pid = Convert.ToInt32(Request.QueryString["pid"]);
            Process process = ProcessService.GetAllProcesses().Where(x => x.PID == pid).FirstOrDefault();

            //Insert or Update
            if (process != null)
            {

                Process UpdateProcess = new Process();
                UpdateProcess.old_filename = process.old_filename;
                UpdateProcess.new_filename = process.new_filename;
                UpdateProcess.PID = process.PID;
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
                        string now = DateTime.Now.ToString("yyyyMdHmm");
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
                UpdateProcess.Pname = proName.Text;
                UpdateProcess.Description = desc.Text;
                UpdateProcess.Pindex = Convert.ToInt32(proIndex.Text);
                bool isUpdate = ProcessService.UpdateProcess(UpdateProcess);
                if (!isUpdate)
                {
                    AlertMsg.Text = "<script language='javascript'>alert('編輯失敗!');</script>";
                    this.Page.Controls.Add(AlertMsg);
                    return;
                }
                LDTSservice.InsertRecord(admin, "編輯程序書:" + proName.Text);
                AlertMsg.Text = "<script language='javascript'>alert('編輯成功!');</script>";
                this.Page.Controls.Add(AlertMsg);
            }
            else
            {
                Process InsertProcess = new Process();
                //Insert
                if (!processesUpload.HasFile)
                {
                    AlertMsg.Text = "<script language='javascript'>alert( '尚未選取檔案');</script>";
                    this.Page.Controls.Add(AlertMsg);
                    return;
                }
                string serverPath = Server.MapPath("~/Upload/");
                string fileName = processesUpload.FileName;
                string fileType = System.IO.Path.GetExtension(fileName);
                if (fileType.Contains(".docx") || fileType.Contains(".doc") || fileType.Contains(".pdf"))
                {
                    InsertProcess.old_filename = fileName;
                    string now = DateTime.Now.ToString("yyyyMdHmm");
                    InsertProcess.new_filename = now + "_" + fileName;
                    serverPath = serverPath + InsertProcess.new_filename;
                    processesUpload.SaveAs(serverPath);
                }
                else
                {
                    AlertMsg.Text = "<script language='javascript'>alert( '檔案格式錯誤!請上傳doc檔、docx檔或pdf檔。');</script>";
                    this.Page.Controls.Add(AlertMsg);
                    return;
                }
                InsertProcess.Pname = proName.Text;
                InsertProcess.Description = desc.Text;
                InsertProcess.Pindex = proIndex.Text.Equals(string.Empty) ? 0 : Convert.ToInt32(proIndex.Text);
                InsertProcess.CreateMan = admin.admin_name;
                bool isInsert = ProcessService.InsertProcess(InsertProcess);
                if (!isInsert)
                {
                    AlertMsg.Text = "<script language='javascript'>alert( '新增失敗!');</script>";
                    this.Page.Controls.Add(AlertMsg);
                    return;
                }
                LDTSservice.InsertRecord(admin, "新增程序書:" + proName.Text);
                AlertMsg.Text = "<script language='javascript'>alert('新增成功!');</script>";
                this.Page.Controls.Add(AlertMsg);
                Response.Write("<script type='text/javascript'>alert('新增成功!'); location.href ='Relation';</script>");
                //Response.Redirect("Relation");
            }

        }
    }
}