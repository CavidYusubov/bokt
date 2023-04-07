<%@ Page Language="C#" AutoEventWireup="true" MasterPageFile="~/Site.master" CodeFile="Copy of Timesheet.aspx.cs" Inherits="_Default" %>

<asp:Content ID="Content" ContentPlaceHolderID="MainContent" runat="server">

<script type="text/javascript">
        // <![CDATA[


    var keyValue;
    function OnMoreInfoClick(element, key, Descr) {

        Vpopup.SetHeaderText(Descr);
        VcallbackPanel.SetContentHtml("");
        Vpopup.ShowAtElement(element);
        keyValue = colDescrID;
    }

    function Vpopup_Shown(s, e) {
        VcallbackPanel.PerformCallback(keyValue);
    }
        // ]]>
    </script>


<style>
.MyClass {  
        background:none;  
      }  

</style>
<table >
<tr>
<td>
Period
</td>

</tr>
<tr>
<td>

    <dx:ASPxDateEdit ID="dateFrom" runat="server" DisplayFormatString="dd/MM/yyyy">
    </dx:ASPxDateEdit>

</td>
<td>&nbsp;&nbsp;&nbsp;</td>
<td>


    <asp:SqlDataSource ID="SqlDataSource1" runat="server" 
        ConnectionString="<%$ ConnectionStrings:timesheetConnectionString %>" 
        SelectCommand="SELECT [colUserID], [colName] FROM [ts_employee]">
    </asp:SqlDataSource>



</td>
<td>&nbsp;&nbsp;&nbsp;</td>
<td>
    <dx:ASPxButton ID="ASPxButton1" runat="server" Text="getData" 
        AutoPostBack="False" >
        <ClientSideEvents Click="function(s, e) {mainGrid.PerformCallback();}" />
    </dx:ASPxButton>

</td>
<td>&nbsp;&nbsp;&nbsp;</td>
<td>
    <dx:ASPxButton ID="ASPxButton2" runat="server" Text="toXLS" 
        AutoPostBack="False" onclick="ASPxButton2_Click" >
    </dx:ASPxButton>

</td>
<td>
</td>
</tr>
</table>
<br />

<dx:ASPxPopupControl ID="Vpopup" ClientInstanceName="Vpopup" runat="server" AllowDragging="true"
        PopupHorizontalAlign="OutsideRight" HeaderText="Sign" Width="500px" Height="200px">
        <ClientSideEvents Shown="Vpopup_Shown" />
<ClientSideEvents Shown="Vpopup_Shown"></ClientSideEvents>
        <ContentCollection>
            <dx:PopupControlContentControl ID="PopupControlContentControl2" runat="server">
                <dx:ASPxCallbackPanel ID="VcallbackPanel" ClientInstanceName="VcallbackPanel" runat="server"
                    Width="500px" Height="200px" RenderMode="Table">
                    <PanelCollection>
                        <dx:PanelContent ID="PanelContent2" runat="server">



                        <table >
<tr>
<td>
Date From
</td>
<td>&nbsp;&nbsp;&nbsp;</td>
<td>
Date To
</td>
<td>&nbsp;&nbsp;&nbsp;</td>
<td>
Leave Type
</td>

</tr>
<tr>
<td>

    <dx:ASPxDateEdit ID="ASPxDateEdit1" runat="server" DisplayFormatString="dd/MM/yyyy">
    </dx:ASPxDateEdit>

</td>
<td>&nbsp;&nbsp;&nbsp;</td>
<td>
    <dx:ASPxDateEdit ID="dateTo" runat="server" DisplayFormatString="dd/MM/yyyy">
    </dx:ASPxDateEdit>

</td>
<td>&nbsp;&nbsp;&nbsp;</td>
<td>

<dx:ASPxComboBox ID="cbEmployee" ClientInstanceName="cbEmployee" runat="server" Width = "200px" 
        DropDownStyle = "DropDown" TextField="colName" ValueField="colID" DataSourceID="SqlDataSource2" >


    </dx:ASPxComboBox>

        <asp:SqlDataSource ID="SqlDataSource2" runat="server" 
        ConnectionString="<%$ ConnectionStrings:timesheetConnectionString %>" 
        SelectCommand="SELECT [colID], [colName] FROM [ts_leavetypes]">
    </asp:SqlDataSource>


</td>
<td>&nbsp;&nbsp;&nbsp;</td>
<td>
    <dx:ASPxButton ID="ASPxButton3" runat="server" Text="Update" 
        AutoPostBack="False" >
        <ClientSideEvents Click="function(s, e) {mainGrid.PerformCallback(); cbEmployee.PerformCallback(cbEmployee.GetSelectedIndex()); }" />
    </dx:ASPxButton>

</td>

<td>
</td>
</tr>
</table>





                        </dx:PanelContent>
                    </PanelCollection>
                </dx:ASPxCallbackPanel>
            </dx:PopupControlContentControl>
        </ContentCollection>
    </dx:ASPxPopupControl>        

    <dx:ASPxGridView ID="mainGrid" ClientInstanceName="mainGrid" runat="server" AutoGenerateColumns="False" 
        DataSourceID="ds_mainGride" Width="100%" ondatabound="mainGrid_DataBound" 
        oncustomcallback="mainGrid_CustomCallback" KeyFieldName="colID">
<SettingsCommandButton>
<ShowAdaptiveDetailButton ButtonType="Image"></ShowAdaptiveDetailButton>

<HideAdaptiveDetailButton ButtonType="Image"></HideAdaptiveDetailButton>
</SettingsCommandButton>

        <SettingsPager Mode="ShowAllRecords">
        </SettingsPager>

 <Settings HorizontalScrollBarMode="Visible" />
        <SettingsBehavior AutoExpandAllGroups="true" />
        <Styles>  
            <Header CssClass="MyClass" BackColor="#FFFFFF">  
            </Header>  
        </Styles>

        <Columns>
            <dx:GridViewDataTextColumn FieldName="colID" VisibleIndex="0" ReadOnly="True" Visible="false">
                <EditFormSettings Visible="False" />
            </dx:GridViewDataTextColumn>
            <dx:GridViewDataTextColumn FieldName="colEmpID" VisibleIndex="1" Visible="false">
            </dx:GridViewDataTextColumn>

 <dx:GridViewDataTextColumn FieldName="colFullName" VisibleIndex="4" Caption = "Name" Width="200px">
                <EditFormSettings Visible="False" />

            <DataItemTemplate>

            
                    <a href="javascript:void(0);" onclick="OnMoreInfoClick(this, '<%# Container.KeyValue %>','<%# Eval("colFullName") %>')"><%# Eval("colFullName") %></a>
            </DataItemTemplate>     
            </dx:GridViewDataTextColumn>


            <dx:GridViewDataTextColumn FieldName="colDepartment" VisibleIndex="3" Visible="false">
            </dx:GridViewDataTextColumn>
            <dx:GridViewDataTextColumn FieldName="colPosition" VisibleIndex="4" Visible="false">
            </dx:GridViewDataTextColumn>
            <dx:GridViewDataTextColumn FieldName="colShift" VisibleIndex="5" Visible="false">
            </dx:GridViewDataTextColumn>
            <dx:GridViewDataTextColumn FieldName="colDay1" VisibleIndex="6">
                <HeaderStyle HorizontalAlign="Center" />
            </dx:GridViewDataTextColumn>
            <dx:GridViewDataTextColumn FieldName="colDay2" VisibleIndex="7">
                <HeaderStyle HorizontalAlign="Center" />
            </dx:GridViewDataTextColumn>
            <dx:GridViewDataTextColumn FieldName="colDay3" VisibleIndex="8">
                <HeaderStyle HorizontalAlign="Center" />
            </dx:GridViewDataTextColumn>
            <dx:GridViewDataTextColumn FieldName="colDay4" VisibleIndex="9">
                <HeaderStyle HorizontalAlign="Center" />
            </dx:GridViewDataTextColumn>
            <dx:GridViewDataTextColumn FieldName="colDay5" VisibleIndex="10">
                <HeaderStyle HorizontalAlign="Center" />
            </dx:GridViewDataTextColumn>
            <dx:GridViewDataTextColumn FieldName="colDay6" VisibleIndex="11">
                <HeaderStyle HorizontalAlign="Center" />
            </dx:GridViewDataTextColumn>
            <dx:GridViewDataTextColumn FieldName="colDay7" VisibleIndex="12">
                <HeaderStyle HorizontalAlign="Center" />
            </dx:GridViewDataTextColumn>
            <dx:GridViewDataTextColumn FieldName="colDay8" VisibleIndex="13">
                <HeaderStyle HorizontalAlign="Center" />
            </dx:GridViewDataTextColumn>
            <dx:GridViewDataTextColumn FieldName="colDay9" VisibleIndex="14">
                <HeaderStyle HorizontalAlign="Center" />
            </dx:GridViewDataTextColumn>
            <dx:GridViewDataTextColumn FieldName="colDay10" VisibleIndex="15">
                <HeaderStyle HorizontalAlign="Center" />
            </dx:GridViewDataTextColumn>
            <dx:GridViewDataTextColumn FieldName="colDay11" VisibleIndex="16">
                <HeaderStyle HorizontalAlign="Center" />
            </dx:GridViewDataTextColumn>
            <dx:GridViewDataTextColumn FieldName="colDay12" VisibleIndex="17">
                <HeaderStyle HorizontalAlign="Center" />
            </dx:GridViewDataTextColumn>
            <dx:GridViewDataTextColumn FieldName="colDay13" VisibleIndex="18">
                <HeaderStyle HorizontalAlign="Center" />
            </dx:GridViewDataTextColumn>
            <dx:GridViewDataTextColumn FieldName="colDay14" VisibleIndex="19">
                <HeaderStyle HorizontalAlign="Center" />
            </dx:GridViewDataTextColumn>
            <dx:GridViewDataTextColumn FieldName="colDay15" VisibleIndex="20">
                <HeaderStyle HorizontalAlign="Center" />
            </dx:GridViewDataTextColumn>
            <dx:GridViewDataTextColumn FieldName="colDay16" VisibleIndex="21">
                <HeaderStyle HorizontalAlign="Center" />
            </dx:GridViewDataTextColumn>
            <dx:GridViewDataTextColumn FieldName="colDay17" VisibleIndex="22">
                <HeaderStyle HorizontalAlign="Center" />
            </dx:GridViewDataTextColumn>
            <dx:GridViewDataTextColumn FieldName="colDay18" VisibleIndex="23">
                <HeaderStyle HorizontalAlign="Center" />
            </dx:GridViewDataTextColumn>
            <dx:GridViewDataTextColumn FieldName="colDay19" VisibleIndex="24">
                <HeaderStyle HorizontalAlign="Center" />
            </dx:GridViewDataTextColumn>
            <dx:GridViewDataTextColumn FieldName="colDay20" VisibleIndex="25">
                <HeaderStyle HorizontalAlign="Center" />
            </dx:GridViewDataTextColumn>
            <dx:GridViewDataTextColumn FieldName="colDay21" VisibleIndex="26">
                <HeaderStyle HorizontalAlign="Center" />
            </dx:GridViewDataTextColumn>
            <dx:GridViewDataTextColumn FieldName="colDay22" VisibleIndex="27">
                <HeaderStyle HorizontalAlign="Center" />
            </dx:GridViewDataTextColumn>
            <dx:GridViewDataTextColumn FieldName="colDay23" VisibleIndex="28">
                <HeaderStyle HorizontalAlign="Center" />
            </dx:GridViewDataTextColumn>
            <dx:GridViewDataTextColumn FieldName="colDay24" VisibleIndex="29">
                <HeaderStyle HorizontalAlign="Center" />
            </dx:GridViewDataTextColumn>
            <dx:GridViewDataTextColumn FieldName="colDay25" VisibleIndex="30">
                <HeaderStyle HorizontalAlign="Center" />
            </dx:GridViewDataTextColumn>
            <dx:GridViewDataTextColumn FieldName="colDay26" VisibleIndex="31">
                <HeaderStyle HorizontalAlign="Center" />
            </dx:GridViewDataTextColumn>
            <dx:GridViewDataTextColumn FieldName="colDay27" VisibleIndex="32">
                <HeaderStyle HorizontalAlign="Center" />
            </dx:GridViewDataTextColumn>
            <dx:GridViewDataTextColumn FieldName="colDay28" VisibleIndex="33">
                <HeaderStyle HorizontalAlign="Center" />
            </dx:GridViewDataTextColumn>
            <dx:GridViewDataTextColumn FieldName="colDay29" VisibleIndex="34">
                <HeaderStyle HorizontalAlign="Center" />
            </dx:GridViewDataTextColumn>
            <dx:GridViewDataTextColumn FieldName="colDay30" VisibleIndex="35">
                <HeaderStyle HorizontalAlign="Center" />
            </dx:GridViewDataTextColumn>
            <dx:GridViewDataTextColumn FieldName="colDay31" VisibleIndex="36">
                <HeaderStyle HorizontalAlign="Center" />
            </dx:GridViewDataTextColumn>
        </Columns>
    </dx:ASPxGridView>




    <asp:SqlDataSource ID="ds_mainGride" runat="server" 
        ConnectionString="<%$ ConnectionStrings:timesheetConnectionString %>" 
        SelectCommand="sp_timesheet" SelectCommandType="StoredProcedure" 
        CancelSelectOnNullParameter="False">
        <SelectParameters>
            <asp:Parameter DbType="Date" Name="colPeriod" />
        </SelectParameters>
    </asp:SqlDataSource>

    <asp:SqlDataSource ID="detailsDataSource" runat="server" 
        ConnectionString="<%$ ConnectionStrings:timesheetConnectionString %>" 
        SelectCommand="sp_get_timesheet_details" SelectCommandType="StoredProcedure" 
        CancelSelectOnNullParameter="False">
        <SelectParameters>
            <asp:SessionParameter Name="colDate" SessionField="colDate" Type="String" />
            <asp:SessionParameter Name="colUserID" SessionField="colUserID" Type="String" />
            <asp:SessionParameter Name="colType" SessionField="colType" Type="String" />

        </SelectParameters>
    </asp:SqlDataSource>


    <dx:ASPxGridViewExporter ID="ASPxGridViewExporter1" runat="server" GridViewID="mainGrid" />


</asp:Content>
