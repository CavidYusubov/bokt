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
using System.Data.SqlClient;
using System.Configuration;
using System.IO.Compression;
using System.Text;

public partial class _Default : System.Web.UI.Page
{
    string token = "";
    CultureInfo culture = CultureInfo.InvariantCulture;

    protected void Page_Load(object sender, EventArgs e)
    {
//        if (!IsPostBack)
        {
            string colDepID = "0";
            try
            {
                colDepID = ASPxTreeList1.FocusedNode.Key.ToString();
            }
            catch { }
            ds_employee.SelectParameters["colDepID"].DefaultValue = colDepID;// colDepID;
            gvEmployee.DataBind();
        }


    }

    public void MsgBox(String ex, System.Web.UI.Page pg, Object obj)
    {
        string s = "<SCRIPT language='javascript'>alert('" + ex.Replace("\r\n", "\\n").Replace("'", "") + "'); </SCRIPT>";
        Type cstype = obj.GetType();
        ClientScriptManager cs = pg.ClientScript;
        cs.RegisterClientScriptBlock(cstype, s, s.ToString());
    }

    protected void gvEmployee_RowUpdating(object sender, DevExpress.Web.Data.ASPxDataUpdatingEventArgs e)
    {
        try
        {
            ASPxComboBox cbShifts = gvEmployee.FindEditRowCellTemplateControl((GridViewDataColumn)gvEmployee.Columns["colShift"], "cbShifts") as ASPxComboBox;
            string colShiftID = cbShifts.SelectedItem.Value.ToString();
            e.NewValues["colShiftID"] = colShiftID;
        }
        catch { }
        try
        {
            ASPxComboBox cbPosition = gvEmployee.FindEditRowCellTemplateControl((GridViewDataColumn)gvEmployee.Columns["colPosition"], "cbPositions") as ASPxComboBox;
            string colPosID = cbPosition.SelectedItem.Value.ToString();
            e.NewValues["colPosID"] = colPosID;
        }
        catch { }
        try
        {
            ASPxComboBox cbSalaryGrade = gvEmployee.FindEditRowCellTemplateControl((GridViewDataColumn)gvEmployee.Columns["colSalaryID"], "cbSalaryGrade") as ASPxComboBox;
            string colSalaryID = cbSalaryGrade.SelectedItem.Value.ToString();
            e.NewValues["colSalaryID"] = colSalaryID;
        }
        catch { }


        e.NewValues["colImage"] = BasePage.getPhoto(e.OldValues["colUserID"].ToString());


/*
        object cat1 = ((ASPxComboBox)gvEmployee.FindEditRowCellTemplateControl(gvEmployee.Columns["colShiftID"] as GridViewDataComboBoxColumn, "cbShifts")).Value;
        try
        {
        }
        catch (Exception ex)
        {
        }
 */ 
//        cat1 = ((ASPxComboBox)gvEmployee.FindEditRowCellTemplateControl(gvEmployee.Columns["colPosID"] as GridViewDataComboBoxColumn, "cbPositions")).Value;
//        e.NewValues["colPosID"] = cat1;
//        cat1 = ((ASPxComboBox)gvEmployee.FindEditRowCellTemplateControl(gvEmployee.Columns["colSalaryID"] as GridViewDataComboBoxColumn, "cbSalaryGrade")).Value;
//        e.NewValues["colSalaryID"] = cat1;
//        string ret = BasePage.updateEmp("18");
//        MsgBox(ret, this.Page, this);

    }



    protected void gvEmployee_CustomCallback(object sender, ASPxGridViewCustomCallbackEventArgs e)
    {
        ds_employee.SelectParameters["colDepID"].DefaultValue = e.Parameters[0].ToString();
        gvEmployee.DataBind();
    }
    protected void ASPxPopupMenu1_ItemClick(object source, MenuItemEventArgs e)
    {
        try
        {
            string colDepID = ASPxTreeList1.FocusedNode.Key.ToString();
//            string colEmpID = gvEmployee.GetRowValues(gvEmployee.FocusedRowIndex, "colID").ToString();
            string sql = "update ts_employee set colDepID =  " + colDepID + " where colID = " + Session["colEmpID"];
            BasePage.ExecSQL(sql);
            gvEmployee.FocusedRowIndex = -1;
        }
        catch { }

    }
    protected void gvEmployee_FocusedRowChanged(object sender, EventArgs e)
    {
        try
        {
            Session["colEmpID"] = gvEmployee.GetRowValues(gvEmployee.FocusedRowIndex, "colID").ToString();
        }
        catch { }
    }
}