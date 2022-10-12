using System;
using System.Web;

namespace LDTS
{
    public partial class Logout : System.Web.UI.Page
    {
        protected void Page_Load(object sender, EventArgs e)
        {
            if (!IsPostBack)
            {
                Session.Abandon();
                HttpCookie myCookie = new HttpCookie("LDTSAdmin");
                Response.Cookies.Remove("LDTSAdmin");
                myCookie.Expires = DateTime.Now.AddDays(-10);
                myCookie.Value = null;
                Response.SetCookie(myCookie);
                Response.Redirect("Login");
            }
        }
    }
}