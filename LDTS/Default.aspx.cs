using System;
using System.Collections;
using System.Collections.Generic;
using LDTS.Models;
using LDTS.Service;

namespace LDTS
{
    public partial class Default : System.Web.UI.Page
    {
        protected void Page_Load(object sender, EventArgs e)
        {
            if(Session["LDTSAdmin"] != null && !IsPostBack)
            {
                checkTodo();
                loadSignForm();
            }
        }

        private void checkTodo()
        {
            Admin admin = (Admin)Session["LDTSAdmin"];
            string showTodo = "<ul class=\"todo-list ui-sortable\" data-widget=\"todo-list\">";
            string badge = "";
            DateTime dt;
            int days = 1;
            List<AlertSetting> alss = AlertService.checkAlerts(admin);

            foreach (AlertSetting als in alss)
            {
                switch(als.ALType)
                {
                    case 1:
                        dt = DateTime.Parse($"{DateTime.Now.Year}/{als.ALFactor.Split(',')[0].Split('-')[1]}");
                        days = dt.Day - DateTime.Now.Day + 1;
                        badge = "badge-primary";
                        break;
                    case 2:
                        dt = DateTime.Parse($"{DateTime.Now.Year}/{als.ALFactor.Split(',')[0].Split('-')[1]}");
                        days = dt.Day - DateTime.Now.Day + 1;
                        badge = "badge-success";
                        break;
                    case 3:
                        days = int.Parse(als.ALFactor.Split(',')[0].Split('-')[1]) - DateTime.Now.Day + 1;
                        badge = "badge-info";
                        break;
                    case 4:
                        days = 1;
                        badge = "badge-warning";
                        break;
                }
                showTodo += "<li>";
                showTodo += "<span class=\"ui-sortable-handle\">";
                showTodo += "<i class=\"fas fa-ellipsis-v\"></i>";
                showTodo += "<i class=\"fas fa-ellipsis-v\"></i>";
                showTodo += "</span>";
                showTodo += "<div class=\"icheck-primary d-inline ml-2\">";
                showTodo += $"<input type=\"checkbox\" value=\"\" name=\"todo{als.ALID}\" id=\"todoCheck{als.ALID}\" expire=\"{days}\">";
                showTodo += $"<label for=\"todoCheck{als.ALID}\"></label>";
                showTodo += "</div>";
                showTodo += $"<span class=\"text\">{als.ALTitle}</span>";
                showTodo += $"<small class=\"badge {badge}\"><i class=\"far fa-clock\"></i> {days} day</small>";
                showTodo += $"<div class=\"tools\"><a href=\"AlertSettingEdit?ALID={als.ALID}\"><i class=\"fas fa-edit\"></i></a></div>";
                showTodo += "</li>";
            }

            showTodo += "</ul>";

            TodoDiv.InnerHtml = showTodo;
        }

        private void loadSignForm()
        {
            Admin admin = (Admin)Session["LDTSAdmin"];
            string showTodo = "<ul class=\"todo-list ui-sortable\" data-widget=\"todo-list\">";
            List<ReportAnswer> ras = ReportAnswerService.GetAnswers();
            List<ReAdminForm> rafs = AoService.GetReAdminForms();
            ArrayList rafss = new ArrayList();
            foreach (var raf in rafs)
            {
                if (raf.admin_id.Equals(admin.admin_id) && raf.status == 2)
                {
                    rafss.Add(raf.QID.ToString());
                }
            }
            foreach (ReportAnswer ra in ras)
            {
                if (rafss.Contains(ra.QID.ToString()) && ra.Status == 2)
                {
                    showTodo += "<li>";
                    showTodo += "<span class=\"ui-sortable-handle\">";
                    showTodo += "<i class=\"fas fa-ellipsis-v\"></i>";
                    showTodo += "<i class=\"fas fa-ellipsis-v\"></i>";
                    showTodo += "</span>";
                    showTodo += $"<span class=\"text\">{ra.Title}_{ra.ExtendName}</span>";
                    showTodo += $"<small class=\"badge badge-primary\"><i class=\"far fa-clock\"></i> {ra.CreateDate.ToString("yyyy/MM/dd")}</small>";
                    showTodo += $"<div class=\"tools\"><a href=\"ReportQuestionEdit?aid={ra.AID}\"><i class=\"fas fa-edit\"></i></a></div>";
                    showTodo += "</li>";
                }
            }

            showTodo += "</ul>";

            UnsignDiv.InnerHtml = showTodo;
        }
    }
}