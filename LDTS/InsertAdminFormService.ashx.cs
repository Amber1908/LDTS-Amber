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
    /// InsertAdminFormService 的摘要描述
    /// </summary>
    public class InsertAdminFormService : IHttpHandler
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

                var reAdimForm = new JavaScriptSerializer().Deserialize<List<ReAdminForm>>(json);
               ReAdminForm adminForm = AoService.GetReAdminForms().Where(x=>x.admin_id== reAdimForm[0].admin_id).FirstOrDefault();
                if (adminForm != null)
                {
                    if (!AoService.DeletereAdminFormByID(reAdimForm[0].admin_id))
                    {
                        message = "權限設定失敗!";
                        this.SendResponse(context, message);
                    }
                }
                if (!AoService.InsertreAdminForms(reAdimForm))
                {
                    message = "權限設定失敗!";
                    this.SendResponse(context, message);
                }
                List<ReProcessQuestion> reProcessForms = RelationService.GetAllReProcesssQuestion();
                List<ReAdminProcess> reAdminProcesses = new List<ReAdminProcess>();
                List<int> fids = reAdimForm.Select(x => x.QID).ToList();
                foreach (var reProcessForm in reProcessForms)
                {
                    foreach (var fid in fids)
                    {
                        if (reProcessForm.QID== fid&& !reAdminProcesses.Any(x=>x.PID== reProcessForm.PID))
                        {
                            reAdminProcesses.Add(new ReAdminProcess()
                            {
                                admin_id = reAdimForm[0].admin_id,
                                PID = reProcessForm.PID
                            });

                        }
                    }
                }
                if (RelationService.InsertReAdminProcesses(reAdminProcesses))
                {
                    message = "權限設定成功!";
                }
                else
                {
                    message = "權限設定失敗!";
                    this.SendResponse(context, message);
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