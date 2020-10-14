﻿<%@ Page Title="" Language="vb" AutoEventWireup="false" MasterPageFile="~/CF_Console.Master" CodeBehind="dropdown_list.aspx.vb" Inherits="cleanfleets_fms.dropdown_list" %>

<asp:Content runat="server" ContentPlaceHolderID="head">
	<style type="text/css">
		#form1
		{
			text-align: left;
		}
	</style>
</asp:Content>
<asp:Content runat="server" ContentPlaceHolderID="RightColumnContentPlaceHolder">
	<br />
	<br />
	<asp:DropDownList ID="ddl_OptionNames" runat="server" DataSourceID="sds_Option_List"
		DataTextField="OptionName" DataValueField="OptionName" AutoPostBack="True">
	</asp:DropDownList>
	<br />
	<br />
	<telerik:radgrid id="rgd_Optionn_Details" runat="server" datasourceid="sds_Option_List_rgd"
		gridlines="None" autogeneratedeletecolumn="True" autogenerateeditcolumn="True"
		width="916px" allowautomaticdeletes="True" allowautomaticinserts="True" allowautomaticupdates="True"
		cssclass="radgrid" allowsorting="True">
<MasterTableView CommandItemDisplay="Bottom" AutoGenerateColumns="False" DataKeyNames="IDOptionList" DataSourceID="sds_Option_List_rgd">
<RowIndicatorColumn>
<HeaderStyle Width="20px"></HeaderStyle>
</RowIndicatorColumn>

<ExpandCollapseColumn>
<HeaderStyle Width="20px"></HeaderStyle>
</ExpandCollapseColumn>
    <Columns>
        <telerik:GridBoundColumn DataField="RecordValue" DefaultInsertValue="" HeaderText="Record Value" SortExpression="RecordValue" UniqueName="RecordValue">
        </telerik:GridBoundColumn>
        <telerik:GridBoundColumn DataField="DisplayValue" DefaultInsertValue="" HeaderText="Display Value" SortExpression="DisplayValue" UniqueName="DisplayValue">
        </telerik:GridBoundColumn>
        <telerik:GridBoundColumn DataField="OptionName" DefaultInsertValue="" HeaderText="Option Name" SortExpression="OptionName" UniqueName="OptionName">
        </telerik:GridBoundColumn>
    </Columns>
</MasterTableView>
                </telerik:radgrid>
	<br />
	<br />
	You can edit current Options in the categories that already exist. To do so:<br />
	<br />
	Click Edit<br />
	Modify the Record Value<br />
	Modify the Display Value<br />
	<span style="color: #FF3300">DO NOT</span> modify the Option Name<br />
	Click update<br />
	<br />
	You can enter new Options in the categories that already exist. To do so:<br />
	<br />
	Select the category you want to add a record to<br />
	Select Add new record<br />
	Enter the Record Value<br />
	Enter the Display Value (Should be the same as the Record Value)<br />
	Enter the Option Name esuring it is spelled <span style="color: #FF3300">EXACTLY</span>
	the same as the category you selected otherwise it will not display.<br />
	<br />
	<br />
	The entry of the Option Name will be automated in the near future.<br />
	<asp:SqlDataSource ID="sds_Option_List" runat="server" ConnectionString="<%$ ConnectionStrings:CF_SQL_Connection %>"
		SelectCommand="SELECT DISTINCT [OptionName] FROM [CF_Option_List] ORDER BY [OptionName]">
	</asp:SqlDataSource>
	<br />
	<asp:SqlDataSource ID="sds_Option_List_rgd" runat="server" ConnectionString="<%$ ConnectionStrings:CF_SQL_Connection %>"
		SelectCommand="SELECT [IDOptionList], [RecordValue], [DisplayValue], [OptionName] FROM [CF_Option_List] WHERE ([OptionName] = @OptionName) ORDER BY [RecordValue]"
		DeleteCommand="DELETE FROM [CF_Option_List] WHERE [IDOptionList] = @IDOptionList"
		InsertCommand="INSERT INTO [CF_Option_List] ([RecordValue], [DisplayValue], [OptionName]) VALUES (@RecordValue, @DisplayValue, @OptionName)"
		UpdateCommand="UPDATE [CF_Option_List] SET [RecordValue] = @RecordValue, [DisplayValue] = @DisplayValue, [OptionName] = @OptionName WHERE [IDOptionList] = @IDOptionList">
		<SelectParameters>
			<asp:ControlParameter ControlID="ddl_OptionNames" Name="OptionName" PropertyName="SelectedValue"
				Type="String" />
		</SelectParameters>
		<DeleteParameters>
			<asp:Parameter Name="IDOptionList" Type="Int32" />
		</DeleteParameters>
		<UpdateParameters>
			<asp:Parameter Name="RecordValue" Type="String" />
			<asp:Parameter Name="DisplayValue" Type="String" />
			<asp:Parameter Name="OptionName" Type="String" />
			<asp:Parameter Name="IDOptionList" Type="Int32" />
		</UpdateParameters>
		<InsertParameters>
			<asp:Parameter Name="RecordValue" Type="String" />
			<asp:Parameter Name="DisplayValue" Type="String" />
			<asp:Parameter Name="OptionName" Type="String" />
		</InsertParameters>
	</asp:SqlDataSource>
</asp:Content>
