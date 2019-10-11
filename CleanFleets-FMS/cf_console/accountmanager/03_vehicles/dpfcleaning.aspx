<%@ Page Title="" Language="vb" AutoEventWireup="false" MasterPageFile="~/CF_Console.Master" CodeBehind="dpfcleaning.aspx.vb" Inherits="cleanfleets_fms.dpfcleaning" %>
<asp:Content runat="server" ContentPlaceHolderID="RightColumnContentPlaceHolder">
	<style>
		.hidden { display:none; }
	</style>

    <%--Added by Andrew on 9/3/2019--%>

    <div id="viewtextvariable" runat="server" visible="false"></div>
    <div id="viewtextvariable_WO" runat="server" visible="false"></div>
    <div id="viewtextvariable_Job" runat="server" visible="false"></div>
    <div id="viewtextvariable_Company" runat="server" visible="false"></div>
    <div id="viewtextvariable_VIN_UNIT" runat="server" visible="false"></div>
    <div id="viewtextvariable_MAKE" runat="server" visible="false"></div>
    <div id="viewtextvariable_MODEL" runat="server" visible="false"></div>

    <!--<div id="viewtextvariable_theField" runat="server" visible="false"></div>
    <div id="viewtextvariable_theFieldValues" runat="server" visible="false"></div>-->

    <div id="PlateValidationPrompt" runat="server" visible="false" color="red"></div>
    <div id="VINNumberValidationPrompt" runat="server" visible="false" color="red"></div>
    <div id="DecimalValidationPrompt" runat="server" visible="false" color="red"></div>
    <div id="DateValidationPrompt" runat="server" visible="false" color="red"></div>
    <div id="WOValidationPrompt" runat="server" visible="false" color="red"></div>
    <div id="MilesHoursValidationPrompt" runat="server" visible="false" color="red"></div>

    <style type="text/css">

        .PlateValidationPrompt{

            color: red;

        }

    </style>

    <%--End of what was Added by Andrew on 9/3/2019--%>

	<div id="dvSectionImport" runat="server">
		<h1>Import DPF Cleaning Record</h1>
		<div id="dvImportFile" runat="server">
			<p>
				Imports a DPF Cleaning record from a specially formatted PDF File (.PDF).
			</p>
			<p>
				If the "Attach to Vehicle" option is set to Yes or left blank and a DPF Cleaning record already exists with the Vehicle and Test Date, the existing DPF Cleaning record will be updated.
			</p>
            <p>
            	If the "Attach to Vehicle" option is set to No, then the imported file will just generate a temporary report.
            </p>
			<table ID="tblImportFile" runat="server" cellpadding="0" cellspacing="0" class="style1">
				<tr>
					<td class="tdtable" style="padding:3px" align="left">
						<asp:Label ID="Label2" runat="server" AssociatedControlID="fu_ImportFile">PDF File:</asp:Label>
					</td>
					<td style="padding:3px" align="left">
						<asp:FileUpload ID="fu_ImportFile" runat="server" accept=".pdf" />
						<asp:RequiredFieldValidator runat="server" ID="RequiredFieldValidator1" ControlToValidate="fu_ImportFile"
							ErrorMessage="Please choose a PDF file to import." />
					</td>
				</tr>
                <tr>
					<td class="tdtable" style="padding:3px" align="left">
					</td>
					<td style="padding:3px" align="left">
						<asp:RadioButtonList ID="rbl_AttachToDBRecord" runat="server" CssClass="rbl" RepeatDirection="Horizontal">
                        	<asp:ListItem Text="Import and Attach to Vehicle" value="1"></asp:ListItem>
                            <asp:ListItem Text="Generate Report Only" value="2"></asp:ListItem>
                        </asp:RadioButtonList>
					</td>
				</tr>
				<tr>
					<td>&nbsp;</td>
					<td colspan="2" align="left">
						<asp:Button ID="btnImport" runat="server" TabIndex="20" Text="Import" />
                        <asp:Button ID="btnPDFReport" runat="server" TabIndex="21" Text="View PDF Report" Visible="false" CausesValidation="False"/>
                    </td>
				</tr>
			</table>
		</div>
		<table>
			<tr>
				<td colspan="2" align="left"><br/>
					<asp:Label ID="Messages" runat="server" />
				</td>
			</tr>
		</table>
		<asp:GridView ID="gv_Text" runat="server" OnRowDataBound="gv_Text_RowDataBound" OnRowCommand="gv_Text_OnRowCommand" AutoGenerateColumns="false" CellPadding="2" CellSpacing="0">
			<Columns>
				<asp:BoundField DataField="IDProfileAccount" HeaderText="Account" />
				<asp:BoundField DataField="IDProfileTerminal" HeaderText="Terminal" />
				<asp:BoundField DataField="IDVehicles" HeaderText="Vehicle" />
				<asp:BoundField DataField="CompanyName" HeaderText="Company Name" />
				<asp:BoundField DataField="TestCity" HeaderText="Test City" />
				<asp:BoundField DataField="LicensePlate" HeaderText="License Plate" />
				<asp:BoundField DataField="Unit" HeaderText="VIN / Unit #" />
				<asp:BoundField DataField="TestDate" HeaderText="Test Date" />
				<asp:BoundField DataField="TestedBy" HeaderText="Tested By" />
				<asp:BoundField DataField="AverageOpacity" HeaderText="Average Opacity" />
				<asp:BoundField DataField="TestResult" HeaderText="Test Result" />
				<asp:BoundField DataField="Mileage" HeaderText="Mileage" DataFormatString="{0:n0}" >
					<itemstyle HorizontalAlign="right"/>
				</asp:BoundField>
				<%--<asp:BoundField DataField="OpacityTestsImportStatus" HeaderText="OpacityTestsImportStatus" />
				<asp:BoundField DataField="Errors" HeaderText="Errors" /> --%>
				<asp:TemplateField ShowHeader="False">
					<ItemTemplate>
						<asp:Button ID="btnSelectAccount" runat="server" Visible="false" CausesValidation="false" CommandName="SelectAccount" Text="Select Account" CommandArgument='<%# Eval("IDImport") %>' />
						<asp:Button ID="btnSelectTerminal" runat="server" Visible="false" CausesValidation="false" CommandName="SelectTerminal" Text="Select Terminal" CommandArgument='<%# Eval("IDImport") %>' />
						<asp:Button ID="btnSelectUnit" runat="server" Visible="false" CausesValidation="false" CommandName="SelectUnit" Text="Select Unit" CommandArgument='<%# Eval("IDImport") %>' />
						<asp:Button ID="btnSelectSignature" runat="server" Visible="false" CausesValidation="false" CommandName="SelectSignature" Text="Select Signature" CommandArgument='<%# Eval("IDImport") %>' />
					</ItemTemplate>
				</asp:TemplateField>
			</Columns>
		</asp:GridView>
       
        
	</div>
	<asp:Panel id="pnlFixRecords" runat="server" visible="false">
		<asp:HiddenField runat="server" ID="hidIDProfileAccount" />
		<asp:HiddenField runat="server" ID="hidIDProfileTerminal" />
		<asp:HiddenField runat="server" ID="hidIDProfileFleet" />
		<h1>Editing Record</h1>
		<asp:Button ID="btnReturnList" runat="server" Text="Return" />
		<table id="tblEditingRecord" cellspacing="0" cellpadding="2" rules="all" border="1" style="border-collapse: collapse;margin-bottom: 20px;">
			<tbody>
				<tr>
					<th>Company Name</th>
					<th>Test City</th>
					<th>License Plate</th>
					<th>VIN / Unit Number</th>
					<th>Test Date</th>
					<th>Tested By</th>
					<th>Avarage Opacity</th>
					<th>Test Result</th>
					<th>Mileage</th>
					<th>Errors</th>
				</tr>
				<tr>
					<td>
						<asp:Literal ID="tbCompanyName" runat="server"></asp:Literal>
					</td>
					<td>
						<asp:Literal ID="tbTestCity" runat="server"></asp:Literal>
					</td>
					<td>
						<asp:Literal ID="tbLicensePlate" runat="server"></asp:Literal>
					</td>
					<td>
						<asp:Literal ID="tbUnitNo" runat="server"></asp:Literal>
					</td>
					<td>
						<asp:Literal ID="tbTestDate" runat="server"></asp:Literal>
					</td>
					<td>
						<asp:Literal ID="tbTestedBy" runat="server"></asp:Literal>
					</td>
					<td>
						<asp:Literal ID="tbAverageOpacity" runat="server"></asp:Literal>
					</td>
					<td>
						<asp:Literal ID="tbTestResult" runat="server"></asp:Literal>
					</td>
					<td>
						<asp:Literal ID="tbMileage" runat="server"></asp:Literal>
					</td>
					<td>
						<asp:Literal ID="tbErrors" runat="server"></asp:Literal>
					</td>
				</tr>
			</tbody>
		</table>
		<asp:Panel ID="pnlSelectSignature" runat="server">
			<asp:GridView ID="gv_Signatures" runat="server" OnRowCommand="gv_Signatures_OnRowCommand" AutoGenerateColumns="false" CellPadding="2" CellSpacing="0">
				<Columns>
					<asp:BoundField DataField="FilePath" HeaderText="File Path" />
					<asp:BoundField DataField="FirstName" HeaderText="First Name" />
					<asp:BoundField DataField="LastName" HeaderText="Last Name" />
					<asp:ImageField DataImageUrlField="FilePath" HeaderText="Signature" ControlStyle-Width="200px"></asp:ImageField>
					<asp:TemplateField ShowHeader="False">
						<ItemTemplate>
							<asp:Button ID="btnSelectSignature" runat="server" CausesValidation="false" CommandName="SelectSignature" Text="Select Signature" CommandArgument='<%# Eval("IDSignature") %>' />
						</ItemTemplate>
					</asp:TemplateField>
				</Columns>
			</asp:GridView>
		</asp:Panel>
		<asp:Panel id="pnlSelectUnit" runat="server">
			<asp:SqlDataSource ID="sds_ddl_Account" runat="server" ConnectionString="<%$ ConnectionStrings:CF_SQL_Connection %>"
				SelectCommand="SELECT * FROM [CF_Profile_Account] ORDER BY [AccountName]"></asp:SqlDataSource>
			<table cellpadding="0" cellspacing="0" class="style1">
				<tr>
					<td class="tdtable" style="padding: 3px">
						<asp:Label ID="Label1" runat="server" AssociatedControlID="ddl_Account">Account:</asp:Label>
					</td>
					<td style="padding: 3px">
						<asp:DropDownList ID="ddl_Account" runat="server" Width="300px" DataSourceID="sds_ddl_Account"
							DataTextField="AccountName" DataValueField="IDProfileAccount" AppendDataBoundItems="True"
							AutoPostBack="true" OnSelectedIndexChanged="ddl_Account_SelectedIndexChanged" OnDataBound="ddl_Account_DataBound">
							<Items>
								<asp:ListItem Text="- Select Account -" Value="0" />
							</Items>
						</asp:DropDownList>
					</td>
				</tr>
				<tr>
					<td class="tdtable" style="padding: 3px">
						<asp:Label ID="Label3" runat="server" AssociatedControlID="ddl_Terminal">Terminal:</asp:Label>
					</td>
					<td style="padding: 3px">
						<asp:DropDownList ID="ddl_Terminal" runat="server" Width="186px" AutoPostBack="true"
							OnSelectedIndexChanged="ddl_Terminal_SelectedIndexChanged" OnDataBound="ddl_Terminal_DataBound" />
					</td>
				</tr>
				<tr>
					<td class="tdtable" style="padding: 3px">
						<asp:Label ID="Label4" runat="server" AssociatedControlID="ddl_Fleet">Fleet:</asp:Label>
					</td>
					<td style="padding: 3px">
						<asp:DropDownList ID="ddl_Fleet" runat="server" Width="186px" AutoPostBack="true"
							OnSelectedIndexChanged="ddl_Fleet_SelectedIndexChanged" OnDataBound="ddl_Fleet_DataBound" />
					</td>
				</tr>
				<tr>
					<td class="tdtable" style="padding: 3px">&nbsp;</td>
					<td style="padding: 3px">&nbsp;</td>
				</tr>
			</table>
			<h1>Vehicles</h1>
			<telerik:radgrid id="rg_Terminals" datasourceid="sds_Vehicles" allowsorting="True" allowpaging="True" runat="server" gridlines="None" onload="rg_Terminals_OnLoad">
				<MasterTableView Width="100%" CommandItemDisplay="Top" AutoGenerateColumns="False" DataSourceID="sds_Vehicles">
					<Columns>
						<telerik:GridBoundColumn DataField="AccountName" DefaultInsertValue="" 
							HeaderText="Account" SortExpression="AccountName" 
							UniqueName="AccountName">
						</telerik:GridBoundColumn>
						<telerik:GridBoundColumn DataField="TerminalName" DefaultInsertValue="" 
							HeaderText="Terminal" SortExpression="TerminalName" 
							UniqueName="TerminalName">
						</telerik:GridBoundColumn>
						<telerik:GridBoundColumn DataField="FleetName" DefaultInsertValue="" 
							HeaderText="Fleet" SortExpression="FleetName" 
							UniqueName="FleetName">
						</telerik:GridBoundColumn>
						<telerik:GridBoundColumn DataField="UnitNo" DefaultInsertValue="" 
							HeaderText="UnitNo" SortExpression="UnitNo" 
							UniqueName="UnitNo">
						</telerik:GridBoundColumn>
						<telerik:GridBoundColumn DataField="LicensePlateNo" DefaultInsertValue="" 
							HeaderText="LicensePlateNo" 
							SortExpression="LicensePlateNo" UniqueName="LicensePlateNo">
						</telerik:GridBoundColumn>
						<telerik:GridBoundColumn DataField="ChassisVIN" DefaultInsertValue="" 
							HeaderText="ChassisVIN" SortExpression="ChassisVIN" 
							UniqueName="ChassisVIN">
						</telerik:GridBoundColumn>
						<telerik:GridBoundColumn DataField="ChassisModelYear" DefaultInsertValue="" 
							HeaderText="ChassisModelYear" SortExpression="ChassisModelYear" 
							UniqueName="ChassisModelYear" ReadOnly="True">
						</telerik:GridBoundColumn>
						<telerik:GridBoundColumn DataField="ChassisMake" DefaultInsertValue="" 
							HeaderText="ChassisMake" SortExpression="ChassisMake" 
							UniqueName="ChassisMake" ReadOnly="True">
						</telerik:GridBoundColumn>
						<telerik:GridBoundColumn DataField="OpacityTestCount" DefaultInsertValue="" 
							HeaderText="Number of Opacity Test Files" SortExpression="OpacityTestCount" UniqueName="OpacityTestCount">
						</telerik:GridBoundColumn>
						<telerik:GridBoundColumn DataField="LastOpacityTestDate" 
							DataType="System.DateTime" DefaultInsertValue="" 
							HeaderText="LastOpacityTestDate" SortExpression="LastOpacityTestDate" 
							UniqueName="LastOpacityTestDate" DataFormatString="{0:MM/dd/yyyy}">
						</telerik:GridBoundColumn>
						<telerik:GridBoundColumn DataField="SerialNum" DefaultInsertValue="" 
							HeaderText="SerialNum" SortExpression="SerialNum" UniqueName="SerialNum">
						</telerik:GridBoundColumn>
						<telerik:GridTemplateColumn HeaderText="Action" AllowFiltering="false">
							<HeaderStyle Width="102px" />
							<ItemTemplate>
								<asp:Button ID="btnSelectUnit" runat="server" CausesValidation="false" CommandName="SelectUnit" Text="Select Unit" CommandArgument='<%# Eval("IDVehicles") %>' />
							</ItemTemplate>
						</telerik:GridTemplateColumn>
					</Columns>
					<PagerStyle Mode="NextPrevNumericAndAdvanced" />
				</MasterTableView>
			</telerik:radgrid>
			<p>&nbsp;</p>
			<asp:SqlDataSource ID="sds_Vehicles" runat="server" ConnectionString="<%$ ConnectionStrings:CF_SQL_Connection %>"
				SelectCommandType="StoredProcedure"
				SelectCommand="ReportVehiclesDetails">
				<SelectParameters>
					<asp:ControlParameter ControlID="hidIDProfileFleet" Name="IDProfileFleet" PropertyName="Value" Type="Int32" />
				</SelectParameters>
			</asp:SqlDataSource>
		</asp:Panel>
	</asp:Panel>
</asp:Content>
