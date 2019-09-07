<%@ Page Title="" Language="vb" AutoEventWireup="false" MasterPageFile="~/CF_Console.Master" CodeBehind="vehicleimport.aspx.vb" Inherits="cleanfleets_fms.vehicleimport" %>
<asp:Content runat="server" ContentPlaceHolderID="RightColumnContentPlaceHolder">
	<h1>
		Import Terminals, Fleets, and Vehicles</h1>
	<div style="width: 500px">
		<p>
			Imports Vehicles, Engines, and DECS from a specially formatted Excel Workbook
			(.XLS). This process will automatically create any missing Accounts, Terminals,
			and Fleets that do not already exist.
		</p>
		<p>
			If a Vehicle already exists with the VIN matching the ChassisVIN from the Workbook,
			the existing Vehicle will be updated with the information from the Workbook. This
			includes possibly changing the Fleet and Account to which it originally belonged.
		</p>
		<p>
			If an Engine already exists with the SerialNum from the Workbook, the Engine will
			be updated with the information from the Workbook. This includes possibly changing
			the Account and Vehicle to which it is attached.
		</p>
		<p>
			Any columns that are based on drop-down lists are automatically converted. If any
			cells cannot be converted because it does not match one of the options in the system,
			the rows containing that value will be ignored and the Vehicle, Engine, and DECS
			will not be created or updated.
		</p>
	</div>
	<table cellpadding="0" cellspacing="0" class="style1">
		<tr>
			<td class="tdtable" style="padding: 3px" align="left">
				<asp:Label ID="Label2" runat="server" AssociatedControlID="fu_ImportFile">Excel File:</asp:Label>
			</td>
			<td style="padding: 3px" align="left">
				<asp:FileUpload ID="fu_ImportFile" runat="server" />
				<asp:RequiredFieldValidator runat="server" ID="RequiredFieldValidator1" ControlToValidate="fu_ImportFile"
					ErrorMessage="Please choose an Excel file to import." />
			</td>
		</tr>
		<tr>
			<td class="tdtable" style="padding: 3px" align="left">
				<asp:Label ID="Label3" runat="server" AssociatedControlID="fu_ImportFile2">Zip File:</asp:Label>
			</td>
			<td style="padding: 3px" align="left">
				<asp:FileUpload ID="fu_ImportFile2" runat="server" />
			</td>
		</tr>
		<tr>
		<td></td>
			<td colspan="2" align="left"><br/>
				<asp:Button ID="btnImport" runat="server" TabIndex="20" Text="Import" /> 
				<asp:Button ID="btnImportFiles" runat="server" TabIndex="20" Text="Import Vehicle Files Only" />
				<asp:CheckBox id="cbReplaceAllFiles" runat="server" Text="Remove Existing Files I Attached First" />				
			</td>
		</tr>
		
		<tr>
			<td colspan="2" align="left"><br/>
				<asp:Label ID="Messages" runat="server" />
			</td>
		</tr>
	</table>
	<asp:GridView ID="gv_Excel" runat="server" OnRowDataBound="gv_Excel_RowDataBound">
	</asp:GridView>
	<asp:SqlDataSource ID="sds_ddl_Account" runat="server" ConnectionString="<%$ ConnectionStrings:CF_SQL_Connection %>"
		SelectCommand="SELECT * FROM [CF_Profile_Account] ORDER BY [AccountName]"></asp:SqlDataSource>
</asp:Content>

