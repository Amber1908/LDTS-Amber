using System;
using System.Collections.Generic;
using System.Linq;
using System.Web;
using System.Web.Script.Serialization;
using LDTS.Models;
using LDTS.Service;
using System.IO;


namespace LDTS
{
    /// <summary>
    /// InsertReSworkbookForm 的摘要描述
    /// </summary>
    public class InsertReSworkbookForm : IHttpHandler
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
                var standardWorkBook = new JavaScriptSerializer().Deserialize<ReStandarWorkBookForm>(json);
                if (RelationService.InsertReSworkbookForm(standardWorkBook))
                {
                    message = "關聯設定成功!";
                }
                else
                {
                    message = "關聯設定失敗!";
                    this.SendResponse(context, message);
                }
            }
            this.SendResponse(context, message);
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


