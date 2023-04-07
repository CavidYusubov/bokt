<%@ Page Language="C#" AutoEventWireup="true" MasterPageFile="~/Site.master" CodeFile="Timesheet.aspx.cs" Inherits="_Default" %>

<asp:Content ID="Content" ContentPlaceHolderID="MainContent" runat="server">

<script type="text/javascript">
        // <![CDATA[

    var keyValue;
    function OnMoreInfoClick(element, key, Descr, colEmpID) {

        Vpopup.SetHeaderText(Descr);
        VcallbackPanel.SetContentHtml("");
        Vpopup.ShowAtElement(element);
        keyValue = colEmpID;
    }

    function Vpopup_Shown(s, e) {
        VcallbackPanel.PerformCallback(keyValue);
    }
        // ]]>

    function OnInit(s, e) {
        AdjustSize();
    }
    function OnEndCallback(s, e) {
        AdjustSize();
    }
    function AdjustSize() {
        var height = Math.max(0, document.documentElement.clientHeight);
        mainGrid.SetHeight(height - 200);
    }  


    </script>

<style type="text/css">  
   
.MyClass1 {  
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

<dx:ASPxPopupControl ID="Vpopup" ClientInstanceName="Vpopup" runat="server" AllowDragging="True"
        PopupHorizontalAlign="OutsideRight" HeaderText="Sign" Width="500px" 
        Height="300px">
<ClientSideEvents Shown="Vpopup_Shown" CloseUp="function(s, e) { mainGrid.PerformCallback();}"></ClientSideEvents>
        <ContentCollection>
            <dx:PopupControlContentControl ID="PopupControlContentControl2" runat="server">
                <dx:ASPxCallbackPanel ID="VcallbackPanel" ClientInstanceName="VcallbackPanel" 
                    OnCallback="VcallbackPanel_Callback" runat="server"
                    Width="500px" Height="200px" RenderMode="Table" 
                    >
                    <PanelCollection>
                        <dx:PanelContent ID="PanelContent2" runat="server">


        <asp:SqlDataSource ID="ds_leavetypes" runat="server" 
        ConnectionString="<%$ ConnectionStrings:timesheetConnectionString %>" 
        SelectCommand="SELECT [colID], [colName] FROM [ts_leavetypes] where colStat = 0">
    </asp:SqlDataSource>


                            <asp:SqlDataSource ID="ds_leaves" runat="server" 
                                ConnectionString="<%$ ConnectionStrings:timesheetConnectionString %>" 
                                SelectCommand="sp_get_leaves" SelectCommandType="StoredProcedure" 
                                CancelSelectOnNullParameter="False" DeleteCommand="sp_update_leaves" 
                                DeleteCommandType="StoredProcedure" InsertCommand="sp_update_leaves" 
                                InsertCommandType="StoredProcedure" UpdateCommand="sp_update_leaves" 
                                UpdateCommandType="StoredProcedure">
                                <DeleteParameters>
                                    <asp:Parameter Name="colID" Type="Int32" />
                                    <asp:Parameter Name="colStat" Type="Byte" DefaultValue = "1"/>
                                </DeleteParameters>
                                <InsertParameters>
                                    <asp:SessionParameter Name="colEmpID" SessionField="colTypeID" Type="Int32" />
                                    <asp:Parameter Name="colTypeID" Type="Byte" />
                                    <asp:Parameter Name="colSDate" DbType="Date" />
                                    <asp:Parameter Name="colEDate" DbType="Date" />
                                </InsertParameters>
                                <SelectParameters>
                                    <asp:Parameter Name="colEmpID" Type="Int32"/>
                                </SelectParameters>
                                <UpdateParameters>
                                    <asp:Parameter Name="colID" Type="Int32" />
                                    <asp:Parameter Name="colTypeID" Type="Byte" />
                                    <asp:Parameter DbType="Date" Name="colSDate" />
                                    <asp:Parameter DbType="Date" Name="colEDate" />
                                </UpdateParameters>
                            </asp:SqlDataSource>

<table><tr><td>
Shift
</td></tr>
<tr><td>
 <dx:ASPxComboBox ID="cbShifts" ClientInstanceName="cbShifts" runat="server" Width = "200px" 
        DropDownStyle = "DropDown" TextField="colName" ValueField="colID" 
        DataSourceID="ds_shifts" 
>
    </dx:ASPxComboBox>

    </td><td>&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;
    <dx:ASPxButton ID="ASPxButton4" ClientInstanceName="btnSave" runat="server" 
        Text="Set as Default Shift" ClientEnabled="true"
         onclick="btnSave_Click" >
        <ClientSideEvents Click="function(s, e) { e.processOnServer = confirm('are you sure?');  }" />  
    </dx:ASPxButton>
    </td>
</tr>
</table>




    <asp:SqlDataSource ID="ds_shifts" runat="server" 
        ConnectionString="<%$ ConnectionStrings:timesheetConnectionString %>" 
        SelectCommand="SELECT * FROM [ts_shifts] where colStat = 0" >
    </asp:SqlDataSource>    


Leaves
<dx:ASPxGridView ID="gv_leaves" runat="server" AutoGenerateColumns="False"  Width="100%"
        DataSourceID="ds_leaves" KeyFieldName="colID" OnRowInserting="gv_leaves_RowInserting" OnRowUpdating="gv_leaves_RowUpdating" >
<SettingsCommandButton>
<ShowAdaptiveDetailButton ButtonType="Image"></ShowAdaptiveDetailButton>

<HideAdaptiveDetailButton ButtonType="Image"></HideAdaptiveDetailButton>
</SettingsCommandButton>
     <Columns>
     <dx:GridViewCommandColumn ShowNewButtonInHeader="true" ShowEditButton="true" ShowDeleteButton="true" VisibleIndex="100" />
         <dx:GridViewDataTextColumn FieldName="colID" ReadOnly="True" Visible="false">
             <EditFormSettings Visible="False" />
         </dx:GridViewDataTextColumn>


            <dx:GridViewDataComboBoxColumn FieldName="colType" VisibleIndex="6" Caption="Leave Type">
            <PropertiesComboBox DataSourceID="ds_leavetypes" ValueField="colID" TextField="colName" ValueType="System.Int32" />
                <EditItemTemplate>
                            <dx:ASPxComboBox ID="cbLeavetypes" runat="server" DataSourceID="ds_leavetypes"  TextField="colName" ValueField="colID" Value='<%# Bind("colType") %>' 
                             ValueType="System.Int32" Width = "100%">
                            </dx:ASPxComboBox>



                    </EditItemTemplate>
            </dx:GridViewDataComboBoxColumn>
         <dx:GridViewDataDateColumn FieldName="colSDate" ShowInCustomizationForm="True" 
             VisibleIndex="3" Caption="Date From">
         </dx:GridViewDataDateColumn>
         <dx:GridViewDataDateColumn FieldName="colEDate" ShowInCustomizationForm="True" 
             VisibleIndex="4" Caption="Date To">
         </dx:GridViewDataDateColumn>



     </Columns>
    </dx:ASPxGridView>


    <asp:SqlDataSource ID="ds_hollidays" runat="server" 
        ConnectionString="<%$ ConnectionStrings:timesheetConnectionString %>" 
        
        SelectCommand="SELECT * FROM [ts_holidays] ORDER BY [colHMonth], [colHDay]" 
        DeleteCommand="delete ts_holidays where colID = @colID" 
        InsertCommand="insert into ts_holidays (colHMonth, colHDay) select @colHMonth, @colHDay" 
        UpdateCommand="update ts_holidays set colHMonth = @colHMonth, colHDay = @colHDay where colID = @colID">

        <DeleteParameters>
            <asp:Parameter Name="colID" Type="Int32" />
        </DeleteParameters>


        <UpdateParameters>
            <asp:Parameter Name="colID" Type="Int32" />
            <asp:Parameter DbType="Int32" Name="colHDay" />
            <asp:Parameter DbType="Int32" Name="colHMonth" />
        </UpdateParameters>

        <InsertParameters>
            <asp:Parameter Name="colID" Type="Int32" />
            <asp:Parameter DbType="Int32" Name="colHDay" />
            <asp:Parameter DbType="Int32" Name="colHMonth" />
        </InsertParameters>


    </asp:SqlDataSource>
                        </dx:PanelContent>
                    </PanelCollection>
                </dx:ASPxCallbackPanel>
            </dx:PopupControlContentControl>
        </ContentCollection>
    </dx:ASPxPopupControl>        

    <dx:ASPxGridView ID="mainGrid" ClientInstanceName="mainGrid" runat="server" AutoGenerateColumns="False" 
        DataSourceID="ds_mainGride" Width="100%" ondatabound="mainGrid_DataBound" 
        oncustomcallback="mainGrid_CustomCallback" KeyFieldName="colID" 
        onhtmldatacellprepared="mainGrid_HtmlDataCellPrepared" 
        ondatabinding="mainGrid_DataBinding">

         <ClientSideEvents Init="OnInit" EndCallback="OnEndCallback" />  

<SettingsCommandButton>
<ShowAdaptiveDetailButton ButtonType="Image"></ShowAdaptiveDetailButton>

<HideAdaptiveDetailButton ButtonType="Image"></HideAdaptiveDetailButton>
</SettingsCommandButton>

        <SettingsPager Mode="ShowAllRecords">
        </SettingsPager>
        <Settings VerticalScrollableHeight="100" VerticalScrollBarMode="Visible" />
 <Settings HorizontalScrollBarMode="Visible" />
        <SettingsBehavior AutoExpandAllGroups="true" />
        <Styles>  
            <Header CssClass="MyClass1" BackColor="#FFFFFF" Wrap="True">  
            </Header>  
        </Styles>

        <Columns>
            <dx:GridViewDataTextColumn FieldName="colID" VisibleIndex="0" ReadOnly="True" Visible="false">
                <EditFormSettings Visible="False" />
            </dx:GridViewDataTextColumn>
            <dx:GridViewDataTextColumn FieldName="colEmpID" VisibleIndex="1" Visible="false">
            </dx:GridViewDataTextColumn>

 <dx:GridViewDataTextColumn FieldName="colFullName" VisibleIndex="4" Caption = "Name" Width="200px" FixedStyle="Left">
                <EditFormSettings Visible="False" />

            <DataItemTemplate>
                    <a href="javascript:void(0);" onclick="OnMoreInfoClick(this, '<%# Container.KeyValue %>','<%# Eval("colFullName") %>','<%# Eval("colEmpID") %>')"><%# Eval("colFullName") %></a>
            </DataItemTemplate>     
            </dx:GridViewDataTextColumn>


            <dx:GridViewDataTextColumn FieldName="colDepartment" VisibleIndex="3" Visible="false">
            </dx:GridViewDataTextColumn>
            <dx:GridViewDataTextColumn FieldName="colPosition" VisibleIndex="5" 
                Visible="false">
            </dx:GridViewDataTextColumn>
            <dx:GridViewDataTextColumn FieldName="colShift" VisibleIndex="6" 
                Visible="false">
            </dx:GridViewDataTextColumn>

            <dx:GridViewDataTextColumn FieldName="colDDay" VisibleIndex="38" caption="Day" 
                Width="70px">
                <HeaderStyle HorizontalAlign="Center" />
            </dx:GridViewDataTextColumn>
            <dx:GridViewDataTextColumn FieldName="colNight" VisibleIndex="39" 
                caption="Night" Width="70px">
                <HeaderStyle HorizontalAlign="Center" />
            </dx:GridViewDataTextColumn>
            <dx:GridViewDataTextColumn FieldName="colOvertime" VisibleIndex="40" 
                caption="Overtime" Width="70px">
                <HeaderStyle HorizontalAlign="Center" />
            </dx:GridViewDataTextColumn>
            <dx:GridViewDataTextColumn FieldName="colOvernorm" VisibleIndex="41" 
                caption="Regular Overtime" Width="70px">
                <HeaderStyle HorizontalAlign="Center" />
            </dx:GridViewDataTextColumn>
            <dx:GridViewDataTextColumn FieldName="colVacation" VisibleIndex="42" 
                caption="Vacation" Width="70px">
                <HeaderStyle HorizontalAlign="Center" />
            </dx:GridViewDataTextColumn>
            <dx:GridViewDataTextColumn FieldName="colTraining" VisibleIndex="43" 
                caption="Training" Width="70px">
                <HeaderStyle HorizontalAlign="Center" />
            </dx:GridViewDataTextColumn>
            <dx:GridViewDataTextColumn FieldName="colSLeave" VisibleIndex="44" 
                caption="Sick Leave" Width="70px">
                <HeaderStyle HorizontalAlign="Center" />
            </dx:GridViewDataTextColumn>
            <dx:GridViewDataTextColumn FieldName="colHollyday" VisibleIndex="45" 
                caption="Holiday" Width="70px">
                <HeaderStyle HorizontalAlign="Center" />
            </dx:GridViewDataTextColumn>
            <dx:GridViewDataTextColumn FieldName="colBTrip" VisibleIndex="46" 
                caption="Business Trip" Width="70px">
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
