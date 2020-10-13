<%@ Page Language="vb" AutoEventWireup="false" CodeBehind="bluereport_fleet_display.aspx.vb" Inherits="cleanfleets_fms.bluereport_fleet_display2" %>
<%@ Import Namespace="Inspironix" %>
<%@ Import Namespace="Inspironix.DB" %>
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
	
	.hidden {
		display:none;
	}
	
	.header td.label {
		font-weight: bold; 
		color: #2C7500; 
		text-align: right; 
		width: 105px; 
		font-size: small;
	}
	.header td.value {
	}
	
	.information td.label {
		width:135px;
	}
	.information td.value {
		width:auto;
	}
	.information td.whitespace {
		width:auto;
	}

	
	@media print {
		body {
			width:640px;
		}
		.noprint {
			display:none;
		}
		.reportContainer {
			width: auto;
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



<meta name="viewport" content="width=device-width, initial-scale=1.0, user-scalable=no">
</head>
<body>
<!--<div class="reportContainer">-->
    <form id="form1" runat="server">
		
		<div>
			<table id="table9" cellpadding="0" cellspacing="0" style="width: 100%" class="noprint">
				<tr>
					<td style="width: 14px">&nbsp;
						</td>
					<td>
						<asp:Button ID="btn_Print" runat="server" Text="Print Report" />
					</td>
				</tr>
			</table>
			<div class="noprint">
				<asp:FormView ID="FormView1" runat="server" DataSourceID="sds_ReportEnginesDECS" style="width:auto">
					<ItemTemplate>
						<table id="table6" cellpadding="0" cellspacing="0" style="width: 100%"> 
							<tr>
								<td style="font-size: x-large; font-weight: bold; color: #008000; width: 340px;">
									Vehicle Information Report</td>
								<td style="text-align: right">
									<img alt="Test" src="../../images/newCFLogo300W.jpg" 
										class="cfnLogo" /></td>
							</tr>
						</table>
						<table class="header">
							<tr>
								<td rowspan="3" style="text-align: center; width: 20px; ">&nbsp;
									</td>
								<td class="label">
									Account Name:</td>
								<td class="value">
									<asp:Label ID="AccountNameLabel" runat="server" Text='<%# Bind("AccountName") %>' />
								</td>
								
							</tr>
							<tr>
								<td class="label">
									Terminal Name:
								</td>
								<td class="value">
									<asp:Label ID="TerminalNameLabel" runat="server" Text='<%# Bind("TerminalName") %>' />
								</td>
								
							</tr>
							<tr>
								<td class="label">
									Fleet Name:</td>
								<td class="value">
									<asp:Label ID="FleetNameLabel" runat="server" Text='<%# Bind("FleetName") %>' />
								</td>
								
							</tr>
						</table>
						<hr />
					</ItemTemplate>
				</asp:FormView>
			</div>
		</div>
	


<% For i as Integer = 0 to vehicleView.Count - 1 %>
<% Dim vehicleRow = vehicleView(i) %>
	<div class="printonly">
		<table cellpadding="0" cellspacing="0" style="width: 640px">
			<tr>
				<td style="font-size: x-large; font-weight: bold; color: #008000; width: 340px;">
					Vehicle Information Report</td>
				<td style="text-align: right">
					<img alt="Test" src="../../images/newCFLogo300W.jpg" 
						class="cfnLogo" /></td>
			</tr>
		</table>
	
		<div>
			<table class="header">
				<tr>
					<td rowspan="3" style="text-align: center; width: 20px; ">&nbsp;
						</td>
					<td class="label">
						Account Name:</td>
					<td class="value">
						<%= vehicleRow("AccountName") %>
					</td>
					
				</tr>
				<tr>
					<td class="label">
						Terminal Name:
					</td>
					<td class="value">
						<%= vehicleRow("TerminalName") %>
					</td>
					
				</tr>
				<tr>
					<td class="label">
						Fleet Name:</td>
					<td class="value">
						<%= vehicleRow("FleetName") %>
					</td>
					
				</tr>
			</table>
			<hr />
		</div>
	</div> 

<h2>Vehicle Information</h2>
	<table class="information">
		<tr>
			<td rowspan="13" style="text-align: center; width: 205px; " valign="top">
				<img src="<%= Page.ResolveUrl(vehicleRow("ImageVehicle")) + "?height=133" %>" height="133" />
			</td>
			<td class="tabletld label">
				Unit No:</td>
			<td class="value">
				<%= vehicleRow("UnitNo") %>
			</td>
			<td class="whitespace">&nbsp;
				</td>
		</tr>
		<tr>
			<td class="tabletld label">
				VIN:</td>
			<td class="value">
				<%= vehicleRow("ChassisVin") %>
			</td>
			<td class="whitespace">&nbsp;
				</td>
		</tr>
		<tr>
			<td class="tabletld label">
				Vehicle Year:</td>
			<td class="value">
				<%= vehicleRow("ChassisModelYear") %>
			</td>
			<td class="whitespace">&nbsp;
				</td>
		</tr>
		<tr>
			<td class="tabletld label">
				Gross Vehicle Weight:
			</td>
			<td class="value">
				<%= vehicleRow("GrossVehicleWeight") %>
			</td>
			<td class="whitespace">&nbsp;
				</td>
		</tr>
		<% If Not vehicleRow("WeightDefinition") Is Nothing AndAlso Not IsDbNull(vehicleRow("WeightDefinition")) AndAlso Not String.IsNullOrEmpty(vehicleRow("WeightDefinition")) Then %><tr>
			<td class="tabletld label">
				Weight Definition:</td>
			<td class="value">
				<%= vehicleRow("WeightDefinition") %>
			</td>
			<td class="whitespace">&nbsp;
				</td>
		</tr>
		<% End If %>
		<tr>
			<td class="tabletld label">
				Rule Code:</td>
			<td class="value">
				<%= vehicleRow("RuleCode") %>
			</td>
			<td class="whitespace">&nbsp;
				</td>
		</tr>
		<tr>
			<td class="tabletld label">
				Vehicle Group:</td>
			<td class="value">
				<%= vehicleRow("CARBGroup") %>
			</td>
			<td class="whitespace">&nbsp;
				</td>
		</tr>
		<tr>
			<td class="tabletld label">
				Status:</td>
			<td class="value">
				<%= vehicleRow("VehicleStatus") %>
			</td>
			<td class="whitespace">&nbsp;
				</td>
		</tr>
		 <% If Not vehicleRow("SpecialProvision") Is Nothing AndAlso  Not IsDbNull(vehicleRow("SpecialProvision")) AndAlso Not String.IsNullOrEmpty(vehicleRow("SpecialProvision")) Then %><tr>
			<td class="tabletld label">
				Special Provision:</td>
			<td class="value">
				<%= vehicleRow("SpecialProvision") %>
			</td>
			<td class="whitespace">&nbsp;
				</td>
		</tr>
		<% End If %>
		<tr>
			<td>&nbsp;</td>
		</tr>
	</table>   
	

	<hr />
	
	<h2>Engine Information</h2>
	<table class="information">
		<tr>
			<td rowspan="12" style="text-align: center; width: 205px; " valign="top">
			<img src="<%= Page.ResolveUrl(vehicleRow("ImageEngine")) + "?height=133" %>" height="133" />
			</td>
			<td class="tabletld label">
				Manufacturer:</td>
			<td class="value">
				<%= vehicleRow("EngineManufacturer") %>
			</td>
			<td class="whitespace">&nbsp;
				</td>
		</tr>
		<tr>
			<td class="tabletld label">
				Serial No:</td>
			<td class="value">
				<%= vehicleRow("SerialNum") %>
			</td>
			<td class="whitespace">&nbsp;
				</td>
		</tr>
		<tr>
			<td class="tabletld label">
				Family Name:</td>
			<td class="value">
				<%= vehicleRow("FamilyName") %>
			</td>
			<td class="whitespace">&nbsp;
				</td>
		</tr>
		<tr>
			<td class="tabletld label">
				Model Year:</td>
			<td class="value">
				<%= vehicleRow("ModelYear") %>
				<asp:Label ID="ModelYearLabel" runat="server" Text='<%# Eval("ModelYear") %>' />
			</td>
			<td class="whitespace">&nbsp;
				</td>
		</tr>
		<tr>
			<td class="tabletld label">
				Model:</td>
			<td class="value">
				<%= vehicleRow("EngineModel") %>
			</td>
			<td class="whitespace">&nbsp;
				</td>
		</tr>
		<tr>
			<td class="tabletld label">
				Status:</td>
			<td class="value">
				<%= vehicleRow("EngineStatus") %>
			</td>
			<td class="whitespace">&nbsp;
				</td>
		</tr>
		<tr>
			<td class="tabletld label">
				Fuel Type:</td>
			<td class="value">
				<%= vehicleRow("EngineFuelType") %>
			</td>
			<td class="whitespace">&nbsp;
				</td>
		</tr>
	</table>
	<hr />
	<h2>DECS Information</h2>
	<table class="information">
		<tr>
			<td rowspan="7" style="text-align: center; width: 205px; " valign="top">
				<img src="<%= Page.ResolveUrl(vehicleRow("ImageDECS")) + "?height=133" %>" height="133" />
			</td>
			<td class="tabletld label">
				Manufacturer:</td>
			<td class="value">
				<%= vehicleRow("DECSManufacturer") %>
			</td>
			<td class="whitespace">&nbsp;
				</td>
		</tr>
		<tr>
			<td class="tabletld label">
				Serial No:</td>
			<td class="value">
				<%= vehicleRow("SerialNo") %>
			</td>
			<td class="whitespace">&nbsp;
				</td>
		</tr>
		<tr>
			<td class="tabletld label">
				Name:</td>
			<td class="value">
				<%= vehicleRow("DECSName") %>
			</td>
			<td class="whitespace">&nbsp;
				</td>
		</tr>
		<tr>
			<td class="tabletld label">
				Level:</td>
			<td class="value">
				<%= vehicleRow("DECSLevel") %>
			</td>
			<td class="whitespace">&nbsp;
				</td>
		</tr>
		<tr>
			<td class="tabletld label">
				Installation Date:</td>
			<td class="value">
				<%= vehicleRow("DECSInstallationDate") %>
			</td>
			<td class="whitespace">&nbsp;
				</td>
		</tr>
		<tr>
			<td class="tabletld whitespace">&nbsp;
				</td>
			<td class="whitespace">&nbsp;
				</td>
			<td class="whitespace">&nbsp;
				</td>
		</tr>
		<tr>
			<td class="tabletld label whitespace">&nbsp;
				</td>
			<td class="value whitespace">&nbsp;
				</td>
			<td class="whitespace">&nbsp;
				</td>
		</tr>
	</table>
			<hr />
	<div class="printonly">
		<table id="table7" cellpadding="0" cellspacing="0" 
			style="text-align: left;">
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
	</div>
		
	<span class="page-break"></span>
<% Next %>


<% If vehicleView.Count = 0 %>
	<div>
		<div >
			No Vehicles found.
		</div>
	</div>
<% End If %>

<!--</div>-->
    <br />
	<table id="table7" cellpadding="0" cellspacing="0" class="noprint"
		style="width: auto; text-align: left;">
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

    <asp:SqlDataSource ID="sds_ReportEnginesDECS" runat="server" ConnectionString="<%$ ConnectionStrings:CF_SQL_Connection %>"
        SelectCommand="SELECT [IDVehicles], RDEV.[IDProfileFleet], [IDEngines], [UnitNo], [ChassisVIN], [ChassisModelYear], [RuleCode], [PlannedComplianceDate], [ActualComplianceDate], [CARBGroup], [RetireStatusDate], [ImageVehicle], [SerialNum], [FamilyName], [SeriesModelNo], [Horsepower], [Hours], [Miles], [EngineManufacturer], [EngineModel], [EngineStatus], [EngineFuelType], [ModelYear], [IDDECS], [SerialNo], [DECSName], [IDDECSManufacturer], [DECSManufacturer], [IDDECSLevel], [DECSLevel], [DECSInstallationDate], [ImageEngine], [ImageDECS], [Displacement], AccountName, TerminalName, FleetName, RDEV.[VehicleStatus], [GrossVehicleWeight], [WeightDefinition], [SpecialProvision]
		  FROM [CFV_Report_D_to_E_to_V] RDEV
		  LEFT JOIN CF_Profile_Fleet F ON RDEV.IDProfileFleet = F.IDProfileFleet
		  LEFT JOIN CF_Profile_Terminal T ON F.IDProfileTerminal = T.IDProfileTerminal
		  LEFT JOIN CF_Profile_Account A ON T.IDProfileAccount = A.IDProfileAccount
		  WHERE ( (RDEV.[IDProfileFleet] = @IDProfileFleet)
		  OR (A.IDProfileAccount = @IDProfileAccount AND RDEV.IDCARBGroup = @IDCARBGroup))
		  ORDER BY UnitNo">
    <SelectParameters>
        <%--<asp:SessionParameter Name="IDProfileFleet" SessionField="IDProfileFleet" Type="Int32" />--%>
		<asp:QueryStringParameter name="IDProfileFleet" QueryStringField="IDProfileFleet" Type="Int32" DefaultValue="0" />
		<asp:QueryStringParameter name="IDProfileAccount" QueryStringField="IDProfileAccount" Type="Int32" DefaultValue="0" />
		<asp:QueryStringParameter name="IDCARBGroup" QueryStringField="IDCARBGroup" Type="Int32" DefaultValue="0" />
    </SelectParameters>
    <UpdateParameters>
    </UpdateParameters>
    <InsertParameters>
    </InsertParameters>
</asp:SqlDataSource>

    </form>
</body>
</html>
