<%@ Page Title="" Language="vb" AutoEventWireup="false" MasterPageFile="~/CF_Console.Master" CodeBehind="account_custom_module.aspx.vb" Inherits="cleanfleets_fms.account_custom_module" %>
<%@ Register Assembly="CFWebControls" Namespace="CFWebControls" TagPrefix="CF" %>

	<asp:Content runat="server" ContentPlaceHolderID="head">

	<style>
		.errorMessage {
			font-weight: bold;
			color: red;	
		}
	</style>
</asp:Content>
<asp:Content runat="server" ContentPlaceHolderID="RightColumnContentPlaceHolder">

	<%
		Dim IDProfileAccount = Request.QueryString("IDProfileAccount")
	%>


	<p style="font-size: medium; font-weight: bold; color: #ED8701">
		Custom Module</p>
		
		
		<div>
			Module Name:
			<asp:TextBox ID="tb_moduleName" runat="server"></asp:TextBox>
			<asp:RequiredFieldValidator id="tb_moduleName_validator" ControlToValidate="tb_moduleName" runat="server" 
			  EnableClientScript="false"
			  ErrorMessage="You must enter a Module Name."/>
		</div>
		
		<div>
			Available Files:
			<CF:GroupedDropDownList ID="ddlFiles" runat= "server" TabIndex="5">
			</CF:GroupedDropDownList>
			
				
				
			<!--<asp:DropDownList ID="ddl_files1" runat="server" AppendDataBoundItems="True"
				DataSourceID="src_files" DataTextField="Title"
				DataValueField="IDFile" TabIndex="5">
				<asp:ListItem Text="Select" Value="" />
			</asp:DropDownList>-->
			<asp:Button ID="addFileButton" OnClick="addFileButton_Click" runat="server" Text="Add File To Module"/>
			<asp:RequiredFieldValidator id="ddl_files_validator" ControlToValidate="ddlFiles" runat="server" 
			  EnableClientScript="false"
			  ErrorMessage="You must choose a file. If no files are available, add a file using Public Documents"/>
		</div>
		
		<div>
			<asp:Button ID="saveButon" OnClick="saveButton_Click" runat="server" Text="Save"/>
			<asp:Button ID="cancelButton" OnClick="cancelButton_Click" runat="server" Text="Cancel"/>
		</div>
		
		<br />
		<asp:Label ID="messageLabel" CssClass="errorMessage" runat="server"></asp:Label>
		<div style="width: 50%">
			<telerik:RadGrid ID="rdg_fileTable" runat="server" AllowPaging="false" CellSpacing="0" PageSize="10">
				<MasterTableView AutoGenerateColumns="false" DataKeyNames="File Name">
					<Columns>
						<telerik:GridBoundColumn DataField="File Name" 
                             HeaderText="File Name"
                             SortExpression="Title" 
                             UniqueName="Title"></telerik:GridBoundColumn>
						<telerik:GridButtonColumn HeaderText="Control" Text="Remove From Module" ButtonType="PushButton" CommandName="Delete"></telerik:GridButtonColumn>
					</Columns>
				</MasterTableView>
			</telerik:RadGrid>
		</div>

	
	
	<asp:SqlDataSource ID="src_files" runat="server" ConnectionString="<%$ ConnectionStrings:CF_SQL_Connection %>"
		SelectCommand=	"SELECT IDFile, Title, 'Public Documents' AS optgroup
						FROM CFV_Files_Account_Public  
						WHERE IDProfileAccount = @IDProfileAccount 
						UNION 
						SELECT F.IDFile, F.Title AS Title,  T.TerminalName + ' - Terminal Documents' AS optgroup 
						FROM CF_Files F 
						INNER JOIN CF_Profile_Terminal T 
						  ON F.IDProfileTerminal = T.IDProfileTerminal 
						WHERE F.IDProfileAccount = @IDProfileAccount 
						AND F.IDProfileTerminal IS NOT NULL 
						ORDER BY Title">
		<SelectParameters>
			<asp:QueryStringParameter Name="IDProfileAccount" QueryStringField="IDProfileAccount"
				Type="Int32" />
		</SelectParameters>
	</asp:SqlDataSource>
</asp:Content>
