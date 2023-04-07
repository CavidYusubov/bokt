<%@ Page Language="C#" AutoEventWireup="true" MasterPageFile="~/Site.master" CodeFile="Shifts.aspx.cs" Inherits="_Default" %>

<asp:Content ID="Content" ContentPlaceHolderID="MainContent" runat="server">

    <script type="text/javascript" >
    function getShift(s, e) {
//        if (s.GetSelectedIndex() == -1) btnSave.SetEnabled(true); else btnSave.SetEnabled(false);
    }
</script>


<table style="border-spacing: 0px; border-collapse: separate;">
<tr>
<td>
Shifts
</td>

</tr>
<tr>
<td>

<dx:ASPxComboBox ID="cbShifts" ClientInstanceName="cbShifts" runat="server" Width = "200px" 
        DropDownStyle = "DropDown" TextField="colName" ValueField="colID" 
        DataSourceID="SqlDataSource1" 
        AutoPostBack="true" onvaluechanged="cbShifts_ValueChanged" 
>
    <ClientSideEvents KeyUp="getShift" CloseUp="getShift"/>
    </dx:ASPxComboBox>
    <asp:SqlDataSource ID="SqlDataSource1" runat="server" 
        ConnectionString="<%$ ConnectionStrings:timesheetConnectionString %>" 
        SelectCommand="SELECT * FROM [ts_shifts]"></asp:SqlDataSource>




</td>
<td>&nbsp;&nbsp;&nbsp;</td>
<td>
    <dx:ASPxButton ID="btnSave" ClientInstanceName="btnSave" runat="server" 
        Text="Save as New" ClientEnabled="true"
         onclick="btnSave_Click" >
        <ClientSideEvents Click="function(s, e) { e.processOnServer = confirm('are you sure?');  }" />  
    </dx:ASPxButton>

</td>
<td>&nbsp;&nbsp;&nbsp;</td>
<td>
    <dx:ASPxButton ID="ASPxButton1" ClientInstanceName="btnSave" runat="server" 
        Text="Delete" ClientEnabled="true" onclick="ASPxButton1_Click"
        >
        <ClientSideEvents Click="function(s, e) { e.processOnServer = confirm('are you sure?');  }" />  
    </dx:ASPxButton>

</td>
<td>
</td>
</tr>
</table>
<br>
<dx:ASPxGridView ID="gvShiftDetails" ClientInstanceName="gvShiftDetails" Width="100%"
        runat="server" AutoGenerateColumns="False" 
        DataSourceID="SqlDataSource2" 
         OnCustomUnboundColumnData="gvShiftDetails_CustomUnboundColumnData"  
        PreviewFieldName="colID" KeyFieldName="colID" 
        onrowupdating="gvShiftDetails_RowUpdating">
    <SettingsEditing Mode="inline"></SettingsEditing>
<SettingsCommandButton>
<ShowAdaptiveDetailButton ButtonType="Image"></ShowAdaptiveDetailButton>

<HideAdaptiveDetailButton ButtonType="Image"></HideAdaptiveDetailButton>
</SettingsCommandButton>

    <Columns>
     <dx:GridViewCommandColumn ShowEditButton="true" />
         <dx:GridViewDataTextColumn FieldName="colID" ReadOnly="True" Visible="false">
            </dx:GridViewDataTextColumn>
            <dx:GridViewDataTextColumn FieldName="colName" VisibleIndex="1" Caption="Shitf" ReadOnly="True">

            </dx:GridViewDataTextColumn>
            <dx:GridViewDataTextColumn FieldName="colWDay" VisibleIndex="2" Caption="Week day" ReadOnly="true">
             <EditFormSettings Visible="False"/>
            </dx:GridViewDataTextColumn>

            <dx:GridViewDataTimeEditColumn FieldName="colTimeIn" VisibleIndex="3" Caption="Time in" UnboundType="DateTime" Visible="false">
            </dx:GridViewDataTimeEditColumn>
            <dx:GridViewDataTimeEditColumn FieldName="ubTimeIn" VisibleIndex="3" Caption="Time in" UnboundType="DateTime">
                <PropertiesTimeEdit DisplayFormatString="HH:mm" EditFormat="Custom" EditFormatString="HH:mm">  
                </PropertiesTimeEdit>  
            </dx:GridViewDataTimeEditColumn>



            <dx:GridViewDataTimeEditColumn FieldName="colTimeOut" VisibleIndex="4" Caption="Time Out" Visible="false">
            </dx:GridViewDataTimeEditColumn>
            <dx:GridViewDataTimeEditColumn FieldName="ubTimeOut" VisibleIndex="4" Caption="Time Out" UnboundType="DateTime">
                <PropertiesTimeEdit DisplayFormatString="HH:mm" EditFormat="Custom" EditFormatString="HH:mm">  
                </PropertiesTimeEdit>  
            </dx:GridViewDataTimeEditColumn>


            <dx:GridViewDataTimeEditColumn FieldName="colLTimeOut" VisibleIndex="5" Caption="Launch Out" Visible="false">
            </dx:GridViewDataTimeEditColumn>
            <dx:GridViewDataTimeEditColumn FieldName="ubLTimeOut" VisibleIndex="5" Caption="Launch Out" UnboundType="DateTime">
                <PropertiesTimeEdit DisplayFormatString="HH:mm" EditFormat="Custom" EditFormatString="HH:mm">  
                </PropertiesTimeEdit>  
            </dx:GridViewDataTimeEditColumn>

            <dx:GridViewDataTimeEditColumn FieldName="colLTimeIn" VisibleIndex="6" Caption="Launch in" UnboundType="DateTime" Visible="false">
            </dx:GridViewDataTimeEditColumn>
            <dx:GridViewDataTimeEditColumn FieldName="ubLTimeIn" VisibleIndex="6" Caption="Launch in" UnboundType="DateTime">
                <PropertiesTimeEdit DisplayFormatString="HH:mm" EditFormat="Custom" EditFormatString="HH:mm">  
                </PropertiesTimeEdit>  
            </dx:GridViewDataTimeEditColumn>


    </Columns>
</dx:ASPxGridView>


<br>



Holidays

 <dx:ASPxGridView ID="ASPxGridView1" runat="server" AutoGenerateColumns="False" 
        DataSourceID="SqlDataSource3" KeyFieldName="colID">
<SettingsCommandButton>
<ShowAdaptiveDetailButton ButtonType="Image"></ShowAdaptiveDetailButton>

<HideAdaptiveDetailButton ButtonType="Image"></HideAdaptiveDetailButton>
</SettingsCommandButton>
     <Columns>
     <dx:GridViewCommandColumn ShowNewButtonInHeader="true" ShowEditButton="true" ShowDeleteButton="true" VisibleIndex="0" />
         <dx:GridViewDataTextColumn FieldName="colID" ReadOnly="True" Visible="false">
             <EditFormSettings Visible="False" />
         </dx:GridViewDataTextColumn>
         <dx:GridViewDataComboBoxColumn FieldName="colHMonth" VisibleIndex="2" Caption = "Month" Width="120px">

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
         </dx:GridViewDataComboBoxColumn>
         <dx:GridViewDataSpinEditColumn FieldName="colHDay" VisibleIndex="3" Caption="Day">
<PropertiesSpinEdit DisplayFormatString="g" MaxValue="31"></PropertiesSpinEdit>
         </dx:GridViewDataSpinEditColumn>
     </Columns>
    </dx:ASPxGridView>

    <asp:SqlDataSource ID="SqlDataSource3" runat="server" 
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

    <asp:SqlDataSource ID="SqlDataSource2" runat="server" 
        ConnectionString="<%$ ConnectionStrings:timesheetConnectionString %>" 
        SelectCommand="sp_get_shift_details" SelectCommandType="StoredProcedure" 
        CancelSelectOnNullParameter="False" UpdateCommand="sp_update_shiftdetails" 
        UpdateCommandType="StoredProcedure">
        <SelectParameters>
            <asp:Parameter DefaultValue="0" Name="colShiftID" Type="Int32" />
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
