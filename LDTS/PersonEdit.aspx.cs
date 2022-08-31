using System;
using System.Collections.Generic;
using System.Linq;
using System.Web;
using System.Web.UI;
using System.Web.UI.WebControls;
using LDTS.Service;
using LDTS.Models;
using LDTS.Utils;

namespace LDTS
{
    public partial class PersonEdit : System.Web.UI.Page
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
                PassWordReset.Enabled = false;
                Delete.Enabled = false;
                memoTextbox.Enabled = false;
            }
            if (!Page.IsPostBack)
            {
                string id = Request.QueryString["id"];

                if (id!=null)
                {
                    //找出 被修改成員的資料
                    AdmndID.Enabled = false;
                    Admin admin = PersonnelManagementService.GetAdminById(id);
                    AdmndID.Text = admin.admin_id;
                    EmailTextBox2.Text = admin.admin_email;
                    Name.Text = admin.admin_name;
                    PhoneTextBox1.Text = admin.admin_phone;
                    memoTextbox.Text = admin.memo;
                    Mug.Src = "ShowAdminImg.aspx?id=" + admin.admin_image;
                    ImageMug.ImageUrl = "ShowAdminImg.aspx?id=" + admin.admin_image;
                    signImg.ImageUrl = "ShowAdminImg.aspx?id=" + admin.admin_sign;
                    //ao
                    if (admin.status != 0)
                    {
                        statusSetNormal.Checked = true;
                    }
                    else
                    {
                        statusSetNotWork.Checked = true;
                    }
                    //status
                    if (admin.admin_ao != null && admin.admin_ao.Contains("admin") && admin.admin_ao.Contains("form"))
                    {
                        personnalManagement.Checked = true;
                        formManagement.Checked = true;
                    }
                    else if (admin.admin_ao != null && admin.admin_ao.Contains("form"))
                    {
                        formManagement.Checked = true;
                    }
                    else if (admin.admin_ao != null && admin.admin_ao.Contains("admin"))
                    {
                        personnalManagement.Checked = true;
                    }

                }
            }
        }

        protected void SaveButton_Click(object sender, EventArgs e)
        {
            string email = EmailTextBox2.Text;
            string id = Request.QueryString["id"];
            bool isChangeMug = true;
            bool isChangeSign = true;

            //先看有沒有上傳要換的圖
            if (FileUpload.HasFile)//換大頭照
            {
                string fileName = FileUpload.FileName;
                String filetype = System.IO.Path.GetExtension(fileName);

                Images MugImg = new Images()
                {
                    image_id = PublicUtil.saveImage(FileUpload),
                };

                if (filetype.Contains(".jpg") || filetype.Contains(".png"))
                {
                    fileNameImgEdit.Text = fileName;
                    if (LDTSservice.UpdatImge(MugImg))
                    {
                        isChangeMug = true;
                    }
                }
                else
                {
                    Literal AlertMsg = new Literal();
                    AlertMsg.Text = "<script language='javascript'>alert('圖片上傳失敗，請上傳jpg檔或png檔');location.href='Default.aspx';</script>";
                    this.Page.Controls.Add(AlertMsg);
                    isChangeMug = false;
                }
            }
            if (signNameUpload.HasFile)
            {
                string fileName = signNameUpload.FileName;
                String filetype = System.IO.Path.GetExtension(fileName);
                Images signImg = new Images()
                {
                    image_id = PublicUtil.saveImage(signNameUpload),
                };
                if (filetype.Contains(".jpg") || filetype.Contains(".png"))
                {
                    signNameEdit.Text = fileName;
                    if (LDTSservice.UpdatImge(signImg))
                    {
                        isChangeSign = true;
                    }
                }
                else
                {
                    Literal AlertMsg = new Literal();
                    AlertMsg.Text = "<script language='javascript'>alert('圖片上傳失敗，請上傳jpg檔或png檔');</script>";
                    this.Page.Controls.Add(AlertMsg);
                    isChangeSign = false;
                }
            }
            string ao = "";
            if (formManagement.Checked && personnalManagement.Checked)
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
            int status = 0;
            if (statusSetNormal.Checked)
            {
                status = 1;
            }
            Admin admin = new Admin()
            {
                admin_id = id,
                admin_name = Name.Text,
                admin_phone = PhoneTextBox1.Text,
                admin_ao = ao,
                admin_email = EmailTextBox2.Text,
                status = status,
                memo = memoTextbox.Text
            };
            if (PersonnelManagementService.UpdateAdmin(admin) && isChangeMug && isChangeSign)
            {
                Admin loginAdmin = (Admin)Session["LDTSAdmin"];
                string work = "編輯人員:" + admin.admin_name;
                LDTSservice.InsertRecord(loginAdmin, work);
                Literal AlertMsg = new Literal();
                AlertMsg.Text = "<script language='javascript'>alert('編輯成功');</script>";
                this.Page.Controls.Add(AlertMsg);
            }
            else
            {
                Literal AlertMsg = new Literal();
                AlertMsg.Text = "<script language='javascript'>alert('編輯失敗');</script>";
                this.Page.Controls.Add(AlertMsg);

            }

        }

        protected void PassWordReset_Click(object sender, EventArgs e)
        {
            string id = Request.QueryString["id"];
            Admin admin = new Admin();
            admin = PersonnelManagementService.GetAdminById(id);
            if (PersonnelManagementService.ResetPassword(admin.admin_id))
            {
                Admin loginAdmin = (Admin)Session["LDTSAdmin"];
                string work = "重置人員密碼:" + admin.admin_name;
                LDTSservice.InsertRecord(loginAdmin, work);

                Literal AlertMsg = new Literal();
                AlertMsg.Text = "<script language='javascript'>alert('密碼重置成功!');</script>";
                this.Page.Controls.Add(AlertMsg);
            }
            else
            {
                Literal AlertMsg = new Literal();
                AlertMsg.Text = "<script language='javascript'>alert('密碼重置失敗!');</script>";
                this.Page.Controls.Add(AlertMsg);
            }

        }

        protected void Delete_Click(object sender, EventArgs e)
        {
            string id = Request.QueryString["id"];
            Admin admin = new Admin();
            bool isDeleteImgs = false;

            admin = PersonnelManagementService.GetAdminById(id);
            if (admin.admin_image != 0 && LDTSservice.DeleteImg(admin.admin_image))
            {
                isDeleteImgs = true;
            }
            if (admin.admin_sign != 0 && LDTSservice.DeleteImg(admin.admin_sign))
            {
                isDeleteImgs = true;
            }
            if (PersonnelManagementService.DeleteAdmin(id) && isDeleteImgs)
            {
                Admin loginAdmin = (Admin)Session["LDTSAdmin"];
                string work = "刪除人員:" + admin.admin_name;
                LDTSservice.InsertRecord(loginAdmin, work);

                Literal AlertMsg = new Literal();
                AlertMsg.Text = "<script language='javascript'>alert('刪除成功');location.href='PersonnelManagement.aspx';</script>";
                this.Page.Controls.Add(AlertMsg);
            }
            else
            {
                Literal AlertMsg = new Literal();
                AlertMsg.Text = "<script language='javascript'>alert('刪除失敗');</script>";
                this.Page.Controls.Add(AlertMsg);

            }

        }
    }
}