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
    public partial class RestPassWord : System.Web.UI.Page
    {
        protected void Page_Load(object sender, EventArgs e)
        {
            Admin adminMyself = (Admin)Session["LDTSADMIN"];
            if (adminMyself==null)
            {
                Response.Redirect("Login.aspx");
            }
        }
        protected void SaveButton_Click(object sender, EventArgs e)
        {
            Admin admin = (Admin)Session["LDTSAdmin"];
            string oldPSW = admin.admin_password;
            string inputPSW = LDTSservice.toSha256(PassWord.Text.Trim());
            string newPSW = NewPsw.Text.Trim();
            string confirmPsw = confirmPassWord.Text.Trim();
            if (oldPSW != inputPSW)
            {
                Errmsg.Text = "原密碼輸入錯誤!";
                return;
            }
            if (newPSW != confirmPsw)
            {
                Errmsg.Text = "新密碼兩次輸入不一置!";
                return;
            }
            newPSW = LDTSservice.toSha256(newPSW);
            admin.admin_password = newPSW;
            if (PersonnelManagementService.UpdatePassword(admin))
            {
                Session["LDTSAdmin"] = admin;
                Literal AlertMsg = new Literal();
                AlertMsg.Text = "<script language='javascript'>alert('密碼變更成功!');</script>";
                this.Page.Controls.Add(AlertMsg);
            }
            else
            {
                Literal AlertMsg = new Literal();
                AlertMsg.Text = "<script language='javascript'>alert('密碼變更失敗!');</script>";
                this.Page.Controls.Add(AlertMsg);
            };
        }
    }
}