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
    public partial class Processes : System.Web.UI.Page
    {
        protected void Page_Load(object sender, EventArgs e)
        {
            Admin loginAdmin = (Admin)Session["LDTSAdmin"];
            int PID = Convert.ToInt32(Request.QueryString["pid"]);
            string Pname = ProcessService.GetProceById(PID).Pname;
            ProcessName.Text = Pname;
            string ProcessContainerStr = "";
            //跟PID有關的表單qid
            List<int> reProcessQids = RelationService.GetAllReProcesssQuestion().Where(x => x.PID == PID).Select(x => x.QID).ToList();
            List<ReportQuestion> reportQuestions = new List<ReportQuestion>();
            List<ReportQuestion> Allreports = ReportQuestiovService.GetAllReportQuestions();
            foreach (var report in Allreports)
            {
                foreach (var qid in reProcessQids)
                {
                    if (report.QID == qid)
                    {
                        reportQuestions.Add(report);
                    }
                }
            }
            //畫面:程序書 下面有哪些ReportQuestion 全部有關的表單 
            foreach (var reportQuestion in reportQuestions)
            {
                int Conts = ReportAnswerService.GetAnswers().Where(x => x.QID == reportQuestion.QID).Count();
                ProcessContainerStr += "<div class=\"prossesCard card card-primary\"> ";
                ProcessContainerStr += "<div class=\"prossesCardHeader card-header\">";
                ProcessContainerStr += "<h3 class=\"card-title\">";
                ProcessContainerStr += reportQuestion.Title;
                ProcessContainerStr += "</h3>";
                ProcessContainerStr += "<div class=\"card-tools\">";
                ProcessContainerStr += "<button type=\"button\" class=\"btn btn-tool\" data-card-widget=\"collapse\">";
                ProcessContainerStr += "<i class=\"fas fa-minus\"></i>";
                ProcessContainerStr += "</div>";//card-tools
                ProcessContainerStr += "<span class=\"float-right badge bg-danger\">";
                ProcessContainerStr += Conts;
                ProcessContainerStr += "</span>";

                ProcessContainerStr += "</div>";//prossesCardHeader 
                ProcessContainerStr += "<div class=\"card-body\" style=\"display:block;\">";
                //找用這個Qid產出的表單有幾個 
                List<ReportAnswer> answers = ReportAnswerService.GetAnswers().Where(x => x.QID == reportQuestion.QID).ToList();
                ProcessContainerStr += "<div class=\"card-footer p-0\">";//找用這個Qid產出的表單有幾個 
                ProcessContainerStr += "<ul class=\"nav flex-column\">";
                foreach (var ans in answers)
                {
                    ProcessContainerStr += "<li class=\"nav-item\">";
                    ProcessContainerStr += "<a class=\"nav-link\" href=\"" + "ReportQuestionEdit.aspx?aid=" + ans.AID+"\">";
                    ProcessContainerStr += ans.ExtendName;
                    ProcessContainerStr += "</a>";
                    ProcessContainerStr += "<span class=\"float-right badge bg-primary\"></span>";
                    ProcessContainerStr += "</li>";
                }
                ProcessContainerStr += "</ul>";
                ProcessContainerStr += "</div>";//card-footer
                ProcessContainerStr += "<div class=\"d-flex justify-content-center\">";
                ProcessContainerStr += "<div class=\"btn mb-3\">";
                ProcessContainerStr += "<a href=\"";
                ProcessContainerStr += "ReportQuestionEdit.aspx?qid=";
                ProcessContainerStr += reportQuestion.QID;
                ProcessContainerStr += "\" atl=\"新增\" <i class=\"fas fa-plus\"></i>";
                ProcessContainerStr += "</a>";
                ProcessContainerStr += "</div>";
                ProcessContainerStr += "</div>";
                ProcessContainerStr += "</div>";//card-body
                ProcessContainerStr += "</div>";//prossesCard 

            }
            ProcessContainer.InnerHtml = ProcessContainerStr;
        }
    }
}