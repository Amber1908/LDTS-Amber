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
            int id =Convert.ToInt32( Request.QueryString["sid"]);
            StandardWorkBook workBook = StandarWorkBookService.GetStandardWorkBookById(id);
            workBook.Sname = sName.Text;
            workBook.Sindex = Convert.ToInt32(sIndex.Text);
            workBook.Description = desc.Text;
            if (StandarWorkBookService.UpdateStandarwookbook(workBook))
            {
                Admin loginAdmin = (Admin)Session["LDTSAdmin"];
                string work = "編輯標準作業書:" + workBook.Sname;
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
            int id = Convert.ToInt32(Request.QueryString["sid"]);

            StandardWorkBook standardWorkBook = StandarWorkBookService.GetStandardWorkBookById(id);

            //Update
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
                        string now = DateTime.Now.ToString("yyyyMMddHHmmssfff");
                        UpdatestandardWBk.new_filename = now + "_" + fileName;
                        if (UpdatestandardWBk.new_filename.Length>50)
                        {
                            AlertMsg.Text = "<script language='javascript'>alert('檔案名稱字數過長請少於28字(含空白)。');</script>";
                            this.Page.Controls.Add(AlertMsg);
                            return;
                        }
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
                    AlertMsg.Text = "<script language='javascript'>alert('更換標準作業書檔案失敗!');</script>";
                    this.Page.Controls.Add(AlertMsg);
                    return;
                }
                download.HRef = "Upload/" + UpdatestandardWBk.new_filename.ToString();
                LDTSservice.InsertRecord(admin, "更換標準作業書檔案:" + sName.Text);
                AlertMsg.Text = "<script language='javascript'>alert('更換標準作業書檔案成功!');</script>";
                this.Page.Controls.Add(AlertMsg);
            }

        }

        protected void DeleteSwb_Click(object sender, EventArgs e)
        {

        }
    }
}