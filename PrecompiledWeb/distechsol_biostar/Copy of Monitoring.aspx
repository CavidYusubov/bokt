<%@ page language="C#" autoeventwireup="true" masterpagefile="~/Site.master" inherits="_Default, App_Web_3tzlguhl" %>

<asp:Content ID="Content" ContentPlaceHolderID="MainContent" runat="server">
    <link href="~/Content/Card.css" rel="stylesheet" /> 


    <script type="text/javascript" >
    function getShift(s, e) {
//        if (s.GetSelectedIndex() == -1) btnSave.SetEnabled(true); else btnSave.SetEnabled(false);
    }
</script>


<table style="border-spacing: 0px; border-collapse: separate;">
<tr>
<td>
Monitoring
</td>

</tr>
<tr>
<td>


 <dx:ASPxCardView ID="CardView" runat="server" EnableCardsCache="False" 
        AutoGenerateColumns="False" DataSourceID="ds_monitoring">
        <SettingsPager SettingsTableLayout-RowsPerPage="1" EnableAdaptivity="true" >
<SettingsTableLayout RowsPerPage="3"></SettingsTableLayout>
        </SettingsPager>

        <Columns>
            <dx:CardViewBinaryImageColumn FieldName="colImage">
                <PropertiesBinaryImage ImageWidth="250px" ImageHeight="250px" />
            </dx:CardViewBinaryImageColumn>
            <dx:CardViewColumn FieldName="colName" />
            <dx:CardViewColumn FieldName="colTitle" />
            <dx:CardViewColumn FieldName="colPosition" />
        </Columns>

        <Templates>
            <Card>
                <dx:ASPxBinaryImage ID="Photo" runat="server" Value='<%# Eval("colImage") %>' />
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
        <Styles CssFilePath="~/Content/Card.css">
            <Card CssClass="Card" />
        </Styles>
    </dx:ASPxCardView>




    <asp:SqlDataSource ID="ds_monitoring" runat="server" 
        ConnectionString="<%$ ConnectionStrings:timesheetConnectionString %>" 
        SelectCommand="sp_monitoring" SelectCommandType="StoredProcedure">
    </asp:SqlDataSource>





</asp:Content>
