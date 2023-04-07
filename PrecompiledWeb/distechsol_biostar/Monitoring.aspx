<%@ page language="C#" autoeventwireup="true" masterpagefile="~/Site.master" inherits="_Default, App_Web_ycbn33n4" %>

<asp:Content ID="Content" ContentPlaceHolderID="MainContent" runat="server">



<style type="text/css">

.card
{
    position: relative;
    height: 170px !important;
    width: 200px !important;
}
.card img
{
    display: block;
    margin: auto;
    padding: 15px 0;
}
.card .info
{
    position: absolute;
    top: 0;
    left: 0;
    right: 0;
    bottom: 0;
    color: white;
    background-color: black;
    opacity: 0;
    text-align: center;
    transition: all 0.4s ease-in-out;
    -webkit-transition: all 0.4s ease-in-out;
    -moz-transition: all 0.4s ease-in-out;
    -ms-transition: all 0.4s ease-in-out;
    -o-transition: all 0.4s ease-in-out;
}
.card:hover .info
{
    opacity: 0.8;
}
.info .address
{
    padding-top: 20px;
}
.info p
{
    margin-top: 45px;
}
.card .info p,
.card .info span
{
    font-size: 12pt;
    color: white;
    opacity: 0;
    -webkit-transition:all 0.3s ease-out;
    -moz-transition:all 0.3s ease-out;
    -ms-transition:all 0.3s ease-out;
    -o-transition:all 0.3s ease-out;
    transition: all 0.3s ease-out;
    -moz-transform: scale(0);
    -webkit-transform: scale(0);
    -o-transform: scale(0);
    -ms-transform: scale(0);
    transform: scale(0);
}
.card .info .address span
{
    font-size: 10pt;
}
.card:hover .info p,
.card:hover .info span
{
    opacity: 1;
    -moz-transform: scale(1);
    -webkit-transform: scale(1);
    -o-transform: scale(1);
    -ms-transform: scale(1);
    transform: scale(1);
}


  </style>


<script type="text/javascript">
    var timeout;
    function scheduleGridUpdate(grid) {
        window.clearTimeout(timeout);
        timeout = window.setTimeout(
                function () { grid.Refresh(); },
                20000000
            );
    }
    function grid_Init(s, e) {
        scheduleGridUpdate(s);
    }
    function grid_BeginCallback(s, e) {
        window.clearTimeout(timeout);
    }
    function grid_EndCallback(s, e) {
        scheduleGridUpdate(s);
    }


    function checkStat() {
        ASPxCallbackPanel1.PerformCallback();
//        alert(ASPxLabel5.GetText());
        if (ASPxLabel5.GetText() == "ok") {
            CardView.Refresh();
            ASPxLabel5.SetText("");
        }
    }

    </script>


    <dx:ASPxTimer ID="ASPxTimer1" runat="server" Interval="2000">
        <ClientSideEvents Tick="checkStat" />


    </dx:ASPxTimer>
<center>
<table style="border-spacing: 0px; border-collapse: separate;" >
<tr>
<td>
Monitoring
</td>

</tr>
<tr>

<td>

<dx:ASPxCallbackPanel ID="ASPxCallbackPanel1" ClientInstanceName="ASPxCallbackPanel1" Width="200px" runat="server" 
        oncallback="ASPxCallbackPanel1_Callback">
        
    <SettingsLoadingPanel Enabled="False" ShowImage="False" Text="" />
        
<PanelCollection>
<dx:PanelContent runat="server">
    <dx:ASPxLabel ID="ASPxLabel5" ClientInstanceName="ASPxLabel5" runat="server" Text="">
    </dx:ASPxLabel>
</dx:PanelContent>
</PanelCollection>
        

</dx:ASPxCallbackPanel>

 <dx:ASPxCardView ID="CardView" ClientInstanceName="CardView" runat="server" EnableCardsCache="False" 
        AutoGenerateColumns="False" DataSourceID="ds_monitoring" 
         >
        <SettingsPager SettingsTableLayout-RowsPerPage="1" EnableAdaptivity="true" >
<SettingsTableLayout  ColumnCount="4" RowsPerPage="3" ></SettingsTableLayout>
        </SettingsPager>


        <ClientSideEvents Init="grid_Init" BeginCallback="grid_BeginCallback" EndCallback="grid_EndCallback" />
        

        <Columns>
            <dx:CardViewBinaryImageColumn FieldName="colImage">
                <PropertiesBinaryImage ImageWidth="150px" ImageHeight="150px" />
            </dx:CardViewBinaryImageColumn>
            <dx:CardViewColumn FieldName="colName" />
            <dx:CardViewColumn FieldName="colTitle" />
            <dx:CardViewColumn FieldName="colPosition" />
        </Columns>

        <Templates>
            <Card>
                <dx:ASPxBinaryImage ID="Photo" runat="server" Value='<%# Eval("colImage") %>' Width="150px" Height="150px"/>
                <div class="info">
                    <p><dx:ASPxLabel ID="ASPxLabel1" runat="server" Text='<%# Eval("colName") %>' /></p>
                    <dx:ASPxLabel ID="ASPxLabel2" runat="server" Text='<%# Eval("colTitle") %>' />
                    <div class="address">
                        <dx:ASPxLabel ID="ASPxLabel4" runat="server" Text='<%# Eval("colDateTime") %>' />
                        <br />
                        <dx:ASPxLabel ID="ASPxLabel3" runat="server" Text='<%# Eval("colPosition") %>' />
                    </div>
                </div>
            </Card>
        </Templates>
        <Styles >
            <Card CssClass="card" />
        </Styles>
    </dx:ASPxCardView>




    <asp:SqlDataSource ID="ds_monitoring" runat="server" 
        ConnectionString="<%$ ConnectionStrings:timesheetConnectionString %>" 
        SelectCommand="sp_monitoring" SelectCommandType="StoredProcedure">
    </asp:SqlDataSource>





</asp:Content>
