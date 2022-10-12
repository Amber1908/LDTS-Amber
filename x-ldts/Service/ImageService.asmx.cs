using System;
using System.Data;
using System.Data.SqlClient;
using System.IO;
using System.Net;
using System.Web;
using System.Web.Configuration;
using System.Web.Services;
using LDTS.Utils;

namespace LDTS.Service
{
    /// <summary>
    ///ImageService 的摘要描述
    /// </summary>
    [WebService(Namespace = "http://tempuri.org/")]
    [WebServiceBinding(ConformsTo = WsiProfiles.BasicProfile1_1)]
    [System.ComponentModel.ToolboxItem(false)]
    // 若要允許使用 ASP.NET AJAX 從指令碼呼叫此 Web 服務，請取消註解下列一行。
    // [System.Web.Script.Services.ScriptService]
    public class ImageService : System.Web.Services.WebService
    {
        static readonly Logger logger = new Logger("ImageService");

        [WebMethod]
        public void UploadImage()
        {
            int result = 0;
            try
            {
                HttpPostedFile postedFile = HttpContext.Current.Request.Files[0];
                byte[] byteArray = null;
                using (var binaryReader = new BinaryReader(postedFile.InputStream))
                {
                    byteArray = binaryReader.ReadBytes(postedFile.ContentLength);
                }

                using (SqlConnection sqc = new SqlConnection(WebConfigurationManager.ConnectionStrings["LDTSConnectionString"].ToString()))
                {
                    SqlCommand sqmm = new SqlCommand("INSERT INTO Images(image_bytes) VALUES(@image_bytes); SET @LogId = SCOPE_IDENTITY(); ", sqc);
                    sqc.Open();

                    sqmm.Parameters.AddWithValue("@image_bytes", byteArray);

                    SqlParameter pmtLogId = new SqlParameter("@LogId", SqlDbType.Int)
                    {
                        Direction = ParameterDirection.Output
                    };

                    sqmm.Parameters.Add(pmtLogId);

                    sqmm.ExecuteNonQuery();

                    result = (int)pmtLogId.Value;
                }
            }
            catch (Exception e)
            {
                result = 0;
                logger.ERROR(e.Message);
            }

            //Send OK Response to Client.
            HttpContext.Current.Response.StatusCode = (int)HttpStatusCode.OK;
            HttpContext.Current.Response.Write(result);
            HttpContext.Current.Response.Flush();
            HttpContext.Current.Response.End();
        }
    }
}
