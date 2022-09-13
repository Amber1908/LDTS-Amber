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
                title.InnerText = Sname;
                //跟標準書有關的表單
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
                    Swbstr += "<span class=\"float-right ml-1 mr-1 badge badge-warning\">";
                    Swbstr += "目前最新版本:" + reportQ.Version;
                    Swbstr += "</span>";
                    Swbstr += "<span class=\"float-right badge bg-danger\">";
                    Swbstr += Count;
                    Swbstr += "</span>";

                    Swbstr += "</div>"; //CardHeader
                    Swbstr += "<div class=\"card-body\" style=\"display:block;\">";
                    //找用這個Qid產出的表單有幾個 

                    //有權限的表單
                    List<ReAdminForm> reAdminForms = Service.RelationService.GetAllreAdminFormByAdminId(loginAdmin.admin_id);
                    List<ReportAnswer> answers = ReportAnswerService.GetAnswers().Where(x => x.QID == reportQ.QID).ToList();

                    List<ReportAnswer> allans = ReportAnswerService.GetAnswers();
                    List<ReportAnswer> reAdminAns = new List<ReportAnswer>();
                    foreach (var item in allans)
                    {
                        for (int i = 0; i < reAdminForms.Count; i++)
                        {
                            if (reAdminForms[i].QID == item.QID)
                            {
                                reAdminAns.Add(item);
                            }
                        }
                    }
                    reAdminAns = reAdminAns.Distinct().ToList();
                    //畫面:程序書 下面有哪些ReportQuestion 全部有關的表單 
                    bool hasAdd = false;

                    Swbstr += "<table class=\"table\">";
                    Swbstr += "<thead>";
                    Swbstr += "<tr>";
                    Swbstr += "<th>自定義名稱</th><th>異動時間</th><th>異動人員</th><th>簽核狀態</th><th>版本號</th><th>編輯</th>";
                    Swbstr += "</tr>";
                    Swbstr += "</thead>";
                    Swbstr += "<tbody>";
                    foreach (var ans in answers)
                    {
                        Swbstr += "<tr>";
                        Swbstr += "<td>";
                        Swbstr += ans.ExtendName;
                        Swbstr += "</td>";
                        Swbstr += "<td>";
                        Swbstr += ans.LastupDate;
                        Swbstr += "</td>";
                        Swbstr += "<td>";
                        Swbstr += ans.LastupMan;
                        Swbstr += "</td>";
                        Swbstr += "<td>";
                        Swbstr += ReportAnswerService.MatchStatus(ans.Status);
                        Swbstr += "</td>";
                        Swbstr += "<td>";
                        Swbstr += ans.Version;
                        Swbstr += "</td>";
                        Swbstr += "<td>";
                        Swbstr += "<a href=\"" + "ReportQuestionEdit.aspx?aid=" + ans.AID + "\">";
                        Swbstr += reAdminAns.Any(x=>x.AID==ans.AID)?"<i class=\" fas fa-edit\"></i>": "<i class=\"fas fa-eye\"></i>";
                        hasAdd = reAdminAns.Any(x => x.AID == ans.AID);
                        Swbstr += "</a>";
                        Swbstr += "</td>";
                        Swbstr += "</tr>";
                    }
                    Swbstr += "<tbody>";
                    Swbstr += "</table>";
                    if (reAdminAns.Count == 0)
                    {
                        hasAdd = reAdminForms.Any(x => x.QID == reportQ.QID);
                    }
                    if (reportQ.Status == 2)
                    {
                        hasAdd = false;
                    }
                    if (hasAdd)
                    {
                        Swbstr += "<div class=\"d-flex justify-content-center\">";
                        Swbstr += "<div class=\"btn mb-3\">";
                        Swbstr += "<a href=\"";
                        Swbstr += "ReportQuestionEdit.aspx?sqid=";
                        Swbstr += reportQ.QID;
                        Swbstr += "\" atl=\"新增\" <i class=\"fas fa-plus-circle\"></i>";
                        Swbstr += "</a>";
                        Swbstr += "</div>";
                        Swbstr += "</div>";
                    }
                    Swbstr += "</div>";//card-body
                    Swbstr += "</div>";//Card 
                }
                SwbContainer.InnerHtml = Swbstr;

            }
        }

    }
}