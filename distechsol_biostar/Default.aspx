<%@ Page Language="C#" AutoEventWireup="true" MasterPageFile="~/Site.master" CodeFile="Default.aspx.cs" Inherits="_Default" %>

<asp:Content ID="Content" ContentPlaceHolderID="MainContent" runat="server">

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
Employee
</td>

</tr>
<tr>
<td>

    <dx:ASPxDateEdit ID="dateFrom" runat="server" DisplayFormatString="dd/MM/yyyy">
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
        DropDownStyle = "DropDown" TextField="colName" ValueField="colUserID" 
        DataSourceID="SqlDataSource1" oncallback="cbEmployee_Callback">
    </dx:ASPxComboBox>

    <asp:SqlDataSource ID="SqlDataSource1" runat="server" 
        ConnectionString="<%$ ConnectionStrings:timesheetConnectionString %>" 
        SelectCommand="SELECT [colUserID], [colName] FROM [ts_employee]">
    </asp:SqlDataSource>



</td>
<td>&nbsp;&nbsp;&nbsp;</td>
<td>
    <dx:ASPxButton ID="ASPxButton1" runat="server" Text="getData" 
        AutoPostBack="False" >
        <ClientSideEvents Click="function(s, e) {mainGrid.PerformCallback(); cbEmployee.PerformCallback(cbEmployee.GetSelectedIndex()); }" />
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

    <dx:ASPxGridView ID="mainGrid" ClientInstanceName="mainGrid" runat="server" AutoGenerateColumns="False" 
        Width="100%" DataSourceID="SqlDataSource2" 
        oncustomcallback="mainGrid_CustomCallback" KeyFieldName="colID" 
        onhtmldatacellprepared="mainGrid_HtmlDataCellPrepared" 
        oncustomsummarycalculate="mainGrid_CustomSummaryCalculate" >
        <SettingsDetail AllowOnlyOneMasterRowExpanded="False" />
        <SettingsPager PageSize="20">
        </SettingsPager>
        <Settings VerticalScrollableHeight="600" VerticalScrollBarMode="Visible" 
            
           ShowFooter="true" ShowGroupFooter="VisibleAlways" />

        <SettingsBehavior  AllowSelectSingleRowOnly="True" 
            EnableRowHotTrack="true" AutoExpandAllGroups="False"  />
        <Styles>
            <AlternatingRow Enabled="true" />

<Header Wrap="True"></Header>
            <Footer Font-Bold="True">
            </Footer>
            <GroupFooter Font-Bold="True" ForeColor="#CC3300">
            </GroupFooter>
        </Styles>



<SettingsCommandButton>
<ShowAdaptiveDetailButton ButtonType="Image"></ShowAdaptiveDetailButton>

<HideAdaptiveDetailButton ButtonType="Image"></HideAdaptiveDetailButton>
</SettingsCommandButton>



        <Columns>
            <dx:GridViewDataTextColumn FieldName="colID" ReadOnly="True" VisibleIndex="0" Caption="ID" Visible="false">
            </dx:GridViewDataTextColumn>
            <dx:GridViewDataDateColumn VisibleIndex="1"  FieldName="colDate" Caption="Date">
                <PropertiesDateEdit DisplayFormatString="dd/MM/yyyy ddd">  
                </PropertiesDateEdit>  
            </dx:GridViewDataDateColumn>
            <dx:GridViewDataTextColumn FieldName="colUserName" VisibleIndex="2" 
                Caption="Name" Width="150px" GroupIndex="0" SortIndex="0" 
                SortOrder="Ascending">
            </dx:GridViewDataTextColumn>
            <dx:GridViewDataTextColumn FieldName="colShiftTime" VisibleIndex="3" 
                Caption="Regular Shift">
            </dx:GridViewDataTextColumn>
            <dx:GridViewDataTextColumn FieldName="colLaunchTime" VisibleIndex="4" 
                Caption="Launch Shift">
            </dx:GridViewDataTextColumn>
            <dx:GridViewDataTextColumn FieldName="colHoursdDay" VisibleIndex="5" 
                Caption="Hours per Day">
            </dx:GridViewDataTextColumn>
            <dx:GridViewDataTextColumn FieldName="colTimeIn" VisibleIndex="6" Caption="In">
            </dx:GridViewDataTextColumn>
            <dx:GridViewDataTextColumn FieldName="colLaunchOut" VisibleIndex="7" Caption="Launch Out">
            </dx:GridViewDataTextColumn>

            <dx:GridViewDataTextColumn FieldName="colLaunchIn" VisibleIndex="8" Caption="Launch IN">
            </dx:GridViewDataTextColumn>
            <dx:GridViewDataTextColumn FieldName="colTimeOut" VisibleIndex="9" Caption="Out">
            </dx:GridViewDataTextColumn>

            <dx:GridViewDataTextColumn FieldName="colLaunchExp" VisibleIndex="10" Caption="Launch Exception Min">
            </dx:GridViewDataTextColumn>
            <dx:GridViewDataTextColumn FieldName="colShiftExp" VisibleIndex="11" Caption="Regular Exception Min">
            </dx:GridViewDataTextColumn>
            <dx:GridViewDataTextColumn FieldName="colLateLeave" VisibleIndex="12" Caption="Late and leave Early Min">
            </dx:GridViewDataTextColumn>
            <dx:GridViewDataTextColumn FieldName="colOvertime" VisibleIndex="13" Caption="Overtime Hours">
            </dx:GridViewDataTextColumn>
            <dx:GridViewDataTextColumn FieldName="colTHours" VisibleIndex="14" Caption="Total Work Hours">

            </dx:GridViewDataTextColumn>
            <dx:GridViewDataTextColumn FieldName="colTHoursInt" VisibleIndex="15" Visible="false" >
            </dx:GridViewDataTextColumn>
            <dx:GridViewDataTextColumn FieldName="colOvertimeInt" VisibleIndex="16" 
                Visible="false" >
            </dx:GridViewDataTextColumn>
            <dx:GridViewDataTextColumn FieldName="colLateLeaveInt" VisibleIndex="17" 
                Visible="false" >
            </dx:GridViewDataTextColumn>
        </Columns>

        <TotalSummary>
        <dx:ASPxSummaryItem FieldName="colTHours" SummaryType="Custom" Tag="colGTHours" />
        <dx:ASPxSummaryItem FieldName="colOvertime" SummaryType="Custom" Tag="colGOvertime" />
        <dx:ASPxSummaryItem FieldName="colLateLeave" SummaryType="Custom" Tag="colGLateLeave" />

        </TotalSummary>

    <GroupSummary>
        <dx:ASPxSummaryItem FieldName="colDate"  ShowInGroupFooterColumn="colDate" SummaryType="Count" />
        <dx:ASPxSummaryItem FieldName="colTHours" SummaryType="Custom" Tag="colTHours" ShowInGroupFooterColumn="colTHours"/>
        <dx:ASPxSummaryItem FieldName="colOvertime" SummaryType="Custom" Tag="colOvertime" ShowInGroupFooterColumn="colOvertime"/>
        <dx:ASPxSummaryItem FieldName="colLateLeave"  SummaryType="Custom"  Tag = "colLateLeave" ShowInGroupFooterColumn="colLateLeave"   />
    </GroupSummary>


<Templates>
            <DetailRow>
                <dx:ASPxGridView ID="detailGrid" runat="server" DataSourceID="detailsDataSource" KeyFieldName="colUserID, colDate"
                    Width="100%" EnablePagingGestures="False" OnBeforePerformDataSelect="detailGrid_DataSelect">
                    <Columns>
                        <dx:GridViewDataColumn FieldName="colDate" Caption="Date" VisibleIndex="1" />
                        <dx:GridViewDataColumn FieldName="colUserName" caption = "Name" VisibleIndex="2" />
                        <dx:GridViewDataColumn FieldName="colTime" Caption = "Time" VisibleIndex="3" />
                        <dx:GridViewDataColumn FieldName="colType" Caption = "In/Out" VisibleIndex="4" />
                    </Columns>
                    <SettingsPager Mode="ShowAllRecords" />
                    <Settings VerticalScrollableHeight="400" VerticalScrollBarMode="Visible"/>

                </dx:ASPxGridView>
            </DetailRow>
        </Templates>
        <SettingsDetail ShowDetailRow="true" />


    </dx:ASPxGridView>
    <asp:SqlDataSource ID="SqlDataSource2" runat="server" 
        ConnectionString="<%$ ConnectionStrings:timesheetConnectionString %>" 
        SelectCommand="sp_get_timesheet" SelectCommandType="StoredProcedure" 
        CancelSelectOnNullParameter="False">
        <SelectParameters>
            <asp:Parameter DbType="Date" Name="colDateFrom" />
            <asp:Parameter DbType="Date" Name="colDateTo" />
            <asp:Parameter Name="colUserID" Type="Int32" />
            <asp:Parameter Name="colType" Type="Byte" />
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
