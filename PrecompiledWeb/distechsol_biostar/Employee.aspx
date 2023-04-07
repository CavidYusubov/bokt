<%@ page language="C#" autoeventwireup="true" masterpagefile="~/Site.master" inherits="_Default, App_Web_ylx3nowf" %>

<%@ Register Assembly="DevExpress.Web.ASPxTreeList.v16.1, Version=16.1.5.0, Culture=neutral, PublicKeyToken=b88d1754d700e49a"
    Namespace="DevExpress.Web.ASPxTreeList" TagPrefix="dx" %>

<asp:Content ID="Content" ContentPlaceHolderID="MainContent" runat="server">


<script type="text/javascript">

    var doProcessClick;
    var nodeKey;
    function onClick(s, e) {

//        alert(e.nodeKey)
        gvEmployee.PerformCallback(e.nodeKey);

    }
    function ShowNodeClick(value) {
            alert("Click - " + value);
    }

</script>  

    Employee

<table  style="border-spacing: 10px; border-collapse: separate; " cellspacing="5"><tr>
<td valign="top" width = "20%">


<dx:ASPxPopupMenu ID="ASPxPopupMenu1" runat="server" ClientInstanceName="ASPxPopupMenuClientControl"
        PopupElementID="ASPxTreeList1" ShowPopOutImages="True" AutoPostBack="True" 
        PopupAction="RightMouseClick" onitemclick="ASPxPopupMenu1_ItemClick">
        <Items>
            <dx:MenuItem Text="Move Here" Name="Name">
            </dx:MenuItem>
        </Items>
        <ItemStyle Width="143px"></ItemStyle>
    </dx:ASPxPopupMenu>

    <dx:ASPxTreeList ID="ASPxTreeList1" ClientInstanceName="treeList" runat="server" AutoGenerateColumns="False" Width="100%"
        DataSourceID="ds_deparments" KeyFieldName="colID" ParentFieldName="colParentID">
        <Settings GridLines="Both" ScrollableHeight="300" SuppressOuterGridLines="true"/>


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
        </Columns>
    <SettingsBehavior AllowFocusedNode="True"  />
        <ClientSideEvents NodeDblClick="function(s, e) {gvEmployee.PerformCallback(e.nodeKey);}" />
    </dx:ASPxTreeList>


</td>
<td>
    <dx:ASPxGridView ID="gvEmployee" ClientInstanceName="gvEmployee" runat="server" AutoGenerateColumns="False" 
        Width="100%" 
        onrowupdating="gvEmployee_RowUpdating" DataSourceID="ds_employee" 
        KeyFieldName="colID" oncustomcallback="gvEmployee_CustomCallback" onfocusedrowchanged="gvEmployee_FocusedRowChanged" 
        >


        <SettingsEditing Mode="EditForm">
        </SettingsEditing>
        <Settings ShowFilterRow="True" />
        <SettingsBehavior AllowFocusedRow="True"  AllowDragDrop="true"  
            EnableRowHotTrack="true" ConfirmDelete="True" />
        <Styles>
            <AlternatingRow Enabled="true" />
        </Styles>

        <Columns>

        <dx:GridViewCommandColumn ShowNewButtonInHeader="true" ShowEditButton="true" ShowDeleteButton="true" VisibleIndex="100" />

            <dx:GridViewDataTextColumn FieldName="colID" ReadOnly="True" Visible="false">
                <EditFormSettings Visible="False" />
            </dx:GridViewDataTextColumn>
            <dx:GridViewDataTextColumn FieldName="colUserID" Visible="false" Caption = "User ID">
            </dx:GridViewDataTextColumn>

            <dx:GridViewDataBinaryImageColumn FieldName="colImage" Caption = "Photo">
                <PropertiesBinaryImage ImageHeight="170px" ImageWidth="160px">
                    <EditingSettings Enabled="true" 
                        UploadSettings-UploadValidationSettings-MaxFileSize="4194304">
<UploadSettings>
<UploadValidationSettings MaxFileSize="4194304"></UploadValidationSettings>
</UploadSettings>
                    </EditingSettings>
                </PropertiesBinaryImage>
            </dx:GridViewDataBinaryImageColumn>

            <dx:GridViewDataTextColumn FieldName="colFullName" VisibleIndex="3" Caption = "Full Name">
            </dx:GridViewDataTextColumn>
            <dx:GridViewDataTextColumn FieldName="colFName" Visible="False" Caption = "First Name">
            </dx:GridViewDataTextColumn>
            <dx:GridViewDataTextColumn FieldName="colLName" Visible="False" Caption = "Last Name">
            </dx:GridViewDataTextColumn>
            <dx:GridViewDataTextColumn FieldName="colMName" Visible="False" Caption = "Pathers Name">
            </dx:GridViewDataTextColumn>
            <dx:GridViewDataTextColumn FieldName="colEmail" VisibleIndex="7" Caption = "EMail">
            </dx:GridViewDataTextColumn>
            <dx:GridViewDataTextColumn FieldName="colMPhone" VisibleIndex="8" Caption = "Phone">
            </dx:GridViewDataTextColumn>



            <dx:GridViewDataComboBoxColumn FieldName="colPosition" VisibleIndex="5" Caption="Position">
            <PropertiesComboBox DataSourceID="ds_positions" ValueField="colID" TextField="colName" ValueType="System.Int32" />
                <EditItemTemplate>
                            <dx:ASPxComboBox ID="cbPositions" runat="server"     DataSourceID="ds_positions"  TextField="colName" ValueField="colID" Value='<%# Bind("colPosition") %>' 
                             ValueType="System.Int32" Width = "100%">
                            </dx:ASPxComboBox>
                    </EditItemTemplate>
            </dx:GridViewDataComboBoxColumn>


            <dx:GridViewDataComboBoxColumn FieldName="colShift" VisibleIndex="11" Caption="Shift">
            <PropertiesComboBox DataSourceID="ds_shifts" ValueField="colID" TextField="colName" ValueType="System.Int32" />
                <EditItemTemplate>
                            <dx:ASPxComboBox ID="cbShifts" runat="server"     DataSourceID="ds_shifts"  TextField="colName" ValueField="colID" Value='<%# Bind("colShift") %>' 
                             ValueType="System.Int32" Width = "100%">
                            </dx:ASPxComboBox>
                    </EditItemTemplate>
            </dx:GridViewDataComboBoxColumn>


            <dx:GridViewDataComboBoxColumn FieldName="colSalary" VisibleIndex="12" Caption="Salary Grade">
            <PropertiesComboBox DataSourceID="ds_salarygrade" ValueField="colID" TextField="colName" ValueType="System.Int32" />
                <EditItemTemplate>
                            <dx:ASPxComboBox ID="cbSalaryGrade" runat="server"     DataSourceID="ds_salarygrade"  TextField="colName" ValueField="colID" Value='<%# Bind("colSalary") %>' 
                             ValueType="System.Int32" Width = "100%">
                            </dx:ASPxComboBox>
                    </EditItemTemplate>


            </dx:GridViewDataComboBoxColumn>

        </Columns>

        <EditFormLayoutProperties ColCount="4">
            <Items>
                <dx:GridViewColumnLayoutItem ColumnName="colImage" RowSpan="5" ShowCaption="False" HelpText="You can upload JPG, GIF or PNG file. Maximum fils size is 4MB." Width="180px"/>
                <dx:GridViewColumnLayoutItem ColumnName="colUserID"/>
                <dx:GridViewColumnLayoutItem ColumnName="colLName"/>
                <dx:GridViewColumnLayoutItem ColumnName="colFName"/>
                <dx:GridViewColumnLayoutItem ColumnName="colMName"/>
                <dx:GridViewColumnLayoutItem ColumnName="colMPhone" />
                <dx:GridViewColumnLayoutItem ColumnName="colEmail" />
                <dx:GridViewColumnLayoutItem ColumnName="colPosition" />
                <dx:GridViewColumnLayoutItem ColumnName="colSalary" />
                <dx:GridViewColumnLayoutItem ColumnName="colShift" />
                <dx:EmptyLayoutItem />
                <dx:EmptyLayoutItem />
                <dx:EditModeCommandLayoutItem ShowCancelButton="true" ShowUpdateButton="true" HorizontalAlign="Right" />
            </Items>
        </EditFormLayoutProperties>


    </dx:ASPxGridView>


</td>
</tr></table>

    <asp:SqlDataSource ID="ds_employee" runat="server" 
        ConnectionString="<%$ ConnectionStrings:timesheetConnectionString %>" 
        SelectCommand="sp_get_emplist" SelectCommandType="StoredProcedure" 
        UpdateCommand="sp_update_employee" UpdateCommandType="StoredProcedure">
        <SelectParameters>
            <asp:Parameter DefaultValue="0" Name="colDepID" Type="Int32" />
        </SelectParameters>
        <UpdateParameters>
            <asp:Parameter Direction="ReturnValue" Name="RETURN_VALUE" Type="Int32" />
            <asp:Parameter Name="colID" Type="Int32" />
            <asp:Parameter Name="colFName" Type="String" />
            <asp:Parameter Name="colLName" Type="String" />
            <asp:Parameter Name="colMName" Type="String" />
            <asp:Parameter Name="colEmail" Type="String" />
            <asp:Parameter Name="colTitle" Type="String" />
            <asp:Parameter Name="colMPhone" Type="String" />
            <asp:Parameter Name="colPosID" Type="Int32" />
            <asp:Parameter Name="colSalaryID" Type="Int32" />
            <asp:Parameter Name="colShiftID" Type="Int32" />
            <asp:Parameter Name="colStat" Type="Byte" />
            <asp:Parameter Name="colImage" DbType="Binary" />
        </UpdateParameters>
    </asp:SqlDataSource>

    

        <asp:SqlDataSource ID="ds_shifts" runat="server" 
        ConnectionString="<%$ ConnectionStrings:timesheetConnectionString %>" 
        SelectCommand="sp_get_shifts" SelectCommandType="StoredProcedure">
        </asp:SqlDataSource>
    <asp:SqlDataSource ID="ds_positions" runat="server" 
        ConnectionString="<%$ ConnectionStrings:timesheetConnectionString %>" 
        SelectCommand="sp_get_positions_name" SelectCommandType="StoredProcedure">
    </asp:SqlDataSource>

    <asp:SqlDataSource ID="ds_salarygrade" runat="server" 
        ConnectionString="<%$ ConnectionStrings:timesheetConnectionString %>" 
        SelectCommand="sp_get_salarygrades_name" SelectCommandType="StoredProcedure">
    </asp:SqlDataSource>

    <asp:SqlDataSource ID="ds_deparments" runat="server" 
        ConnectionString="<%$ ConnectionStrings:timesheetConnectionString %>" 
        SelectCommand="sp_deps_treelist_name" SelectCommandType="StoredProcedure">
    </asp:SqlDataSource>
    


</asp:Content>
