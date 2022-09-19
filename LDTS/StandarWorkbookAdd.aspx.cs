using System;
using System.Collections.Generic;
using System.Linq;
using System.Web;
using System.Web.UI;
using System.Web.UI.WebControls;
using LDTS.Models;
using LDTS.Service;

namespace LDTS
{
    public partial class StandarWorkbookAdd : System.Web.UI.Page
    {
        protected void Page_Load(object sender, EventArgs e)
        {
            Session["MsgResult"] = "NoMsg";

            int id = Convert.ToInt32(Request.QueryString["sid"]);
            StandardWorkBook standardWorkBook = StandarWorkBookService.GetAllStandarwookbooks().Where(x => x.SID == id).FirstOrDefault();
            if (!Page.IsPostBack)
            {
                if (standardWorkBook != null)
                {
                    sName.Text = standardWorkBook.Sname;
                    sIndex.Text = standardWorkBook.Sindex.ToString();
                    desc.Text = standardWorkBook.Description;
                }
            }

        }

        protected void SaveButton_Click(object sender, EventArgs e)
        {
            Literal AlertMsg = new Literal();
            Admin admin = (Admin)Session["LDTSAdmin"];
            int id = Convert.ToInt32(Request.QueryString["sid"]);

            StandardWorkBook standardWorkBook = StandarWorkBookService.GetAllStandarwookbooks().Where(x => x.SID == id).FirstOrDefault();
            //Insert or Update
            if (standardWorkBook != null)
            {
                StandardWorkBook UpdatestandardWBk = new StandardWorkBook();
                UpdatestandardWBk.old_filename = standardWorkBook.old_filename;
                UpdatestandardWBk.new_filename = standardWorkBook.new_filename;
                if (swbUpload.HasFile)
                {
                    string serverPath = Server.MapPath("~/Upload/");
                    string fileName = swbUpload.FileName;
                    string fileType = System.IO.Path.GetExtension(fileName);
                    if (fileType.Contains(".docx") || fileType.Contains(".doc") || fileType.Contains(".pdf"))
                    {
                        UpdatestandardWBk.old_filename = fileName;
                        string now = DateTime.Now.ToString("yyyyMdHmm");
                        UpdatestandardWBk.new_filename = now + "_" + fileName;
                        serverPath = serverPath + UpdatestandardWBk.new_filename;
                        swbUpload.SaveAs(serverPath);
                    }
                    else
                    {
                        AlertMsg.Text = "<script language='javascript'>alert( '檔案格式錯誤!請上傳doc檔、docx檔或pdf檔。');</script>";
                        this.Page.Controls.Add(AlertMsg);
                        return;
                    }
                }
                //基本資料
                UpdatestandardWBk.SID = standardWorkBook.SID;
                UpdatestandardWBk.Sname = sName.Text;
                UpdatestandardWBk.Sindex = Convert.ToInt32(sIndex.Text);
                UpdatestandardWBk.Description = desc.ToString();
                bool isUpdate = StandarWorkBookService.UpdateStandarwookbook(UpdatestandardWBk);
                if (!isUpdate)
                {
                    AlertMsg.Text = "<script language='javascript'>alert('編輯失敗!');</script>";
                    this.Page.Controls.Add(AlertMsg);
                    return;
                }
                LDTSservice.InsertRecord(admin, "編輯標準作業書:" + sName.Text);
                AlertMsg.Text = "<script language='javascript'>alert('編輯成功!');</script>";
                this.Page.Controls.Add(AlertMsg);
            }
            else
            {
                if (!swbUpload.HasFile)
                {
                    AlertMsg.Text = "<script language='javascript'>alert( '尚未選取檔案');</script>";
                    this.Page.Controls.Add(AlertMsg);
                    return;
                }

                StandardWorkBook InsertSWB = new StandardWorkBook();
                string serverPath = Server.MapPath("~/Upload/");
                string fileName = swbUpload.FileName;
                string fileType = System.IO.Path.GetExtension(fileName);
                if (fileType.Contains(".docx") || fileType.Contains(".doc") || fileType.Contains(".pdf"))
                {
                    InsertSWB.old_filename = fileName;
                    string now = DateTime.Now.ToString("yyyyMdHmm");
                    InsertSWB.new_filename = now + "_" + fileName;
                    serverPath = serverPath + InsertSWB.new_filename;
                    swbUpload.SaveAs(serverPath);
                }
                else
                {
                    AlertMsg.Text = "<script language='javascript'>alert( '檔案格式錯誤!請上傳doc檔、docx檔或pdf檔。');</script>";
                    this.Page.Controls.Add(AlertMsg);
                    return;
                }
                InsertSWB.Sname = sName.Text;
                InsertSWB.Description = desc.Text;
                InsertSWB.Sindex = sIndex.Text.Equals(string.Empty) ? 0 : Convert.ToInt32(sIndex.Text);
                InsertSWB.CreateMan = admin.admin_name;
                bool isInsert = StandarWorkBookService.InsterStandarwookbook(InsertSWB);
                if (!isInsert)
                {
                    AlertMsg.Text = "<script language='javascript'>alert( '新增失敗!');</script>";
                    this.Page.Controls.Add(AlertMsg);
                    return;

                }
                LDTSservice.InsertRecord(admin, "新增標準作業書:" + sName.Text);
                Response.Write("<script type='text/javascript'>alert('新增成功!'); location.href ='Relation';</script>");
            }
        }
    }
}