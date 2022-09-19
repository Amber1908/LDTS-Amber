using LDTS.Models;
using System;
using System.Collections.Generic;
using System.Linq;
using System.Web;
using System.Web.UI;
using System.Web.UI.WebControls;
using LDTS.Service;
using LDTS.Utils;

namespace LDTS
{
    public partial class ReportQuestionEdit : System.Web.UI.Page
    {
        protected void Page_Load(object sender, EventArgs e)
        {
            Admin loginAdmin = (Admin)Session["LDTSAdmin"];
            if (!loginAdmin.admin_ao.Contains("from"))
            {
                Literal AlertMsg = new Literal();
                AlertMsg.Text = "<script language='javascript'>alert('此帳號沒有編輯權限!!');location.href='Default.aspx';</script>";
            }
            if (loginAdmin != null)
            {
                byte[] imgbyte = LDTSservice.GetImageById(loginAdmin.admin_sign).image_bytes;
                adminSign.Value = loginAdmin.admin_sign.ToString();
            }
            if (!Page.IsPostBack)
            {
                int ReportQuestionId = Convert.ToInt32(Request.QueryString["qid"]);
                int ReportQuestionSid = Convert.ToInt32(Request.QueryString["sqid"]);
                int ReportAnswerId = Convert.ToInt32(Request.QueryString["aid"]);
                int ReportAnswerSid = Convert.ToInt32(Request.QueryString["said"]);
                if (ReportQuestionId != 0)
                {
                    ReportQuestion reportQuestion = FormService.GetReportQuestionById(ReportQuestionId);
                    Qtitle.Text = reportQuestion.Title;
                    desc.Text = reportQuestion.Description;
                    jsonData.Value = reportQuestion.OutputJson;
                    Stauts.Value = reportQuestion.Status.ToString();
                    //表單範本的權限
                    List<ReAdminForm> reQuestions = Service.RelationService.GetAllreAdminFormByAdminId(loginAdmin.admin_id).ToList();
                    if (reQuestions != null)
                    {
                        ReAdminForm reQuestion = reQuestions.Where(x => x.QID == ReportQuestionId).FirstOrDefault();
                        switch (reQuestion.status)
                        {
                            case 2:
                                Ao.Text = "2";
                                break;
                            case 1:
                                Ao.Text = "1";
                                break;
                            default:
                                break;
                        }
                    }
                }
                else if (ReportAnswerId != 0)
                {
                    ReportAnswer reportAnswer = FormService.GetReportAnswerById(ReportAnswerId);
                    Qtitle.Text = reportAnswer.Title;
                    jsonData.Value = reportAnswer.OutputJson;
                    ExtendName.Value = reportAnswer.ExtendName;
                    Stauts.Value = reportAnswer.Status.ToString();
                    desc.Text = reportAnswer.Description;
                    keyword.Value = reportAnswer.Keyword;
                    //int Qsid = ReportAnswerService.GetReportAnswer(ReportAnswerId.ToString()).QID;
                    List<ReAdminForm> adminForms = Service.RelationService.GetAllreAdminFormByAdminId(loginAdmin.admin_id).ToList();
                    //有權限的reportQ
                    List<int> reportQuestions = ReportQuestiovService.GetAllReportQuestions().Where(x => x.QID == reportAnswer.QID).Select(x=>x.QID).ToList();
                    foreach (var reportQuestion in reportQuestions)
                    {
                        if (adminForms.Any(x=>x.QID==reportQuestion))
                        {
                            ReAdminForm adminForm = adminForms.Where(x => x.QID == reportQuestion).FirstOrDefault();
                            //1.編輯2.編輯加簽核
                            if (adminForm.status == 1)
                            {
                                Ao.Text = "1";
                            }
                            else
                            {
                                Ao.Text = "2";
                            }
                        }
                        else
                        {
                            Ao.Text = "0";
                        }
                    }
                }
                else if (ReportAnswerSid != 0)
                {
                    ReportAnswer reportAnswer = FormService.GetReportAnswerById(ReportAnswerSid);
                    Qtitle.Text = reportAnswer.Title;
                    jsonData.Value = reportAnswer.OutputJson;
                    ExtendName.Value = reportAnswer.ExtendName;
                    Stauts.Value = reportAnswer.Status.ToString();
                    desc.Text = reportAnswer.Description;
                    keyword.Value = reportAnswer.Keyword;

                }
                else if (ReportQuestionSid != 0)
                {
                    ReportQuestion reportQuestion = FormService.GetReportQuestionById(ReportQuestionSid);
                    Qtitle.Text = reportQuestion.Title;
                    desc.Text = reportQuestion.Description;
                    jsonData.Value = reportQuestion.OutputJson;
                    Stauts.Value = reportQuestion.Status.ToString();
                }
            }

        }

        protected void SaveButton_Click(object sender, EventArgs e)
        {
            ReportAnswer reportAnswer = new ReportAnswer();
            Admin loginAdmin = (Admin)Session["LDTSAdmin"];
            int ReportQuestionId = Convert.ToInt32(Request.QueryString["qid"]);//Insert
            ReportQuestion question = ReportQuestiovService.GetReportQuestions(Request.QueryString["qid"]);

            int ReportQuestionSqid = Convert.ToInt32(Request.QueryString["sqid"]);
            int ReportAnswerId = Convert.ToInt32(Request.QueryString["aid"]);//Update
            if (ReportQuestionId != 0)
            {
                reportAnswer.AppendFile = AppendFile.Value;
                reportAnswer.QID = ReportQuestionId;
                reportAnswer.Title = Qtitle.Text;
                reportAnswer.CreateMan = loginAdmin.admin_id;
                reportAnswer.Description = desc.Text;
                reportAnswer.ExtendName = ExtendName.Value;
                reportAnswer.OutputJson = jsonData.Value;
                reportAnswer.Status = Convert.ToInt32(Stauts.Value);
                reportAnswer.Keyword = keyword.Value;
                reportAnswer.LastupMan = loginAdmin.admin_name;
                reportAnswer.Version = question.Version;//新增是最新的版本號
                List<ReportQuestionFile> files = ReportQuestiovService.GetReportQuestionFile(ReportQuestionId.ToString(), question.Version);
                if (files!=null)
                {
                    reportAnswer.OutputTemplate = files[0].TemplateFile;
                }
                int aid = ReportAnswerService.InsertReportAnswer(reportAnswer);
                if (aid != 0)
                {
                    LDTSservice.InsertRecord(loginAdmin, "新增表單:" + reportAnswer.ExtendName);
                    Literal AlertMsg = new Literal();
                    AlertMsg.Text = "<script language='javascript'>alert('新增表單成功!!!');location.href='ReportQuestionEdit.aspx?aid=" + aid + "';</script>";
                    this.Page.Controls.Add(AlertMsg);
                }
                else
                {
                    Literal AlertMsg = new Literal();
                    AlertMsg.Text = "<script language='javascript'>alert('新增表單失敗!!!');location.href='ReportQuestionEdit.aspx?aid=" + aid + "';</script>";
                    this.Page.Controls.Add(AlertMsg);
                }
            }
            else if (ReportAnswerId != 0)
            {
                //原本的版本號
                ReportAnswer answer = ReportAnswerService.GetReportAnswer(ReportAnswerId.ToString());
                reportAnswer.Version = FormService.GetReportAnswerById(ReportAnswerId).Version.ToString();
                reportAnswer.AID = ReportAnswerId;
                reportAnswer.Title = Qtitle.Text;
                reportAnswer.Description = desc.Text;
                reportAnswer.ExtendName = ExtendName.Value;
                reportAnswer.OutputJson = jsonData.Value;
                reportAnswer.Status = Convert.ToInt32(Stauts.Value);
                reportAnswer.AppendFile = AppendFile.Value;
                reportAnswer.Keyword = keyword.Value;
                reportAnswer.LastupMan = loginAdmin.admin_name;
                reportAnswer.OutputTemplate = answer.OutputTemplate;
                DateTime thisDay = DateTime.Now;
                reportAnswer.LastupDate = thisDay;
                if (ReportAnswerService.UpdateReportAnswer(reportAnswer))
                {
                    LDTSservice.InsertRecord(loginAdmin, "編輯表單:" + reportAnswer.ExtendName);
                    Literal AlertMsg = new Literal();
                    AlertMsg.Text = "<script language='javascript'>alert('編輯表單成功!!!');location.href='ReportQuestionEdit.aspx?aid=" + ReportAnswerId + "';</script>";
                    this.Page.Controls.Add(AlertMsg);
                }
            }
            else if (ReportQuestionSqid!=0)
            {
                reportAnswer.AppendFile = AppendFile.Value;
                reportAnswer.QID = ReportQuestionSqid;
                reportAnswer.Title = Qtitle.Text;
                reportAnswer.CreateMan = loginAdmin.admin_id;
                reportAnswer.Description = desc.Text;
                reportAnswer.ExtendName = ExtendName.Value;
                reportAnswer.OutputJson = jsonData.Value;
                reportAnswer.Status = Convert.ToInt32(Stauts.Value);
                reportAnswer.Keyword = keyword.Value;
                reportAnswer.LastupMan = loginAdmin.admin_name;
                int aid = ReportAnswerService.InsertReportAnswer(reportAnswer);
                if (aid != 0)
                {
                    LDTSservice.InsertRecord(loginAdmin, "新增表單:" + reportAnswer.ExtendName);
                    Literal AlertMsg = new Literal();
                    AlertMsg.Text = "<script language='javascript'>alert('新增表單成功!!!');location.href='ReportQuestionEdit.aspx?aid=" + aid + "';</script>";
                    this.Page.Controls.Add(AlertMsg);
                }
                else
                {
                    Literal AlertMsg = new Literal();
                    AlertMsg.Text = "<script language='javascript'>alert('新增表單失敗!!!');location.href='ReportQuestionEdit.aspx?aid=" + aid + "';</script>";
                    this.Page.Controls.Add(AlertMsg);
                }

            }

        }

        protected void Printbtn_Click(object sender, EventArgs e)
        {
            int ReportAnswerId = Convert.ToInt32(Request.QueryString["aid"]);
            int ReportQID = Convert.ToInt32(Request.QueryString["qid"]);
            int ReportAnswerSid = Convert.ToInt32(Request.QueryString["said"]);

            string OutputTemplate = ReportAnswerService.GetReportAnswer(ReportAnswerId.ToString()).OutputTemplate;
            if (OutputTemplate!=string.Empty&& OutputTemplate !=null)
            {
                Response.Redirect("OutputWord.ashx?AID=" + ReportAnswerId);
            }
            else if (ReportQID!= 0)
            {
                Literal AlertMsg = new Literal();
                AlertMsg.Text = "<script language='javascript'>alert('目前該表單範本還沒有建立表單!!!');</script>";
                this.Page.Controls.Add(AlertMsg);
            }
            else
            {
                Literal AlertMsg = new Literal();
                AlertMsg.Text = "<script language='javascript'>alert('目前沒有表單列印範本!!!');</script>";
                this.Page.Controls.Add(AlertMsg);
            }
        }

        protected void Deletebtn_Click(object sender, EventArgs e)
        {
            Admin loginAdmin = (Admin)Session["LDTSAdmin"];

            string ReportAnswerId = Request.QueryString["aid"];
            ReportAnswer answer = ReportAnswerService.GetReportAnswer(ReportAnswerId);
            if (answer != null)
            {
                if (ReportAnswerService.DeleteReportAnswer(ReportAnswerId))
                {
                    int qid = answer.QID;
                    ReProcessQuestion reProcessQuestion = Service.RelationService.GetAllReProcesssQuestion().Where(x => x.QID == qid).First();


                    LDTSservice.InsertRecord(loginAdmin,"刪除表單"+ answer.ExtendName);
                    string url = "Process?pid=" + reProcessQuestion.PID;
                    Response.Write("<script type='text/javascript'>alert('刪除表單成功!'); location.href ='"+ url +"'</script>");


                }
            }
        }
    }
}