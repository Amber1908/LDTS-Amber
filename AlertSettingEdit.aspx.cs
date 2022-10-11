using System;
using System.Collections;
using System.Collections.Generic;
using System.Web.UI.WebControls;
using LDTS.Models;
using LDTS.Service;

namespace LDTS
{
    public partial class AlertSettingEdit : System.Web.UI.Page
    {
        protected void Page_Load(object sender, EventArgs e)
        {
            if(!IsPostBack)
            {
                initReportQuestion();
                if (Request["ALID"] != null)
                    loadAlert(Request["ALID"]);
            }
        }

        private void initReportQuestion()
        {
            List<ReportQuestion> rqs = ReportQuestiovService.GetAllReportQuestions();

            formselect.Items.Clear();
            foreach (var rq in rqs)
            {
                formselect.Items.Add(new ListItem(rq.Title, rq.QID.ToString()));
            }
        }

        private void loadAlert(string alid)
        {
            AlertSetting als = AlertService.GetAlert(int.Parse(alid));
            if(als != null)
            {
                ALID.Text = als.ALID.ToString();
                ALTitle.Text = als.ALTitle;
                Status.SelectedValue = als.Status.ToString();
                ALType.SelectedValue = als.ALType.ToString();
                ALFactor.Value = als.ALFactor;

                string[] stt = als.ALForm.Split(',');
                foreach(var st in stt)
                {
                    foreach(ListItem li in formselect.Items)
                    {
                        if (st == li.Value)
                            li.Selected = true;
                    }
                }
            }
        }

        protected void SEND_Click(object sender, EventArgs e)
        {
            ArrayList alForm = new ArrayList();
            foreach(ListItem item in formselect.Items)
            {
                if (item.Selected)
                    alForm.Add(item.Value);
            }

            AlertSetting als = new AlertSetting()
            {
                ALID = ALID.Text.Length > 0 ? int.Parse(ALID.Text) : 0,
                ALTitle = ALTitle.Text,
                ALType = int.Parse(ALType.SelectedValue),
                ALFactor = ALFactor.Value,
                ALForm = string.Join(",", alForm.ToArray()),
                Status = int.Parse(Status.SelectedValue),
                CreateMan = "Admin"
            };

            if (ALID.Text.Length < 1)
            {
                if(AlertService.InsertreAlert(als))
                {
                    Response.Write($"<script>alert('提醒建立完成');location.href='AlertSettingList';</script>");
                }
                else
                {
                    Response.Write($"<script>alert('提醒建立失敗');</script>");
                }
            }
            else
            {
                if (AlertService.UpdateAlert(als))
                {
                    Response.Write($"<script>alert('提醒儲存完成');location.href='AlertSettingList';</script>");
                }
                else
                {
                    Response.Write($"<script>alert('提醒儲存失敗');</script>");
                }
            }
        }
    }
}