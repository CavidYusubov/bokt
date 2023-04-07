using System;
using System.Collections.Generic;
using System.Linq;
using System.Web;
using System.Web.UI;
using System.Web.UI.WebControls;
using DevExpress.Web;

    public partial class SiteMaster : System.Web.UI.MasterPage {
        protected void Page_Load(object sender, EventArgs e) {
            if (Session["token"] == null) 
                BasePage.loginBIO(this.Page, this);
        }
        protected void HeaderMenu_ItemClick(object source, MenuItemEventArgs e)
        {
            if (e.Item.Text == "Refresh Data")
            {
                string ret = BasePage.loginBIO(this.Page, this);
                MsgBox(ret, this.Page, this);
            }
        }


        public void MsgBox(String ex, System.Web.UI.Page pg, Object obj)
        {
            string s = "<SCRIPT language='javascript'>alert('" + ex.Replace("\r\n", "\\n").Replace("'", "") + "'); </SCRIPT>";
            Type cstype = obj.GetType();
            ClientScriptManager cs = pg.ClientScript;
            cs.RegisterClientScriptBlock(cstype, s, s.ToString());
        }

}