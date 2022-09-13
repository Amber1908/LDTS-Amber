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
    public partial class LDTS : System.Web.UI.MasterPage
    {
        protected void Page_Load(object sender, EventArgs e)
        {
            //檢查session
            if (Session["LDTSAdmin"] == null)
            {
                Response.Redirect("Login.aspx");
            }
            //單位名稱
            UnitBasedata unitBasedata = UnitService.GetUnit();
            if (unitBasedata != null)
            {
                UnitName.Text = unitBasedata.UnitName;
                LogoIcon.Src = "ShowAdminImg.aspx?id=" + unitBasedata.UnitIcon;
            }
            Admin loginAdmin = (Admin)Session["LDTSAdmin"];
            adminMug.Src = "ShowAdminImg.aspx?id=" + loginAdmin.admin_image;
            adminName.Text = loginAdmin.admin_name;
            if (!loginAdmin.admin_ao.Contains("form"))
            {
                
            }
            if (!IsPostBack)
            {
                string sidebarMenuString = "";

                if (Request.RawUrl.Contains("PersonnelManagement") || Request.RawUrl.Contains("PersonEdit"))//人員清單
                {
                    List<Admin> adminsNamesIds = PersonnelManagementService.GetAllLazyAdmin();
                    foreach (var admin in adminsNamesIds)
                    {
                        sidebarMenuString += "<ul class=\"nav nav-pills nav-sidebar flex-column\" data-widget=\"treeview\" role=\"menu\" data-accordion=\"false\">";
                        sidebarMenuString += string.Format ("<li class=\"nav-item user-panel d-flex pl-3 pb-3 mt-2 {0} \">",Request.RawUrl.Contains(admin.admin_id)? "menu-open" : "");
                        
                        sidebarMenuString += "<img class=\"elevation-2 \" src=\"";
                        sidebarMenuString += "ShowAdminImg.aspx?id="+ admin.admin_image;
                        sidebarMenuString += "\">";
                        sidebarMenuString += "<a class=\"nav-link\" href=\"PersonEdit?id=";
                        sidebarMenuString += admin.admin_id + "\">";//
                        sidebarMenuString += "<p>";
                        sidebarMenuString += admin.admin_name;//
                        sidebarMenuString += "</p>";
                        sidebarMenuString += "</a>";
                        sidebarMenuString += "</li>";
                        sidebarMenuString += "</ul>";
                    }
                }
                else if (Request.RawUrl.Contains("Ao"))
                {
                    List<Admin> adminsNamesIds = PersonnelManagementService.GetAllLazyAdmin();
                    foreach (var admin in adminsNamesIds)
                    {
                        sidebarMenuString += "<ul class=\"nav nav-pills nav-sidebar flex-column\" data-widget=\"treeview\" role=\"menu\" data-accordion=\"false\">";
                        //sidebarMenuString += "<li class=\"nav-item user-panel d-flex pl-3 pb-3 mt-2\">";
                        sidebarMenuString += string.Format("<li class=\"nav-item user-panel d-flex pl-3 pb-3 mt-2 {0} \">", Request.RawUrl.Contains(admin.admin_id) ? "menu-open" : "");
                        sidebarMenuString += "<img class=\"elevation-2 \" src=\"";
                        sidebarMenuString += "ShowAdminImg.aspx?id=" + admin.admin_image;
                        sidebarMenuString += "\">";
                        sidebarMenuString += "<a class=\"nav-link\" href=\"Ao?id=";
                        sidebarMenuString += admin.admin_id + "\">";//
                        sidebarMenuString += "<p>";
                        sidebarMenuString += admin.admin_name;//
                        sidebarMenuString += "</p>";
                        sidebarMenuString += "</a>";
                        sidebarMenuString += "</li>";
                        sidebarMenuString += "</ul>";
                    }

                }
                else if (Request.RawUrl.Contains("RestPassWord") || Request.RawUrl.Contains("Unit") || Request.RawUrl.Contains("Relation")|| Request.RawUrl.Contains("AdminWorkRecord")||Request.RawUrl.Contains("account"))
                {
                    SidebarMenu.Visible = false;
                }
                else
                {
                    List<Process> processes = ProcessService.GetAllProcesses().OrderBy(x=>x.Pindex).ToList();
                    sidebarMenuString += "<ul class=\"nav nav-pills nav-sidebar flex-column\" data-widget=\"treeview\" role=\"menu\" data-accordion=\"false\">";
                    //程序書
                    foreach (var process in processes)
                    {
                        sidebarMenuString += "<li class=\"nav-item\">";

                        sidebarMenuString += "<a class=\"nav-link nav-LinkLDTS\" href=\"Process.aspx?pid=";
                        sidebarMenuString += process.PID + "\">";//要換 連到程序書網址
                        sidebarMenuString += "<i class=\" nav-icon fas fa-book\"></i>";
                        sidebarMenuString += "<p>";
                        sidebarMenuString += process.Pname;//要換程序書名稱
                        sidebarMenuString += " <i class=\"rightLDTS right fas fa-angle-left\"></i>";
                        sidebarMenuString += "</p>";
                        sidebarMenuString += "</a>";
                        List<StandardWorkBook> standardWorks = StandarWorkBookService.GetAllStandarwookbooks();
                        List<int> RePreSids = Service.RelationService.GetAllReProcessStandardWorkBooks().Where(x => x.PID == process.PID).Select(x => x.SID).ToList();
                        List<StandardWorkBook> standardWorkBooks = new List<StandardWorkBook>();
                        foreach (var Sid in RePreSids)
                        {
                            standardWorkBooks.Add(standardWorks.Where(x => x.SID == Sid).FirstOrDefault());
                        }
                        sidebarMenuString += "<ul class=\"nav nav-treeview  pl-2\">";//程序書標頭
                        sidebarMenuString += "<li class=\"nav-item pl-1\">";
                        sidebarMenuString += "<a class=\"nav-link nav-LinkLDTS\" href=\"Process.aspx?pid=";
                        sidebarMenuString += process.PID + "\">";//要換標準書網址
                        sidebarMenuString += "<i class=\"fal fa-book-open fas nav-icon\"></i>";
                        sidebarMenuString += "<p>";
                        sidebarMenuString += process.Pname;//要換
                        sidebarMenuString += "</p>";
                        sidebarMenuString += "</a>";
                        sidebarMenuString += "</li>";
                        sidebarMenuString += "</ul>";//標準書
                        standardWorkBooks = standardWorkBooks.OrderBy(x => x.Sindex).ToList();
                        foreach (var Book in standardWorkBooks)
                        {
                            sidebarMenuString += "<ul class=\"nav nav-treeview pl-3 pr-1\">";//標準書
                            sidebarMenuString += "<li class=\"nav-item \">";
                            sidebarMenuString += "<a class=\"nav-link nav-LinkLDTS\" href=\"StandarWorkbook.aspx?sid=";
                            sidebarMenuString += Book.SID + "\">";//要換標準書網址
                            sidebarMenuString += "<i class=\"far fa-circle nav-icon\"></i>";
                            sidebarMenuString += "<p>";
                            sidebarMenuString += Book.Sname;//要換
                            sidebarMenuString += "</p>";
                            sidebarMenuString += "</a>";
                            sidebarMenuString += "</li>";
                            sidebarMenuString += "</ul>";//標準書
                        }
                    }
                    //程序書
                    sidebarMenuString += "</li>";
                    sidebarMenuString += "</ul>";

                }
                SidebarMenu.InnerHtml = sidebarMenuString;
            }

        }
    }
}