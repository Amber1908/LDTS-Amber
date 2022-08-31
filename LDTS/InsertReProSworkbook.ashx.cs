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
    /// InsertReProSworkbook 的摘要描述
    /// </summary>
    public class InsertReProSworkbook : IHttpHandler
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
                var standardWorkBook = new JavaScriptSerializer().Deserialize<ReProcessStandardWorkBook>(json);
                if (RelationService.InsertReProcessStandardWorkBook(standardWorkBook))
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