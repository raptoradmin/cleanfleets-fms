<%@ Page Title="" Language="vb" AutoEventWireup="false" MasterPageFile="~/CF_Console.Master" CodeBehind="bluereport_fleet_display.aspx.vb" Inherits="cleanfleets_fms.bluereport_fleet_display" %>
<asp:Content ID="Content1" ContentPlaceHolderID="head" runat="server">
    <title>Fleet Compliance Management System</title>
    <link rel="stylesheet" type="text/css" href="/includes/styles/cf_style_report.css" />
</asp:Content>
<asp:Content ID="Content2" ContentPlaceHolderID="RightColumnContentPlaceHolder" runat="server">
     <table id="table6" cellpadding="0" cellspacing="0" style="width: 800px">
        <tr>
            <td style="font-size: x-large; font-weight: bold; color: #008000; width: 340px;">
                Vehicle Information Report</td>
            <td style="text-align: right">
                <img alt="Test" src="../../images/300W_vflogogreen.gif" 
                    style="width: 303px; height: 50px" /></td>
        </tr>
    </table>
    <p>
        <asp:FormView ID="FormView1" runat="server" DataSourceID="sds_ReportVehicles" 
            Width="800px">
            <ItemTemplate>
                <h2>
                    Account</h2>
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
                <table ID="table3" cellpadding="0" cellspacing="0" style="width: 100%">
                    <tr>
                        <td style="border-bottom-style: solid; border-width: 1px; border-color: #000000">&nbsp;
                            </td>
                    </tr>
                    <tr>
                        <td>&nbsp;
                            </td>
                    </tr>
                </table>
                <h2>
                    Vehicle Details</h2>
                <table cellpadding="0" cellspacing="0" style="width: 100%">
                    <tr>
                        <td>&nbsp;
                            </td>
                    </tr>
                    <tr>
                        <td>&nbsp;
                            </td>
                    </tr>
                </table>
                <table width="100%">
                    <tr>
                        <td rowspan="7" style="text-align: center; width: 205px; " valign="top">
                            <asp:Image ID="image" runat="server" Height="133" 
                                ImageUrl='<%#Eval("Image") %>' Width="200" />
                        </td>
                        <td style="width: 115px; " class="tabletld">
                            Unit No:</td>
                        <td style="width: 224px">
                            <asp:Label ID="UnitNoLabel" runat="server" Text='<%# Bind("UnitNo") %>' />
                        </td>
                        <td>&nbsp;
                            </td>
                    </tr>
                    <tr>
                        <td style="width: 115px; " class="tabletld">
                            VIN:</td>
                        <td style="width: 224px">
                            <asp:Label ID="ChassisVINLabel" runat="server" Text='<%# Bind("ChassisVIN") %>' />
                        </td>
                        <td>&nbsp;
                            </td>
                    </tr>
                    <tr>
                        <td style="width: 115px; " class="tabletld">
                            Vehicle Year:
                        </td>
                        <td style="width: 224px">
                            <asp:Label ID="ChassisModelYearLabel" runat="server" Text='<%# Bind("ChassisModelYear") %>' />
                        </td>
                        <td>&nbsp;
                            </td>
                    </tr>
                    <tr>
                        <td style="width: 115px; " class="tabletld">
                            RuleCode:
                        </td>
                        <td style="width: 224px; height: 20px;">
                            <asp:Label ID="RuleCodeLabel" runat="server" Text='<%# Bind("RuleCode") %>' />
                        </td>
                        <td>&nbsp;
                            </td>
                    </tr>
                    <tr>
                        <td style="width: 115px; " class="tabletld">
                            Vehicle Group:
                        </td>
                        <td style="width: 224px">
                            <asp:Label ID="CARBGroupLabel" runat="server" Text='<%# Bind("CARBGroup") %>' />
                        </td>
                        <td>&nbsp;
                            </td>
                    </tr>
                    <tr>
                        <td style="width: 115px; " class="tabletld">
                            RetireStatusDate:
                        </td>
                        <td style="width: 224px">
                            <asp:Label ID="RetireStatusDateLabel" runat="server" 
                                Text='<%# Bind("RetireStatusDate") %>' />
                        </td>
                        <td>&nbsp;
                            </td>
                    </tr>
                    <tr>
                        <td style="width: 115px; " class="tabletld">&nbsp;
                            </td>
                        <td style="width: 224px">&nbsp;
                            </td>
                        <td>&nbsp;
                            </td>
                    </tr>
                </table>
                <table ID="table2" cellpadding="0" cellspacing="0" style="width: 100%">
                    <tr>
                        <td style="border-bottom-style: solid; border-width: 1px; border-color: #000000">&nbsp;
                            </td>
                    </tr>
                    <tr>
                        <td>&nbsp;
                            </td>
                    </tr>
                </table>
            </ItemTemplate>
        </asp:FormView>
    </p>
    <table cellpadding="0" cellspacing="0" style="width: 800px">
        <tr>
            <td>
    <telerik:RadListView ID="RadListView1" runat="server" DataSourceID="sds_ReportEnginesDECS" BorderStyle="None" Width="800px">
        <AlternatingItemTemplate>
            
  <h2>
                    Engine Information</h2>
                <table width="100%">
                    <tr>
                        <td rowspan="12" style="text-align: center; width: 205px; " valign="top">
                            <asp:Image ID="image" runat="server" Height="133" 
                                ImageUrl='<%#Eval("ImageEngine") %>' Width="200" />
                        </td>
                        <td style="width: 115px; " class="tabletld">
                            Manufacturer:</td>
                        <td style="250: ;">
                            <asp:Label ID="EngineManufacturerLabel" runat="server" 
                                Text='<%# Eval("EngineManufacturer") %>' />
                        </td>
                        <td>&nbsp;
                            </td>
                    </tr>
                    <tr>
                        <td style="width: 115px; " class="tabletld">
                            Serial No:</td>
                        <td style="250: ;">
                            <asp:Label ID="SerialNumLabel" runat="server" Text='<%# Eval("SerialNum") %>' />
                        </td>
                        <td>&nbsp;
                            </td>
                    </tr>
                    <tr>
                        <td style="width: 115px; " class="tabletld">
                            Family Name:</td>
                        <td style="250: ;">
                            <asp:Label ID="FamilyNameLabel" runat="server" 
                                Text='<%# Eval("FamilyName") %>' />
                        </td>
                        <td>&nbsp;
                            </td>
                    </tr>
                    <tr>
                        <td style="width: 115px; " class="tabletld">
                            Model No:</td>
                        <td style="250: ;">
                            <asp:Label ID="SeriesModelNoLabel" runat="server" 
                                Text='<%# Eval("SeriesModelNo") %>' />
                        </td>
                        <td>&nbsp;
                            </td>
                    </tr>
                    <tr>
                        <td style="width: 115px; " class="tabletld">
                            Model Year:</td>
                        <td style="250: ;">
                            <asp:Label ID="ModelYearLabel" runat="server" Text='<%# Eval("ModelYear") %>' />
                        </td>
                        <td>&nbsp;
                            </td>
                    </tr>
                    <tr>
                        <td style="width: 115px; " class="tabletld">
                            Model:</td>
                        <td style="250: ;">
                            <asp:Label ID="EngineModelLabel" runat="server" 
                                Text='<%# Eval("EngineModel") %>' />
                        </td>
                        <td>&nbsp;
                            </td>
                    </tr>
                    <tr>
                        <td style="width: 115px; " class="tabletld">
                            Status:</td>
                        <td style="250: ;">
                            <asp:Label ID="EngineStatusLabel" runat="server" 
                                Text='<%# Eval("EngineStatus") %>' />
                        </td>
                        <td>&nbsp;
                            </td>
                    </tr>
                    <tr>
                        <td style="width: 115px; " class="tabletld">
                            Fuel Type:</td>
                        <td style="250: ;">
                            <asp:Label ID="EngineFuelTypeLabel" runat="server" 
                                Text='<%# Eval("EngineFuelType") %>' />
                        </td>
                        <td>&nbsp;
                            </td>
                    </tr>
                    <tr>
                        <td style="width: 115px; " class="tabletld">
                            Hourse Power:</td>
                        <td style="250: ;">
                            <asp:Label ID="HorsepowerLabel" runat="server" 
                                Text='<%# Eval("Horsepower") %>' />
                        </td>
                        <td>&nbsp;
                            </td>
                    </tr>
                    <tr>
                        <td style="width: 115px; " class="tabletld">
                            Displacement:</td>
                        <td style="250: ;">
                            <asp:Label ID="DisplacementLabel" runat="server" Text='<%# Eval("Displacement") %>' />
                        </td>
                        <td style="width: 131px">
                            &nbsp;&nbsp;</td>
                    </tr>
                    <tr>
                        <td style="width: 115px; " class="tabletld">
                            Total Hours:</td>
                        <td style="250: ;">
                            <asp:Label ID="HoursLabel" runat="server" Text='<%# Eval("Hours") %>' />
                        </td>
                        <td style="width: 131px">
                            &nbsp;&nbsp;</td>
                    </tr>
                    <tr>
                        <td style="width: 115px; " class="tabletld">
                            Total Miles:</td>
                        <td style="250: ;">
                            <asp:Label ID="MilesLabel" runat="server" Text='<%# Eval("Miles") %>' />
                        </td>
                        <td style="width: 131px; height: 20px;">
                            &nbsp;&nbsp;</td>
                    </tr>
                </table>
                <table cellpadding="0" cellspacing="0" style="width: 100%" ID="table5">
                    <tr>
                        <td style="border-bottom-style: solid; border-width: 1px; border-color: #000000">&nbsp;
                            </td>
                    </tr>
                    <tr>
                        <td>&nbsp;
                            </td>
                    </tr>
                </table>
                <h2>
                    DECS Information</h2>
                <table width="100%">
                    <tr>
                        <td rowspan="7" style="text-align: center; width: 205px; " valign="top">
                            <asp:Image ID="image0" runat="server" Height="133" 
                                ImageUrl='<%#Eval("ImageDECS") %>' Width="200" />
                        </td>
                        <td style="width: 115px; " class="tabletld">
                            Manufacturer:</td>
                        <td style="width: 227px">
                            <asp:Label ID="DECSManufacturerLabel" runat="server" 
                                Text='<%# Eval("DECSManufacturer") %>' />
                        </td>
                        <td>&nbsp;
                            </td>
                    </tr>
                    <tr>
                        <td style="width: 115px; " class="tabletld">
                            Serial No:</td>
                        <td style="width: 227px">
                            <asp:Label ID="SerialNoLabel" runat="server" Text='<%# Eval("SerialNo") %>' />
                        </td>
                        <td>&nbsp;
                            </td>
                    </tr>
                    <tr>
                        <td style="width: 115px; " class="tabletld">
                            Name:</td>
                        <td style="width: 227px">
                            <asp:Label ID="DECSNameLabel" runat="server" Text='<%# Eval("DECSName") %>' />
                        </td>
                        <td>&nbsp;
                            </td>
                    </tr>
                    <tr>
                        <td style="width: 115px;" class="tabletld">
                            Level:</td>
                        <td style="width: 227px">
                            <asp:Label ID="DECSLevelLabel" runat="server" Text='<%# Eval("DECSLevel") %>' />
                        </td>
                        <td>&nbsp;
                            </td>
                    </tr>
                    <tr>
                        <td style="width: 115px;" class="tabletld">
                            Instalation Date:</td>
                        <td style="width: 227px">
                            <asp:Label ID="DECSInstallationDateLabel" runat="server" 
                                Text='<%# Eval("DECSInstallationDate") %>' />
                        </td>
                        <td>&nbsp;
                            </td>
                    </tr>
                    <tr>
                        <td class="tabletld" style="width: 115px;">&nbsp;
                            </td>
                        <td style="width: 227px">&nbsp;
                            </td>
                        <td>&nbsp;
                            </td>
                    </tr>
                    <tr>
                        <td class="tabletld" style="width: 115px;">&nbsp;
                            </td>
                        <td style="width: 227px">&nbsp;
                            </td>
                        <td>&nbsp;
                            </td>
                    </tr>
                </table>
                <table ID="table1" cellpadding="0" cellspacing="0" style="width: 100%">
                    <tr>
                        <td style="border-bottom-style: solid; border-width: 1px; border-color: #000000">&nbsp;
                            </td>
                    </tr>
                    <tr>
                        <td>&nbsp;
                            </td>
                    </tr>
                </table>
           
        </AlternatingItemTemplate>
        <ItemTemplate>

                <h2>
                    Engine Information</h2>
                <table width="100%">
                    <tr>
                        <td rowspan="12" style="text-align: center; width: 205px; " valign="top">
                            <asp:Image ID="image" runat="server" Height="133" 
                                ImageUrl='<%#Eval("ImageEngine") %>' Width="200" />
                        </td>
                        <td style="width: 115px; " class="tabletld">
                            Manufacturer:</td>
                        <td style="250: ;">
                            <asp:Label ID="EngineManufacturerLabel" runat="server" 
                                Text='<%# Eval("EngineManufacturer") %>' />
                        </td>
                        <td>&nbsp;
                            </td>
                    </tr>
                    <tr>
                        <td style="width: 115px; " class="tabletld">
                            Serial No:</td>
                        <td style="250: ;">
                            <asp:Label ID="SerialNumLabel" runat="server" Text='<%# Eval("SerialNum") %>' />
                        </td>
                        <td>&nbsp;
                            </td>
                    </tr>
                    <tr>
                        <td style="width: 115px; " class="tabletld">
                            Family Name:</td>
                        <td style="250: ;">
                            <asp:Label ID="FamilyNameLabel" runat="server" 
                                Text='<%# Eval("FamilyName") %>' />
                        </td>
                        <td>&nbsp;
                            </td>
                    </tr>
                    <tr>
                        <td style="width: 115px; " class="tabletld">
                            Model No:</td>
                        <td style="250: ;">
                            <asp:Label ID="SeriesModelNoLabel" runat="server" 
                                Text='<%# Eval("SeriesModelNo") %>' />
                        </td>
                        <td>&nbsp;
                            </td>
                    </tr>
                    <tr>
                        <td style="width: 115px; " class="tabletld">
                            Model Year:</td>
                        <td style="250: ;">
                            <asp:Label ID="ModelYearLabel" runat="server" Text='<%# Eval("ModelYear") %>' />
                        </td>
                        <td>&nbsp;
                            </td>
                    </tr>
                    <tr>
                        <td style="width: 115px; " class="tabletld">
                            Model:</td>
                        <td style="250: ;">
                            <asp:Label ID="EngineModelLabel" runat="server" 
                                Text='<%# Eval("EngineModel") %>' />
                        </td>
                        <td>&nbsp;
                            </td>
                    </tr>
                    <tr>
                        <td style="width: 115px; " class="tabletld">
                            Status:</td>
                        <td style="250: ;">
                            <asp:Label ID="EngineStatusLabel" runat="server" 
                                Text='<%# Eval("EngineStatus") %>' />
                        </td>
                        <td>&nbsp;
                            </td>
                    </tr>
                    <tr>
                        <td style="width: 115px; " class="tabletld">
                            Fuel Type:</td>
                        <td style="250: ;">
                            <asp:Label ID="EngineFuelTypeLabel" runat="server" 
                                Text='<%# Eval("EngineFuelType") %>' />
                        </td>
                        <td>&nbsp;
                            </td>
                    </tr>
                    <tr>
                        <td style="width: 115px; " class="tabletld">
                            Hourse Power:</td>
                        <td style="250: ;">
                            <asp:Label ID="HorsepowerLabel" runat="server" 
                                Text='<%# Eval("Horsepower") %>' />
                        </td>
                        <td>&nbsp;
                            </td>
                    </tr>
                    <tr>
                        <td style="width: 115px; " class="tabletld">
                            Displacement:</td>
                        <td style="250: ;">
                            <asp:Label ID="DisplacementLabel" runat="server" Text='<%# Eval("Displacement") %>' />
                        </td>
                        <td style="width: 131px">
                            &nbsp;&nbsp;</td>
                    </tr>
                    <tr>
                        <td style="width: 115px; " class="tabletld">
                            Total Hours:</td>
                        <td style="250: ;">
                            <asp:Label ID="HoursLabel" runat="server" Text='<%# Eval("Hours") %>' />
                        </td>
                        <td style="width: 131px">
                            &nbsp;&nbsp;</td>
                    </tr>
                    <tr>
                        <td style="width: 115px; " class="tabletld">
                            Total Miles:</td>
                        <td style="250: ;">
                            <asp:Label ID="MilesLabel" runat="server" Text='<%# Eval("Miles") %>' />
                        </td>
                        <td style="width: 131px; height: 20px;">
                            &nbsp;&nbsp;</td>
                    </tr>
                </table>
                <table cellpadding="0" cellspacing="0" style="width: 100%" ID="table5">
                    <tr>
                        <td style="border-bottom-style: solid; border-width: 1px; border-color: #000000">&nbsp;
                            </td>
                    </tr>
                    <tr>
                        <td>&nbsp;
                            </td>
                    </tr>
                </table>
                <h2>
                    DECS Information</h2>
                <table width="100%">
                    <tr>
                        <td rowspan="7" style="text-align: center; width: 205px; " valign="top">
                            <asp:Image ID="image0" runat="server" Height="133" 
                                ImageUrl='<%#Eval("ImageDECS") %>' Width="200" />
                        </td>
                        <td style="width: 115px; " class="tabletld">
                            Manufacturer:</td>
                        <td style="width: 227px">
                            <asp:Label ID="DECSManufacturerLabel" runat="server" 
                                Text='<%# Eval("DECSManufacturer") %>' />
                        </td>
                        <td>&nbsp;
                            </td>
                    </tr>
                    <tr>
                        <td style="width: 115px; " class="tabletld">
                            Serial No:</td>
                        <td style="width: 227px">
                            <asp:Label ID="SerialNoLabel" runat="server" Text='<%# Eval("SerialNo") %>' />
                        </td>
                        <td>&nbsp;
                            </td>
                    </tr>
                    <tr>
                        <td style="width: 115px; " class="tabletld">
                            Name:</td>
                        <td style="width: 227px">
                            <asp:Label ID="DECSNameLabel" runat="server" Text='<%# Eval("DECSName") %>' />
                        </td>
                        <td>&nbsp;
                            </td>
                    </tr>
                    <tr>
                        <td style="width: 115px;" class="tabletld">
                            Level:</td>
                        <td style="width: 227px">
                            <asp:Label ID="DECSLevelLabel" runat="server" Text='<%# Eval("DECSLevel") %>' />
                        </td>
                        <td>&nbsp;
                            </td>
                    </tr>
                    <tr>
                        <td style="width: 115px;" class="tabletld">
                            Instalation Date:</td>
                        <td style="width: 227px">
                            <asp:Label ID="DECSInstallationDateLabel" runat="server" 
                                Text='<%# Eval("DECSInstallationDate") %>' />
                        </td>
                        <td>&nbsp;
                            </td>
                    </tr>
                    <tr>
                        <td class="tabletld" style="width: 115px;">&nbsp;
                            </td>
                        <td style="width: 227px">&nbsp;
                            </td>
                        <td>&nbsp;
                            </td>
                    </tr>
                    <tr>
                        <td class="tabletld" style="width: 115px;">&nbsp;
                            </td>
                        <td style="width: 227px">&nbsp;
                            </td>
                        <td>&nbsp;
                            </td>
                    </tr>
                </table>
                <table ID="table1" cellpadding="0" cellspacing="0" style="width: 100%">
                    <tr>
                        <td style="border-bottom-style: solid; border-width: 1px; border-color: #000000">&nbsp;
                            </td>
                    </tr>
                    <tr>
                        <td>&nbsp;
                            </td>
                    </tr>
                </table>
<DIV style="page-break-after:always"></DIV>

<table ID="table4" cellpadding="0" cellspacing="0" style="width: 100%">
                    <tr>
                        <td style="border-bottom-style: solid; border-width: 1px; border-color: #000000">&nbsp;
                            </td>
                    </tr>
                    <tr>
                        <td>&nbsp;
                            </td>
                    </tr>
                </table>

        </ItemTemplate>
        <EmptyDataTemplate>
            <div>
                <div >
                    No Engines or DECS are associated with this vehicle.</div>
            </div>
        </EmptyDataTemplate>
        <LayoutTemplate>
            <div >
                <div ID="itemPlaceholder" runat="server">
                </div>
                <div style="display:none">
                    <telerik:RadCalendar ID="rlvSharedCalendar" runat="server" Skin="<%# Container.Skin %>" />
                </div>
                <div style="display:none">
                    <telerik:RadTimeView ID="rlvSharedTimeView" runat="server" Skin="<%# Container.Skin %>" />
                </div>
            </div>
        </LayoutTemplate>
        <SelectedItemTemplate>
        </SelectedItemTemplate>
    </telerik:RadListView>
            </td>
        </tr>
    </table>

    <br />
    <table id="table7" cellpadding="0" cellspacing="0" 
        style="width: 800px; text-align: right;">
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
                Copyright © 2007+ CleanFleets.net LLC. All Rights Res
                </td>
        </tr>
    </table>
    <br />

    <br />

    <telerik:RadScriptManager ID="rsm_CF" Runat="server">
    </telerik:RadScriptManager>

    <asp:SqlDataSource ID="sds_ReportVehicles" runat="server" ConnectionString="<%$ ConnectionStrings:CF_SQL_Connection %>"
        SelectCommand="SELECT [IDVehicles], [IDProfileFleet], [AccountName], [TerminalName], [FleetName], [UnitNo], [ChassisVIN], [ChassisModelYear], [RuleCode], [CARBGroup], [PlannedComplianceDate], [BackupStatusDate], [ActualComplianceDate], [RetireStatusDate], [IDImages], [Image] FROM [CFV_Report_Vehicle_w_Image] WHERE ([IDProfileFleet] = @IDProfileFleet)">
    <SelectParameters>
                    <asp:SessionParameter Name="IDProfileFleet" SessionField="IDProfileFleet" Type="Int32" />
    </SelectParameters>
    <UpdateParameters>
    </UpdateParameters>
    <InsertParameters>
    </InsertParameters>
</asp:SqlDataSource>

    <asp:SqlDataSource ID="sds_ReportEnginesDECS" runat="server" ConnectionString="<%$ ConnectionStrings:CF_SQL_Connection %>"
        SelectCommand="SELECT [IDVehicles], [IDProfileFleet], [IDEngines], [SerialNum], [FamilyName], [SeriesModelNo], [Horsepower], [Hours], [Miles], [EngineManufacturer], [EngineModel], [EngineStatus], [EngineFuelType], [ModelYear], [IDDECS], [SerialNo], [DECSName], [IDDECSManufacturer], [DECSManufacturer], [IDDECSLevel], [DECSLevel], [DECSInstallationDate], [ImageEngine], [ImageDECS], [Displacement] FROM [CFV_Report_D_to_E_to_V] WHERE ([IDProfileFleet] = @IDProfileFleet)">
    <SelectParameters>
        <asp:SessionParameter Name="IDProfileFleet" SessionField="IDProfileFleet" Type="Int32" />
    </SelectParameters>
    <UpdateParameters>
    </UpdateParameters>
    <InsertParameters>
    </InsertParameters>
</asp:SqlDataSource>
</asp:Content>
