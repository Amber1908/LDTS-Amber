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
    /// DeleteOldReProSworkbook 的摘要描述
    /// </summary>
    public class DeleteOldReProSworkbook : IHttpHandler
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
                ReProcessStandardWorkBook standardWorkBook = new JavaScriptSerializer().Deserialize<ReProcessStandardWorkBook>(json);
                RelationService.DeleteReProcessStandardWorkBookByID(standardWorkBook.PID);
            }
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