using LDTS.Models;
using LDTS.Service;
using System;
using System.Collections.Generic;
using System.Linq;
using System.Web;
using System.Web.UI;
using System.Web.UI.WebControls;

namespace LDTS
{
    public partial class StandarWorkbook : System.Web.UI.Page
    {
        protected void Page_Load(object sender, EventArgs e)
        {
            if (!Page.IsPostBack)
            {
                Admin loginAdmin = (Admin)Session["LDTSAdmin"];
                int SID = Convert.ToInt32(Request.QueryString["sid"]);
                string Sname = StandarWorkBookService.GetAllStandarwookbooks().Where(x => x.SID == SID).Select(x => x.Sname).FirstOrDefault();
                SwbName.Text = Sname;
                sName.Text = Sname;
                desc.Text = StandarWorkBookService.GetAllStandarwookbooks().Where(x => x.SID == SID).Select(x => x.Description).FirstOrDefault().ToString();
                sIndex.Text = StandarWorkBookService.GetAllStandarwookbooks().Where(x => x.SID == SID).Select(x => x.Sindex).FirstOrDefault().ToString();
                download.HRef = "Upload/" + StandarWorkBookService.GetAllStandarwookbooks().Where(x => x.SID == SID).Select(x => x.new_filename).FirstOrDefault().ToString();

                List<int> reQids = Service.RelationService.GetAllreSWorkBookForm().Where(x => x.SID == SID).Select(x => x.QID).ToList();
                List<ReportQuestion> reportQuestions = new List<ReportQuestion>();
                List<ReportQuestion> Allreports = ReportQuestiovService.GetAllReportQuestions();
                foreach (var report in Allreports)
                {
                    foreach (var qid in reQids)
                    {
                        if (report.QID == qid)
                        {
                            reportQuestions.Add(report);
                        }
                    }
                }
                string Swbstr = "";
                //畫面:標準作業書 
                foreach (var reportQ in reportQuestions)
                {
                    int Count = ReportAnswerService.GetAnswers().Where(x => x.QID == reportQ.QID).Count();
                    Swbstr += "<div class=\"SwbCard card card-info\">";
                    Swbstr += "<div class=\"prossesCardHeader card-header\">";
                    Swbstr += "<h3 class=\"card-title\">";
                    Swbstr += reportQ.Title;
                    Swbstr += "</h3>";
                    Swbstr += "<div class=\"card-tools\">";
                    Swbstr += "<button type=\"button\" class=\"btn btn-tool\" data-card-widget=\"collapse\">";
                    Swbstr += "<i class=\"fas fa-minus\"></i>";
                    Swbstr += "</div>";//card-tools
                    Swbstr += "<span class=\"float-right badge bg-danger\">";
                    Swbstr += Count;
                    Swbstr += "</span>";
                    Swbstr += "<span class=\"float-right mr-2 badge badge-warning\">";
                    Swbstr += "目前最新版本:" + reportQ.Version;
                    Swbstr += "</span>";

                    Swbstr += "</div>"; //CardHeader
                    Swbstr += "<div class=\"card-body\" style=\"display:block;\">";
                    //找用這個Qid產出的表單有幾個 
                    List<ReportAnswer> answers = ReportAnswerService.GetAnswers().Where(x => x.QID == reportQ.QID).ToList();
                    Swbstr += "<table class=\"table\">";
                    Swbstr += "<thead>";
                    Swbstr += "<tr>";
                    Swbstr += "<th>自定義名稱</th><th>異動時間</th><th>異動人員</th><th>簽核狀態</th><th>版本號</th><th>編輯</th>";
                    Swbstr += "</tr>";
                    Swbstr += "</thead>";
                    Swbstr += "<tbody>";
                    foreach (var ans in answers)
                    {
                        //顯示異動時間跟人員 用ExtendName搜尋
                        Models.AdminWorkRecord admin_Works = LDTSservice.GetAdminWorks().Where(x => x.work_content.Contains(ans.ExtendName)).LastOrDefault();
                        string admin_id = "";
                        DateTime Update = new DateTime();
                        if (admin_Works != null)
                        {
                            admin_id = admin_Works.admin_id;
                            Update = admin_Works.createtime;
                        }
                        Swbstr += "<tr>";
                        Swbstr += "<td>";
                        Swbstr += ans.ExtendName;
                        Swbstr += "</td>";
                        Swbstr += "<td>";
                        Swbstr += Update;
                        Swbstr += "</td>";
                        Swbstr += "<td>";
                        Swbstr += admin_id;
                        Swbstr += "</td>";
                        Swbstr += "<td>";
                        Swbstr += ans.Status == 1 ? "未簽核" : "已簽核";
                        Swbstr += "</td>";
                        Swbstr += "<td>";
                        Swbstr += ans.Version;
                        Swbstr += "</td>";
                        Swbstr += "<td>";
                        Swbstr += "<a href=\"" + "ReportQuestionEdit.aspx?aid=" + ans.AID + "\">";
                        Swbstr += "<i class=\" fas fa-edit\"></i>";
                        Swbstr += "</a>";
                        Swbstr += "</td>";
                        Swbstr += "</tr>";
                    }
                    Swbstr += "<tbody>";
                    Swbstr += "</table>";
                    Swbstr += "<div class=\"d-flex justify-content-center\">";
                    Swbstr += "<div class=\"btn mb-3\">";
                    Swbstr += "<a href=\"";
                    Swbstr += "ReportQuestionEdit.aspx?sqid=";
                    Swbstr += reportQ.QID;
                    Swbstr += "\" atl=\"新增\" <i class=\"fas fa-plus-circle\"></i>";
                    Swbstr += "</a>";
                    Swbstr += "</div>";
                    Swbstr += "</div>";
                    Swbstr += "</div>";//card-body
                    Swbstr += "</div>";//Card 
                }
                SwbContainer.InnerHtml = Swbstr;

            }
        }

        protected void SaveButton_Click(object sender, EventArgs e)
        {
            //修改
            string id = Request.QueryString["sid"];
            StandardWorkBook workBook = StandarWorkBookService.GetAllStandarwookbooks().Where(x => x.SID == Convert.ToInt32(id)).FirstOrDefault();
            workBook.Sname = sName.Text;
            workBook.Sindex =Convert.ToInt32( sIndex.Text);
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

            StandardWorkBook standardWorkBook = StandarWorkBookService.GetAllStandarwookbooks().Where(x => x.SID == id).FirstOrDefault();

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
                    AlertMsg.Text = "<script language='javascript'>alert('更換標準作業書檔案失敗!');</script>";
                    this.Page.Controls.Add(AlertMsg);
                    return;
                }
                LDTSservice.InsertRecord(admin, "更換標準作業書檔案:" + sName.Text);
                AlertMsg.Text = "<script language='javascript'>alert('更換標準作業書檔案成功!');</script>";
                this.Page.Controls.Add(AlertMsg);
            }

        }
    }
}