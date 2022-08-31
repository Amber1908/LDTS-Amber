using System;
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
                        TemplateFile.Value = rq.TemplateFile;
                    }
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
                    TemplateFile = TemplateFileName,
                    Status = int.Parse(Status.SelectedValue)
                };

                if (rq.QID == 0)
                {
                    int Qid = ReportQuestiovService.InsertReportQuestion(rq);
                    if (Qid > 0)
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
                    if (ReportQuestiovService.UpdateReportQuestion(rq))
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