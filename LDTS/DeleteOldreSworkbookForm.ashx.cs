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
    /// DeleteOldreSworkbookForm 的摘要描述
    /// </summary>
    public class DeleteOldreSworkbookForm : IHttpHandler
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
                ReStandarWorkBookForm reStandarWorkBookForm = new JavaScriptSerializer().Deserialize<ReStandarWorkBookForm>(json);
                RelationService.DeleteReStandarWorkBookFormByID(reStandarWorkBookForm.SID);
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