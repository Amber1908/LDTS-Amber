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
                }
                else if (ReportAnswerId != 0)
                {
                    ReportAnswer reportAnswer = FormService.GetReportAnswerById(ReportAnswerId);
                    Qtitle.Text = reportAnswer.Title;
                    jsonData.Value = reportAnswer.OutputJson;
                    ExtendName.Value = reportAnswer.ExtendName;
                    Stauts.Value = reportAnswer.Status.ToString();
                    desc.Text = reportAnswer.Description;
                    int Qsid = ReportAnswerService.GetReportAnswer(ReportAnswerId.ToString()).QID;
                    List<ReAdminForm> adminForms= AoService.GetReAdminForms().Where(x => x.QID == Qsid).ToList();
                    ReAdminForm adminForm= adminForms.Where(x=>x.admin_id== loginAdmin.admin_id).FirstOrDefault();
                    if (adminForm != null)
                    {
                        //1.編輯2.編輯加簽核
                        if (adminForm.status==1)
                        {
                            Ao.Text ="1";
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
                else if (ReportAnswerSid != 0)
                {
                    ReportAnswer reportAnswer = FormService.GetReportAnswerById(ReportAnswerSid);
                    Qtitle.Text = reportAnswer.Title;
                    jsonData.Value = reportAnswer.OutputJson;
                    ExtendName.Value = reportAnswer.ExtendName;
                    Stauts.Value = reportAnswer.Status.ToString();
                    desc.Text = reportAnswer.Description;

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
                reportAnswer.Version = FormService.GetReportAnswerById(ReportAnswerId).Version.ToString();
                reportAnswer.AID = ReportAnswerId;
                reportAnswer.Title = Qtitle.Text;
                reportAnswer.Description = desc.Text;
                reportAnswer.ExtendName = ExtendName.Value;
                reportAnswer.OutputJson = jsonData.Value;
                reportAnswer.Status = Convert.ToInt32(Stauts.Value);
                reportAnswer.AppendFile = AppendFile.Value;
                if (ReportAnswerService.UpdateReportAnswer(reportAnswer))
                {
                    LDTSservice.InsertRecord(loginAdmin, "編輯表單:" + reportAnswer.ExtendName);
                    Literal AlertMsg = new Literal();
                    AlertMsg.Text = "<script language='javascript'>alert('編輯表單成功!!!');location.href='ReportQuestionEdit.aspx?aid=" + ReportAnswerId + "';</script>";
                    this.Page.Controls.Add(AlertMsg);
                }
            }

        }
    }
}