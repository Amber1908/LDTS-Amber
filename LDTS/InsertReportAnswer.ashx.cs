using System;
using System.Collections.Generic;
using System.IO;
using System.Linq;
using System.Web;
using System.Web.Script.Serialization;
using LDTS.Models;
using LDTS.Service;

namespace LDTS
{
    /// <summary>
    /// InsertReportAnswer 的摘要描述
    /// </summary>
    public class InsertReportAnswer : IHttpHandler
    {

        public void ProcessRequest(HttpContext context)
        {
            context.Response.ContentType = "text/plain";
            string json = string.Empty;
            string message = string.Empty;

            using (var reader = new StreamReader(context.Request.InputStream))
            {
                json = reader.ReadToEnd();
            }
            if (!string.IsNullOrEmpty(json))
            {
                var reportAnswerJson  = new JavaScriptSerializer().Deserialize<ReportAnswerJson>(json);
                string extendName = reportAnswerJson.ExtendName.ToString();
                string des = reportAnswerJson.Description.ToString();
                string title = reportAnswerJson.Title.ToString();
                string outputjson = reportAnswerJson.OutputJson.ToString();
                int QID = reportAnswerJson.QID;
                int stauts = reportAnswerJson.Status;
                string adminid = reportAnswerJson.admin_id;
                Admin admin = PersonnelManagementService.GetAdminById(adminid);
                ReportAnswer reportAnswer = new ReportAnswer()
                {
                    ExtendName = extendName,
                    Description = des,
                    Title = title,
                    OutputJson = outputjson,
                    QID = QID,
                    Status = stauts,
                    CreateMan = admin.admin_name
                };
                if (reportAnswerJson.insertorUpdate== "insert")
                {
                    if (ReportAnswerService.InsertReportAnswer(reportAnswer)!=0)
                    {

                        LDTSservice.InsertRecord(admin, "編輯:" + extendName);
                        message = "儲存成功!";
                    }
                    else
                    {
                        message = "儲存失敗!";
                        this.SendResponse(context, message);
                    }

                }
                else
                {
                    reportAnswer.AID = reportAnswerJson.AID;
                    if (ReportAnswerService.UpdateReportAnswer(reportAnswer))
                    {
                        LDTSservice.InsertRecord(admin, "編輯:" + extendName);
                        message = "儲存成功!";
                    }
                    else
                    {
                        message = "儲存失敗!";
                        this.SendResponse(context, message);
                    }
                }
                this.SendResponse(context, message);
            }

        }
        private void SendResponse(HttpContext context, string message)
        {
            context.Response.Write(message);
            context.Response.End();
        }

        public bool IsReusable
        {
            get
            {
                return false;
            }
        }
    }
}