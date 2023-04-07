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
using DevExpress.Web;
using System.Drawing;

public partial class _Default : System.Web.UI.Page
{
    string token = "";
    Int32 tWHours = 0, tOvertime = 0, tLateLeave = 0;
    Int32 tGWHours = 0, tGOvertime = 0, tGLateLeave = 0;
    
    CultureInfo culture = CultureInfo.InvariantCulture;
    protected void Page_Load(object sender, EventArgs e)
    {
        if (!IsPostBack)
        {
            DateTime dt = DateTime.Now;
            var firstDayOfMonth = new DateTime(dt.Year, dt.Month, 1);
            var lastDayOfMonth = firstDayOfMonth.AddMonths(1).AddDays(-1);
            dateFrom.Date = firstDayOfMonth;
        }
        else
        {
            ds_mainGride.SelectParameters["colPeriod"].DefaultValue = dateFrom.Date.ToString();
            mainGrid.DataBind();
//            mainGrid.ExpandAll();  
        }
    }

    public void MsgBox(String ex, System.Web.UI.Page pg, Object obj)
    {
        string s = "<SCRIPT language='javascript'>alert('" + ex.Replace("\r\n", "\\n").Replace("'", "") + "'); </SCRIPT>";
        Type cstype = obj.GetType();
        ClientScriptManager cs = pg.ClientScript;
        cs.RegisterClientScriptBlock(cstype, s, s.ToString());
    }

    protected void ASPxButton1_Click(object sender, EventArgs e)
    {
    }

    protected void ASPxButton2_Click(object sender, EventArgs e)
    {
        ASPxGridViewExporter1.WriteXlsxToResponse(new XlsxExportOptionsEx { ExportType = ExportType.DataAware });
    }
   
    
    protected void mainGrid_DataBound(object sender, EventArgs e)
    {
        ASPxGridView grid = (ASPxGridView)sender;
        int i = 0; string d = dateFrom.Date.Year + "/" + dateFrom.Date.Month + "/"; 
        int days = DateTime.DaysInMonth(dateFrom.Date.Year, dateFrom.Date.Month);
        foreach (GridViewDataColumn c in grid.Columns)
        {

            if ((c.FieldName.ToString()).StartsWith("colDay"))
            {
                i++;
                c.Caption = i.ToString() + "<br>" + Convert.ToDateTime(d + i.ToString()).ToString("ddd");
                if ((int)Convert.ToDateTime(d + i.ToString()).DayOfWeek == 6 || (int)Convert.ToDateTime(d + i.ToString()).DayOfWeek == 0)
                {
                    c.HeaderStyle.BackColor = Color.Red;
                    c.HeaderStyle.ForeColor = Color.White;
                    c.HeaderStyle.Font.Bold = true;
                }
                if (i > days)
                    c.Visible = false;
            }
        }  
    }
    protected void mainGrid_CustomCallback(object sender, ASPxGridViewCustomCallbackEventArgs e)
    {
        mainGrid.DataBind();
    }
}