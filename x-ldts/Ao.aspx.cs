using System;
using System.Collections.Generic;
using System.Linq;
using System.Web;
using System.Web.UI;
using System.Web.UI.WebControls;
using LDTS.Models;
using LDTS.Service;
using LDTS.Utils;
using Newtonsoft.Json;

namespace LDTS
{
    public partial class Ao : System.Web.UI.Page
    {
        protected void Page_Load(object sender, EventArgs e)
        {
            Admin loginAdmin = (Admin)Session["LDTSAdmin"];
            if (loginAdmin == null)
            {
                Response.Redirect("Login.aspx");
            }

            //全部的程序書
            List<Process> processes = ProcessService.GetAllProcesses();
            //全部跟程序書有關的標準書
            List<ReProcessStandardWorkBook> reProcessStandards = Service.RelationService.GetAllReProcessStandardWorkBooks();
            //全部跟程序書有關的表單
            List<ReProcessQuestion> reProcessForms = Service.RelationService.GetAllReProcesssQuestion();
            //組完的Json
            List<AoViewJson> aoViewJsons = new List<AoViewJson>();//組完全部
                                                                  //全部的標準書
            List<StandardWorkBook> SWBs = StandarWorkBookService.GetAllStandarwookbooks();
            //全部跟標準書有關的表單
            List<ReStandarWorkBookForm> reStandarWorkBookForms = Service.RelationService.GetAllreSWorkBookForm();
            //Admin有關的程序書
            List<ReAdminProcess> reAdminProcesses = AoService.GetReAdminProcesses();
            //Admin有關的表單
            List<ReAdminForm> reAdminForms = AoService.GetReAdminForms();
            //全部的表單
            List<ReportQuestion> reports = ReportQuestiovService.GetAllReportQuestions();
            //先看是誰的Admin 
            string admin = Request.QueryString["id"];
            if (admin == null)
            {
                foreach (var processe in processes)//全部的程序書
                {
                    List<ChildrenSBW> childrenSBWs = new List<ChildrenSBW>();
                    List<ChildForm> reProforms = new List<ChildForm>();
                    List<int> sids = reProcessStandards.Where(x => x.PID == processe.PID).Select(x => x.SID).ToList();
                    List<int> pfids = reProcessForms.Where(x => x.PID == processe.PID).Select(x => x.QID).ToList();

                    foreach (var pfid in pfids)
                    {

                        reProforms.Add(new ChildForm()
                        {
                            status = 0,
                            form = reports.Where(x => x.QID == pfid).FirstOrDefault()
                        });
                    }
                    foreach (var sid in sids)//有關聯的標準書
                    {
                        List<int> fids = reStandarWorkBookForms.Where(x => x.SID == sid).Select(x => x.QID).ToList();
                        List<ChildForm> reSWBforms = new List<ChildForm>();
                        foreach (var fid in fids)
                        {
                            reSWBforms.Add(new ChildForm()
                            {
                                status = 0,
                                form = reports.Where(x => x.QID == fid).FirstOrDefault(),
                            }); ;
                        }
                        childrenSBWs.Add(new ChildrenSBW()
                        {
                            SID = sid,
                            Sname = SWBs.Where(x => x.SID == sid).Select(x => x.Sname).First(),
                            ChildrenSWBforms = reSWBforms
                            //有關的表單
                        });
                    }
                    aoViewJsons.Add(new AoViewJson()
                    {
                        PID = processe.PID,
                        Pname = processe.Pname,
                        ChildrenSwbs = childrenSBWs,
                        ChildrenForms = reProforms
                    });
                }
                string strJson = JsonConvert.SerializeObject(aoViewJsons);
                jsonDefult.Text = strJson;

            }
            else
            {
                //找有關 Admin 有權限的表單
                List<ReAdminForm> reAdmins = AoService.GetReAdminForms().Where(x => x.admin_id == admin).ToList();

                foreach (var processe in processes)//全部的程序書
                {
                    List<ChildrenSBW> childrenSBWs = new List<ChildrenSBW>();
                    List<ChildForm> reProforms = new List<ChildForm>();
                    List<int> sids = reProcessStandards.Where(x => x.PID == processe.PID).Select(x => x.SID).ToList();
                    List<int> pfids = reProcessForms.Where(x => x.PID == processe.PID).Select(x => x.QID).ToList();

                    foreach (var pfid in pfids)
                    {
                        int stauts = 0;
                        foreach (var reAdmin_form in reAdmins)
                        {
                            if (reAdmin_form.QID == pfid)
                            {
                                stauts = reAdmin_form.status;
                            }
                        }
                        reProforms.Add(new ChildForm()
                        {
                            status = stauts,
                            form = reports.Where(x => x.QID == pfid).FirstOrDefault()
                        });

                    }
                    foreach (var sid in sids)//有關聯的標準書
                    {
                        List<int> fids = reStandarWorkBookForms.Where(x => x.SID == sid).Select(x => x.QID).ToList();
                        List<ChildForm> reSWBforms = new List<ChildForm>();

                        foreach (var fid in fids)
                        {
                            int Status = 0;
                            foreach (var reAdmin_form in reAdmins)
                            {
                                if (reAdmin_form.QID == fid)
                                {
                                    Status = reAdmin_form.status;
                                }

                            }
                            reSWBforms.Add(new ChildForm()
                            {
                                status = Status,
                                form = reports.Where(x => x.QID == fid).FirstOrDefault(),
                            }); ;

                        }
                        childrenSBWs.Add(new ChildrenSBW()
                        {
                            SID = sid,
                            Sname = SWBs.Where(x => x.SID == sid).Select(x => x.Sname).First(),
                            ChildrenSWBforms = reSWBforms
                            //有關的表單
                        });
                    }
                    aoViewJsons.Add(new AoViewJson()
                    {
                        admin_id = admin,
                        PID = processe.PID,
                        Pname = processe.Pname,
                        ChildrenSwbs = childrenSBWs,
                        ChildrenForms = reProforms
                    });

                }
                string strJson = JsonConvert.SerializeObject(aoViewJsons);
                jsonDefult.Text = strJson;
            };
        }
    }
}