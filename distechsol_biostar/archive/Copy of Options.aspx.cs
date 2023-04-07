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
using DevExpress.Web.Data;
using DevExpress.Web;

public partial class _Default : System.Web.UI.Page
{

    protected void Page_Load(object sender, EventArgs e)
    {

    }

    public void getShiftData()
    {
        string s = "0";
        try
        {
            s = cbShifts.SelectedItem.Value.ToString();
        }
        catch (Exception ex)
        {
        }

        ds_shiftdetails.SelectParameters["colShiftID"].DefaultValue = s;
//        gvShiftDetails.DataBind();
    }

    protected void btnSave_Click(object sender, EventArgs e)
    {
//        BasePage.MsgBox("OK", this.Page, this);
        BasePage.ExecSQL("exec ts_addShift @colShift='" + cbShifts.Text + "'");
        cbShifts.SelectedIndex = -1;
        cbShifts.DataBind();
        getShiftData();
    }
    protected void cbShifts_SelectedIndexChanged(object sender, EventArgs e)
    {
        getShiftData();
    }

    protected void gvShiftDetails_CustomUnboundColumnData(object sender, DevExpress.Web.ASPxGridViewColumnDataEventArgs e)
    {
        if (e.Column.FieldName == "ubLTimeOut")
        {
            e.Value = DateTime.MinValue.Add((TimeSpan)e.GetListSourceFieldValue("colLTimeOut"));
        }
        if (e.Column.FieldName == "ubLTimeIn")
        {
            e.Value = DateTime.MinValue.Add((TimeSpan)e.GetListSourceFieldValue("colLTimeIn"));
        }
        if (e.Column.FieldName == "ubTimeOut")
        {
            e.Value = DateTime.MinValue.Add((TimeSpan)e.GetListSourceFieldValue("colTimeOut"));
        }
        if (e.Column.FieldName == "ubTimeIn")
        {
            e.Value = DateTime.MinValue.Add((TimeSpan)e.GetListSourceFieldValue("colTimeIn"));
        }
    }  

    protected void gvShiftDetails_RowUpdating(object sender, DevExpress.Web.Data.ASPxDataUpdatingEventArgs e)
    {
        DateTime date = (DateTime)e.NewValues["ubLTimeOut"];
        e.NewValues["colLTimeOut"] = date.TimeOfDay;
        date = (DateTime)e.NewValues["ubLTimeIn"];
        e.NewValues["colLTimeIn"] = date.TimeOfDay;
        date = (DateTime)e.NewValues["ubTimeIn"];
        e.NewValues["colTimeIn"] = date.TimeOfDay;
        date = (DateTime)e.NewValues["ubTimeOut"];
        e.NewValues["colTimeOut"] = date.TimeOfDay;
    }
    protected void cbShifts_ValueChanged(object sender, EventArgs e)
    {
        getShiftData();
    }

    protected void ASPxButton1_Click(object sender, EventArgs e)
    {
        BasePage.ExecSQL("exec ts_addShift @colType = 1, @colShift='" + cbShifts.Text + "'");
        cbShifts.SelectedIndex = -1;
        cbShifts.DataBind();
        getShiftData();

    }
    protected void gv_salarygrades_InitNewRow(object sender, DevExpress.Web.Data.ASPxDataInitNewRowEventArgs e)
    {
        GridView gridView = sender as GridView;
        e.NewValues["colOvertime"] = 1;
        e.NewValues["colOvernorm"] = 1;
        e.NewValues["colNight"] = 1;
        e.NewValues["colHoliday"] = 1;
        e.NewValues["colAmount"] = 0;

    }


    protected void grid_BatchUpdate(object sender, ASPxDataBatchUpdateEventArgs e)
    {
/*
        foreach (var args in e.InsertValues)
            InsertNewItem(args.NewValues, false, (ASPxGridView)sender);
        foreach (var args in e.UpdateValues)
            UpdateItem(args.Keys, args.NewValues, false);
        foreach (var args in e.DeleteValues)
            DeleteItem(args.Keys, args.Values, false);
        e.Handled = true;
 */ 
    }
    protected void Grid_CommandButtonInitialize(object sender, ASPxGridViewCommandButtonEventArgs e)
    {
        if (e.ButtonType == ColumnCommandButtonType.Update || e.ButtonType == ColumnCommandButtonType.Cancel)
        {
            e.Visible = false;
        }
    }


    protected void grid2_BeforePerformDataSelect(object sender, EventArgs e)
    {
        ASPxGridView child = sender as ASPxGridView;
        GridViewDetailRowTemplateContainer container = child.NamingContainer as GridViewDetailRowTemplateContainer;
        child.ClientInstanceName = "detailGrid" + container.KeyValue;
        Session["colShiftID"] = child.GetMasterRowKeyValue();

    }












}