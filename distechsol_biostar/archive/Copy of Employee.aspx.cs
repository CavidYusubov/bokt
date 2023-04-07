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


        string colPhoto = BasePage.getPhoto("3");
        colPhoto  = colPhoto.Substring(1, colPhoto.Length - 2);



        ASPxLabel1.Text = colPhoto;

        try
        {
        }
        catch { }

        ASPxImage1.ImageUrl = "Data:Image/jpg;base64," + colPhoto;

    }


    private string DecompressGZIP(string compressedText)
    {
        byte[] gZipBuffer = Convert.FromBase64String(compressedText);
        using (var memoryStream = new MemoryStream())
        {
            int dataLength = BitConverter.ToInt32(gZipBuffer, 0);
            memoryStream.Write(gZipBuffer, 4, gZipBuffer.Length - 4);

            var buffer = new byte[dataLength];

            memoryStream.Position = 0;
            using (var gZipStream = new GZipStream(memoryStream, CompressionMode.Decompress))
            {
                gZipStream.Read(buffer, 0, buffer.Length);
            }

            return Encoding.UTF8.GetString(buffer);
        }
    }

    public static string UnZip(string value)
    {
        //Transform string into byte[]
        byte[] byteArray = new byte[value.Length];
        int indexBA = 0;
        foreach (char item in value.ToCharArray())
        {
            byteArray[indexBA++] = (byte)item;
        }

        //Prepare for decompress
        System.IO.MemoryStream ms = new System.IO.MemoryStream(byteArray);
        System.IO.Compression.GZipStream sr = new System.IO.Compression.GZipStream(ms,
            System.IO.Compression.CompressionMode.Decompress);

        //Reset variable to collect uncompressed result
        byteArray = new byte[byteArray.Length];

        //Decompress
        int rByte = sr.Read(byteArray, 0, byteArray.Length);

        //Transform byte[] unzip data to string
        System.Text.StringBuilder sB = new System.Text.StringBuilder(rByte);
        //Read the number of bytes GZipStream red and do not a for each bytes in
        //resultByteArray;
        for (int i = 0; i < rByte; i++)
        {
            sB.Append((char)byteArray[i]);
        }
        sr.Close();
        ms.Close();
        sr.Dispose();
        ms.Dispose();
        return sB.ToString();
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