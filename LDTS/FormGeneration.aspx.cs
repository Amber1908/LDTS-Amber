using System;
using System.Collections.Generic;
using LDTS.Models;
using LDTS.Service;
using LDTS.Utils;

namespace LDTS
{
    public partial class FormGeneration : System.Web.UI.Page
    {
        protected void Page_Load(object sender, EventArgs e)
        {
            Admin loginAdmin = (Admin)Session["LDTSAdmin"];
            if (loginAdmin == null)
            {
                Response.Redirect("Login.aspx");
            }
            
            if (!IsPostBack)
            {
               
                // OutputJson.Style.Add("display", "none");
                if (Request["QID"] != null)
                {
                    ReportQuestion rq = ReportQuestiovService.GetReportQuestions(Request["QID"]);
                    if(rq != null)
                    {
                        QID.Value = rq.QID.ToString();
                        FormTitle.Text = rq.Title;
                        Version.Text = rq.Version;
                        Description.Text = rq.Description;
                        Status.SelectedValue = rq.Status.ToString();
                        OutputJson.Text = rq.OutputJson;
                    }
                    List<ReportQuestionFile> vers = ReportQuestiovService.GetAllReportFilesById(Convert.ToInt32(Request["QID"])); ;
                    string verStr = "";
                    if (vers.Count > 0)
                    {
                        verStr += "<label for=\"Ver\" class=\"d-block\">下載表單列印範本</label>";
                        verStr += "<select id=\"Ver\" class=\"form-control d-inline\" onchange=\"changeVer()\" style=\"width:75%\">";
                        //<a href=\"/Upload/" + ver.TemplateFile + "\">"
                        foreach (var ver in vers)
                        {
                            //版本號
                            verStr += "<option value=\"Upload/" + ver.TemplateFile + "\">" + ver.Version + "</option>";
                            TemplateFile.Value = ver.TemplateFile;
                        }
                        verStr += "</select>";

                        var disab = vers.Count > 0 && vers[0].TemplateFile.Length > 0 ? "" : "disabled";

                        verStr += $"<a class=\"ml-3 btn btn-info {disab}\" id=\"downloadVer\" href=\"";
                        verStr += vers.Count > 0 ? "Upload/" + vers[0].TemplateFile : "#";
                        verStr += "\">下載</a>";
                    }

                    VersGroup.InnerHtml = verStr;
                }
                //開啟表單範本清單 Modal
                List<ReportQuestion> reportQuestions = ReportQuestiovService.GetAllReportQuestions();
                string modalStr = "";
                modalStr = "<table class=\"table\">";
                modalStr += "<thead class=\"sticky\">";
                modalStr += "<tr>";
                modalStr += "<th>表單名稱</th>";
                modalStr += "<th>異動時間</th>";
                modalStr += "<th>異動人員</th>";
                modalStr += "<th>版本號</th>";
                modalStr += "<th></th>";
                modalStr += "</tr>";
                modalStr += "</thead>";
                modalStr += "<tbody>";
                foreach (var Qs in reportQuestions)
                {
                    modalStr += "<tr>";
                    modalStr += "<td>"+Qs.Title+"</td>";
                    modalStr += "<td>" + Qs.LastupDate + "</td>";
                    modalStr += "<td>" + Qs.LastupMan + "</td>";
                    modalStr += "<td>" + Qs.Version + "</td>";
                    modalStr += "<td>";
                    modalStr += "<a onclick=\"if(confirm('目前編輯的單表若尚未儲存，請先儲存!!')==false)return false\" href=\"FormGeneration.aspx?qid=" + Qs.QID+"\">";
                   
                    modalStr += "<i class=\"fas fa-edit\">";
                    modalStr += "</a>";
                    modalStr += "</td>";
                    modalStr += "</tr>";
                }
                
                modalStr += "</tbody>";
                modalStr += "</table>";
                formListModalBody.InnerHtml = modalStr;
            }
        }

        protected void SaveForm_Click(object sender, EventArgs e)
        {
            Admin loginAdmin = (Admin)Session["LDTSAdmin"];
            try
            {
                string TemplateFileName = TemplateFile.Value;

                if (PrintTemplate.HasFile)
                    TemplateFileName = TemplateFile.Value = PublicUtil.saveFile(PrintTemplate);
                DateTime thisDay = DateTime.Now;
                ReportQuestion rq = new ReportQuestion()
                {
                    QID = int.Parse(QID.Value),
                    Title = FormTitle.Text,
                    Description = Description.Text,
                    OutputJson = OutputJson.Text,
                    CreateMan = loginAdmin.admin_id,
                    Version = Version.Text,
                    Status = int.Parse(Status.SelectedValue),
                    LastupMan = loginAdmin.admin_name,
                    LastupDate= thisDay
                };
                
                if (rq.QID == 0)
                {
                    int Qid = ReportQuestiovService.InsertReportQuestion(rq);
                    ReportQuestionFile file = new ReportQuestionFile()
                    {
                        QID = Qid,
                        Version = rq.Version,
                        TemplateFile= TemplateFileName
                    };
                    bool result = ReportQuestiovService.InsertReportQuestionFile(file);
                    if (Qid > 0 && result)
                    {
                        Response.Write($"<script>alert('表單新增完成');location.href='FormGeneration.aspx?QID={Qid}';</script>");
                    }
                    else
                    {
                        Response.Write($"<script>alert('表單新增失敗');</script>");
                    }
                }
                else
                {
                    ReportQuestionFile report = new ReportQuestionFile()
                    {
                        Version = Version.Text,
                        QID = Convert.ToInt32(QID.Value),
                        TemplateFile = TemplateFileName
                    };

                    bool isUpdate = ReportQuestiovService.GetReportQuestionFile(report.QID.ToString(), report.Version).Count>0?true:false;
                    bool result = false;
                    if (isUpdate)
                    {
                        result = ReportQuestiovService.UpdateReportQuestionFile(report);
                        //改所有ReportQuestion下面的 ReportAnswers的Reportfile
                        List<ReportAnswer> updateAnswers = ReportAnswerService.GetAllAnswersByQID(report.QID);
                        
                        foreach (var updateAnswer in updateAnswers)
                        {
                            updateAnswer.OutputTemplate = TemplateFileName;
                            ReportAnswerService.UpdateReportAnswer(updateAnswer);
                        }
                    }
                    else
                    {
                        result = ReportQuestiovService.InsertReportQuestionFile(report);
                    }
                    if (ReportQuestiovService.UpdateReportQuestion(rq)&& result)
                    {
                        Response.Write($"<script>alert('表單儲存完成');location.href='FormGeneration.aspx?QID={rq.QID}';</script>");
                    }
                    else
                    {
                        Response.Write($"<script>alert('表單儲存失敗');</script>");
                    }
                }
            }
            catch
            {
                
            }
        }
    }
}