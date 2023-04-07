using System;
using System.Collections.Generic;
using System.Linq;
using System.Web;
using System.Web.UI;
using System.Web.UI.WebControls;
using System.Net;
using System.IO;
using System.Web.Script.Serialization;
using System.Data;
using System.Globalization;
using DevExpress.XtraPrinting;
using DevExpress.Export;

public partial class _Default : System.Web.UI.Page
{

    protected void Page_Load(object sender, EventArgs e)
    {

    }

    protected void ASPxCallbackPanel1_Callback(object sender, DevExpress.Web.CallbackEventArgsBase e)
    {
        if (ASPxLabel5.Text != "ok")
            ASPxLabel5.Text = DateTime.Now.ToString("HH:mm:ss");
        string ret = BasePage.checkTimesheet();
        if (ret == "yes")
        {
            ASPxLabel5.Text = "ok";
        }
//        ASPxLabel5.Text = "ok";

    }

}