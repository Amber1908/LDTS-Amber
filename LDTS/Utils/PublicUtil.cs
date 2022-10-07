using System;
using System.Collections;
using System.Data;
using System.Data.SqlClient;
using System.Drawing;
using System.IO;
using System.Net.Mail;
using System.Security.Cryptography;
using System.Text;
using System.Web;
using System.Web.Configuration;
using System.Web.UI.WebControls;
using LDTS.Models;

namespace LDTS.Utils
{
    /// <summary>
    /// 公用程式集合
    /// </summary>
    public class PublicUtil
    {
        static readonly Logger logger = new Logger("PublicUtil");

        /// <summary>
        /// 產生隨機檔案名稱
        /// </summary>
        /// <param name="subname">副檔名含 .</param>
        /// <returns>產生檔名</returns>
        public static string GenFilename(string subname)
        {
            return string.Format("LDTS{0:yyyyMMddHHmmssfff}{1}", DateTime.Now, subname);
        }

        /// <summary>
        /// 產生資料庫名稱
        /// </summary>
        /// <returns>資料庫名稱</returns>
        public static string GenDBname()
        {
            return string.Format("Health{0:yyyyMMddHHmmssfff}", DateTime.Now);
        }

        /// <summary>
        /// 產生亂數密碼
        /// </summary>
        /// <param name="Number">密碼位數</param>
        /// <returns>新密碼</returns>
        public static string CreateRandomCode(int Number)
        {
            string allChar = "0,1,2,3,4,5,6,7,8,9,a,b,c,d,e,f,g,h,i,j,k,l,m,n,o,p,q,r,s,t,u,v,w,x,y,z,A,B,C,D,E,F,G,H,I,J,K,L,M,N,O,P,Q,R,S,T,U,V,W,X,Y,Z";
            string[] allCharArray = allChar.Split(',');
            string randomCode = "";
            int temp = -1;

            Random rand = new Random();
            for (int i = 0; i < Number; i++)
            {
                if (temp != -1)
                {
                    rand = new Random(i * temp * ((int)DateTime.Now.Ticks));
                }
                int t = rand.Next(62);
                if (temp != -1 && temp == t)
                {
                    return CreateRandomCode(Number);
                }
                temp = t;
                randomCode += allCharArray[t];
            }
            return randomCode;
        }

        /// <summary>
        /// 取得隨機驗證碼
        /// </summary>
        /// <param name="Number"></param>
        /// <returns></returns>
        public static string GenVerifyCode(int Number)
        {
            string ret = "";
            Random rand = new Random(Guid.NewGuid().GetHashCode());

            for (int i = 0; i < Number; i++)
            {
                ret += rand.Next(0, 10).ToString();
            }

            return ret;
        }

        /// <summary>
        /// MD5 計算
        /// </summary>
        /// <param name="md5string"></param>
        /// <returns></returns>
        public static string toMD5(string md5string)
        {
            MD5CryptoServiceProvider cryptHandler = new MD5CryptoServiceProvider();
            byte[] ba = cryptHandler.ComputeHash(Encoding.UTF8.GetBytes(md5string));
            StringBuilder hex = new StringBuilder(ba.Length * 2);
            foreach (byte b in ba)
                hex.AppendFormat("{0:X2}", b);

            return hex.ToString();
        }

        /// <summary>
        /// SHA256 加密
        /// </summary>
        /// <param name="pwd">欲加密字串</param>
        /// <returns>加密後字串</returns>
        public static string toSha256(string pwd)
        {
            SHA256 sha256 = new SHA256CryptoServiceProvider();
            return Convert.ToBase64String(sha256.ComputeHash(Encoding.Default.GetBytes(pwd)));
        }

        /// <summary>
        /// 讀取檔案內容
        /// </summary>
        /// <param name="filename"></param>
        /// <returns></returns>
        public static string readFile(string filename)
        {
            string output = "";

            try
            {   // Open the text file using a stream reader.
                using (StreamReader sr = new StreamReader(filename))
                {
                    // Read the stream to a string, and write the string to the console.
                    output = sr.ReadToEnd();
                }
            }
            catch (IOException e)
            {
                output = "";
                logger.ERROR(e.Message);
            }

            return output;
        }

        public static byte[] readImageR(int image_id)
        {
            Bitmap bmp;
            using (var ms = new MemoryStream(readImage(image_id)))
            {
                bmp = new Bitmap(ms);
            }
            bmp.RotateFlip(RotateFlipType.Rotate90FlipNone);
            ImageConverter converter = new ImageConverter();
            return (byte[])converter.ConvertTo(bmp, typeof(byte[]));
        }

        /// <summary>
        /// 讀取圖片二進位資料
        /// </summary>
        /// <param name="image_id"></param>
        /// <returns></returns>
        public static byte[] readImage(int image_id)
        {
            using (SqlConnection sqc = new SqlConnection(WebConfigurationManager.ConnectionStrings["LDTSConnectionString"].ToString()))
            {
                SqlCommand sqmm = new SqlCommand("SELECT image_bytes FROM Images WHERE image_id=@image_id ", sqc);
                sqc.Open();

                sqmm.Parameters.AddWithValue("@image_id", image_id);

                return (byte[])sqmm.ExecuteScalar();
            }
        }

        /// <summary>
        /// 圖片上傳
        /// </summary>
        /// <param name="fu"></param>
        /// <returns></returns>
        public static int saveImage(FileUpload fu)
        {
            int result = 0;
            try
            {
                byte[] byteArray = new byte[0];

                if (fu.PostedFile == null)
                {
                    return 0;
                }

                // Get a reference to PostedFile object
                HttpPostedFile myFile = fu.PostedFile;

                // 取得檔案的大小
                int nFileLen = myFile.ContentLength;

                if (nFileLen > 0)
                {
                    // 建立一個buffer來接收資料
                    byteArray = new byte[nFileLen];

                    // 從InputStream中讀取資料至buffer中
                    myFile.InputStream.Read(byteArray, 0, nFileLen);
                }
                else
                {
                    return 0;
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
            catch(Exception e)
            {
                result = 0;
                logger.ERROR(e.Message);
            }

            return result;
        }
        /// <summary>
        /// 取得單一圖片 
        /// </summary>
        /// <returns></returns>
        public static Images GetImgById(int image_id)
        {
            Images img = new Images();
            try
            {
                using (SqlConnection sqc = new SqlConnection(WebConfigurationManager.ConnectionStrings["LDTSConnectionString"].ToString()))
                {
                    SqlCommand sqmm = new SqlCommand(@"Select * from Images where image_id=@image_id", sqc);
                    sqc.Open();
                    sqmm.Parameters.AddWithValue("@image_id", image_id);
                    SqlDataReader sd = sqmm.ExecuteReader();
                    if (sd.Read())
                    {
                        img.image_id = sd.IsDBNull(sd.GetOrdinal("image_id")) ? 0 : sd.GetInt32(sd.GetOrdinal("image_id"));
                        img.image_bytes =sd.IsDBNull(sd.GetOrdinal("image_bytes"))?null: (byte[])sd["image_bytes"];
                        img.memo = sd.IsDBNull(sd.GetOrdinal("memo")) ? "" : sd.GetString(sd.GetOrdinal("memo"));
                    }

                }
            }
            catch (Exception e)
            {
                logger.ERROR(e.Message);
                return img = new Images();
            }
            return img;
        }

        /// <summary>
        /// 圖片上傳(base64字串)
        /// </summary>
        /// <param name="image">base64字串</param>
        /// <returns></returns>
        public static int saveImage(string image)
        {
            int result = 0;
            try
            {
                byte[] byteArray = Convert.FromBase64String(image);

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

            return result;
        }

        /// <summary>
        /// 檔案上傳
        /// </summary>
        /// <param name="fu">FileUpload Object</param>
        /// <returns>新檔案名</returns>
        public static string saveFile(FileUpload fu)
        {
            string result;

            try
            {
                if (fu.PostedFile == null)
                {
                    return "";
                }

                // Get a reference to PostedFile object
                HttpPostedFile myFile = fu.PostedFile;
                result = GenFilename(Path.GetExtension(myFile.FileName));

                myFile.SaveAs(HttpContext.Current.Server.MapPath("~/Upload/") + result);
            }
            catch(Exception e)
            {
                result = "";
                logger.ERROR(e.Message);
            }

            return result;
        }

        /// <summary>
        /// 寄發 EMAIL Office365
        /// </summary>
        /// <param name="subject"></param>
        /// <param name="content"></param>
        /// <param name="mailto"></param>
        /// <returns></returns>
        public static bool SendOmail(string subject, string content, string mailto)
        {
            bool sendresult;
            string[] mailtom;

            try
            {
                MailMessage msg = new MailMessage();
                mailtom = mailto.Split(';');
                foreach (string tmp in mailtom)
                {
                    if (tmp.Length > 5)
                        msg.To.Add(tmp);
                }
                msg.From = new System.Net.Mail.MailAddress(WebConfigurationManager.AppSettings["MAIL_ADDR"], "iDoctor.Tools", System.Text.Encoding.UTF8);
                /* 上面3個參數分別是發件人地址（可以隨便寫），發件人姓名，編碼*/
                msg.Subject = subject;//郵件標題
                msg.SubjectEncoding = System.Text.Encoding.UTF8;//郵件標題編碼
                msg.Body = content; //郵件內容
                msg.BodyEncoding = System.Text.Encoding.UTF8;//郵件內容編碼 
                // msg.Attachments.Add(new Attachment(@"D:\test2.docx"));  //附件
                msg.IsBodyHtml = true;//是否是HTML郵件
                //msg.Priority = MailPriority.High;//郵件優先級 

                // 這段一定要, 要寫這個才可以跳過 "根據驗證程序,遠端憑證是無效的" 的錯誤
                // System.Net.ServicePointManager.ServerCertificateValidationCallback = new System.Net.Security.RemoteCertificateValidationCallback(ValidateServerCertificate);

                SmtpClient client = new SmtpClient
                {
                    Credentials = new System.Net.NetworkCredential(WebConfigurationManager.AppSettings["MAIL_USER"], WebConfigurationManager.AppSettings["MAIL_PSWD"]), //這裡要填正確的帳號跟密碼
                    Host = WebConfigurationManager.AppSettings["MAIL_SERVER"], //設定 smtp Server
                    TargetName = "STARTTLS/smtp.office365.com",
                    Port = 587, // 設定Port
                    EnableSsl = true // 預設開啟驗證
                };

                client.Send(msg); // 寄出信件
                client.Dispose();
                msg.Dispose();
                sendresult = true;
            }
            catch(Exception ex)
            {
                sendresult = false;
                logger.ERROR(ex.Message);
            }
            return sendresult;
        }

        /// <summary>
        /// 寄發 Gmail
        /// </summary>
        /// <param name="subject"></param>
        /// <param name="content"></param>
        /// <param name="mailto"></param>
        /// <returns></returns>
        public static bool SendGmail(string subject, string content, string mailto)
        {
            bool sendresult;
            string[] mailtom;
            try
            {
                MailMessage msg = new MailMessage();

                mailtom = mailto.Split(';');

                foreach (string tmp in mailtom)
                {
                    if (tmp.Length > 5)
                        msg.To.Add(tmp);
                }
                //msg.To.Add("b@b.com");可以發送給多人
                //msg.CC.Add("c@c.com");
                //msg.CC.Add("c@c.com");可以抄送副本給多人 
                //這裡可以隨便填，不是很重要
                msg.From = new MailAddress(WebConfigurationManager.AppSettings["MAIL_ADDR"], "iDoctorTools", System.Text.Encoding.UTF8);
                /* 上面3個參數分別是發件人地址（可以隨便寫），發件人姓名，編碼*/
                msg.Subject = subject;//郵件標題
                msg.SubjectEncoding = System.Text.Encoding.UTF8;//郵件標題編碼
                msg.Body = content; //郵件內容
                msg.BodyEncoding = System.Text.Encoding.UTF8;//郵件內容編碼 
                // msg.Attachments.Add(new Attachment(@"D:\test2.docx"));  //附件
                msg.IsBodyHtml = true;//是否是HTML郵件
                //msg.Priority = MailPriority.High;//郵件優先級 

                SmtpClient client = new SmtpClient
                {
                    Credentials = new System.Net.NetworkCredential(WebConfigurationManager.AppSettings["MAIL_ADDR"], WebConfigurationManager.AppSettings["MAIL_PSWD"]), //這裡要填正確的帳號跟密碼
                    Host = WebConfigurationManager.AppSettings["GMAIL_SERVER"], //設定smtp Server
                    Port = 25, //設定Port
                    EnableSsl = true //gmail預設開啟驗證
                };

                client.Send(msg); //寄出信件
                client.Dispose();
                msg.Dispose();
                sendresult = true;
            }
            catch (Exception ex)
            {
                sendresult = false;
                logger.ERROR(ex.Message);
            }
            return sendresult;
        }

        /// <summary>
        /// 西元日期轉民國日期 yyyy/MM/dd > yyy/MM/dd
        /// </summary>
        /// <param name="indate"></param>
        /// <returns></returns>
        public static string W2CDate(string indate)
        {
            string outDate = "";

            if (indate.Length > 9)
            {
                int year = int.Parse(indate.Substring(0, 4)) - 1911;
                outDate = string.Format("{0}{1}", year, indate.Substring(4));
            }

            return outDate;
        }

        /// <summary>
        /// 民國日期轉西元日期 yyy/MM/dd > yyyy/MM/dd
        /// </summary>
        /// <param name="indate"></param>
        /// <returns></returns>
        public static string C2WDate(string indate)
        {
            string outDate = "";

            try
            {
                if (indate.Length > 5)
                {
                    string[] cc = indate.Split('/');
                    int year = int.Parse(cc[0]) + 1911;
                    outDate = string.Format("{0}/{1}/{2}", year, cc[1], cc[2]);
                }
            }
            catch (Exception ex)
            {
                outDate = "日期格式錯誤";
                logger.ERROR(ex.Message);
            }

            return outDate;
        }

        /// <summary>
        /// 產生 UUID
        /// </summary>
        /// <returns></returns>
        public static string genUUID()
        {
            return Guid.NewGuid().ToString().Replace("-", "").ToUpper();
        }

        /// <summary>
        /// 產生 Session Key
        /// </summary>
        /// <param name="email"></param>
        /// <returns></returns>
        public static string genSessionKey(string email)
        {
            string result = email.Substring(0, 3).ToUpper();
            string rad;
            ArrayList al = new ArrayList() { "A", "B", "C", "D", "E", "F", "G", "H", "I", "J" };

            rad = DateTime.Now.Ticks.ToString();

            for(int i = 0; i < rad.Length; i++)
            {
                result += al[int.Parse(rad.Substring(i, 1))];
            }

            return result;
        }

        /// <summary>
        /// Hello
        /// </summary>
        /// <returns></returns>
        public static string getHello()
        {
            string result;

            if (DateTime.Now.Hour > 6 && DateTime.Now.Hour < 12)
                result = "Good Morning";
            else if (DateTime.Now.Hour > 12 && DateTime.Now.Hour < 18)
                result = "Good Afternoon";
            else if (DateTime.Now.Hour > 18 && DateTime.Now.Hour < 21)
                result = "Good Evening";
            else
                result = "Good Night";


            return result;
        }

        /// <summary>
        /// 計算檔案MD5驗證
        /// </summary>
        /// <param name="filename"></param>
        /// <returns></returns>
        public static string CalculateMD5(string filename)
        {
            using (var md5 = MD5.Create())
            {
                using (var stream = File.OpenRead(filename))
                {
                    var hash = md5.ComputeHash(stream);
                    return BitConverter.ToString(hash).Replace("-", "").ToLowerInvariant();
                }
            }
        }

        /// <summary>
        /// 檢查是否到期
        /// </summary>
        /// <param name="dt"></param>
        /// <returns></returns>
        public static bool isExpire(DateTime dt)
        {
            DateTime dn = DateTime.Now;
            DateTime dtt = new DateTime(dt.Year, dt.Month, dt.Day, 0, 0, 0);
            dtt = dtt.AddDays(1);

            if (dtt > dn)
                return false;
            else
                return true;
        }

        /// <summary>
        /// 修正金額顯示
        /// </summary>
        /// <param name="money"></param>
        /// <returns></returns>
        public static string fixMoney(int money)
        {
            double tm = money;
            tm /= 100;
            return tm.ToString("#,###,###,##0.00");
        }

        #region 加解密專用

        private const string strkey = "42710833";

        public static string Encrypt(string strSorc)
        {
            string strDest = "";
            int intFt;
            char chrAsc;

            if (strSorc.Length == 0)
                strDest = "";

            for (intFt = 0; intFt < strSorc.Length; intFt++)
            {
                chrAsc = strSorc[intFt];
                strDest += (Char)((int)chrAsc ^ ((int)strkey[intFt % strkey.Length]));
            }
            return strDest;
        }

        public static byte[] EncryptByte(byte[] strSorc)
        {
            if (strSorc.Length == 0)
                return null;

            byte[] strDest = new byte[strSorc.Length];
            int intFt;
            byte chrAsc;

            for (intFt = 0; intFt < strSorc.Length; intFt++)
            {
                chrAsc = strSorc[intFt];
                strDest[intFt] = (byte)((int)chrAsc ^ ((int)strkey[intFt % strkey.Length]));
            }

            return strDest;
        }

        public static string Decrypt(string strSorc)
        {
            return Encrypt(strSorc);
        }

        public static byte[] DecryptByte(byte[] strSorc)
        {
            return EncryptByte(strSorc);
        }

        #endregion

    }
}