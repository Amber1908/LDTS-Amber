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
    public partial class PersonnelManagement : System.Web.UI.Page
    {
        protected void Page_Load(object sender, EventArgs e)
        {
            Admin loginAdmin = (Admin)Session["LDTSAdmin"];
            if (!loginAdmin.admin_ao.Contains("admin"))
            {
                Name.Enabled = false;
                PhoneTextBox1.Enabled = false;
                EmailTextBox2.Enabled = false;
                AdmndID.Enabled = false;
                statusSetNormal.Enabled = false;
                statusSetNotWork.Enabled = false;
                personnalManagement.Enabled = false;
                formManagement.Enabled = false;
                SaveButton.Enabled = false;
                memoTextbox.Enabled = false;
            }
        }

        protected void SaveButton_Click(object sender, EventArgs e)
        {
            Admin loginAdmin = (Admin)Session["LDTSAdmin"];
            int status;
            int admin_img = 0;
            string ao = "";
            int admin_sign = 0;
            bool isHasimg = false;
            bool isHasSign = false;
            //權限
            if (personnalManagement.Checked && formManagement.Checked)
            {
                ao = "admin,form";
            }
            else if (personnalManagement.Checked)
            {
                ao = "admin";
            }
            else if (formManagement.Checked)
            {
                ao = "form";
            }
            //狀態
            if (statusSetNormal.Checked)
            {
                status = 1;
            }
            else { status = 0; }
            string err = "新增失敗!";
            if (FileUpload.HasFile)
            {
                string fileName = FileUpload.FileName;
                String filetype = System.IO.Path.GetExtension(fileName);
                if (filetype.Contains(".jpg") || filetype.Contains(".png"))
                {
                    admin_img = PublicUtil.saveImage(FileUpload);
                    string workContent = "新增大頭照:" + Name.Text;
                    LDTSservice.InsertRecord(loginAdmin, workContent);
                }
                else
                {
                    err += "圖片上傳失敗，檔格式錯誤，請上傳jpg檔或png檔。";
                }
                if (admin_img != 0)
                {
                    isHasimg = true;
                }
            }
            else
            {
                err += "請上傳照片";
            }
            if (signNameUpload.HasFile)
            {
                string fileName = signNameUpload.FileName;
                String filetype = System.IO.Path.GetExtension(fileName);
                if (filetype.Contains(".jpg") || filetype.Contains(".png"))
                {
                    admin_sign = PublicUtil.saveImage(signNameUpload);
                    string workContent = "新增簽名檔:" + Name.Text;
                    LDTSservice.InsertRecord(loginAdmin, workContent);
                }
                else
                {
                    err += "簽名檔上傳失敗，檔格式錯誤，請上傳jpg檔或png檔。";

                }
                if (admin_sign != 0)
                {
                    isHasSign = true;
                }
            }
            else
            {
                err += "請上傳簽名檔，檔案格式為jpg檔或png檔。";
            }
            Admin admin = new Admin
            {
                admin_id = AdmndID.Text,
                admin_name = Name.Text,
                admin_email = EmailTextBox2.Text,
                admin_phone = PhoneTextBox1.Text,
                admin_ao = ao,
                status = status,
                admin_image = admin_img,
                admin_sign = admin_sign,
                memo = memoTextbox.Text,
            };
            if (isHasSign && isHasimg && PersonnelManagementService.InsertAdmin(admin))
            {
                string id = admin.admin_id;
                string url = "PersonEdit?id=";
                url += admin.admin_id;
                string workContent = "新增人員:" + admin.admin_name;
                LDTSservice.InsertRecord(loginAdmin, workContent);

                Literal AlertMsg = new Literal();
                AlertMsg.Text = "<script language='javascript'>alert('新增成功');location.href='PersonnelManagement.aspx';</script>";
                this.Page.Controls.Add(AlertMsg);
            }
            else
            {
                Literal AlertMsg = new Literal();
                AlertMsg.Text = "<script language='javascript'>alert('" + err + "');</script>";
                this.Page.Controls.Add(AlertMsg);
            }

        }
    }
}