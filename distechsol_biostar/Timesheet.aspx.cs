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


    protected void btnSave_Click(object sender, EventArgs e)
    {
        //        BasePage.MsgBox("OK", this.Page, this);
        BasePage.ExecSQL("exec sp_setShift @colEmpID = " + Session["colEmpID"] + ", @colPeriod = '" + dateFrom.Date.ToString() + "', @colShiftID='" + cbShifts.SelectedItem.Value.ToString() + "'");
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
        int i = 0; string d = dateFrom.Date.Year + "/" + dateFrom.Date.Month + "/"; int wd = 0;
        int days = DateTime.DaysInMonth(dateFrom.Date.Year, dateFrom.Date.Month);
        foreach (GridViewDataColumn c in grid.Columns)
        {

            c.HeaderStyle.BackColor = Color.White;
            c.HeaderStyle.ForeColor = Color.Black;
            c.HeaderStyle.Font.Bold = false;
            if ((c.FieldName.ToString()).StartsWith("colDay"))
            {
                i++;
                if (i > days)
                {
                    c.Visible = false;
                    continue;
                }
                c.Width = 60;
                wd = (int)Convert.ToDateTime(d + i.ToString()).DayOfWeek;
                c.Caption = i.ToString() + "<br>" + Convert.ToDateTime(d + i.ToString()).ToString("ddd");
                if (wd == 6 || wd == 0)
                {
                    c.HeaderStyle.BackColor = Color.Red;
                    c.HeaderStyle.ForeColor = Color.White;
                    c.HeaderStyle.Font.Bold = true;
                }
            }
        }  
    }
    protected void mainGrid_CustomCallback(object sender, ASPxGridViewCustomCallbackEventArgs e)
    {
        mainGrid.DataBind();
    }


    protected void VcallbackPanel_Callback(object sender, CallbackEventArgsBase e)
    {
        ds_leaves.SelectParameters["colEmpID"].DefaultValue = e.Parameter;
        Session["colEmpID"] = e.Parameter;
//        gv_hollidays.DataBind();
//        gv_leaves.DataBind();
    }

    protected void gv_leaves_RowUpdating(object sender, DevExpress.Web.Data.ASPxDataUpdatingEventArgs e)
    {
        ds_leaves.SelectParameters["colEmpID"].DefaultValue = Session["colEmpID"].ToString();
        try
        {
            ASPxComboBox cbLeavetypes = gv_leaves.FindEditRowCellTemplateControl((GridViewDataColumn)gv_leaves.Columns["colTypeID"], "cbLeavetypes") as ASPxComboBox;
            string colTypeID = cbLeavetypes.SelectedItem.Value.ToString();
            e.NewValues["colTypeID"] = colTypeID;
        }
        catch { }


    }
    protected void gv_leaves_RowInserting(object sender, DevExpress.Web.Data.ASPxDataInsertingEventArgs e)
    {

        ds_leaves.SelectParameters["colEmpID"].DefaultValue = Session["colEmpID"].ToString();
        try
        {
            ASPxComboBox cbLeavetypes = gv_leaves.FindEditRowCellTemplateControl((GridViewDataColumn)gv_leaves.Columns["colTypeID"], "cbLeavetypes") as ASPxComboBox;
            string colTypeID = cbLeavetypes.SelectedItem.Value.ToString();
            e.NewValues["colTypeID"] = colTypeID;
            e.NewValues["colEmpID"] = Session["colEmpID"];
        }
        catch { }

    }
    protected void mainGrid_HtmlDataCellPrepared(object sender, ASPxGridViewTableDataCellEventArgs e)
    {

        string CellValue = e.CellValue.ToString().Trim();

/*
        if (e.DataColumn.FieldName == "colVacation" && Convert.ToInt16(e.CellValue) > 0)
        {
//            e.Cell.BackColor = Color.Purple;
            e.Cell.Font.Bold = true;
            e.Cell.ForeColor = Color.Purple;
            return;
        }
        if (e.DataColumn.FieldName == "colBTrip" && Convert.ToInt16(e.CellValue) > 0)
        {
//            e.Cell.BackColor = Color.Green;
            e.Cell.Font.Bold = true;
            e.Cell.ForeColor = Color.Green;
            return;
        }
        if (e.DataColumn.FieldName == "colTraining" && Convert.ToInt16(e.CellValue) > 0)
        {
//            e.Cell.BackColor = Color.Blue;
            e.Cell.Font.Bold = true;
            e.Cell.ForeColor = Color.Blue;
            return;
        }
        if (e.DataColumn.FieldName == "colSLeave" && Convert.ToInt16(e.CellValue) > 0)
        {
//            e.Cell.BackColor = Color.Black;
            e.Cell.Font.Bold = true;
            e.Cell.ForeColor = Color.Black;
            return;
        }


        if (CellValue == "VAC")
        {
            e.Cell.BackColor = Color.Purple;
            e.Cell.Font.Bold = true;
            e.Cell.ForeColor = Color.White;
            return;
        }
        if (CellValue == "BT")
        {
            e.Cell.BackColor = Color.Green;
            e.Cell.Font.Bold = true;
            e.Cell.ForeColor = Color.White;
            return;
        }
        if (CellValue == "TR")
        {
            e.Cell.BackColor = Color.Blue;
            e.Cell.Font.Bold = true;
            e.Cell.ForeColor = Color.White;
            return;
        }
        if (CellValue == "SL")
        {
            e.Cell.BackColor = Color.Black;
            e.Cell.Font.Bold = true;
            e.Cell.ForeColor = Color.White;
            return;
        }

        if (CellValue.Contains("@"))
        {
            e.Cell.Text = CellValue.Substring(0, CellValue.IndexOf("@"));
            try
            {
                e.Cell.BackColor = System.Drawing.Color.FromName(CellValue.Substring(CellValue.IndexOf("@") + 1, 7));
                e.Cell.Font.Bold = true;
                e.Cell.ForeColor = Color.White;
            }
            catch { }

        }
*/
        if (e.DataColumn.FieldName.StartsWith("colDay"))
        {
            string colDay = new String(e.DataColumn.FieldName.Where(Char.IsDigit).ToArray());
            e.Cell.BackColor = System.Drawing.Color.FromName(mainGrid.GetRowValues(e.VisibleIndex, "colColorDay" + colDay).ToString());
            e.Cell.Font.Bold = true;
            e.Cell.ForeColor = Color.White;

            if (Convert.ToInt16(mainGrid.GetRowValues(e.VisibleIndex, "colShiftDay" + colDay)) > 0)
                e.Cell.Text = "<a href='javascript:void(0);' style='text-decoration: none; color:white' onclick='OnMoreInfoClick(this)'>" + e.CellValue + "</a>";
            if (Convert.ToInt16(mainGrid.GetRowValues(e.VisibleIndex, "colShiftDay" + colDay)) == 0)
                e.Cell.Text = "<a href='javascript:void(0);' style='text-decoration: none; color:black' onclick='OnMoreInfoClick(this)'>" + e.CellValue + "</a>";

        }
    }

    protected void mainGrid_DataBinding(object sender, EventArgs e)
    {
        DataView dw = (DataView)ds_mainGride.Select(DataSourceSelectArguments.Empty);
        foreach (DataColumn c in dw.Table.Columns)
        {
            if (c.ColumnName.Contains("colColor"))
            {
                AddTextColumn(c.ColumnName, false);
            }
            if (c.ColumnName.Contains("colDay"))
                AddTextColumn(c.ColumnName, true);
        }

//        mainGrid.KeyFieldName = dw.Table.Columns[0].ColumnName;
//        mainGrid.Columns[0].Visible = false;
    }


    private void AddTextColumn(string fieldName, bool visible)
    {
        GridViewDataTextColumn c = new GridViewDataTextColumn();
        c.FieldName = fieldName;
        c.Name = fieldName;
        c.Visible = visible;
        mainGrid.Columns.Add(c);
    }

}