using System;
using System.Collections.Generic;
using System.Linq;
using System.Web;
using System.Data.SqlClient;
using System.Data;
using System.Configuration;
using System.Collections;
using System.Net;
using System.IO;
using System.Web.UI;
using System.Web.Script.Serialization;
using System.Globalization;
using System.Data.SqlTypes;
using System.Text;

/// <summary>
/// Summary description for Utils
/// </summary>
/// 
public partial class BasePage : System.Web.UI.Page 
{
    public string erMsg
    {
        get;
        set;
    }

    public class SessionData
    {
        public string colSessionID
        {
            get
            {
                try
                {
                    return HttpContext.Current.Session["colSessionID"].ToString();
                }
                catch
                { return null; }
            }
            set { HttpContext.Current.Session["colSessionID"] = value; }
        }



        public int isNew
        {
            get
            {
                int outcome;
                try
                {
                    outcome = Convert.ToInt32(HttpContext.Current.Session["isNew"]);
                }
                catch
                {
                    outcome = 0;
                }
                return outcome;
            }
            set
            {
                HttpContext.Current.Session["isNew"] = value;
            }
        }
        public int colID
        {
            get
            {
                int outcome;
                try
                {
                    outcome = Convert.ToInt32(HttpContext.Current.Session["colID"]);
                }
                catch
                {
                    outcome = 0;
                }
                return outcome;
            }
            set
            {
                HttpContext.Current.Session["colID"] = value;
            }
        }

    }


    public static string updateEmp(string colUserID)
    {





        HttpWebRequest request = (HttpWebRequest)WebRequest.Create(ConfigurationManager.AppSettings["dURL"] + "users/" + colUserID);
        request.Method = "PUT";
        request.ContentType = "application/json";
        request.Headers["Cookie"] = "bs-cloud-session-id=" + HttpContext.Current.Session["token"];
//        string postData = "{\"name\":\"Salam\"}";

        var values = string.Format("name={0}", "value1", "salam");
        var bytes = Encoding.UTF8.GetBytes(values);

        Stream stream = request.GetRequestStream();
        stream.Write(bytes, 0, bytes.Length);
        stream.Flush();
        stream.Close();


        try
        {
            var httpResponse = (HttpWebResponse)request.GetResponse();

            using (var streamReader = new StreamReader(httpResponse.GetResponseStream()))
            {
                var result3 = streamReader.ReadToEnd();

            }
        }

        catch (Exception ex)
        {
            return ex.Message;
        }

        return "ok";
    }
/*


        CultureInfo culture = CultureInfo.InvariantCulture;

        HttpWebRequest request = (HttpWebRequest)WebRequest.Create(ConfigurationManager.AppSettings["dURL"] + "users/"+colUserID);
        request.Method = "PUT";
        request.ContentType = "application/json";
        request.Headers["Cookie"] = "bs-cloud-session-id=" + HttpContext.Current.Session["token"];
        string postData = "{\"name\":\"Salam\"}";

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
                    HttpContext.Current.Session["token"] = httpResponse.Headers["set-token"];
                    String setCookieHeader = httpResponse.Headers[HttpResponseHeader.SetCookie];
                    CookieContainer cookieContainer = new CookieContainer();
                    System.Net.Cookie cook = new System.Net.Cookie("bs-cloud-session-id", httpResponse.Headers["set-token"].ToString());
                    request.CookieContainer = cookieContainer;
                }
            }
        }
        catch (Exception ex)
        {
            return ex.Message;
        }

        return "ok";
 * 
    }
    */
    public static string loginBIO(System.Web.UI.Page pg, Object obj)
    {
        CultureInfo culture = CultureInfo.InvariantCulture;

        SqlConnection sqlConnection = new SqlConnection(ConfigurationManager.ConnectionStrings["timesheetConnectionString"].ConnectionString);
        sqlConnection.Open();
        HttpWebRequest request = (HttpWebRequest)WebRequest.Create(ConfigurationManager.AppSettings["dURL"] + "login");
        request.Method = "POST";
        request.ContentType = "application/json";

        //            string postData = "{\"name\":\"bioaq\", \"password\":\"" + tbPassword.Text + " \", \"user_id\":\"" + tbUserName.Text + "\"}";

        string DName = ConfigurationManager.AppSettings["DName"];
        string DPassword = ConfigurationManager.AppSettings["DPassword"];
        string DUserName = ConfigurationManager.AppSettings["DUserName"];
        string postData = "{\"name\":\"" + DName + "\", \"password\":\"" + DPassword + "\", \"user_id\":\"" + DUserName + "\"}";

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
                    HttpContext.Current.Session["token"] = httpResponse.Headers["set-token"];
                    String setCookieHeader = httpResponse.Headers[HttpResponseHeader.SetCookie];
                    CookieContainer cookieContainer = new CookieContainer();
                    System.Net.Cookie cook = new System.Net.Cookie("bs-cloud-session-id", httpResponse.Headers["set-token"].ToString());
                    request.CookieContainer = cookieContainer;
                }
            }
        }
        catch (Exception ex)
        {
            return ex.Message;
        }


        DataSet dataSet = new DataSet();

        request = (HttpWebRequest)WebRequest.Create(ConfigurationManager.AppSettings["dURL"] + "users?limit=1000&offset=0");
        request.Method = "GET";
        request.ContentType = "application/json";
        request.Headers["Cookie"] = "bs-cloud-session-id=" + HttpContext.Current.Session["token"];
        var result3 = "";
        try
        {
            var httpResponse = (HttpWebResponse)request.GetResponse();

            using (var streamReader = new StreamReader(httpResponse.GetResponseStream()))
            {
                result3 = streamReader.ReadToEnd();

            }
        }

        catch (Exception ex)
        {

        }




        if (!String.IsNullOrEmpty(result3))
        {
            JavaScriptSerializer js = new JavaScriptSerializer();
            var ob = js.Deserialize<dynamic>(result3);
            foreach (var item in ob["records"])
            {
                try
                {
                    dataSet = BasePage.getData("if not exists ( select colUserID from ts_employee where colUserID = '" + item["user_id"].ToString() + "') select 0 else select 1");
                    Int32 colUserID = Convert.ToInt32(dataSet.Tables["getData"].Rows[0][0]);
                    if (colUserID == 0)
                    {
                        string[] names = item["name"].ToString().Split(' ');
                        string colFName = names.ElementAtOrDefault(0) ?? item["name"].ToString();
                        string colLName = names.ElementAtOrDefault(1) ?? "";
                        string colPhoto = getPhoto(item["user_id"]);
                        string colMName = names.ElementAtOrDefault(2) ?? "";
//                        string sql = string.Format("insert into ts_employee (colUserID, colName, colFName, colLName, colMName) select '{0}', '{1}', '{2}', '{3}', '{4}'", item["user_id"].ToString(), item["name"].ToString(), colFName, colLName, colMName);
                        string sql = string.Format("exec [sp_update_employee] @colID = null, @colUserID = {0}, @colFName = '{1}', @colLName = '{2}', @colMName = '{3}', @colImage = '{4}'", item["user_id"].ToString(), colFName, colLName, colMName, colPhoto);
                        ExecSQL(sql);
                    }



                }
                catch (Exception ex)
                {
                    return ex.Message;
                }
            }
        }


        checkTimesheet();

        return "ok";


    }

    public static string getPhoto(string colUserID)
    {
        string colPhoto = "";

        HttpWebRequest request = (HttpWebRequest)WebRequest.Create(ConfigurationManager.AppSettings["dURL"] + "users/" + colUserID + "/photo");
        request.Method = "GET";
        request.ContentType = "application/json";
        request.Headers["Cookie"] = "bs-cloud-session-id=" + HttpContext.Current.Session["token"];

        try
        {
            var httpResponse = (HttpWebResponse)request.GetResponse();

            using (var streamReader = new StreamReader(httpResponse.GetResponseStream()))
            {
                colPhoto = streamReader.ReadToEnd();
                colPhoto = colPhoto.Substring(1, colPhoto.Length - 2);
            }
        }

        catch (Exception ex)
        {
            return ex.Message;
        }
        return colPhoto;
    }


    public static string checkTimesheet()
    {
        string ret = "no";
        CultureInfo culture = CultureInfo.InvariantCulture;

        SqlConnection sqlConnection = new SqlConnection(ConfigurationManager.ConnectionStrings["timesheetConnectionString"].ConnectionString);
        sqlConnection.Open();



        HttpWebRequest request = (HttpWebRequest)WebRequest.Create(ConfigurationManager.AppSettings["dURL"] + "monitoring/event_log/search");
        request.Method = "POST";
        request.ContentType = "application/json";
        request.Headers["Cookie"] = "bs-cloud-session-id=" + HttpContext.Current.Session["token"];


        DataSet dataSet = new DataSet();

        dataSet = BasePage.getData("select dateadd(hour, -5, ISNULL(max(colDateTime), '2022-01-01')) as colDatewTime from ts_timesheet ");
        string colDate1 = Convert.ToDateTime(dataSet.Tables["getData"].Rows[0][0]).ToString("yyyy-MM-ddTHH:mm:ss.00Z");
        string colDate2 = DateTime.Now.ToString("yyyy-MM-ddTHH:mm:ss.00Z");

        string postData = "{\"limit\":\"4000\", \"offset\":\"0\", \"datetime\":[\"" + colDate1 + "\",\"" + colDate2 + "\"]}";


        var result2 = "";
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
                    result2 = streamReader.ReadToEnd();
                }
            }
        }
        catch (Exception ex)
        {
            return ex.Message;
        }

        if (!String.IsNullOrEmpty(result2))
        {
            JavaScriptSerializer js = new JavaScriptSerializer();
            var ob = js.Deserialize<dynamic>(result2);
            foreach (var item in ob["records"])
            {

                if (item.ContainsKey("user"))
                {

                    //                    if (item["event_type"]["code"].ToString() == "4867")
                    {
                        DateTime colDate = DateTime.Parse(item["datetime"].ToString(), culture, DateTimeStyles.None);
                        Int16 colWDay = (Int16)colDate.DayOfWeek;
                        try
                        {
                            dataSet = BasePage.getData("if (not exists(select colID from ts_timesheet where colBID = " + item["id"].ToString() + ")) select 0 else select 1");
                            if (dataSet.Tables["getData"].Rows[0][0].ToString() == "0")
                            {
                                string sql = "insert into ts_timesheet (colWDay, colDateTime, colCode, colIndex, colBID, colDate, colTime, colUserID, colUserName, colType, colDevID) select " + colWDay.ToString() + ", '" + colDate.ToString("MM/dd/yyyy HH:mm:ss") + "', '" +
                                item["event_type"]["code"].ToString() + "', " + item["index"].ToString() + ", " + item["id"].ToString() + ", '" + colDate.ToString("MM/dd/yyyy") + "', '" + colDate.ToString("HH:mm:ss") + "', " + item["user"]["user_id"].ToString() + ", N'" + item["user"]["name"].ToString() + "', 0, " + item["device"]["id"].ToString();
                                ExecSQL(sql);
                                ret = "yes";
                            }
                        }
                        catch (Exception ex)
                        {
//                            return ex.Message;
                        }
                    }
                }
            }


        }

        return ret;
    }


    public static int MsgBox(String ex, System.Web.UI.Page pg, Object obj)
    {
        string s = "<SCRIPT language='javascript'>alert('" + ex.Replace("\r\n", "\\n").Replace("'", "") + "'); </SCRIPT>";
        Type cstype = obj.GetType();
        ClientScriptManager cs = pg.ClientScript;
        cs.RegisterClientScriptBlock(cstype, s, s.ToString());
        return 0;
    }

    public static int ExecSQL(string sqltext)
    {

        using (SqlConnection connection =
                   new SqlConnection(System.Configuration.ConfigurationManager.ConnectionStrings["timesheetConnectionString"].ConnectionString))
        {
            SqlCommand command = connection.CreateCommand();
            command.CommandText = sqltext;
            command.CommandType = CommandType.Text;
            connection.Open();
            int res = command.ExecuteNonQuery();
            return res;
        }
    }


    public static DataSet getData(string sqlText)
    {
        DataSet custDS = new DataSet();
        SqlDataAdapter adapter = new SqlDataAdapter(sqlText, System.Configuration.ConfigurationManager.ConnectionStrings["timesheetConnectionString"].ConnectionString);
        adapter.MissingSchemaAction = MissingSchemaAction.AddWithKey;
        adapter.Fill(custDS, "getData");
        return custDS;
    }


    public static string GetIPAddress_NEW()
    {
        HttpContext current = HttpContext.Current;
        string str_ = current.Request.ServerVariables["HTTP_X_FORWARDED_FOR"];
        if (!string.IsNullOrEmpty(str_))
        {
            string[] arr_ = str_.Split(new char[]
               {
                    ','
               });
            if (arr_.Length != 0)
            {
                return arr_[0];
            }
        }
        return current.Request.ServerVariables["REMOTE_ADDR"];
    }

    public static string UpdateData_full(string data, string sp)
    {
        int retval;
        string cmdText = "select colError, colVal from st_errors where colApp= @colApp and colPar = @colPar";
        string str_ = "";
        SqlConnection sqlConnection = new SqlConnection(ConfigurationManager.ConnectionStrings["setsConnectionString_true"].ConnectionString);
        sqlConnection.Open();
        SqlCommand sqlCommand = new SqlCommand(sp, sqlConnection);
        sqlCommand.CommandType = CommandType.StoredProcedure;
        SqlCommandBuilder.DeriveParameters(sqlCommand);
        SqlCommand sqlCommand2 = new SqlCommand(sp, sqlConnection);
//        SqlParameter parm = new SqlParameter("@return", SqlDbType.Text);

        sqlCommand2.CommandType = CommandType.StoredProcedure;


        string str_2 = "";
        IEnumerator enumerator = sqlCommand.Parameters.GetEnumerator();
        try
        {
            while (enumerator.MoveNext())
            {
                SqlParameter sqlParameter = (SqlParameter)enumerator.Current;
                string parameterName = sqlParameter.ParameterName;
                if (!(parameterName == "@RETURN_VALUE"))
                {
                    int int_ = data.IndexOf(parameterName);
                    if (int_ > 0)
                    {
                        try
                        {
                            str_2 = data.Substring(int_ + parameterName.Length);
                            int_ = str_2.IndexOf("=") + 1;
                            int int_2 = str_2.IndexOf("@");
                            if (int_2 > 0)
                            {
                                str_2 = str_2.Substring(int_, int_2 - int_);
                                str_2 = str_2.Substring(0, str_2.LastIndexOf(","));
                                if (str_2.Trim() == "")
                                {
                                    using (SqlCommand sqlCommand3 = new SqlCommand(cmdText, sqlConnection))
                                    {
                                        sqlCommand3.Parameters.AddWithValue("@colApp", sp);
                                        sqlCommand3.Parameters.AddWithValue("@colPar", sqlParameter.ParameterName);
                                        using (SqlDataReader sqlDataReader = sqlCommand3.ExecuteReader())
                                        {
                                            if (!sqlDataReader.Read())
                                            {
                                                throw new Exception("Something is very wrong");
                                            }
                                            if (sqlDataReader["colError"].ToString() != "")
                                            {
                                                str_ = str_ + sqlDataReader["colError"].ToString() + ", ";
                                            }
                                        }
                                    }
                                    sqlCommand2.Parameters.Add(sqlParameter.ParameterName, sqlParameter.SqlDbType).Value = DBNull.Value;
                                }
                                else
                                {
                                    sqlCommand2.Parameters.Add(sqlParameter.ParameterName, sqlParameter.SqlDbType).Value = str_2.Trim().Replace("<#>", "@");
                                }
                            }
                            else
                            {
                                str_2 = str_2.TrimEnd(new char[0]);
                                if (str_2[str_2.Length - 1] == ',')
                                {
                                    str_2 = str_2.Substring(int_, str_2.LastIndexOf(",") - int_);
                                }
                                if (str_2.Trim() == "")
                                {
                                    using (SqlCommand sqlCommand4 = new SqlCommand(cmdText, sqlConnection))
                                    {
                                        sqlCommand4.Parameters.AddWithValue("@colApp", sp);
                                        sqlCommand4.Parameters.AddWithValue("@colPar", sqlParameter.ParameterName);
                                        using (SqlDataReader sqlDataReader2 = sqlCommand4.ExecuteReader())
                                        {
                                            if (!sqlDataReader2.Read())
                                            {
                                                throw new Exception("Something is very wrong");
                                            }
                                            if (sqlDataReader2["colError"].ToString() != "")
                                            {
                                                string str_3 = str_;
                                                str_ = string.Concat(new string[]
                                                            {
                                                                 str_3, 
                                                                 sqlParameter.ParameterName, 
                                                                 ":", 
                                                                 sqlDataReader2["colError"].ToString(), 
                                                                 ", "
                                                            });
                                            }
                                        }
                                    }
                                    sqlCommand2.Parameters.Add(sqlParameter.ParameterName, sqlParameter.SqlDbType).Value = DBNull.Value;
                                }
                                else
                                {
                                    sqlCommand2.Parameters.Add(sqlParameter.ParameterName, sqlParameter.SqlDbType).Value = str_2.Trim().Replace("<#>", "@");
                                }
                            }
                        }
                        catch
                        {
                        }
                    }
                }
                else
                {

                    //            sqlCommand2.Parameters.Add("@retValue", System.Data.SqlDbType.Int).Value = 0;
                    //            sqlCommand2.Parameters.Add("@retValue", System.Data.SqlDbType.Int).Direction = System.Data.ParameterDirection.ReturnValue;
                }

            }
        }
        finally
        {
            IDisposable disposable_ = enumerator as IDisposable;
            if (disposable_ != null)
            {
                disposable_.Dispose();
            }
        }
        try
        {

            SqlParameter RuturnValue = new SqlParameter("@RETURN_VALUE", SqlDbType.Int);
            RuturnValue.Direction = ParameterDirection.Output;
            sqlCommand2.Parameters.Add(RuturnValue);

            sqlCommand2.ExecuteNonQuery();

            retval = (int)sqlCommand2.Parameters["@RETURN_VALUE"].Value;
        }
        catch (SqlException varWDF0)
        {
            SqlException sqlException = varWDF0;
            sqlConnection.Close();
//            throw new Exception(sqlException.Message);
//            str_ = sqlException.Message;
            return sqlException.Message;
        }

        sqlConnection.Close();
        return retval.ToString();
    }
    public static string UpdateData_min(string data, string sp)
    {
        string cmdText = "select colError, colVal from st_errors where colApp= @colApp and colPar = @colPar";
        string str_ = "";
        SqlConnection sqlConnection = new SqlConnection(ConfigurationManager.ConnectionStrings["setsConnectionString_true"].ConnectionString);
        sqlConnection.Open();
        SqlCommand sqlCommand = new SqlCommand(sp, sqlConnection);
        sqlCommand.CommandType = CommandType.StoredProcedure;
        SqlCommandBuilder.DeriveParameters(sqlCommand);
        SqlCommand sqlCommand2 = new SqlCommand(sp, sqlConnection);
        sqlCommand2.CommandType = CommandType.StoredProcedure;
        string str_2 = "";
        IEnumerator enumerator = sqlCommand.Parameters.GetEnumerator();
        try
        {
            while (enumerator.MoveNext())
            {
                SqlParameter sqlParameter = (SqlParameter)enumerator.Current;
                string parameterName = sqlParameter.ParameterName;
                if (!(parameterName == "@RETURN_VALUE"))
                {
                    int int_ = data.IndexOf(parameterName);
                    if (int_ > 0)
                    {
                        try
                        {
                            str_2 = data.Substring(int_ + parameterName.Length);
                            int_ = str_2.IndexOf("=") + 1;
                            int int_2 = str_2.IndexOf("@");
                            if (int_2 > 0)
                            {
                                str_2 = str_2.Substring(int_, int_2 - int_);
                                str_2 = str_2.Substring(0, str_2.LastIndexOf(","));
                                if (str_2.Trim() == "")
                                {
                                    using (SqlCommand sqlCommand3 = new SqlCommand(cmdText, sqlConnection))
                                    {
                                        sqlCommand3.Parameters.AddWithValue("@colApp", sp);
                                        sqlCommand3.Parameters.AddWithValue("@colPar", sqlParameter.ParameterName);
                                        using (SqlDataReader sqlDataReader = sqlCommand3.ExecuteReader())
                                        {
                                            if (!sqlDataReader.Read())
                                            {
                                                throw new Exception("Something is very wrong");
                                            }
                                            if (sqlDataReader["colError"].ToString() != "")
                                            {
                                                str_ = str_ + sqlDataReader["colError"].ToString() + ", ";
                                            }
                                        }
                                    }
                                    sqlCommand2.Parameters.Add(sqlParameter.ParameterName, sqlParameter.SqlDbType).Value = DBNull.Value;
                                }
                                else
                                {
                                    sqlCommand2.Parameters.Add(sqlParameter.ParameterName, sqlParameter.SqlDbType).Value = str_2.Trim().Replace("<#>", "@");
                                }
                            }
                            else
                            {
                                str_2 = str_2.TrimEnd(new char[0]);
                                if (str_2[str_2.Length - 1] == ',')
                                {
                                    str_2 = str_2.Substring(int_, str_2.LastIndexOf(",") - int_);
                                }
                                if (str_2.Trim() == "")
                                {
                                    using (SqlCommand sqlCommand4 = new SqlCommand(cmdText, sqlConnection))
                                    {
                                        sqlCommand4.Parameters.AddWithValue("@colApp", sp);
                                        sqlCommand4.Parameters.AddWithValue("@colPar", sqlParameter.ParameterName);
                                        using (SqlDataReader sqlDataReader2 = sqlCommand4.ExecuteReader())
                                        {
                                            if (!sqlDataReader2.Read())
                                            {
                                                throw new Exception("Something is very wrong");
                                            }
                                            if (sqlDataReader2["colError"].ToString() != "")
                                            {
                                                string str_3 = str_;
                                                str_ = string.Concat(new string[]
                                                            {
                                                                 str_3, 
                                                                 sqlParameter.ParameterName, 
                                                                 ":", 
                                                                 sqlDataReader2["colError"].ToString(), 
                                                                 ", "
                                                            });
                                            }
                                        }
                                    }
                                    sqlCommand2.Parameters.Add(sqlParameter.ParameterName, sqlParameter.SqlDbType).Value = DBNull.Value;
                                }
                                else
                                {
                                    sqlCommand2.Parameters.Add(sqlParameter.ParameterName, sqlParameter.SqlDbType).Value = str_2.Trim().Replace("<#>", "@");
                                }
                            }
                        }
                        catch
                        {
                        }
                    }
                }
            }
        }
        finally
        {
            IDisposable disposable_ = enumerator as IDisposable;
            if (disposable_ != null)
            {
                disposable_.Dispose();
            }
        }
        try
        {
            sqlCommand2.ExecuteNonQuery();
        }
        catch (SqlException varWDF0)
        {
            SqlException sqlException = varWDF0;
            sqlConnection.Close();
            throw new Exception(sqlException.Message);
        }
        sqlConnection.Close();
        return str_;
    }


}