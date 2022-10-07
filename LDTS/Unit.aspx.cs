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
    public partial class Unit : System.Web.UI.Page
    {
        protected void Page_Load(object sender, EventArgs e)
        {
            UnitBasedata unitBasedata = UnitService.GetUnit();
            Admin admin = (Admin)Session["LDTSAdmin"];
            if (!admin.admin_ao.Contains("admin"))
            {
                UnitNameTextBox1.Enabled = false;
                IDTextBox1.Enabled = false;
                PhoneTextBox1.Enabled = false;
                AddrTextBox1.Enabled = false;
                EmailTextBox2.Enabled = false;
                ContactTextbox.Enabled = false;
                ContactMailTextbox.Enabled = false;
                BossTextBox.Enabled = false;
                BossPhone.Enabled = false;
                BossEmail.Enabled = false;
            }
            if (!Page.IsPostBack)
            {
                if (unitBasedata != null)
                {
                    UnitNameTextBox1.Text = unitBasedata.UnitName;
                    IDTextBox1.Text = unitBasedata.UnitID;
                    PhoneTextBox1.Text = unitBasedata.UnitPhone;
                    AddrTextBox1.Text = unitBasedata.UnitAddr;
                    EmailTextBox2.Text = unitBasedata.UnitEmail;
                    ContactTextbox.Text = unitBasedata.UnitContact;
                    ContactPhoneTexBox.Text = unitBasedata.UnitContactPhone;
                    ContactMailTextbox.Text = unitBasedata.UnitContactEmail;
                    BossTextBox.Text = unitBasedata.UnitBoss;
                    BossEmail.Text = unitBasedata.UnitBossEmail;
                    BossPhone.Text = unitBasedata.UnitBossPhone;
                    DesTextbox.Text = unitBasedata.UnitDesc;
                    logo.Src = "ShowAdminImg.aspx?id=" + unitBasedata.UnitIcon;
                    UnitLogo.ImageUrl = "ShowAdminImg.aspx?id=" + unitBasedata.UnitIcon;
                    UnitMark.ImageUrl = "ShowAdminImg.aspx?id=" + unitBasedata.UnitWatermark;
                }
            }
        }

        protected void SaveButton_Click(object sender, EventArgs e)
        {
            UnitBasedata unitBasedata = UnitService.GetUnit();
            Admin admin = (Admin)Session["LDTSAdmin"];
            if (FileUpload.HasFile)
                unitBasedata.UnitIcon = PublicUtil.saveImage(FileUpload);
            if (FileUploadMark.HasFile)
                unitBasedata.UnitWatermark = PublicUtil.saveImage(FileUploadMark);

            if (unitBasedata.UnitName == string.Empty)//新增
            {
                unitBasedata.UnitName = UnitNameTextBox1.Text;
                unitBasedata.UnitDesc = DesTextbox.Text;
                unitBasedata.UnitID = IDTextBox1.Text;
                unitBasedata.UnitEmail = EmailTextBox2.Text;
                unitBasedata.UnitPhone = PhoneTextBox1.Text;
                unitBasedata.UnitAddr = AddrTextBox1.Text;
                unitBasedata.UnitBoss = BossTextBox.Text;
                unitBasedata.UnitBossEmail = BossEmail.Text;
                unitBasedata.UnitBossPhone = BossPhone.Text;
                unitBasedata.UnitContact = ContactTextbox.Text;
                unitBasedata.UnitContactEmail = ContactMailTextbox.Text;
                unitBasedata.UnitContactPhone = ContactPhoneTexBox.Text;

                string workContent = "新增單位資訊";
                if (UnitService.InsertUnit(unitBasedata))
                {
                    LDTSservice.InsertRecord(admin, workContent);

                    Literal AlertMsg = new Literal();
                    AlertMsg.Text = "<script language='javascript'>alert('新增成功!');location=location;</script>";
                    this.Page.Controls.Add(AlertMsg);
                }
                else
                {
                    Literal AlertMsg = new Literal();
                    AlertMsg.Text = "<script language='javascript'>alert('新增失敗!');</script>";
                    this.Page.Controls.Add(AlertMsg);
                }
            }
            else
            {
                unitBasedata.UnitName = UnitNameTextBox1.Text;
                unitBasedata.UnitDesc = DesTextbox.Text;
                unitBasedata.UnitID = IDTextBox1.Text;
                unitBasedata.UnitEmail = EmailTextBox2.Text;
                unitBasedata.UnitPhone = PhoneTextBox1.Text;
                unitBasedata.UnitAddr = AddrTextBox1.Text;
                unitBasedata.UnitBoss = BossTextBox.Text;
                unitBasedata.UnitBossEmail = BossEmail.Text;
                unitBasedata.UnitBossPhone = BossPhone.Text;
                unitBasedata.UnitContact = ContactTextbox.Text;
                unitBasedata.UnitContactEmail = ContactMailTextbox.Text;
                unitBasedata.UnitContactPhone = ContactPhoneTexBox.Text;

                string workContent = "編輯單位資訊";
                if (UnitService.UpdateUnit(unitBasedata))
                {
                    LDTSservice.InsertRecord(admin, workContent);
                    Literal AlertMsg = new Literal();
                    AlertMsg.Text = "<script language='javascript'>alert('編輯成功!');location=location;</script>";
                    this.Page.Controls.Add(AlertMsg);
                }
                else
                {
                    Literal AlertMsg = new Literal();
                    AlertMsg.Text = "<script language='javascript'>alert('編輯失敗!');</script>";
                    this.Page.Controls.Add(AlertMsg);
                }
            }
        }
    }
}