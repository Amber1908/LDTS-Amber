using System;
using System.Collections.Generic;
using System.Linq;
using System.Web;
using System.Web.UI;
using System.Web.UI.WebControls;
using LDTS.Models;
using LDTS.Service;
using LDTS.Utils;

namespace LDTS
{
    public partial class Processes : System.Web.UI.Page
    {
        protected void Page_Load(object sender, EventArgs e)
        {
            if (!Page.IsPostBack)
            {
                Admin loginAdmin = (Admin)Session["LDTSAdmin"];
                int PID = Convert.ToInt32(Request.QueryString["pid"]);
                int ALID= Convert.ToInt32(Request.QueryString["ALID"]);
                string Pname = ProcessService.GetProceById(PID).Pname;
                download.HRef = "Upload/" + ProcessService.GetProceById(PID).new_filename;
                proName.Text = Pname;
                ProcessName.Text = Pname;
                desc.Text = ProcessService.GetProceById(PID).Description;
                proIndex.Text = ProcessService.GetProceById(PID).Pindex.ToString();
                string ProcessContainerStr = "";
                //跟PID有關的表單qid
                List<int> reProcessQids = Service.RelationService.GetAllReProcesssQuestion().Where(x => x.PID == PID).Select(x => x.QID).ToList();
                List<ReportQuestion> reportQuestions = new List<ReportQuestion>();
                List<ReportQuestion> Allreports = ReportQuestiovService.GetAllReportQuestions();
                foreach (var report in Allreports)
                {
                    foreach (var qid in reProcessQids)
                    {
                        if (report.QID == qid)
                        {
                            reportQuestions.Add(report);
                        }
                    }
                }
                if (PID!=0)
                {
                    //有權限的表單
                    List<ReAdminForm> reAdminForms = Service.RelationService.GetAllreAdminFormByAdminId(loginAdmin.admin_id);
                    List<ReportAnswer> allans = ReportAnswerService.GetAnswers();
                    List<ReportAnswer> reAdminAns = new List<ReportAnswer>();
                    foreach (var item in allans)
                    {
                        for (int i = 0; i < reAdminForms.Count; i++)
                        {
                            if (reAdminForms[i].QID==item.QID)
                            {
                                reAdminAns.Add(item);
                            }
                        }
                    }
                    reAdminAns = reAdminAns.Distinct().ToList();
                    //畫面:程序書 下面有哪些ReportQuestion 全部有關的表單 

                    foreach (var reportQuestion in reportQuestions)
                    {

                        int Conts = ReportAnswerService.GetAnswers().Where(x => x.QID == reportQuestion.QID).Count();

                        ProcessContainerStr += "<div class=\"prossesCard card card-primary\"> ";
                        ProcessContainerStr += "<div class=\"prossesCardHeader card-header\">";
                        ProcessContainerStr += "<h3 class=\"card-title\">";
                        ProcessContainerStr += reportQuestion.Title;
                        ProcessContainerStr += "</h3>";
                        ProcessContainerStr += "<div class=\"card-tools\">";
                        ProcessContainerStr += "<button type=\"button\" class=\"btn btn-tool\" data-card-widget=\"collapse\">";
                        ProcessContainerStr += "<i class=\"fas fa-minus\"></i>";
                        ProcessContainerStr += "</div>";//card-tools
                        ProcessContainerStr += "<span class=\"badge badge-warning float-right ml-1 mr-1 \">";
                        ProcessContainerStr += "目前最新版本 V." + reportQuestion.Version;
                        ProcessContainerStr += "</span>";
                        ProcessContainerStr += "<span class=\"float-right badge bg-danger\">";
                        ProcessContainerStr += Conts;
                        ProcessContainerStr += "</span>";

                        ProcessContainerStr += "</div>";//prossesCardHeader 
                        ProcessContainerStr += "<div class=\"card-body\" style=\"display:block;\">";
                        //找用這個Qid產出的表單有幾個 
                        //顯示異動時間跟人員 用ExtendName搜尋
                        List<ReportAnswer> answers = ReportAnswerService.GetAnswers().Where(x => x.QID == reportQuestion.QID).ToList();
                        bool hasAdd = false;
                        //USER 權限 
                        ProcessContainerStr += "<table class=\"table\">";
                        ProcessContainerStr += "<thead>";
                        ProcessContainerStr += "<tr>";
                        ProcessContainerStr += "<th>自定義名稱</th><th>異動時間</th><th>異動人員</th><th>簽核狀態</th><th>版本號</th><th></th>";
                        ProcessContainerStr += "</tr>";
                        ProcessContainerStr += "</thead>";
                        ProcessContainerStr += "<tbody>";
                        foreach (var ans in answers)
                        {
                            ProcessContainerStr += "<tr>";
                            ProcessContainerStr += "<td>";
                            ProcessContainerStr += ans.ExtendName;
                            ProcessContainerStr += "</td>";
                            ProcessContainerStr += "<td>";
                            ProcessContainerStr += ans.LastupDate;
                            ProcessContainerStr += "</td>";
                            ProcessContainerStr += "<td>";
                            ProcessContainerStr += ans.LastupMan;
                            ProcessContainerStr += "</td>";
                            ProcessContainerStr += "<td>";
                            ProcessContainerStr +=ReportAnswerService.MatchStatus(ans.Status);
                            ProcessContainerStr += "</td>";
                            ProcessContainerStr += "<td>";
                            ProcessContainerStr += ans.Version;
                            ProcessContainerStr += "</td>";
                            ProcessContainerStr += "<td>";
                            ProcessContainerStr += "<a href=\"" + "ReportQuestionEdit.aspx?aid=" + ans.AID + "\">";
                            ProcessContainerStr += reAdminAns.Any(x=>x.AID== ans.AID)?"<i class=\" fas fa-edit\"></i>": "<i class=\"fas fa-eye\"></i>";
                            hasAdd = reAdminAns.Any(x => x.AID == ans.AID);
                            ProcessContainerStr += "</a>";
                            ProcessContainerStr += "</td>";
                            ProcessContainerStr += "</tr>";
                        }
                        ProcessContainerStr += "<tbody>";
                        ProcessContainerStr += "</table>";
                        if (answers.Count==0)
                        {
                            hasAdd = reAdminForms.Any(x => x.QID == reportQuestion.QID);
                        }
                        if (reportQuestion.Status==2)
                        {
                            hasAdd = false;
                        }
                        if (hasAdd)
                        {
                            ProcessContainerStr += "<div class=\"d-flex justify-content-center\">";
                            ProcessContainerStr += "<div class=\"btn mb-3\">";
                            ProcessContainerStr += "<a href=\"";
                            ProcessContainerStr += "ReportQuestionEdit.aspx?qid=";
                            ProcessContainerStr += reportQuestion.QID;
                            ProcessContainerStr += "\" atl=\"新增\" <i class=\"fas fa-plus\"></i>";
                            ProcessContainerStr += "</a>";
                            ProcessContainerStr += "</div>";
                            ProcessContainerStr += "</div>";
                        }
                        ProcessContainerStr += "</div>";//card-body
                        ProcessContainerStr += "</div>";//prossesCard 
                    }
                }
                else if (ALID!=0)
                {
                    //提醒的表單
                    AlertSetting ALItems = AlertService.GetAlert(ALID);
                    string [] qids = ALItems.ALForm.Split(',');
                    List<ReportQuestion> Reports = new List<ReportQuestion>();
                    
                    foreach (var qid in qids)
                    {
                        Reports.Add(ReportQuestiovService.GetReportQuestions(qid));
                    }
                    //跟Uer有關權限的表單
                    //qid
                    List<ReportQuestion> questionsReadables = new List<ReportQuestion>();
                    List<ReAdminForm> reportAnswers = Service.RelationService.GetAllreAdminFormByAdminId(loginAdmin.admin_id).ToList();
                    foreach (var reportAnswer in reportAnswers)
                    {
                        for (int i = 0; i < Reports.Count; i++)
                        {
                            if (Reports[i]!=null)
                            {
                                if (reportAnswer.QID == Reports[i].QID)
                                {
                                    questionsReadables.Add(Reports[i]);
                                }

                            }
                        }
                    }
                    questionsReadables = questionsReadables.Distinct().ToList();
                    foreach (var question in questionsReadables)
                    {
                        List<ReportAnswer> answers = ReportAnswerService.GetAnswers().Where(X => X.QID == question.QID).ToList();
                        int Conts= answers.Count();
                        ProcessContainerStr += "<div class=\"prossesCard card card-primary\"> ";
                        ProcessContainerStr += "<div class=\"prossesCardHeader card-header\">";
                        ProcessContainerStr += "<h3 class=\"card-title\">";
                        ProcessContainerStr += question.Title;
                        ProcessContainerStr += "</h3>";
                        ProcessContainerStr += "<div class=\"card-tools\">";
                        ProcessContainerStr += "<button type=\"button\" class=\"btn btn-tool\" data-card-widget=\"collapse\">";
                        ProcessContainerStr += "<i class=\"fas fa-minus\"></i>";
                        ProcessContainerStr += "</div>";//card-tools
                        ProcessContainerStr += "<span class=\"badge badge-warning float-right ml-1 mr-1 \">";
                        ProcessContainerStr += "目前最新版本 V." + question.Version;
                        ProcessContainerStr += "</span>";
                        ProcessContainerStr += "<span class=\"float-right badge bg-danger\">";
                        ProcessContainerStr += Conts;
                        ProcessContainerStr += "</span>";

                        ProcessContainerStr += "</div>";//prossesCardHeader 
                        ProcessContainerStr += "<div class=\"card-body\" style=\"display:block;\">";
                        ProcessContainerStr += "<table class=\"table\">";
                        ProcessContainerStr += "<thead>";
                        ProcessContainerStr += "<tr>";
                        ProcessContainerStr += "<th>自定義名稱</th><th>異動時間</th><th>異動人員</th><th>簽核狀態</th><th>版本號</th><th></th>";
                        ProcessContainerStr += "</tr>";
                        ProcessContainerStr += "</thead>";
                        ProcessContainerStr += "<tbody>";
                        foreach (var answer in answers)
                        {
                            ProcessContainerStr += "<tr>";
                            ProcessContainerStr += "<td>";
                            ProcessContainerStr += answer.ExtendName;
                            ProcessContainerStr += "</td>";
                            ProcessContainerStr += "<td>";
                            ProcessContainerStr += answer.LastupDate;
                            ProcessContainerStr += "</td>";
                            ProcessContainerStr += "<td>";
                            ProcessContainerStr += answer.LastupMan;
                            ProcessContainerStr += "</td>";
                            ProcessContainerStr += "<td>";
                            ProcessContainerStr +=ReportAnswerService.MatchStatus(answer.Status);
                            ProcessContainerStr += "</td>";
                            ProcessContainerStr += "<td>";
                            ProcessContainerStr += answer.Version;
                            ProcessContainerStr += "</td>";
                            ProcessContainerStr += "<td>";
                            ProcessContainerStr += "<a href=\"" + "ReportQuestionEdit.aspx?aid=" + answer.AID + "\">";
                            ProcessContainerStr += "<i class=\" fas fa-edit\"></i>";
                            ProcessContainerStr += "</a>";
                            ProcessContainerStr += "</td>";
                            ProcessContainerStr += "</tr>";

                        }
                        ProcessContainerStr += "<tbody>";
                        ProcessContainerStr += "</table>";
                        ProcessContainerStr += "<div class=\"d-flex justify-content-center\">";
                        ProcessContainerStr += "<div class=\"btn mb-3\">";
                        ProcessContainerStr += "<a href=\"";
                        ProcessContainerStr += "ReportQuestionEdit.aspx?qid=";
                        ProcessContainerStr += question.QID;
                        ProcessContainerStr += "\" atl=\"新增\" <i class=\"fas fa-plus\"></i>";
                        ProcessContainerStr += "</a>";
                        ProcessContainerStr += "</div>";
                        ProcessContainerStr += "</div>";
                        ProcessContainerStr += "</div>";//card-body
                        ProcessContainerStr += "</div>";//prossesCard 

                    }
                    title.InnerText = "表單列表";
                    ProcessContainer.Attributes.Remove("class");
                    ProcessContainer.Attributes.Add("class", "col-12");
                    processesInf.Style.Add("display","none");

                }

                ProcessContainer.InnerHtml = ProcessContainerStr;

            }

        }

        protected void SaveButton_Click(object sender, EventArgs e)
        { //修改
            string id = Request.QueryString["pid"];
            Process process = ProcessService.GetProceById(Convert.ToInt32(id));
            process.Pname = proName.Text;
            process.Pindex =Convert.ToInt32( proIndex.Text);
            process.Description = desc.Text;
            if (ProcessService.UpdateProcess(process))
            {
                Admin loginAdmin = (Admin)Session["LDTSAdmin"];
                string work = "編輯程序書:" + process.Pname;
                LDTSservice.InsertRecord(loginAdmin, work);

                Literal AlertMsg = new Literal();
                AlertMsg.Text = "<script language='javascript'>alert('編輯成功!');</script>";
                this.Page.Controls.Add(AlertMsg);
            }
            else
            {
                Literal AlertMsg = new Literal();
                AlertMsg.Text = "<script language='javascript'>alert('編輯失敗!');</script>";
                this.Page.Controls.Add(AlertMsg);
            }
        }

        protected void uploadfile_Click(object sender, EventArgs e)
        {
            Literal AlertMsg = new Literal();
            Admin admin = (Admin)Session["LDTSAdmin"];


            int pid = Convert.ToInt32(Request.QueryString["pid"]);
            Process process = ProcessService.GetAllProcesses().Where(x => x.PID == pid).FirstOrDefault();

            // Update 檔案而已
            if (process != null)
            {
                Process UpdateProcess = new Process();
                UpdateProcess.old_filename = process.old_filename;
                UpdateProcess.new_filename = process.new_filename;
                UpdateProcess.PID = process.PID;
                UpdateProcess.CreateDate = process.CreateDate;
                UpdateProcess.CreateMan = process.CreateMan;
                UpdateProcess.Description = process.Description;
                UpdateProcess.Pindex = process.Pindex;
                UpdateProcess.Pname = process.Pname;
                //Update
                //抓檔案
                //檔案格式
                if (processesUpload.HasFile)
                {
                    string serverPath = Server.MapPath("~/Upload/");
                    string fileName = processesUpload.FileName;
                    string fileType = System.IO.Path.GetExtension(fileName);
                    if (fileType.Contains(".docx") || fileType.Contains(".doc") || fileType.Contains(".pdf"))
                    {
                        UpdateProcess.old_filename = fileName;
                        string now = DateTime.Now.ToString("yyyyMdHmm");
                        UpdateProcess.new_filename = now + "_" + fileName;
                        serverPath = serverPath + UpdateProcess.new_filename;
                        processesUpload.SaveAs(serverPath);
                    }
                    else
                    {
                        AlertMsg.Text = "<script language='javascript'>alert( '檔案格式錯誤!請上傳doc檔、docx檔或pdf檔。');</script>";
                        this.Page.Controls.Add(AlertMsg);
                        return;
                    }
                }

                //程序書基本資料

                bool isUpdate = ProcessService.UpdateProcess(UpdateProcess);
                if (!isUpdate)
                {
                    AlertMsg.Text = "<script language='javascript'>alert('更換程序書檔案失敗!');</script>";
                    this.Page.Controls.Add(AlertMsg);
                    return;
                }
                LDTSservice.InsertRecord(admin, "更換程序書檔案:" + proName.Text);
                AlertMsg.Text = "<script language='javascript'>alert('更換程序書檔案成功!');</script>";
                this.Page.Controls.Add(AlertMsg);
            }

        }
    }
}