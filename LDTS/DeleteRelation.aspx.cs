using System;
using System.Collections.Generic;
using System.Linq;
using System.Web;
using System.Web.UI;
using System.Web.UI.WebControls;
using LDTS.Models;
using LDTS.Service;


namespace LDTS
{
    public partial class DeleteRelation : System.Web.UI.Page
    {
        protected void Page_Load(object sender, EventArgs e)
        {
            Literal AlertMsg = new Literal();
            Admin admin = (Admin)Session["LDTSAdmin"];
            string url = Request.RawUrl.Substring(16,3);
            int id;
            switch (url)
            {
                case "pid":
                    id = Convert.ToInt32(Request.QueryString["pid"]);
                    String process = ProcessService.GetProceById(id).Pname;
                    if (!ProcessService.DeleteProcessById(id))//刪除程序書本人
                    {
                        Session["MsgResult"] = "err1刪除程序書" + process + "失敗";
                    }
                    if (Service.RelationService.GetAllReProcesssQuestion().Where(x=>x.PID==id).FirstOrDefault()!=null)
                    {
                        if (!Service.RelationService.DeleteReProcessFormByID(id))//刪除程序書有關的表單
                        {
                            Session["MsgResult"] = "err2刪除程序書" + process + "失敗";
                        }
                    }
                    if (Service.RelationService.GetAllReProcessStandardWorkBooks().Where(x => x.PID == id).FirstOrDefault() != null)
                    {
                        if (!Service.RelationService.DeleteReProcessStandardWorkBookByPID(id))//刪除程序書有關的標準書
                        {
                            Session["MsgResult"] = "err3刪除程序書" + process + "失敗";
                            Response.Redirect("Relation.aspx");
                            return;
                        }
                    }

                    LDTSservice.InsertRecord(admin, "刪除程序書:" + process);
                    Session["MsgResult"] = "已刪除程序書" + process;
                    Response.Redirect("Relation.aspx");
                        break;
                case "sid":
                   
                    id = Convert.ToInt32(Request.QueryString["sid"]);
                    String SWB = StandarWorkBookService.GetAllStandarwookbooks().Where(x => x.SID == id).Select(x => x.Sname).FirstOrDefault();
                    List<int> processIdS = Service.RelationService.GetAllReProcessStandardWorkBooks().Where(x => x.SID == id).Select(x=>x.PID).ToList();
                    bool isDelete = false;
                    foreach (var pid in processIdS)//刪除標準作業書有關的process
                    {
                        isDelete = Service.RelationService.DeleteReProcessStandardWorkBookByPID(pid);
                    }
                    if (Service.RelationService.GetAllreSWorkBookForm().Where(x=>x.SID==id).FirstOrDefault()!=null)//刪有關的表單
                    {
                        Service.RelationService.DeleteReStandarWorkBookFormByID(id);
                    }
                    if (!StandarWorkBookService.DeleteStandarwookBookById(id)||!isDelete)//刪標準書本人
                    {
                        Session["MsgResult"] = "刪除標準作業書" + SWB + "失敗";
                        Response.Redirect("Relation.aspx");
                        return;
                    }
                    LDTSservice.InsertRecord(admin, "刪除程序書:" + SWB);
                    Session["MsgResult"] = "刪除標準作業書" + SWB + "成功";
                    Response.Redirect("Relation.aspx");
                    break;
                default:
                    break;
                case "qid":
                    //還要刪除上面的關聯設定 
                    id = Convert.ToInt32(Request.QueryString["qid"]);
                    List<int> reProcesses = Service.RelationService.GetAllReProcesssQuestion().Where(x => x.QID == id).Select(x=>x.PID).ToList();
                    List<int> reSwb = Service.RelationService.GetAllreSWorkBookForm().Where(x => x.QID == id).Select(x => x.SID).ToList();
                    ReportQuestion answer =ReportQuestiovService.GetReportQuestions(Request.QueryString["qid"]);
                    bool hasSwb = reSwb.Count > 0 ? true : false;
                    bool hasPro= reProcesses.Count > 0 ? true : false;
                    bool flag = false;
                    if (hasSwb)
                    {
                        flag =Service.RelationService.DeleteReStandardWorkBookFormByQid(id);
                    }
                    if (hasPro)
                    {
                        flag = Service.RelationService.DeleteReProcessQuestionByQID(id);
                    }
                    if (ReportQuestiovService.DeleteReportQuestionById(id)&& flag)
                    {
                        LDTSservice.InsertRecord(admin, "刪除表單範本:" + answer.Title);
                        Session["MsgResult"] = "刪除表單單範本" + answer.Title + "成功";
                        AlertMsg.Text = "<script language='javascript'>alert('刪除表單範本成功!!');location.href='Default.aspx';</script>";
                        this.Page.Controls.Add(AlertMsg);
                        Response.Redirect("Relation.aspx");
                    }
                    else
                    {
                        Session["MsgResult"] = "刪除標準作業書" + answer.Title + "失敗";
                        Response.Redirect("Relation.aspx");
                    }
                    
                    break;
            }
        }
    }
}