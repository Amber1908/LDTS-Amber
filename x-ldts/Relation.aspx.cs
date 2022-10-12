using System;
using System.Collections.Generic;
using System.IO;
using System.Linq;
using System.Runtime.Serialization.Json;
using System.Text;
using System.Web;
using System.Web.UI;
using System.Web.UI.WebControls;
using LDTS.Models;
using LDTS.Service;
using LDTS.Utils;

namespace LDTS
{
    public partial class Relation : System.Web.UI.Page
    {
        protected void Page_Load(object sender, EventArgs e)
        {
            Admin loginAdmin = (Admin)Session["LDTSAdmin"];
            if (loginAdmin == null)
            {
                Response.Redirect("Login.aspx");
            }

            if (Request.RawUrl.Contains("pid"))
            {
                //把 ReProcessForm中關聯的表格撈出並序列化 
                int PID = Convert.ToInt32(Request.QueryString["pid"]);
                List<ReProcessQuestion> reProcessForms = new List<ReProcessQuestion>();
                reProcessForms = Service.RelationService.GetAllReProcesssQuestion().Where(x => x.PID == PID).OrderBy(X => X.QID).ToList();
                List<ReProcessStandardWorkBook> reProcessStandardWorkBooks = new List<ReProcessStandardWorkBook>();
                reProcessStandardWorkBooks = Service.RelationService.GetAllReProcessStandardWorkBooks().Where(x => x.PID == PID).OrderBy(x => x.SID).ToList();
                DataContractJsonSerializer rePSWBJson = new DataContractJsonSerializer(reProcessStandardWorkBooks.GetType());
                DataContractJsonSerializer json = new DataContractJsonSerializer(reProcessForms.GetType());
                string rePFJson = "";
                string rePSWBJsonStr = "";
                //序列化 
                using (MemoryStream stream = new MemoryStream())
                {
                    json.WriteObject(stream, reProcessForms);
                    rePFJson = Encoding.UTF8.GetString(stream.ToArray());
                }
                using (MemoryStream stream = new MemoryStream())
                {
                    rePSWBJson.WriteObject(stream, reProcessStandardWorkBooks);
                    rePSWBJsonStr = Encoding.UTF8.GetString(stream.ToArray());
                }
                AllReProcessForms.Text = rePFJson;
                AllReProSwb.Text = rePSWBJsonStr;
            }
            if (Request.RawUrl.Contains("sid"))
            {
                int SID = Convert.ToInt32(Request.QueryString["sid"]);
                List<ReStandarWorkBookForm> reStandarWorkBookForms = new List<ReStandarWorkBookForm>();
                reStandarWorkBookForms = Service.RelationService.GetAllreSWorkBookForm().Where(x => x.SID == SID).OrderBy(X => X.QID).ToList();
                DataContractJsonSerializer SJSON = new DataContractJsonSerializer(reStandarWorkBookForms.GetType());
                string SJSONstr = "";
                using (MemoryStream stream = new MemoryStream())
                {
                    SJSON.WriteObject(stream, reStandarWorkBookForms);
                    SJSONstr = Encoding.UTF8.GetString(stream.ToArray());
                }
                AllReSwbF.Text = SJSONstr;
            }
            path.InnerText = "";
            pathDetail.InnerText = "";
            int pid = Convert.ToInt32(Request.QueryString["pid"]);
            int sid = Convert.ToInt32(Request.QueryString["sid"]);
            if (Request.RawUrl.Contains("pid"))
            {
                path.InnerText += "程序書-";
                string Pname = ProcessService.GetProceById(pid).Pname;
                pathDetail.InnerText += Pname;
                processID.Value = pid.ToString();
            }
            else if (Request.RawUrl.Contains("sid"))
            {
                path.InnerText += "標準作業書-";
                string Sname = StandarWorkBookService.GetAllStandarwookbooks().Where(X => X.SID == sid).Select(x => x.Sname).FirstOrDefault();
                pathDetail.InnerText += Sname;
                sworkbookID.Value = sid.ToString();
            }

            List<Process> processes = ProcessService.GetAllProcesses();
            string Processstring = "";
            foreach (var process in processes)
            {
                Processstring += "<div class=\"card card-outline card-primary\">";//card-outline
                Processstring += "<div class=\"card-header\"style=\"height: 29px\"> ";
                Processstring += "<span class=\"d-flex justify-content-end\">";
                Processstring += "<a style=\"text-decoration:none; position: absolute \" href=\"";//
                Processstring += "ProcessEdit?pid="+ process.PID+"\">";
                Processstring += "<i style=\"position: relative; top: -5px;right:20px\" class=\"fas fa-edit\"></i>";
                Processstring += "</a>";
                Processstring += "<a  style=\"text-decoration:none; position: absolute \" class=\"ml-1\" onClick=\"return confirm('確定刪除程序書?')\"; href =\"";
                Processstring += "DeleteRelation.aspx?pid="+process.PID;//刪除
                Processstring += "\"style=\"text-decoration:none\">";
                Processstring += string.Format("<i style=\"position: relative; top: -5px;\" class=\"fas fa-trash {0}\"></i></a>", process.PID == pid ? "Active" : " ");
                Processstring += "</span>";
                Processstring += "</div>";//card-header
                Processstring += "<div class=\"card-body\">";//card-body
                Processstring += "<h6  class=\"card-title\">";
                Processstring += "<a href=\"";
                Processstring += "Relation.aspx?pid=" + process.PID;
                Processstring += string.Format("\"style=\"font-size:14px; color:gray; text-decoration:none\"class=\"relaHover {0}\">", process.PID == pid ? "Active" : " ");
                Processstring += process.Pname;
                Processstring += "</a>";
                Processstring += "</h6>";
                Processstring += "</div>";//card-body
                Processstring += "</div>";//card-outline
            }
            proFormList.InnerHtml = Processstring;
            //標準作業書
            List<StandardWorkBook> standarWorkBooks = StandarWorkBookService.GetAllStandarwookbooks();
            string Sstr = "";
            //一組 標準作業書
            foreach (var standarWorkBook in standarWorkBooks)
            {
                Sstr += "<div class=\"card card-outline card-primary\">";//card-outline
                Sstr += "<div class=\"card-header\"style=\"height: 29px\"> ";
                Sstr += "<span class=\"d-flex justify-content-end\">";
                Sstr += "<a style=\"text-decoration:none; position: absolute \" href=\"";//
                Sstr += "StandarWorkbookEdit?sid=" + standarWorkBook.SID + "\">";
                Sstr += "<i style=\"position: relative; top: -5px; right: 20px\" class=\"fas fa-edit\"></i>";
                Sstr += "</a>";
                Sstr += "<a style=\"text-decoration:none; position: absolute \" class=\"ml-1\" onClick=\"return confirm('確定刪除標準作業書?')\" href=\"";
                Sstr += "DeleteRelation.aspx?sid=";//standarWorkBook delete 
                Sstr += standarWorkBook.SID;
                Sstr += "\"style=\"text-decoration:none\">";
                Sstr += string.Format("<i style=\"position: relative; top: -5px;\" class=\"fas fa-trash {0}\"></i></a>", standarWorkBook.SID == sid ? "Active" : " ");
                Sstr += "</span>";
                Sstr += "</div>";//card-header
                Sstr += "<div class=\"card-body\">";//card-body
                Sstr += "<h6 class=\"card-title\">";
                Sstr += "<input type=\"checkbox\" class=\"mr-1 swbook\" id=\"";
                Sstr += "swbook" + standarWorkBook.SID + "\"";
                Sstr += "value=\"" + standarWorkBook.SID + "\"";
                Sstr += ">";
                Sstr += "<a href=\"";
                Sstr += "Relation.aspx?sid=" + standarWorkBook.SID;
                Sstr += string.Format("\"style=\"font-size:14px; color:gray; text-decoration:none\"class=\"relaHover {0}\">", standarWorkBook.SID == sid ? "Active" : " ");
                Sstr += standarWorkBook.Sname;
                Sstr += "</a>";
                Sstr += "</h6>";
                Sstr += "</div>";//card-body
                Sstr += "</div>";//card-outline
            }
            swbFormList.InnerHtml = Sstr;
            //表單
            string Fstr = "";
            List<ReportQuestion> reportQuestions = ReportQuestiovService.GetAllReportQuestions();
            //一組 表單
            foreach (var reportQuestion in reportQuestions)
            {
                int aids = ReportAnswerService.GetAnswers().Where(x=>x.QID== reportQuestion.QID).Select(x=>x.AID).ToList().Count();

                Fstr += "<div class=\"card card-outline card-primary\">";//card-outline
                Fstr += "<div class=\"card-header\"style=\"height: 29px\"> ";
                Fstr += "<span class=\"d-flex justify-content-end\">";
                Fstr += "<a  style=\"text-decoration:none; position: absolute \" href=\"";//
                Fstr += "FormGeneration?QID=" + reportQuestion.QID + "\">";
                Fstr += "<i style=\"position: relative; top: -5px; right: 20px\" class=\"fas fa-edit\"></i>";
                Fstr += "</a>";
                Fstr += "<a onClick=\"return confirm('確定刪除表單範本?')\" style=\"text-decoration:none; position: absolute \" class=\"ml-1\" href=\"";
                Fstr += "DeleteRelation.aspx?qid="+ reportQuestion.QID;// delete 
                Fstr += aids > 0 ? "</a>" : "\"style=\" text-decoration:none\">";
                Fstr +="<i style=\"position: relative; top: -5px\" class=\"fas fa-trash \"></i></a>";
                Fstr += "</span>";
                Fstr += "</div>";//card-header
                Fstr += "<div class=\"card-body\">";//card-body
                Fstr += "<h6 class=\"card-title\">";
                Fstr += "<input type=\"checkbox\" class=\"mr-1 report\" id=\"";
                Fstr += "repoert" + reportQuestion.QID + "\"";
                Fstr += "value=\""+ reportQuestion.QID+"\"";
                Fstr += ">";
                Fstr += "<a style=\"font-size:14px; color:gray; text-decoration:none\"class=\"relaHover\" href=\"";
                Fstr += "#\">";
                Fstr += reportQuestion.Title;
                Fstr += "</a>";
                Fstr += "</h6>";
                Fstr += "</div>";//card-body
                Fstr += "</div>";//card-outline
            }
            formList.InnerHtml = Fstr;
        }
    }
}