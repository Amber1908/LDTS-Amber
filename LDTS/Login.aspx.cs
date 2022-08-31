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
    public partial class Login : System.Web.UI.Page
    {
        protected void Page_Load(object sender, EventArgs e)
        {
            if (!IsPostBack)
            {
                HttpCookie myCookie = Request.Cookies["LDTSAdmin"];
                if (myCookie != null)
                {
                    accountTextbox.Text = myCookie.Values["Admin"];
                    passwordTextBox1.Attributes["value"] = myCookie.Values["PassWord"];

                    rememberCheckBox1.Checked = true;
                }

                if (passwordTextBox1.Text.Length < 1)
                {
                    passwordTextBox1.Focus();
                }
            }

        }

        protected void loginButton1_Click(object sender, EventArgs e)
        {
            //驗證管理者
            Admin admin = new Admin();
            string account = accountTextbox.Text;
            string password = passwordTextBox1.Text;
            bool isUpdatePsw = false;
            admin = PersonnelManagementService.GetAdminById(account);
            if (admin == null)
            {
                msgLiteral.Text = "帳戶不存在!";
                accountTextbox.Focus();
                return;
            }
            if (admin.status == 0)
            {
                msgLiteral.Text = "帳戶停用!";
                accountTextbox.Focus();
                return;

            }
            if (admin.admin_password.Equals(string.Empty))
            {
                admin.admin_password = LDTSservice.toSha256(password);
                PersonnelManagementService.UpdatePassword(admin);
            }
            else
            {
                string checkedPassword = LDTSservice.toSha256(password);
                if (checkedPassword != admin.admin_password)
                {
                    passwordTextBox1.Focus();
                    return;
                }
            }
            //寫入 cookies
            HttpCookie myCookie = new HttpCookie("LDTSAdmin");

            if (rememberCheckBox1.Checked)
            {
                myCookie.Values.Add("Admin", admin.admin_id);
                myCookie.Values.Add("PassWord", passwordTextBox1.Text);
                myCookie.Expires = DateTime.Now.AddMonths(1);
                Response.Cookies.Add(myCookie);
            }
            else
            {
                Response.Cookies.Remove("LDTSAdmin");
                myCookie.Expires = DateTime.Now.AddDays(-10);
                myCookie.Value = null;
                Response.SetCookie(myCookie);
            }
            Session["LDTSAdmin"] = admin;
            LDTSservice.InsertRecord(admin, "登入");
            Response.Redirect("Default.aspx");

        }
    }
}