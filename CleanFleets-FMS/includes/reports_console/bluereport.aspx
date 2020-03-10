<%@ Page Language="vb" AutoEventWireup="false" CodeBehind="bluereport.aspx.vb" Inherits="cleanfleets_fms.bluereport" %>

<!DOCTYPE html>

<html xmlns="http://www.w3.org/1999/xhtml">
<head runat="server">
    <title>Fleet Compliance Management System</title>
    <link rel="stylesheet" type="text/css" href="/includes/styles/cf_style_report.css" />
<style type="text/css">
	hr {
		margin-bottom:5px;
		padding:0px;
		border-bottom: 1px solid #000000;
		border-top:0px;
	}
	h2 {
		margin-top:0px;
	}
	@media print {
		.noprint {
			display:none;
		}
		.reportContainer {
			width: 640px;
		}
		.cfnLogo {
			width: 225px;
			height: 75px;
		}
	}
	
	@media screen {
		.printonly {
			display:none;
		}
		.reportContainer {
			width: 800px;
		}
		.cfnLogo {
			width: 300px;
			height: 100px;
		}
	}
</style>

</head>
<body>
<div class="reportContainer">
    <form id="form1" runat="server">
        <asp:FormView ID="FormView1" runat="server" DataSourceID="sds_ReportVehicles" 
            Class="reportContainer">
            <ItemTemplate>
				<table id="table6" cellpadding="0" cellspacing="0" style="width: 100%;">
					<tr>
						<td style="font-size: x-large; font-weight: bold; color: #008000; width: 340px;">
							Vehicle Information Report</td>
						<td style="text-align: right">
							<img alt="Test" src="../../images/newCFLogo300W.jpg" 
								class="cfnLogo" /></td>
					</tr>
				</table>
                <table width="100%">
                    <tr>
                        <td rowspan="3" style="text-align: center; width: 20px; ">&nbsp;
                            </td>
                        <td style="font-weight: bold; color: #2C7500; text-align: right; width: 105px; font-size: small">
                            Account Name:</td>
                        <td style="width: 131px">
                            <asp:Label ID="AccountNameLabel" runat="server" Text='<%# Bind("AccountName") %>' /> 
                        </td>
                        <td style="font-size: small; font-weight: bold; color: #2C7500; text-align: right; width: 95px;">&nbsp;
                            </td>
                        <td>&nbsp;
                            </td>
                    </tr>
                    <tr>
                        <td style="font-weight: bold; color: #2C7500; text-align: right; width: 105px; font-size: small">
                            Terminal Name:
                        </td>
                        <td style="width: 131px">
                            <asp:Label ID="TerminalNameLabel" runat="server" Text='<%# Bind("TerminalName") %>' />
                        </td>
                        <td style="font-size: small; font-weight: bold; color: #2C7500; text-align: right; width: 95px;">&nbsp;
                            </td>
                        <td>&nbsp;
                            </td>
                    </tr>
                    <tr>
                        <td style="font-weight: bold; color: #2C7500; text-align: right; width: 105px; font-size: small">
                            Fleet Name:</td>
                        <td style="width: 131px">
                            <asp:Label ID="FleetNameLabel" runat="server" Text='<%# Bind("FleetName") %>' />
                        </td>
                        <td style="font-size: small; font-weight: bold; color: #2C7500; text-align: right; width: 95px;">&nbsp;
                            </td>
                        <td>&nbsp;
                            </td>
                    </tr>
                </table>
                <hr />
				</ItemTemplate>

        </asp:FormView>
		
<% If vehicleView.Count > 0 Then %>
<% Dim vehicleRow = vehicleView(0) %>
<% Dim dmvRow = dmvView(0) %>
	<div class="reportContainer">
                <h2>Vehicle Information</h2>
	<table width="100%">
		<tr>
			<td rowspan="13" style="text-align: center; width: 205px; " valign="top">
				<img src="<%= Page.ResolveUrl(vehicleRow("ImageVehicle")) + "?height=133" %>" height="133" />
			</td>
			<td style="width: 135px; " class="tabletld">
				Unit No::</td>
			<td>
				<%= vehicleRow("UnitNo") %>
			</td>
			<td>&nbsp;
				</td>
		</tr>
		<tr>
			<td style="width: 135px; " class="tabletld">
				VIN:</td>
			<td >
				<%= vehicleRow("ChassisVin") %>
			</td>
			<td>&nbsp;
				</td>
		</tr>
		<tr>
			<td style="width: 135px; " class="tabletld">
				Vehicle Year:</td>
			<td>
				<%= vehicleRow("ChassisModelYear") %>
			</td>
			<td>&nbsp;
				</td>
		</tr>
		<tr>
			<td style="width: 115px; " class="tabletld">
				Gross Vehicle Weight:
			</td>
			<td style="width: 224px">
				<%= vehicleRow("GrossVehicleWeight") %>
			</td>
			<td>&nbsp;
				</td>
		</tr>
		<% If Not vehicleRow("WeightDefinition") Is Nothing AndAlso Not IsDbNull(vehicleRow("WeightDefinition")) AndAlso Not String.IsNullOrEmpty(vehicleRow("WeightDefinition")) Then %><tr>
			<td style="width: 135px; " class="tabletld">
				Weight Definition:</td>
			<td>
				<%= vehicleRow("WeightDefinition") %>
			</td>
			<td>&nbsp;
				</td>
		</tr>
		<% End If %>
		<tr>
			<td style="width: 135px; " class="tabletld">
				Rule Code:</td>
			<td style="250: ;">
				<%= vehicleRow("RuleCode") %>
			</td>
			<td>&nbsp;
				</td>
		</tr>
		<tr>
			<td style="width: 135px; " class="tabletld">
				Vehicle Group:</td>
			<td>
				<%= vehicleRow("CARBGroup") %>
			</td>
			<td>&nbsp;
				</td>
		</tr>
		<tr>
			<td style="width: 135px; " class="tabletld">
				Status:</td>
			<td >
				<%= vehicleRow("VehicleStatus") %>
			</td>
			<td>&nbsp;
				</td>
		</tr>
		 <% If Not vehicleRow("SpecialProvision") Is Nothing AndAlso  Not IsDbNull(vehicleRow("SpecialProvision")) AndAlso Not String.IsNullOrEmpty(vehicleRow("SpecialProvision")) Then %><tr>
			<td style="width: 135px; " class="tabletld">
				Special Provision:</td>
			<td>
				<%= vehicleRow("SpecialProvision") %>
			</td>
			<td>&nbsp;
				</td>
		</tr>
		<% End If %>
		<tr>
			<td>&nbsp;</td>
		</tr>
	</table>   
	

	<hr />
	
	<h2>Engine Information</h2>
	<table width="100%">
		<tr>
			<td rowspan="12" style="text-align: center; width: 205px; " valign="top">
			<img src="<%= Page.ResolveUrl(vehicleRow("ImageEngine")) + "?height=133" %>" height="133" />
			</td>
			<td style="width: 135px; " class="tabletld">
				Manufacturer:</td>
			<td style="250: ;">
				<%= vehicleRow("EngineManufacturer") %>
			</td>
			<td>&nbsp;
				</td>
		</tr>
		<tr>
			<td style="width: 135px; " class="tabletld">
				Serial No:</td>
			<td style="250: ;">
				<%= vehicleRow("SerialNum") %>
			</td>
			<td>&nbsp;
				</td>
		</tr>
		<tr>
			<td style="width: 135px; " class="tabletld">
				Family Name:</td>
			<td style="250: ;">
				<%= vehicleRow("FamilyName") %>
			</td>
			<td>&nbsp;
				</td>
		</tr>
		<tr>
			<td style="width: 135px; " class="tabletld">
				Model Year:</td>
			<td style="250: ;">
				<%= vehicleRow("ModelYear") %>
				<asp:Label ID="ModelYearLabel" runat="server" Text='<%# Eval("ModelYear") %>' />
			</td>
			<td>&nbsp;
				</td>
		</tr>
		<tr>
			<td style="width: 135px; " class="tabletld">
				Model:</td>
			<td style="250: ;">
				<%= vehicleRow("EngineModel") %>
			</td>
			<td>&nbsp;
				</td>
		</tr>
		<tr>
			<td style="width: 135px; " class="tabletld">
				Status:</td>
			<td style="250: ;">
				<%= vehicleRow("EngineStatus") %>
			</td>
			<td>&nbsp;
				</td>
		</tr>
		<tr>
			<td style="width: 135px; " class="tabletld">
				Fuel Type:</td>
			<td style="250: ;">
				<%= vehicleRow("EngineFuelType") %>
			</td>
			<td>&nbsp;
				</td>
		</tr>
	</table>
	<hr />
	<h2>DECS Information</h2>
	<table width="100%">
		<tr>
			<td rowspan="7" style="text-align: center; width: 205px; " valign="top">
				<img src="<%= Page.ResolveUrl(vehicleRow("ImageDECS")) + "?height=133" %>" height="133" />
			</td>
			<td style="width: 135px; " class="tabletld">
				Manufacturer:</td>
			<td style="width: 227px">
				<%= vehicleRow("DECSManufacturer") %>
			</td>
			<td>&nbsp;
				</td>
		</tr>
		<tr>
			<td style="width: 135px; " class="tabletld">
				Serial No:</td>
			<td style="width: 227px">
				<%= vehicleRow("SerialNo") %>
			</td>
			<td>&nbsp;
				</td>
		</tr>
		<tr>
			<td style="width: 135px; " class="tabletld">
				Name:</td>
			<td style="width: 227px">
				<%= vehicleRow("DECSName") %>
			</td>
			<td>&nbsp;
				</td>
		</tr>
		<tr>
			<td style="width: 135px;" class="tabletld">
				Level:</td>
			<td style="width: 227px">
				<%= vehicleRow("DECSLevel") %>
			</td>
			<td>&nbsp;
				</td>
		</tr>
		<tr>
			<td style="width: 135px;" class="tabletld">
				Installation Date:</td>
			<td style="width: 227px">
				<%= vehicleRow("DECSInstallationDate") %>
			</td>
			<td>&nbsp;
				</td>
		</tr>
		<tr>
			<td class="tabletld" style="width: 135px;">&nbsp;
				</td>
			<td style="width: 227px">&nbsp;
				</td>
			<td>&nbsp;
				</td>
		</tr>
		<tr>
			<td class="tabletld" style="width: 135px;">&nbsp;
				</td>
			<td style="width: 227px">&nbsp;
				</td>
			<td>&nbsp;
				</td>
		</tr>
	</table>
    <hr />
	<h2>DMV Registration Information</h2>
	<table width="100%">
		<tr>
			<td style="width: 135px; " class="tabletld">
				Valid From Date:</td>
			<td style="width: 227px">
				<%= dmvRow("FromDate") %>
			</td>
			<td>&nbsp;
				</td>
		</tr>
		<tr>
			<td style="width: 135px; " class="tabletld">
				Valid Through Date:</td>
			<td style="width: 227px">
				<%= dmvRow("ThroughDate") %>
			</td>
			<td>&nbsp;
				</td>
		</tr>
		<tr>
			<td style="width: 135px; " class="tabletld">
				Date Issued:</td>
			<td style="width: 227px">
				<%= dmvRow("DateIssued") %>
			</td>
			<td>&nbsp;
				</td>
		</tr>
		<tr>
			<td style="width: 135px;" class="tabletld">
				Date Fee Received:</td>
			<td style="width: 227px">
				<%= dmvRow("DateFeeReceived") %>
			</td>
			<td>&nbsp;
				</td>
		</tr>
		<tr>
			<td style="width: 135px;" class="tabletld">
				Sticker Issued:</td>
			<td style="width: 227px">
				<%= dmvRow("StickerIssued") %>
			</td>
			<td>&nbsp;
				</td>
		</tr>
		<tr>
			<td class="tabletld" style="width: 135px;">&nbsp;
				</td>
			<td style="width: 227px">&nbsp;
				</td>
			<td>&nbsp;
				</td>
		</tr>
		<tr>
			<td class="tabletld" style="width: 135px;">&nbsp;
				</td>
			<td style="width: 227px">&nbsp;
				</td>
			<td>&nbsp;
				</td>
		</tr>
	</table>
   
	</div>
<% Else %>
<p>No vehicle information found.</p>
	
<% End If %>
        
    </telerik:RadListView>
            </td>
        </tr>
    </table>

    <br />
    <table id="table7" cellpadding="0" cellspacing="0" 
        style="width: 640px; text-align: left;">
        <tr>
            <td>&nbsp;
                </td>
        </tr>
        <tr>
            <td>&nbsp;
                </td>
        </tr>
		<tr>
			<td>
				916-520-6040
			</td>
        </tr>
        <tr>
			<td>
				Copyright © 2007+ CleanFleets.net LLC. All Rights Reserved
			</td>
        </tr>
    </table>
    <br />

    <br />

    <telerik:RadScriptManager ID="rsm_CF" Runat="server">
    </telerik:RadScriptManager>

    <asp:SqlDataSource ID="sds_ReportVehicles" runat="server" ConnectionString="<%$ ConnectionStrings:CF_SQL_Connection %>"
        SelectCommand="SELECT [IDVehicles], [AccountName], [TerminalName], [FleetName], [UnitNo], [ChassisVIN], [ChassisModelYear], [GrossVehicleWeight], [RuleCode], [CARBGroup], [PlannedComplianceDate], [BackupStatusDate], [ActualComplianceDate], [RetireStatusDate], [VehicleStatus], [SpecialProvision], [WeightDefinition], [IDImages], [Image] FROM [CFV_Report_Vehicle_w_Image] WHERE ([IDVehicles] = @IDVehicles)">
    <SelectParameters>
        <asp:QueryStringParameter Name="IDVehicles" QueryStringField="IDVehicles" />
    </SelectParameters>
    <UpdateParameters>
    </UpdateParameters>
    <InsertParameters>
    </InsertParameters>
</asp:SqlDataSource>
    <asp:SqlDataSource ID="sds_ReportDMV" runat="server" ConnectionString="<%$ ConnectionStrings:CF_SQL_Connection %>" 
        SelectCommand="SELECT TOP(1) 
                        FORMAT([FromDate], 'MM/dd/yyyy', 'en-US') AS FromDate, 
                        FORMAT([ThroughDate], 'MM/dd/yyyy', 'en-US') AS ThroughDate, 
                        FORMAT([DateFeeReceived], 'MM/dd/yyyy', 'en-US') AS DateFeeReceived, 
                        FORMAT([DateIssued], 'MM/dd/yyyy', 'en-US') AS DateIssued, 
                        [StickerIssued]
                        FROM CF_DMV
                        WHERE ([IDVehicles] = @IDVehicles)
                        ORDER BY [FromDate] DESC">
        <SelectParameters>
            <asp:QueryStringParameter Name="IDVehicles" QueryStringField="IDVehicles" />
        </SelectParameters>
    </asp:SqlDataSource>
    <asp:SqlDataSource ID="sds_ReportEnginesDECS" runat="server" ConnectionString="<%$ ConnectionStrings:CF_SQL_Connection %>"
        SelectCommand="SELECT [IDVehicles], RDEV.[IDProfileFleet], [IDEngines], [UnitNo], [ChassisVIN], 
        [ChassisModelYear], [RuleCode], [PlannedComplianceDate], [ActualComplianceDate], [CARBGroup], 
        [RetireStatusDate], [ImageVehicle], [SerialNum], 
        [FamilyName], [SeriesModelNo], [Horsepower], [Hours], [Miles], 
        [EngineManufacturer], [EngineModel], [EngineStatus], [EngineFuelType], [ModelYear], [IDDECS], 
        [SerialNo], [DECSName], [IDDECSManufacturer], [DECSManufacturer], [IDDECSLevel], [DECSLevel], 
        [DECSInstallationDate], [ImageEngine], [ImageDECS], [Displacement], AccountName, TerminalName, 
        FleetName, RDEV.[VehicleStatus], [GrossVehicleWeight], [WeightDefinition], [SpecialProvision]
FROM [CFV_Report_D_to_E_to_V] RDEV
  LEFT JOIN CF_Profile_Fleet F ON RDEV.IDProfileFleet = F.IDProfileFleet
  LEFT JOIN CF_Profile_Terminal T ON F.IDProfileTerminal = T.IDProfileTerminal
  LEFT JOIN CF_Profile_Account A ON T.IDProfileAccount = A.IDProfileAccount 
        WHERE ([IDVehicles] = @IDVehicles)">
    <SelectParameters>
        <asp:QueryStringParameter Name="IDVehicles" QueryStringField="IDVehicles" />
    </SelectParameters>
    <UpdateParameters>
    </UpdateParameters>
    <InsertParameters>
    </InsertParameters>
</asp:SqlDataSource>

    </form>
	</div>
</body>
</html>
