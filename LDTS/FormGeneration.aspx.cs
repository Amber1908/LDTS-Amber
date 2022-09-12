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
                    verStr += "<table class=\"table table-bordered table-head-fixed text-nowrap\">";
                    verStr += "<thead><tr><th>表單版本</th><th>下載</th></tr></thead>";
                    verStr += "<tbody>";
                    foreach (var ver in vers)
                    {
                        //版本號
                        verStr += "<tr>";
                        verStr += "<td>";
                        verStr += ver.Version;
                        verStr += "</td>";
                        verStr += "<td>";
                        verStr += "<a href=\"/Upload/" + ver.TemplateFile + "\">";
                        verStr += "<i class=\"fas fa-cloud-download-alt\"></i>";
                        verStr += "</a>";
                        verStr += "</td>";
                        verStr += "</tr>";
                    }
                    verStr += "</tbody>";
                    verStr += "</table>";
                    Verlist.InnerHtml = verStr;
                }

            }
        }

        protected void SaveForm_Click(object sender, EventArgs e)
        {
            try
            {
                string TemplateFileName = TemplateFile.Value;

                if (PrintTemplate.HasFile)
                    TemplateFileName = TemplateFile.Value = PublicUtil.saveFile(PrintTemplate);

                ReportQuestion rq = new ReportQuestion()
                {
                    QID = int.Parse(QID.Value),
                    Title = FormTitle.Text,
                    Description = Description.Text,
                    OutputJson = OutputJson.Text,
                    CreateMan = "Admin",
                    Version = Version.Text,
                    Status = int.Parse(Status.SelectedValue)
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
                        Response.Write($"<script>alert('表單新增完成');location.href='FormGeneration?QID={Qid}';</script>");
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
                    }
                    else
                    {
                        result = ReportQuestiovService.InsertReportQuestionFile(report);
                    }
                    if (ReportQuestiovService.UpdateReportQuestion(rq)&& result)
                    {
                        Response.Write($"<script>alert('表單儲存完成');location.href='FormGeneration?QID={rq.QID}';</script>");
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