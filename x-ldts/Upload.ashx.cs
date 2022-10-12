using System;
using System.Collections.Generic;
using System.Linq;
using System.Web;

namespace LDTS
{
    /// <summary>
    /// Upload 的摘要描述
    /// </summary>
    public class Upload : IHttpHandler
    {

        public void ProcessRequest(HttpContext context)
        {
            if (context.Request.Files.Count > 0)
            {
                HttpFileCollection files = context.Request.Files;
                string fileName = context.Request.Params.Get("fileName") == null ? "" :
                context.Request.Params.Get("fileName");
                for (int i = 0; i < files.Count; i++)
                {
                    HttpPostedFile file = files[i];
                    DateTime now = new DateTime();
                    //string today= DateTime.Now.ToString("yyyy-MM-dd-HH-mm-ss-fff");
                    //string fileName = file.FileName + "_" + today;
                    string fname = context.Server.MapPath("~/Upload/" + fileName);
                    file.SaveAs(fname);
                }
            }
            context.Response.ContentType = "text/plain";
            context.Response.Write("fileName");
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