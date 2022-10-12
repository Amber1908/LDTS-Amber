using System;
using System.Collections.Generic;
using System.Linq;
using System.Web;
using System.Web.UI;
using System.Web.UI.WebControls;

namespace LDTS
{
    public partial class AdminWorkRecord : System.Web.UI.Page
    {
        protected void Page_Load(object sender, EventArgs e)
        {
            refreashGrid();
        }

        protected void search_Click(object sender, EventArgs e)
        {
            refreashGrid();
        }
        private void refreashGrid()
        {
            string filter = string.Format("admin_id like '%{0}%' OR admin_name like '%{0}%' OR work_content like '%{0}%' ", table_search.Text);
            SqlDataSource1.FilterExpression = filter;
            GridView1.DataBind();
        }

    }
}