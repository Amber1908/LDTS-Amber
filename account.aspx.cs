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
    public partial class account : System.Web.UI.Page
    {
        protected void Page_Load(object sender, EventArgs e)
        {
            Admin adminMyself = (Admin)Session["LDTSADMIN"];
            if (!Page.IsPostBack)
            {
                Admin admin = PersonnelManagementService.GetAdminById(adminMyself.admin_id);
                adminIDTextBox1.Text = admin.admin_id;
                adminIDTextBox1.Enabled = false;
                NameTextBox1.Text = admin.admin_name;
                PhoneTextBox1.Text = admin.admin_phone;
                EmailTextBox2.Text = admin.admin_email;
                //權限
                if (admin.admin_ao.Contains("admin") && admin.admin_ao.Contains("form"))
                {
                    personnalManagement.Enabled = false;
                    personnalManagement.Checked = true;
                    formManagement.Checked = true;
                    formManagement.Enabled = false;
                }
                else if (admin.admin_ao.Contains("admin"))
                {
                    personnalManagement.Enabled = false;
                    formManagement.Enabled = false;
                    personnalManagement.Checked = true;
                }
                else if (admin.admin_ao.Contains("form"))
                {
                    formManagement.Checked = true;
                    formManagement.Enabled = false;
                    personnalManagement.Enabled = false;
                }
                //大頭照
                Images mug = LDTSservice.GetImageById(admin.admin_image);
                Mug.ImageUrl = "ShowAdminImg.aspx?id=" + mug.image_id;
                ImageMug.ImageUrl = "ShowAdminImg.aspx?id=" + mug.image_id;
            }

        }

        protected void SaveButton_Click(object sender, EventArgs e)
        {
            if (passWords.Text ==string.Empty)
            {
                //msgLiteral.Text = "請輸入密碼";
                return;
            }
            Admin adminMyself = (Admin)Session["LDTSADMIN"];
            Admin admin = new Admin()
            {
                admin_id = adminMyself.admin_id,//不能改id
                admin_name = NameTextBox1.Text,
                admin_phone = PhoneTextBox1.Text,
                admin_email = EmailTextBox2.Text,
                admin_ao = adminMyself.admin_ao,//不能改權限
                status = adminMyself.status,//不能改狀態
                admin_image= adminMyself.admin_image,
                memo = adminMyself.memo,//不能編輯備註
            };
            if (FileUpload.HasFile)
            {
                string fileName = FileUpload.FileName;
                String filetype = System.IO.Path.GetExtension(fileName);
                if (filetype.Contains(".jpg") || filetype.Contains(".png"))
                {
                    admin.admin_image = PublicUtil.saveImage(FileUpload);
                }
                else
                {
                    Literal AlertMsg = new Literal();
                    AlertMsg.Text = "<script language='javascript'>alert('圖片上傳失敗，請上傳jpg檔或png檔');location.href='Default.aspx';</script>";
                    this.Page.Controls.Add(AlertMsg);
                }
            }
            
            string verVerify = LDTSservice.toSha256(passWords.Text);
            
            if (PersonnelManagementService.UpdateAdmin(admin)&& verVerify== adminMyself.admin_password)
            {
                Session["LDTSAdmin"] = admin;
                Literal AlertMsg = new Literal();
                AlertMsg.Text = "<script language='javascript'>alert('編輯成功');</script>";
                this.Page.Controls.Add(AlertMsg);
            }
            else if (verVerify != adminMyself.admin_password)
            {
                Literal AlertMsg = new Literal();
                AlertMsg.Text = "<script language='javascript'>alert('編輯失敗，密碼輸入錯誤!');</script>";
                this.Page.Controls.Add(AlertMsg);
            }
            else
            {
                Literal AlertMsg = new Literal();
                AlertMsg.Text = "<script language='javascript'>alert('編輯失敗');</script>";
                this.Page.Controls.Add(AlertMsg);
            }
            Response.Redirect("account.aspx");

        }
    }
}