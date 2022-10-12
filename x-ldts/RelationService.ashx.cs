using System;
using System.Collections.Generic;
using System.Linq;
using System.Web;
using LDTS.Service;
using LDTS.Models;
using Newtonsoft.Json;
using System.Data.SqlClient;
using System.Web.Configuration;
using System.IO;
using System.Web.Script.Serialization;

namespace LDTS
{
    /// <summary>
    /// RelationService 的摘要描述
    /// </summary>
    public class RelationService : IHttpHandler
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
                var reProcessForm = new JavaScriptSerializer().Deserialize<ReProcessQuestion>(json);
                if (Service.RelationService.InsertReProcessQuestion(reProcessForm))
                {
                    message = "關聯設定成功!";
                }
                else
                {
                    message = "關聯設定失敗!";
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