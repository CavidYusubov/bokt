<%@ Page Language="C#" AutoEventWireup="true" MasterPageFile="~/Site.master" CodeFile="Copy of Options.aspx.cs" Inherits="_Default" %>

<%@ Register Assembly="DevExpress.Web.ASPxTreeList.v16.1, Version=16.1.5.0, Culture=neutral, PublicKeyToken=b88d1754d700e49a"
    Namespace="DevExpress.Web.ASPxTreeList" TagPrefix="dx" %>

<asp:Content ID="Content" ContentPlaceHolderID="MainContent" runat="server">

    <script type="text/javascript" >
    function getShift(s, e) {
//        if (s.GetSelectedIndex() == -1) btnSave.SetEnabled(true); else btnSave.SetEnabled(false);
    }
</script>


<table style="border-spacing: 10px; border-collapse: separate; " cellspacing="5">

<tr>
<td  valign="top" width = "70%"><b>Departments</td>
<td  valign="top" ><b>Positions</td>

</tr>

<tr>
<td  valign="top">
    <dx:ASPxTreeList ID="ASPxTreeList1" runat="server" AutoGenerateColumns="False" Width="100%"
        DataSourceID="ds_deps_treelist" KeyFieldName="colID" ParentFieldName="colParentID">
        <Settings GridLines="Both" ScrollableHeight="300" SuppressOuterGridLines="true"/>
        <SettingsBehavior ExpandCollapseAction="NodeDblClick" />
        <SettingsEditing Mode="EditFormAndDisplayNode" AllowNodeDragDrop="True" />
        <Columns>
            <dx:TreeListTextColumn FieldName="colID" ReadOnly="True" Visible="False" >
            </dx:TreeListTextColumn>
            <dx:TreeListTextColumn FieldName="colName" VisibleIndex="0" Caption="Department" Width="90%">
            <PropertiesTextEdit> 
                <ValidationSettings>  
                    <RequiredField IsRequired="True" />  
                </ValidationSettings>  
            </PropertiesTextEdit>  
            </dx:TreeListTextColumn>
            <dx:TreeListTextColumn FieldName="colCode" VisibleIndex="1" Caption="Code">
            <PropertiesTextEdit> 
                <ValidationSettings>  
                    <RequiredField IsRequired="True" />  
                </ValidationSettings>  
            </PropertiesTextEdit>  
            </dx:TreeListTextColumn>

            <dx:TreeListCommandColumn ShowNewButtonInHeader="true">
                <EditButton Visible="true" />
                <NewButton Visible="true" />
                <DeleteButton Visible="true" />
            </dx:TreeListCommandColumn>

        </Columns>
<SettingsBehavior AllowFocusedNode="True"  />
    </dx:ASPxTreeList>
    <asp:SqlDataSource ID="ds_deps_treelist" runat="server" 
        ConnectionString="<%$ ConnectionStrings:timesheetConnectionString %>" 
        SelectCommand="sp_deps_treelist" SelectCommandType="StoredProcedure" 
        DeleteCommand="sp_update_deps" DeleteCommandType="StoredProcedure" 
        InsertCommand="sp_update_deps" InsertCommandType="StoredProcedure" 
        UpdateCommand="sp_update_deps" UpdateCommandType="StoredProcedure">
        <DeleteParameters>
            <asp:Parameter Direction="ReturnValue" Name="RETURN_VALUE" Type="Int32" />
            <asp:Parameter Name="colID" Type="Int32" />
            <asp:Parameter Name="colParentID" Type="Int32" DefaultValue="0" />
            <asp:Parameter Name="colName" Type="String" DefaultValue="null" />
            <asp:Parameter Name="colCode" Type="String" DefaultValue="null" />
            <asp:Parameter DefaultValue="1" Name="colStat" Type="int32" />
        </DeleteParameters>
        <InsertParameters>
            <asp:Parameter Direction="ReturnValue" Name="RETURN_VALUE" Type="Int32" />
            <asp:Parameter Name="colID" Type="Int32" />
            <asp:Parameter Name="colParentID" Type="Int32" />
            <asp:Parameter Name="colName" Type="String" />
            <asp:Parameter Name="colCode" Type="String" DefaultValue="null" />
            <asp:Parameter DefaultValue="0" Name="colStat" Type="Byte" />
        </InsertParameters>
        <UpdateParameters>
            <asp:Parameter Direction="ReturnValue" Name="RETURN_VALUE" Type="Int32" />
            <asp:Parameter Name="colID" Type="Int32" />
            <asp:Parameter Name="colParentID" Type="Int32" />
            <asp:Parameter Name="colName" Type="String" />
            <asp:Parameter Name="colCode" Type="String" DefaultValue="null" />
            <asp:Parameter DefaultValue="0" Name="colStat" Type="int32" />
        </UpdateParameters>
    </asp:SqlDataSource>
</td>

<td valign="top">
<dx:ASPxGridView ID="gvPositions" ClientInstanceName="gvPositions" Width="100%"
        runat="server" AutoGenerateColumns="False" 
        DataSourceID="ds_positions" 
        PreviewFieldName="colID" KeyFieldName="colID" 
        >

    <SettingsBehavior ConfirmDelete="True" />

<SettingsCommandButton>
<ShowAdaptiveDetailButton ButtonType="Image"></ShowAdaptiveDetailButton>

<HideAdaptiveDetailButton ButtonType="Image"></HideAdaptiveDetailButton>
</SettingsCommandButton>

    <Columns>
<dx:GridViewCommandColumn ShowNewButtonInHeader="true" ShowEditButton="true" ShowDeleteButton="true" VisibleIndex="100" />

         <dx:GridViewDataTextColumn FieldName="colID" ReadOnly="True" Visible="false">
             <EditFormSettings Visible="False" />
            </dx:GridViewDataTextColumn>
            <dx:GridViewDataTextColumn FieldName="colName" Caption = "Position" 
            VisibleIndex="1"  Width="100%">

            </dx:GridViewDataTextColumn>
            <dx:GridViewDataTextColumn FieldName="colCode" Caption = "Code" VisibleIndex="2">

            </dx:GridViewDataTextColumn>

    </Columns>

<EditFormLayoutProperties ColCount="1" >
            <Items>
                <dx:GridViewColumnLayoutItem ColumnName="colName" CaptionSettings-Location="top">
                
                </dx:GridViewColumnLayoutItem>
                <dx:GridViewColumnLayoutItem ColumnName="colCode" CaptionSettings-Location="top" />
                <dx:EditModeCommandLayoutItem Width="100%" HorizontalAlign="Right" />
            </Items>
        </EditFormLayoutProperties>
        <EditFormLayoutProperties>
            <SettingsAdaptivity AdaptivityMode="SingleColumnWindowLimit" SwitchToSingleColumnAtWindowInnerWidth="600" />
        </EditFormLayoutProperties>


</dx:ASPxGridView>


    <asp:SqlDataSource ID="ds_positions" runat="server" 
        ConnectionString="<%$ ConnectionStrings:timesheetConnectionString %>" 
        SelectCommand="sp_get_positions" SelectCommandType="StoredProcedure" 
        DeleteCommand="sp_update_positions" DeleteCommandType="StoredProcedure" 
        InsertCommand="sp_update_positions" InsertCommandType="StoredProcedure" 
        UpdateCommand="sp_update_positions" UpdateCommandType="StoredProcedure">
        <DeleteParameters>
            <asp:Parameter Direction="ReturnValue" Name="RETURN_VALUE" Type="Int32" />
            <asp:Parameter Name="colID" Type="Int32" />
            <asp:Parameter Name="colName" Type="String" />
            <asp:Parameter Name="colCode" Type="String" />
            <asp:Parameter Name="colStat" Type="Byte" />
        </DeleteParameters>
        <InsertParameters>
            <asp:Parameter Direction="ReturnValue" Name="RETURN_VALUE" Type="Int32" />
            <asp:Parameter Name="colID" Type="Int32" />
            <asp:Parameter Name="colName" Type="String" />
            <asp:Parameter Name="colCode" Type="String" />
            <asp:Parameter Name="colStat" Type="Byte" />
        </InsertParameters>
        <UpdateParameters>
            <asp:Parameter Direction="ReturnValue" Name="RETURN_VALUE" Type="Int32" />
            <asp:Parameter Name="colID" Type="Int32" />
            <asp:Parameter Name="colName" Type="String" />
            <asp:Parameter Name="colCode" Type="String" />
            <asp:Parameter Name="colStat" Type="Byte" />
        </UpdateParameters>
    </asp:SqlDataSource>


</td>

</tr>

<tr>
<td  valign="top"><b>
Salary Grades
</td>
<td  valign="top"><b>
Holidays
</td>
</tr>
<tr>


<td valign="top">
 <dx:ASPxGridView ID="gv_salarygrades" ClientInstanceName="gv_salarygrades" runat="server" AutoGenerateColumns="False" Width="100%"
        DataSourceID="ds_salarygrades" KeyFieldName="colID" 
        oninitnewrow="gv_salarygrades_InitNewRow">

<SettingsCommandButton>
<ShowAdaptiveDetailButton ButtonType="Image"></ShowAdaptiveDetailButton>

<HideAdaptiveDetailButton ButtonType="Image"></HideAdaptiveDetailButton>
</SettingsCommandButton>

     <Columns>
    <dx:GridViewCommandColumn ShowNewButtonInHeader="true" ShowEditButton="true" ShowDeleteButton="true" VisibleIndex="100" />


         <dx:GridViewDataTextColumn FieldName="colID" ReadOnly="True" Visible="false">
             <EditFormSettings Visible="False" />
         </dx:GridViewDataTextColumn>
         <dx:GridViewDataTextColumn FieldName="colName" VisibleIndex="0" Caption="Name" Width="100%">
            <PropertiesTextEdit> 
                <ValidationSettings>  
                    <RequiredField IsRequired="True" />  
                </ValidationSettings>  
            </PropertiesTextEdit>  
         </dx:GridViewDataTextColumn>

            <dx:GridViewDataTextColumn FieldName="colCode" Caption = "Code" VisibleIndex="1">
            <PropertiesTextEdit> 
                <ValidationSettings>  
                    <RequiredField IsRequired="True" />  
                </ValidationSettings>  
            </PropertiesTextEdit>  

            </dx:GridViewDataTextColumn>


         <dx:GridViewDataComboBoxColumn FieldName="colType" VisibleIndex="2" Caption = "Type">

                    <PropertiesComboBox DropDownStyle="DropDownList"  TextField="SelectStatus" ValueField="SelectStatus">
                   <Items>
                       <dx:ListEditItem Text="Monthly" Value="0" />
                       <dx:ListEditItem Text="Hourly" Value="1" />
                       <dx:ListEditItem Text="Daily" Value="2" />
                       <dx:ListEditItem Text="Weekly" Value="3" />

                   </Items>
                    <ValidationSettings>
                        <RequiredField IsRequired="True" />  
                    </ValidationSettings>  
                    </PropertiesComboBox>
         </dx:GridViewDataComboBoxColumn>



         <dx:GridViewDataSpinEditColumn FieldName="colAmount" VisibleIndex="3"
             Caption="Amount" UnboundType="Decimal">
               <PropertiesSpinEdit DisplayFormatString="#.##" >
                    <ValidationSettings>
                        <RequiredField IsRequired="True" />  
                    </ValidationSettings>  
               </PropertiesSpinEdit>
         </dx:GridViewDataSpinEditColumn>
         <dx:GridViewDataSpinEditColumn FieldName="colOvertime" VisibleIndex="4" 
             Caption="Overtime ratio" UnboundType="Decimal">

               <PropertiesSpinEdit DisplayFormatString="#.##" >
                    <ValidationSettings>
                        <RequiredField IsRequired="True" />  
                    </ValidationSettings>  
               </PropertiesSpinEdit>



         </dx:GridViewDataSpinEditColumn>
         <dx:GridViewDataSpinEditColumn FieldName="colOvernorm" VisibleIndex="5" 
             Caption="Overnorm ratio" UnboundType="Decimal">
               <PropertiesSpinEdit DisplayFormatString="#.##" >
                    <ValidationSettings>
                        <RequiredField IsRequired="True" />  
                    </ValidationSettings>  
               </PropertiesSpinEdit>

         </dx:GridViewDataSpinEditColumn>
         <dx:GridViewDataSpinEditColumn FieldName="colNight" VisibleIndex="6" 
             Caption="Night ratio" UnboundType="Decimal">
               <PropertiesSpinEdit DisplayFormatString="#.##" >
                    <ValidationSettings>
                        <RequiredField IsRequired="True" />  
                    </ValidationSettings>  
               </PropertiesSpinEdit>

         </dx:GridViewDataSpinEditColumn>
         <dx:GridViewDataSpinEditColumn FieldName="colHoliday" VisibleIndex="7" 
             Caption="Holiday ratio" UnboundType="Decimal">
               <PropertiesSpinEdit DisplayFormatString="#.##" >
                    <ValidationSettings>
                        <RequiredField IsRequired="True" />  
                    </ValidationSettings>  
               </PropertiesSpinEdit>

         </dx:GridViewDataSpinEditColumn>

     </Columns>
    </dx:ASPxGridView>


    <asp:SqlDataSource ID="ds_salarygrades" runat="server" 
        ConnectionString="<%$ ConnectionStrings:timesheetConnectionString %>" 
        SelectCommand="sp_get_salarygrades" SelectCommandType="StoredProcedure" 
        DeleteCommand="sp_update_salarygrades" DeleteCommandType="StoredProcedure" 
        InsertCommand="sp_update_salarygrades" InsertCommandType="StoredProcedure" 
        UpdateCommand="sp_update_salarygrades" UpdateCommandType="StoredProcedure">
        <DeleteParameters>
            <asp:Parameter Direction="ReturnValue" Name="RETURN_VALUE" Type="Int32" />
            <asp:Parameter Name="colID" Type="Int32" />
            <asp:Parameter Name="colName" Type="String" />
            <asp:Parameter Name="colCode" Type="String" />
            <asp:Parameter Name="colType" Type="Byte" />
            <asp:Parameter Name="colAmount" Type="Decimal" />
            <asp:Parameter Name="colOvertime" Type="Decimal" />
            <asp:Parameter Name="colOvernorm" Type="Decimal" />
            <asp:Parameter Name="colNight" Type="Decimal" />
            <asp:Parameter Name="colHoliday" Type="Decimal" />
            <asp:Parameter Name="colStat" Type="Byte" />
        </DeleteParameters>
        <InsertParameters>
            <asp:Parameter Direction="ReturnValue" Name="RETURN_VALUE" Type="Int32" />
            <asp:Parameter Name="colID" Type="Int32" />
            <asp:Parameter Name="colName" Type="String" />
            <asp:Parameter Name="colCode" Type="String" />
            <asp:Parameter Name="colType" Type="Byte" />
            <asp:Parameter Name="colAmount" Type="Decimal" />
            <asp:Parameter Name="colOvertime" Type="Decimal" />
            <asp:Parameter Name="colOvernorm" Type="Decimal" />
            <asp:Parameter Name="colNight" Type="Decimal" />
            <asp:Parameter Name="colHoliday" Type="Decimal" />
            <asp:Parameter Name="colStat" Type="Byte" />
        </InsertParameters>
        <UpdateParameters>
            <asp:Parameter Direction="ReturnValue" Name="RETURN_VALUE" Type="Int32" />
            <asp:Parameter Name="colID" Type="Int32" />
            <asp:Parameter Name="colName" Type="String" />
            <asp:Parameter Name="colCode" Type="String" />
            <asp:Parameter Name="colType" Type="Byte" />
            <asp:Parameter Name="colAmount" Type="Decimal" />
            <asp:Parameter Name="colOvertime" Type="Decimal" />
            <asp:Parameter Name="colOvernorm" Type="Decimal" />
            <asp:Parameter Name="colNight" Type="Decimal" />
            <asp:Parameter Name="colHoliday" Type="Decimal" />
            <asp:Parameter Name="colStat" Type="Byte" />
        </UpdateParameters>
    </asp:SqlDataSource>


</td>


<td valign="top">
 <dx:ASPxGridView ID="gv_hollidays" runat="server" AutoGenerateColumns="False"  Width="100%"
        DataSourceID="ds_hollidays" KeyFieldName="colID">
<SettingsCommandButton>
<ShowAdaptiveDetailButton ButtonType="Image"></ShowAdaptiveDetailButton>

<HideAdaptiveDetailButton ButtonType="Image"></HideAdaptiveDetailButton>
</SettingsCommandButton>
     <Columns>
     <dx:GridViewCommandColumn ShowNewButtonInHeader="true" ShowEditButton="true" ShowDeleteButton="true" VisibleIndex="100" />
         <dx:GridViewDataTextColumn FieldName="colID" ReadOnly="True" Visible="false">
             <EditFormSettings Visible="False" />
         </dx:GridViewDataTextColumn>
         <dx:GridViewDataComboBoxColumn FieldName="colHMonth" VisibleIndex="2" Caption = "Month" Width="100%">

                    <PropertiesComboBox DropDownStyle="DropDownList"  TextField="SelectStatus" ValueField="SelectStatus">
                   <Items>
                       <dx:ListEditItem Text="January" Value="1" />
                       <dx:ListEditItem Text="February" Value="2" />
                       <dx:ListEditItem Text="March" Value="3" />
                       <dx:ListEditItem Text="April" Value="4" />
                       <dx:ListEditItem Text="May" Value="5" />
                       <dx:ListEditItem Text="June" Value="6" />
                       <dx:ListEditItem Text="July" Value="7" />
                       <dx:ListEditItem Text="August" Value="8" />
                       <dx:ListEditItem Text="September" Value="9" />
                       <dx:ListEditItem Text="October" Value="10" />
                       <dx:ListEditItem Text="November" Value="11" />
                       <dx:ListEditItem Text="December" Value="12" />

                   </Items>
                    </PropertiesComboBox>
                    <EditFormSettings CaptionLocation="Top" />
         </dx:GridViewDataComboBoxColumn>
         <dx:GridViewDataSpinEditColumn FieldName="colHDay" VisibleIndex="3" Caption="Day">
<PropertiesSpinEdit DisplayFormatString="g" MaxValue="31"></PropertiesSpinEdit>
             <EditFormSettings CaptionLocation="Top" />
         </dx:GridViewDataSpinEditColumn>
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
</td>
</tr>

<tr>
<td   valign="top"><b>
Shifts
</td>
<td  valign="top" ><b>Devices</td>
</tr><tr>
<td valign="top">
 <dx:ASPxComboBox ID="cbShifts" ClientInstanceName="cbShifts" runat="server" Width = "200px" 
        DropDownStyle = "DropDown" TextField="colName" ValueField="colID" 
        DataSourceID="ds_shifts" 
        AutoPostBack="True" onvaluechanged="cbShifts_ValueChanged" 
>
    <ClientSideEvents KeyUp="getShift" CloseUp="getShift"/>
    </dx:ASPxComboBox>


    <dx:ASPxButton ID="ASPxButton4" ClientInstanceName="btnSave" runat="server" 
        Text="Save as New" ClientEnabled="true"
         onclick="btnSave_Click" >
        <ClientSideEvents Click="function(s, e) { e.processOnServer = confirm('are you sure?');  }" />  
    </dx:ASPxButton>

    <dx:ASPxButton ID="ASPxButton5" ClientInstanceName="btnSave" runat="server" 
        Text="Delete" ClientEnabled="true" onclick="ASPxButton1_Click"
        >
        <ClientSideEvents Click="function(s, e) { e.processOnServer = confirm('are you sure?');  }" />  
    </dx:ASPxButton>

<br>
<dx:ASPxGridView ID="gvShiftDetails2" ClientInstanceName="gvShiftDetails2" Width="100%"
        runat="server" AutoGenerateColumns="False" 
        DataSourceID="ds_shiftdetails" 
         OnCustomUnboundColumnData="gvShiftDetails_CustomUnboundColumnData"  
        PreviewFieldName="colID" KeyFieldName="colID" 
        onrowupdating="gvShiftDetails_RowUpdating">

<SettingsCommandButton>
<ShowAdaptiveDetailButton ButtonType="Image"></ShowAdaptiveDetailButton>

<HideAdaptiveDetailButton ButtonType="Image"></HideAdaptiveDetailButton>
</SettingsCommandButton>

    <Columns>
     <dx:GridViewCommandColumn ShowEditButton="true" VisibleIndex="100"/>
         <dx:GridViewDataTextColumn FieldName="colID" ReadOnly="True" Visible="false">
            </dx:GridViewDataTextColumn>
            <dx:GridViewDataTextColumn FieldName="colName" VisibleIndex="1" Caption="Shitf" ReadOnly="True">

                <EditFormSettings Visible="False" />

            </dx:GridViewDataTextColumn>
            <dx:GridViewDataTextColumn FieldName="colWDay" VisibleIndex="2" Caption="Week day" ReadOnly="true">
             <EditFormSettings Visible="False"/>
            </dx:GridViewDataTextColumn>

            <dx:GridViewDataTimeEditColumn FieldName="colTimeIn" VisibleIndex="3" Caption="Time in" UnboundType="DateTime" Visible="false">
            </dx:GridViewDataTimeEditColumn>
            <dx:GridViewDataTimeEditColumn FieldName="ubTimeIn" VisibleIndex="4" 
            Caption="Time in" UnboundType="DateTime">
                <PropertiesTimeEdit DisplayFormatString="HH:mm" EditFormat="Custom" EditFormatString="HH:mm">  
                <ValidationSettings>  
                    <RequiredField IsRequired="True" />  
                </ValidationSettings>  
                </PropertiesTimeEdit>  
            </dx:GridViewDataTimeEditColumn>



            <dx:GridViewDataTimeEditColumn FieldName="colTimeOut" VisibleIndex="5" 
            Caption="Time Out" Visible="false">
            </dx:GridViewDataTimeEditColumn>
            <dx:GridViewDataTimeEditColumn FieldName="ubTimeOut" VisibleIndex="6" 
            Caption="Time Out" UnboundType="DateTime">
                <PropertiesTimeEdit DisplayFormatString="HH:mm" EditFormat="Custom" EditFormatString="HH:mm">  
                <ValidationSettings>  
                    <RequiredField IsRequired="True" />  
                </ValidationSettings>  
                </PropertiesTimeEdit>  
            </dx:GridViewDataTimeEditColumn>


            <dx:GridViewDataTimeEditColumn FieldName="colLTimeOut" VisibleIndex="7" 
            Caption="Launch Out" Visible="false">
            </dx:GridViewDataTimeEditColumn>
            <dx:GridViewDataTimeEditColumn FieldName="ubLTimeOut" VisibleIndex="8" 
            Caption="Launch Out" UnboundType="DateTime">
                <PropertiesTimeEdit DisplayFormatString="HH:mm" EditFormat="Custom" EditFormatString="HH:mm">  
                <ValidationSettings>  
                    <RequiredField IsRequired="True" />  
                </ValidationSettings>  
                </PropertiesTimeEdit>  
            </dx:GridViewDataTimeEditColumn>

            <dx:GridViewDataTimeEditColumn FieldName="colLTimeIn" VisibleIndex="9" 
            Caption="Launch in" UnboundType="DateTime" Visible="false">
            </dx:GridViewDataTimeEditColumn>
            <dx:GridViewDataTimeEditColumn FieldName="ubLTimeIn" VisibleIndex="10" 
            Caption="Launch in" UnboundType="DateTime">
                <PropertiesTimeEdit DisplayFormatString="HH:mm" EditFormat="Custom" EditFormatString="HH:mm">  
                <ValidationSettings>  
                    <RequiredField IsRequired="True" />  
                </ValidationSettings>  
                </PropertiesTimeEdit>  
            </dx:GridViewDataTimeEditColumn>


    </Columns>
</dx:ASPxGridView>


<dx:ASPxGridView ID="gv_Shifts" ClientInstanceName="gv_Shifts" Width="100%"
        runat="server" AutoGenerateColumns="False" 
        DataSourceID="ds_shifts" 
         
        PreviewFieldName="colID" KeyFieldName="colID" 
        >

        <SettingsPager Mode="ShowAllRecords">
        </SettingsPager>
        <Settings VerticalScrollableHeight="250" VerticalScrollBarMode="Visible" />

<SettingsCommandButton>
<ShowAdaptiveDetailButton ButtonType="Image"></ShowAdaptiveDetailButton>

<HideAdaptiveDetailButton ButtonType="Image"></HideAdaptiveDetailButton>
</SettingsCommandButton>

    <Columns>
     <dx:GridViewCommandColumn ShowNewButtonInHeader="true" ShowEditButton="true" ShowDeleteButton="true" VisibleIndex="100" />
         <dx:GridViewDataTextColumn FieldName="colID" ReadOnly="True" Visible="false">
            </dx:GridViewDataTextColumn>
            <dx:GridViewDataTextColumn FieldName="colName" VisibleIndex="1" Caption="Shitf">
            </dx:GridViewDataTextColumn>
            <dx:GridViewDataTextColumn FieldName="colCode" VisibleIndex="1" Caption="Code">
            </dx:GridViewDataTextColumn>
    </Columns>


            <SettingsDetail ShowDetailButtons="true" ShowDetailRow="true" />
            <Templates>
                <DetailRow>




                    <dx:ASPxGridView runat="server" O KeyFieldName="colID" OnCustomUnboundColumnData="gvShiftDetails_CustomUnboundColumnData" onrowupdating="gvShiftDetails_RowUpdating"  OnBeforePerformDataSelect="grid2_BeforePerformDataSelect" ID="grid2" AutoGenerateColumns="False" DataSourceID="ds_shiftdetails" Width="100%">
                        <Columns>

                            <dx:GridViewCommandColumn ShowEditButton="True" VisibleIndex="0" />
                            <dx:GridViewDataTextColumn FieldName="colID" ReadOnly="True" Visible="false">
                                <EditFormSettings Visible="False" />
                            </dx:GridViewDataTextColumn>


            <dx:GridViewDataTextColumn FieldName="colWDay" VisibleIndex="2" Caption="Week day" ReadOnly="true">
             <EditFormSettings Visible="False"/>
            </dx:GridViewDataTextColumn>


            <dx:GridViewDataTimeEditColumn FieldName="colTimeIn" VisibleIndex="3" Caption="Time in" UnboundType="DateTime" Visible="false">
            </dx:GridViewDataTimeEditColumn>
            <dx:GridViewDataTimeEditColumn FieldName="ubTimeIn" VisibleIndex="4" 
            Caption="Time in" UnboundType="DateTime">
                <PropertiesTimeEdit DisplayFormatString="HH:mm" EditFormat="Custom" EditFormatString="HH:mm">  
                <ValidationSettings>  
                    <RequiredField IsRequired="True" />  
                </ValidationSettings>  
                </PropertiesTimeEdit>  
            </dx:GridViewDataTimeEditColumn>



            <dx:GridViewDataTimeEditColumn FieldName="colTimeOut" VisibleIndex="5" 
            Caption="Time Out" Visible="false">
            </dx:GridViewDataTimeEditColumn>
            <dx:GridViewDataTimeEditColumn FieldName="ubTimeOut" VisibleIndex="6" 
            Caption="Time Out" UnboundType="DateTime">
                <PropertiesTimeEdit DisplayFormatString="HH:mm" EditFormat="Custom" EditFormatString="HH:mm">  
                <ValidationSettings>  
                    <RequiredField IsRequired="True" />  
                </ValidationSettings>  
                </PropertiesTimeEdit>  
            </dx:GridViewDataTimeEditColumn>


            <dx:GridViewDataTimeEditColumn FieldName="colLTimeOut" VisibleIndex="7" 
            Caption="Launch Out" Visible="false">
            </dx:GridViewDataTimeEditColumn>
            <dx:GridViewDataTimeEditColumn FieldName="ubLTimeOut" VisibleIndex="8" 
            Caption="Launch Out" UnboundType="DateTime">
                <PropertiesTimeEdit DisplayFormatString="HH:mm" EditFormat="Custom" EditFormatString="HH:mm">  
                <ValidationSettings>  
                    <RequiredField IsRequired="True" />  
                </ValidationSettings>  
                </PropertiesTimeEdit>  
            </dx:GridViewDataTimeEditColumn>

            <dx:GridViewDataTimeEditColumn FieldName="colLTimeIn" VisibleIndex="9" 
            Caption="Launch in" UnboundType="DateTime" Visible="false">
            </dx:GridViewDataTimeEditColumn>
            <dx:GridViewDataTimeEditColumn FieldName="ubLTimeIn" VisibleIndex="10" 
            Caption="Launch in" UnboundType="DateTime">
                <PropertiesTimeEdit DisplayFormatString="HH:mm" EditFormat="Custom" EditFormatString="HH:mm">  
                <ValidationSettings>  
                    <RequiredField IsRequired="True" />  
                </ValidationSettings>  
                </PropertiesTimeEdit>  
            </dx:GridViewDataTimeEditColumn>




                        </Columns>
                    </dx:ASPxGridView>
                </DetailRow>
            </Templates>



</dx:ASPxGridView>


</td>
















<td valign="top">
<dx:ASPxGridView ID="gvDevices" ClientInstanceName="gvDevices" Width="100%"
        runat="server" AutoGenerateColumns="False" 
        DataSourceID="dsDevices" 
        PreviewFieldName="colID" KeyFieldName="colID" 
        >

    <SettingsBehavior ConfirmDelete="True" />


    <Columns>
<dx:GridViewCommandColumn ShowNewButtonInHeader="true" ShowEditButton="true" ShowDeleteButton="true" VisibleIndex="100" />

         <dx:GridViewDataTextColumn FieldName="colID" ReadOnly="True" Visible="false">
             <EditFormSettings Visible="False" />
            </dx:GridViewDataTextColumn>
            <dx:GridViewDataTextColumn FieldName="colDeviceID" Caption = "Device ID" 
            VisibleIndex="1"  Width="100%">

            </dx:GridViewDataTextColumn>
            <dx:GridViewDataTextColumn FieldName="colCode" Caption = "Code" VisibleIndex="2">
            </dx:GridViewDataTextColumn>

     <dx:GridViewDataComboBoxColumn FieldName="colType" VisibleIndex="3" Caption = "Type" Width="100%">

                    <PropertiesComboBox DropDownStyle="DropDownList"  TextField="SelectStatus" ValueField="SelectStatus">
                   <Items>
                       <dx:ListEditItem Text="In/Out" Value="0" />
                       <dx:ListEditItem Text="In" Value="1" />
                       <dx:ListEditItem Text="Out" Value="2" />
                   </Items>
                    </PropertiesComboBox>
                    <EditFormSettings CaptionLocation="Top" />
         </dx:GridViewDataComboBoxColumn>


    </Columns>



</dx:ASPxGridView>


    <asp:SqlDataSource ID="dsDevices" runat="server" 
        ConnectionString="<%$ ConnectionStrings:timesheetConnectionString %>" 
        SelectCommand="sp_get_devices" SelectCommandType="StoredProcedure" 
        DeleteCommand="sp_update_devices" DeleteCommandType="StoredProcedure" 
        InsertCommand="sp_update_devices" InsertCommandType="StoredProcedure" 
        UpdateCommand="sp_update_devices" UpdateCommandType="StoredProcedure">
        <DeleteParameters>
            <asp:Parameter Direction="ReturnValue" Name="RETURN_VALUE" Type="Int32" />
            <asp:Parameter Name="colID" Type="Int32" />
            <asp:Parameter Name="colDeviceID" Type="String" />
            <asp:Parameter Name="colCode" Type="String" />
            <asp:Parameter Name="colType" Type="Byte" />
            <asp:Parameter Name="colStat" Type="Byte" />
        </DeleteParameters>
        <InsertParameters>
            <asp:Parameter Direction="ReturnValue" Name="RETURN_VALUE" Type="Int32" />
            <asp:Parameter Name="colID" Type="Int32" />
            <asp:Parameter Name="colDeviceID" Type="String" />
            <asp:Parameter Name="colCode" Type="String" />
            <asp:Parameter Name="colType" Type="Byte" />
            <asp:Parameter Name="colStat" Type="Byte" />
        </InsertParameters>
        <UpdateParameters>
            <asp:Parameter Direction="ReturnValue" Name="RETURN_VALUE" Type="Int32" />
            <asp:Parameter Name="colID" Type="Int32" />
            <asp:Parameter Name="colDeviceID" Type="String" />
            <asp:Parameter Name="colCode" Type="String" />
            <asp:Parameter Name="colType" Type="Byte" />
            <asp:Parameter Name="colStat" Type="Byte" />
        </UpdateParameters>
    </asp:SqlDataSource>


</td>

</tr>
</table>



    <asp:SqlDataSource ID="ds_shifts" runat="server" 
        ConnectionString="<%$ ConnectionStrings:timesheetConnectionString %>" 
        SelectCommand="SELECT * FROM [ts_shifts] where colStat = 0" 
        DeleteCommand="[sp_update_shifts]" DeleteCommandType="StoredProcedure" 
        InsertCommand="[sp_update_shifts]" InsertCommandType="StoredProcedure" 
        ProviderName="<%$ ConnectionStrings:timesheetConnectionString.ProviderName %>" 
        UpdateCommand="[sp_update_shifts]" UpdateCommandType="StoredProcedure">
        <DeleteParameters>

            <asp:Parameter Name="colID" Type="Int32" />
            <asp:Parameter Name="colStat" Type="Byte" />
        </DeleteParameters>
        <InsertParameters>
            <asp:Parameter Name="colName" Type="String" />
            <asp:Parameter Name="colCode" Type="String" />
        </InsertParameters>
        <UpdateParameters>
            <asp:Parameter Name="colID" Type="Int32" />
            <asp:Parameter Name="colName" Type="String" />
            <asp:Parameter Name="colCode" Type="String" />
        </UpdateParameters>
    </asp:SqlDataSource>


    <asp:SqlDataSource ID="ds_shiftdetails" runat="server" 
        ConnectionString="<%$ ConnectionStrings:timesheetConnectionString %>" 
        SelectCommand="sp_get_shift_details" SelectCommandType="StoredProcedure" 
        CancelSelectOnNullParameter="False" UpdateCommand="sp_update_shiftdetails" 
        UpdateCommandType="StoredProcedure">
        <SelectParameters>

            <asp:SessionParameter Name="colShiftID" SessionField="colShiftID" Type="Int32" />

        </SelectParameters>
        <UpdateParameters>
            <asp:Parameter Name="colID" Type="Int32" />
            <asp:Parameter DbType="time" Name="colTimeIn" />
            <asp:Parameter DbType="time" Name="colTimeOut" />
            <asp:Parameter DbType="time" Name="colLTimeOut" />
            <asp:Parameter DbType="time" Name="colLTimeIn" />
        </UpdateParameters>
    </asp:SqlDataSource>






</asp:Content>
