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
            Admin loginAdmin = (Admin)Session["LDTSAdmin"];
            int SID = Convert.ToInt32(Request.QueryString["sid"]);
            string Sname = StandarWorkBookService.GetAllStandarwookbooks().Where(x => x.SID == SID).Select(x => x.Sname).FirstOrDefault();
            SwbName.Text = Sname;
            List<int> reQids = RelationService.GetAllreSWorkBookForm().Where(x => x.SID == SID).Select(x => x.QID).ToList();
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
                Swbstr += "<div class=\"SwbCard card card-success\">";
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
                Swbstr+= "<div class=\"card-body\" style=\"display:block;\">";
                //找用這個Qid產出的表單有幾個 
                List<ReportAnswer> answers = ReportAnswerService.GetAnswers().Where(x => x.QID == reportQ.QID).ToList();
                Swbstr += "<div class=\"p-0\">";
                Swbstr+= "<ul class=\"nav flex-column\">";
                foreach ( var ans in answers)
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
                    string status = ans.Status == 1 ? "未簽核" : "已簽核";
                    string ver = ans.Version;

                    Swbstr += "<li class=\"nav-item\">";
                    Swbstr += "<a class=\"nav-link\" href=\"" + "ReportQuestionEdit.aspx?said=" + ans.AID + "\">";
                    Swbstr += ans.ExtendName;
                    Swbstr += "<i class=\"ml-2 mr-2 fas fa-edit\"></i>";//<i class="fas fa-calendar-edit"></i>
                    Swbstr += Update;
                    Swbstr += "<i class=\"ml-2 mr-2 fas fa-user-edit\"></i>";
                    Swbstr += admin_id;
                    Swbstr += "<i class=\"ml-2 mr-2 fas fa-pen-alt\"></i>";
                    Swbstr += status;
                    Swbstr += "<i class=\"ml-2 mr-2 fas fa-bookmark\"></i>";
                    Swbstr += "V" + ver;
                    Swbstr += "</a>";
                    Swbstr += "<span class=\"float-right badge bg-success\"></span>";
                    Swbstr += "</li>";
                }
                Swbstr += "</ul>";
                Swbstr += "</div>";//card-footer
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
}