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
            dateTo.Date = lastDayOfMonth;

        }
        else
        {
            SqlDataSource2.SelectParameters["colDateFrom"].DefaultValue = dateFrom.Date.ToString();
            SqlDataSource2.SelectParameters["colDateTo"].DefaultValue = dateTo.Date.ToString();
            if (cbEmployee.SelectedIndex > -1)
                SqlDataSource2.SelectParameters["colUserID"].DefaultValue = cbEmployee.SelectedItem.Value.ToString();
            mainGrid.DataBind();
//            mainGrid.ExpandAll();  
        }
/*
        if (cbEmployee.Items.Count < 2)
        {
            loginBIO();
        }
*/
    }

/*
    public void loginBIO() 
    {
        HttpWebRequest request = (HttpWebRequest)WebRequest.Create("http://172.20.20.18:8795/v2/login");
        request.Method = "POST";
        request.ContentType = "application/json";

        //            string postData = "{\"name\":\"bioaq\", \"password\":\"" + tbPassword.Text + " \", \"user_id\":\"" + tbUserName.Text + "\"}";

        string postData = "{\"name\":\"bioaq\", \"password\":\"Abbas1972\", \"user_id\":\"test\"}";

        if (request.CookieContainer == null)
        {
            request.CookieContainer = new CookieContainer();
        }

        try
        {
            using (var streamWriter = new StreamWriter(request.GetRequestStream()))
            {
                streamWriter.Write(postData);
                streamWriter.Flush();
                streamWriter.Close();
                var httpResponse = (HttpWebResponse)request.GetResponse();
                using (var streamReader = new StreamReader(httpResponse.GetResponseStream()))
                {
                    var result = streamReader.ReadToEnd();
                    token = httpResponse.Headers["set-token"];
                    String setCookieHeader = httpResponse.Headers[HttpResponseHeader.SetCookie];
                    CookieContainer cookieContainer = new CookieContainer();
                    System.Net.Cookie cook = new System.Net.Cookie("bs-cloud-session-id", token);
                    request.CookieContainer = cookieContainer;
                }
            }
        }
        catch (Exception ex)
        {
            MsgBox(ex.Message, this.Page, this);
        }


        if (!String.IsNullOrEmpty(token))
        {
            Session["token"] = token;
            request = (HttpWebRequest)WebRequest.Create("http://172.20.20.18:8795/v2/users?limit=1000&offset=0");
            request.Method = "GET";
            request.ContentType = "application/json";
            request.Headers["Cookie"] = "bs-cloud-session-id=" + token;
            var result = "";
            try
            {
                var httpResponse = (HttpWebResponse)request.GetResponse();

                using (var streamReader = new StreamReader(httpResponse.GetResponseStream()))
                {
                    result = streamReader.ReadToEnd();

                }
            }

            catch (Exception ex)
            {
                MsgBox(ex.Message, this.Page, this);
            }



            if (!String.IsNullOrEmpty(result))
            {
                JavaScriptSerializer js = new JavaScriptSerializer();
                var obj = js.Deserialize<dynamic>(result);
                foreach (var item in obj["records"])
                {
                    cbEmployee.Items.Add(new DevExpress.Web.ListEditItem(item["name"].ToString(), item["user_id"].ToString()));
                }
            }
        }

    }

*/
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
/*
    protected void ASPxButton1_Click_old(object sender, EventArgs e)
    {


        HttpWebRequest request = (HttpWebRequest)WebRequest.Create("http://172.20.20.18:8795/v2/monitoring/event_log/search");
        request.Method = "POST";
        request.ContentType = "application/json";
        request.Headers["Cookie"] = "bs-cloud-session-id=" + Session["token"];

        string users = "";
        if (cbEmployee.SelectedIndex > 0)
        {
            users = ", \"user_id\":[" + cbEmployee.SelectedItem.Value + "]";
        }


        string postData = "{\"limit\":\"100\", \"offset\":\"0\", \"datetime\":[\"2022-08-02T16:07:29.00Z\",\"2022-10-02T16:07:29.00Z\"]" + users + "}";

        var result = "";
        try
        {
            using (var streamWriter = new StreamWriter(request.GetRequestStream()))
            {
                streamWriter.Write(postData);
                streamWriter.Flush();
                streamWriter.Close();
                var httpResponse = (HttpWebResponse)request.GetResponse();
                using (var streamReader = new StreamReader(httpResponse.GetResponseStream()))
                {
                    result = streamReader.ReadToEnd();
                }
            }
        }
        catch (Exception ex)
        {
            MsgBox(ex.Message, this.Page, this);
        }


//        MsgBox(result.ToString(), this.Page, this);


        if (!String.IsNullOrEmpty(result))
        {
            DataTable table = new DataTable();

            DataColumn column;
            DataRow row;
            DataView view;
            ASPxGridView1.DataSource = null;
            ASPxGridView1.DataBind();

            // Create new DataColumn, set DataType, ColumnName and add to DataTable.

            column = new DataColumn();
            column.DataType = Type.GetType("System.Int32");
            column.ColumnName = "colID";
            table.Columns.Add(column);

            column = new DataColumn();
            column.DataType = System.Type.GetType("System.String");
            column.ColumnName = "colDate";
            table.Columns.Add(column);
            column = new DataColumn();
            column.DataType = System.Type.GetType("System.String");
            column.ColumnName = "colTime";
            table.Columns.Add(column);

            // Create second column.
            column = new DataColumn();
            column.DataType = Type.GetType("System.String");
            column.ColumnName = "colDID";
            table.Columns.Add(column);

            column = new DataColumn();
            column.DataType = Type.GetType("System.String");
            column.ColumnName = "colUserID";
            table.Columns.Add(column);

            column = new DataColumn();
            column.DataType = Type.GetType("System.String");
            column.ColumnName = "colUserName";
            table.Columns.Add(column);

            column = new DataColumn();
            column.DataType = Type.GetType("System.String");
            column.ColumnName = "colType";
            table.Columns.Add(column);

            JavaScriptSerializer js = new JavaScriptSerializer();
            var obj = js.Deserialize<dynamic>(result);
            foreach (var item in obj["records"])
            {
//                if (item["type"].ToString() = "AUTHENTICATION")
                if (item.ContainsKey("user"))
                {
//                    ASPxListBox1.Items.Add(item["datetime"].ToString());
                    row = table.NewRow();
                    row["colID"] = item["id"].ToString();
                    row["colDID"] = item["device"]["id"].ToString();

                    DateTime time = DateTime.Parse(item["datetime"].ToString(), culture, DateTimeStyles.None);

                    row["colDate"] = time.ToString("MM/dd/yyyy");
                    row["colTime"] = time.ToString("HH:mm");
                    row["colUserName"] = item["user"]["name"].ToString();
                    row["colUserID"] = item["user"]["user_id"].ToString();
                    table.Rows.Add(row);


                }
            }

            view = new DataView(table);
            ASPxGridView1.DataSource = view;
                ASPxGridView1.DataBind();
            //            ASPxLabel1.Text = obj["records"].ToString();
            //            MsgBox(result, this.Page, this);
            //                Response.Redirect("~/reports.aspx");
        }


    }

*/
    private void jsonToData()
    {
        // Create new DataTable and DataSource objects.
        DataTable table = new DataTable();

        // Declare DataColumn and DataRow variables.
        DataColumn column;
        DataRow row;
        DataView view;

        // Create new DataColumn, set DataType, ColumnName and add to DataTable.
        column = new DataColumn();
        column.DataType = System.Type.GetType("System.Int32");
        column.ColumnName = "id";
        table.Columns.Add(column);

        // Create second column.
        column = new DataColumn();
        column.DataType = Type.GetType("System.String");
        column.ColumnName = "item";
        table.Columns.Add(column);

        // Create new DataRow objects and add to DataTable.
        for (int i = 0; i < 10; i++)
        {
            row = table.NewRow();
            row["id"] = i;
            row["item"] = "item " + i.ToString();
            table.Rows.Add(row);
        }

        // Create a DataView using the DataTable.
        view = new DataView(table);

        // Set a DataGrid control's DataSource to the DataView.
//        dataGrid1.DataSource = view;
//        return view;
    }

    protected void ASPxButton2_Click(object sender, EventArgs e)
    {
        ASPxGridViewExporter1.WriteXlsxToResponse(new XlsxExportOptionsEx { ExportType = ExportType.DataAware });
    }
    protected void mainGrid_CustomCallback(object sender, DevExpress.Web.ASPxGridViewCustomCallbackEventArgs e)
    {
        SqlDataSource2.SelectParameters["colDateFrom"].DefaultValue = dateFrom.Date.ToString();
        SqlDataSource2.SelectParameters["colDateTo"].DefaultValue = dateTo.Date.ToString();
        if (cbEmployee.SelectedIndex > -1)
            SqlDataSource2.SelectParameters["colUserID"].DefaultValue = cbEmployee.SelectedItem.Value.ToString();
        mainGrid.DataBind();

    }
    protected void cbEmployee_Callback(object sender, DevExpress.Web.CallbackEventArgsBase e)
    {
        cbEmployee.DataBind();
        cbEmployee.SelectedIndex = Convert.ToInt32(e.Parameter);
    }

    protected void detailGrid_DataSelect(object sender, EventArgs e)
    {

        Object masterKey = (sender as ASPxGridView).GetMasterRowKeyValue();
        Session["colDate"] = mainGrid.GetRowValuesByKeyValue(masterKey, "colDate");
        Session["colUserID"] = mainGrid.GetRowValuesByKeyValue(masterKey, "colUserID");
        Session["colType"] = "0";
        /*
                detailsDataSource.SelectParameters["colDate"].DefaultValue = dateTo.Date.ToString();
                detailsDataSource.SelectParameters["colUserID"].DefaultValue = cbEmployee.SelectedItem.Value.ToString();

                Session["CustomerID"] = (sender as ASPxGridView).GetMasterRowKeyValue();
         */ 
    }
    protected void mainGrid_BeforeColumnSortingGrouping(object sender, ASPxGridViewBeforeColumnGroupingSortingEventArgs e)
    {

        if (e.Column.Name == "colName")
            mainGrid.Columns["colName"].Visible = ((mainGrid.Columns["colName"] as GridViewDataColumn).GroupIndex != -1);
    }

    protected void mainGrid_HtmlDataCellPrepared(object sender, ASPxGridViewTableDataCellEventArgs e)
    {
        if (e.DataColumn.FieldName == "colTimeIn")
        {
            string str = e.GetValue("colShiftExp").ToString();
            if (str.Contains("Late"))
            {
                e.Cell.BackColor = Color.Red;
                e.Cell.ForeColor = Color.White;
            }
        }
        if (e.DataColumn.FieldName == "colTimeOut")
        {
            string str = e.GetValue("colShiftExp").ToString();
            if (str.Contains("Early"))
            {
                e.Cell.BackColor = Color.Red;
                e.Cell.ForeColor = Color.White;
            }
        }
        if (e.DataColumn.FieldName == "colLaunchOut")
        {
            string str = e.GetValue("colLaunchExp").ToString();
            if (str.Contains("Early"))
            {
                e.Cell.BackColor = Color.Coral;
                e.Cell.ForeColor = Color.White;
            }
        }
        if (e.DataColumn.FieldName == "colLaunchIn")
        {
            string str = e.GetValue("colLaunchExp").ToString();
            if (str.Contains("Late"))
            {
                e.Cell.BackColor = Color.Coral;
                e.Cell.ForeColor = Color.White;
            }
        }
    }
    protected void mainGrid_CustomSummaryCalculate(object sender, DevExpress.Data.CustomSummaryEventArgs e)
    {
        if (e.IsGroupSummary)
        {
            if ((e.Item as ASPxSummaryItem).Tag == "colTHours")
            {
                if (e.SummaryProcess == DevExpress.Data.CustomSummaryProcess.Calculate)
                {
                    tGWHours += Convert.ToInt32(e.GetValue("colTHoursInt"));
                }
                else
                    if (e.SummaryProcess == DevExpress.Data.CustomSummaryProcess.Start)
                        tGWHours = 0;
                if (e.SummaryProcess == DevExpress.Data.CustomSummaryProcess.Finalize)
                {
                    int mins = tGWHours % 60;
                    string h = (tGWHours / 60).ToString() + ":" + ("00".Substring(0, 2-mins.ToString().Length) + mins.ToString());
                    e.TotalValue = h;
                }
            }
            if ((e.Item as ASPxSummaryItem).Tag == "colOvertime")
            {
                if (e.SummaryProcess == DevExpress.Data.CustomSummaryProcess.Calculate)
                {
                    tGOvertime += Convert.ToInt32(e.GetValue("colOvertimeInt"));
                }
                else
                    if (e.SummaryProcess == DevExpress.Data.CustomSummaryProcess.Start)
                        tGOvertime = 0;
                if (e.SummaryProcess == DevExpress.Data.CustomSummaryProcess.Finalize)
                {
                    int mins = tGOvertime % 60;
                    string h = (tGOvertime / 60).ToString() + ":" + ("00".Substring(0, 2-mins.ToString().Length) + mins.ToString());
                    e.TotalValue = h;

                }
            }
            if ((e.Item as ASPxSummaryItem).Tag == "colLateLeave")
            {
                if (e.SummaryProcess == DevExpress.Data.CustomSummaryProcess.Calculate)
                {
                    tGLateLeave += Convert.ToInt32(e.GetValue("colLateLeaveInt"));
                }
                else
                    if (e.SummaryProcess == DevExpress.Data.CustomSummaryProcess.Start)
                        tGLateLeave = 0;
                if (e.SummaryProcess == DevExpress.Data.CustomSummaryProcess.Finalize)
                {
                    int mins = tGLateLeave % 60;
                    string h = (tGLateLeave / 60).ToString() + ":" + ("00".Substring(0, 2-mins.ToString().Length) + mins.ToString());
                    e.TotalValue = h;
                }
            }
        }
        else
        {
            if ((e.Item as ASPxSummaryItem).Tag == "colGTHours")
            {
                if (e.SummaryProcess == DevExpress.Data.CustomSummaryProcess.Calculate)
                {
//                    tWHours = tWHours.AddMinutes(Convert.ToInt32(e.GetValue("colTHoursInt")));
                    tWHours += Convert.ToInt32(e.GetValue("colTHoursInt"));
                    //                    tWHours = new DateTime(tWHours.Ticks + (DateTime.Parse(e.GetValue("colTHours").ToString())).Ticks);
                }
                else
                    if (e.SummaryProcess == DevExpress.Data.CustomSummaryProcess.Start)
                        tWHours = 0;
                if (e.SummaryProcess == DevExpress.Data.CustomSummaryProcess.Finalize)
                {
                    int mins = tWHours % 60;
                    string h = (tWHours / 60).ToString() + ":" + ("00".Substring(0, 2-mins.ToString().Length) + mins.ToString());
                    e.TotalValue = h;
                }
            }
            if ((e.Item as ASPxSummaryItem).Tag == "colGOvertime")
            {
                if (e.SummaryProcess == DevExpress.Data.CustomSummaryProcess.Calculate)
                {
                    tOvertime += Convert.ToInt32(e.GetValue("colOvertimeInt"));
                }
                else
                    if (e.SummaryProcess == DevExpress.Data.CustomSummaryProcess.Start)
                        tOvertime = 0;
                if (e.SummaryProcess == DevExpress.Data.CustomSummaryProcess.Finalize)
                {
                    int mins = tOvertime % 60;
                    string h = (tOvertime / 60).ToString() + ":" + ("00".Substring(0, 2-mins.ToString().Length) + mins.ToString());
                    e.TotalValue = h;
                }
            }
            if ((e.Item as ASPxSummaryItem).Tag == "colGLateLeave")
            {
                if (e.SummaryProcess == DevExpress.Data.CustomSummaryProcess.Calculate)
                {
                    tLateLeave += Convert.ToInt32(e.GetValue("colLateLeaveInt"));
                }
                else
                    if (e.SummaryProcess == DevExpress.Data.CustomSummaryProcess.Start)
                        tLateLeave = 0;
                if (e.SummaryProcess == DevExpress.Data.CustomSummaryProcess.Finalize)
                {
                    int mins = tLateLeave % 60;
                    string h = (tLateLeave / 60).ToString() + ":" + ("00".Substring(0, 2-mins.ToString().Length) + mins.ToString());
                    e.TotalValue = h;
                }
            }
        }
    }
}