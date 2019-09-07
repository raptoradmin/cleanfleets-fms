<%@ Page Title="" Language="vb" AutoEventWireup="false" MasterPageFile="~/CF_Client.Master" CodeBehind="default.aspx.vb" Inherits="cleanfleets_fms._default3" %>

<asp:Content runat="server" ContentPlaceHolderID="head">
	<style type="text/css">
		#form1
		{
			text-align: left;
		}
		.RadGrid .rgHeader, .RadGrid th.rgResizeCol, .rgRow, .rgAltRow {
			text-align:center !important;
		}
		
		.module {
			width: 30%;	
			margin: 10px;
		}
		
		.moduleArea {
			width: 900px;
		}
	</style>
	<script type="text/javascript" src="/includes/javascript/masonry.pkgd.min.js"></script>
	
	<script type="text/javascript">
        $(document).ready(function (e) {
            $(".moduleArea").masonry({
                //columnWidth: 200,
                itemSelector: '.module'
            });
        });
	</script>
	
</asp:Content>
<asp:Content runat="server" ContentPlaceHolderID="RightColumnContentPlaceHolder">


	<table style="width: 900px" class="tablecenter">
		<tr>
			<td style="text-align: center;" colspan="4">
				<table style="margin-right:auto; margin-left:auto;">
					<tr>
						<td>
							<h5>
								Welcome to the Fleet Compliance Management System</h5>
							<p class="greendark">
								<b>Account Administration</b></p>
							<table cellpadding="0" cellspacing="0" style="padding: 5px; width: 100%; font-family: Arial, Helvetica, sans-serif;
								font-size: medium; font-weight: bold; text-align: right; color: #2C7500;">
								<tr>
									<td style="width:50%">
										Account:
									</td>
									<td style="font-family: Arial, Helvetica, sans-serif; font-size: medium; font-weight: normal;
										text-align: left; color: #000000; width: 2px;">&nbsp;
										
									</td>
									<td style="font-family: Arial, Helvetica, sans-serif; font-size: medium; font-weight: normal;
										text-align: left; color: #000000">
										<asp:Label ID="lbl_Account" runat="server" Text="Label"></asp:Label>
									</td>
								</tr>
								<tr>
									<td style="width: 50%">
										Welcome:
									</td>
									<td style="font-family: Arial, Helvetica, sans-serif; font-size: medium; font-weight: normal;
										text-align: left; color: #000000; width: 2px;">&nbsp;
										
									</td>
									<td style="font-family: Arial, Helvetica, sans-serif; font-size: medium; font-weight: normal;
										text-align: left; color: #000000">
										<asp:Label ID="lbl_User" runat="server" Text="Label"></asp:Label>
									</td>
								</tr>
							</table>
							<p>&nbsp;
								
							</p>
						</td>
					</tr>
				</table>
			</td>
		</tr>
		<tr>
			<td colspan="5">

			<table style="margin-right:auto; margin-left:auto">
				<td style="text-align: center; width: 25%;">
					<telerik:radgrid id="RadGrid2" runat="server" datasourceid="sds_Profile_Terminal"
						font-bold="False" font-italic="False" font-overline="False" font-strikeout="False"
						font-underline="False" gridlines="None" horizontalalign="Center" skin="Default"
						width="110px" cssclass="tablecenter">
						<MasterTableView AutoGenerateColumns="False" DataSourceID="sds_Profile_Terminal">
						<RowIndicatorColumn>
						<HeaderStyle Width="20px"></HeaderStyle>
						</RowIndicatorColumn>

						<ExpandCollapseColumn>
						<HeaderStyle Width="20px"></HeaderStyle>
						</ExpandCollapseColumn>
							<Columns>
								<telerik:GridBoundColumn DataField="Column1" DataType="System.Int32" 
									DefaultInsertValue="" HeaderText="Total Terminals" ReadOnly="True" 
									SortExpression="Total Terminals" UniqueName="Terminals">
								</telerik:GridBoundColumn>
							</Columns>
						</MasterTableView>
						<HeaderStyle HorizontalAlign="Center" />
					</telerik:radgrid>
				</td>
				<td style="text-align: center; width: 25%;">
					<telerik:radgrid id="RadGrid3" runat="server" datasourceid="sds_Profile_Fleet" font-bold="False"
						font-italic="False" font-overline="False" font-strikeout="False" font-underline="False"
						gridlines="None" horizontalalign="Center" skin="Default" width="110px" cssclass="tablecenter">
						<MasterTableView AutoGenerateColumns="False" DataSourceID="sds_Profile_Fleet">
						<RowIndicatorColumn>
						<HeaderStyle Width="20px"></HeaderStyle>
						</RowIndicatorColumn>

						<ExpandCollapseColumn>
						<HeaderStyle Width="20px"></HeaderStyle>
						</ExpandCollapseColumn>
							<Columns>
								<telerik:GridBoundColumn DataField="Column1" DataType="System.Int32" 
									DefaultInsertValue="" HeaderText="Total Fleets" ReadOnly="True" 
									SortExpression="Total Fleets" UniqueName="Fleets">
								</telerik:GridBoundColumn>
							</Columns>
						</MasterTableView>
						<HeaderStyle HorizontalAlign="Center" />
					</telerik:radgrid>
				</td>
				<td style="text-align: center; width: 25%;">
					<telerik:radgrid id="RadGrid4" runat="server" datasourceid="sds_Vehicles" font-bold="False"
						font-italic="False" font-overline="False" font-strikeout="False" font-underline="False"
						gridlines="None" horizontalalign="Center" skin="Default" width="110px" cssclass="tablecenter">
						<MasterTableView AutoGenerateColumns="False" DataSourceID="sds_Vehicles">
							<RowIndicatorColumn>
							<HeaderStyle Width="20px"></HeaderStyle>
							</RowIndicatorColumn>

							<ExpandCollapseColumn>
							<HeaderStyle Width="20px"></HeaderStyle>
							</ExpandCollapseColumn>
							<Columns>
								<telerik:GridBoundColumn DataField="Column1" DataType="System.Int32" 
									DefaultInsertValue="" HeaderText="Total Vehicles" ReadOnly="True" 
									SortExpression="Total Vehicles" UniqueName="Vehicles">
								</telerik:GridBoundColumn>
							</Columns>
						</MasterTableView>
						<HeaderStyle HorizontalAlign="Center" />
					</telerik:radgrid>
				</td>
				<td style="width: 25%; text-align: center;">
					<telerik:radgrid id="RadGrid5" runat="server" datasourceid="sds_Users" font-bold="False"
						font-italic="False" font-overline="False" font-strikeout="False" font-underline="False"
						gridlines="None" horizontalalign="Center" skin="Default" width="110px" cssclass="tablecenter">
						<MasterTableView AutoGenerateColumns="False" DataSourceID="sds_Users">
						<RowIndicatorColumn>
						<HeaderStyle Width="20px"></HeaderStyle>
						</RowIndicatorColumn>

						<ExpandCollapseColumn>
						<HeaderStyle Width="20px"></HeaderStyle>
						</ExpandCollapseColumn>
							<Columns>
								<telerik:GridBoundColumn DataField="Column1" DataType="System.Int32" 
									DefaultInsertValue="" HeaderText="Total Users" ReadOnly="True" 
									SortExpression="Total Users" UniqueName="Users">
								</telerik:GridBoundColumn>
							</Columns>
						</MasterTableView>
						<HeaderStyle HorizontalAlign="Center" />
					</telerik:radgrid>
				</td>
			</table>
			</td>
		</tr>
	</table>
		
		<br />
		<p class="greendark"><b>Account Documents and Reports</b></p>
		<div class="moduleArea tablecenter">
			<asp:PlaceHolder ID="CustomModulesPlaceHolder" runat="server"></asp:PlaceHolder>
		</div>
		<!--<tr>
			<td style="width: 150px; text-align: center;">&nbsp;</td>
			<td style="width: 150px; text-align: center;">&nbsp;</td>
			<td style="width: 150px; text-align: center;">&nbsp;</td>
		</tr>
		<tr>
			<td style="text-align: center;" colspan="4">
				<p class="greendark"><b>Account Documents and Reports</b></p>
				<table style="width:100%;">
                    <tr>
                        <td><table width="100%"><tr>
                            <td style="vertical-align:top; width:33%">
										<telerik:radgrid id="rgd_ComplianceCertification" runat="server"  font-bold="False"
											font-italic="False" font-overline="False" font-strikeout="False" font-underline="False"
											gridlines="None" horizontalalign="Center" skin="Default" cssclass="tablecenter">
											<MasterTableView AutoGenerateColumns="False">
												<HeaderStyle Height="32px" HorizontalAlign="Center"/>
												<RowIndicatorColumn>
													<HeaderStyle Width="20px"></HeaderStyle>
												</RowIndicatorColumn>
									
												<ExpandCollapseColumn>
													<HeaderStyle Width="20px"></HeaderStyle>
												</ExpandCollapseColumn>
												<Columns>
													<telerik:GridHyperLinkColumn FooterText="" DataTextFormatString="{0}" DataTextField="Title" 
													  DataNavigateUrlFields="FilePath,FileName" DataNavigateUrlFormatString="{0}/{1}"
													  UniqueName="ComplianceCertification"  HeaderText="Compliance Certification" Target="_blank">
													</telerik:GridHyperLinkColumn>
												</Columns>
											</MasterTableView>
										</telerik:radgrid>

                            </td>
                            <td style="vertical-align:top; width:33%">
									<telerik:radgrid id="rgd_FleetSummary" runat="server" font-bold="False"
										font-italic="False" font-overline="False" font-strikeout="False" font-underline="False"
										gridlines="None" horizontalalign="Center" skin="Default" cssclass="tablecenter">
										<MasterTableView AutoGenerateColumns="False">
											<HeaderStyle Height="32px" HorizontalAlign="Center"/>
											<RowIndicatorColumn>
												<HeaderStyle Width="20px"></HeaderStyle>
											</RowIndicatorColumn>
		
											<ExpandCollapseColumn>
												<HeaderStyle Width="20px"></HeaderStyle>
											</ExpandCollapseColumn>
											<Columns>
												<telerik:GridHyperLinkColumn FooterText="" DataTextFormatString="{0}" DataTextField="Title" 
												  DataNavigateUrlFields="FilePath,FileName" DataNavigateUrlFormatString="{0}/{1}"
												  UniqueName="FleetSummary"  HeaderText="Fleet Summary" Target="_blank">
												</telerik:GridHyperLinkColumn>
											</Columns>
										</MasterTableView>
									</telerik:radgrid>
                            </td>
                            <td style="vertical-align:top; width:33%">
									<telerik:radgrid id="rgd_OpacityTests" runat="server" font-bold="False"
										font-italic="False" font-overline="False" font-strikeout="False" font-underline="False"
										gridlines="None" horizontalalign="Center" skin="Default" cssclass="tablecenter">
										<MasterTableView AutoGenerateColumns="False">
											<HeaderStyle Height="32px" HorizontalAlign="Center"/>
											<RowIndicatorColumn>
												<HeaderStyle Width="20px"></HeaderStyle>
											</RowIndicatorColumn>
		
											<ExpandCollapseColumn>
												<HeaderStyle Width="20px"></HeaderStyle>
											</ExpandCollapseColumn>
											<Columns>
												<telerik:GridHyperLinkColumn FooterText="" DataTextFormatString="{0}" DataTextField="Title" 
												  DataNavigateUrlFields="FilePath,FileName" DataNavigateUrlFormatString="{0}/{1}"
												  UniqueName="OpacityTests" HeaderText="Opacity Tests" Target="_blank">
												</telerik:GridHyperLinkColumn>
											</Columns>
										</MasterTableView>
									</telerik:radgrid>
                            </td>
                        </tr></table></td>
                    </tr>
                    <tr>
                        <td><table><tr>
                            <td style="vertical-align:top; width:25%">
									<telerik:radgrid id="rgd_EngineModelYearReplacementSchedule" runat="server" font-bold="False"
										font-italic="False" font-overline="False" font-strikeout="False" font-underline="False"
										gridlines="None" horizontalalign="Center" skin="Default" cssclass="tablecenter">
										<MasterTableView AutoGenerateColumns="False" >
											<HeaderStyle Height="32px" HorizontalAlign="Center"/>
											<RowIndicatorColumn>
												<HeaderStyle Width="20px"></HeaderStyle>
											</RowIndicatorColumn>
								
											<ExpandCollapseColumn>
												<HeaderStyle Width="20px"></HeaderStyle>
											</ExpandCollapseColumn>
											<Columns>
												<telerik:GridHyperLinkColumn FooterText="" DataTextFormatString="Engine Model Year Replacement Schedule for {0} Vehicles" DataTextField="Title" 
												  DataNavigateUrlFields="URL" DataNavigateUrlFormatString="{0}"
												  UniqueName="EngineModelYearReplacementSchedule"  HeaderText="Engine Model Year Replacement Schedule" Target="_blank">
												</telerik:GridHyperLinkColumn>
											</Columns>
										</MasterTableView>
									</telerik:radgrid>
                            </td>
                            <td style="vertical-align:top; width:25%">
									<telerik:radgrid id="rgd_STBPhaseInOption" runat="server" font-bold="False"
										font-italic="False" font-overline="False" font-strikeout="False" font-underline="False"
										gridlines="None" horizontalalign="Center" skin="Default" cssclass="tablecenter">
										<MasterTableView AutoGenerateColumns="False">
											<HeaderStyle Height="32px" HorizontalAlign="Center"/>
											<RowIndicatorColumn>
												<HeaderStyle Width="20px"></HeaderStyle>
											</RowIndicatorColumn>
								
											<ExpandCollapseColumn>
												<HeaderStyle Width="20px"></HeaderStyle>
											</ExpandCollapseColumn>
											<Columns>
												<telerik:GridHyperLinkColumn FooterText="" DataTextFormatString="STB Phase-In Option Report" DataTextField="URL" 
												  DataNavigateUrlFields="URL" DataNavigateUrlFormatString="{0}"
												  UniqueName="STBPhaseInOption"  HeaderText="STB Phase-In Option" Target="_blank">
												</telerik:GridHyperLinkColumn>
											</Columns>
										</MasterTableView>
									</telerik:radgrid>
                            </td>
                            <td style="vertical-align:top; width:25%">
									<telerik:radgrid id="rgd_LowMileageConstruction" runat="server" font-bold="False"
										font-italic="False" font-overline="False" font-strikeout="False" font-underline="False"
										gridlines="None" horizontalalign="Center" skin="Default" width="220px" cssclass="tablecenter">
										<MasterTableView AutoGenerateColumns="False">
											<HeaderStyle Height="32px" HorizontalAlign="Center"/>
											<RowIndicatorColumn>
												<HeaderStyle Width="20px"></HeaderStyle>
											</RowIndicatorColumn>
								
											<ExpandCollapseColumn>
												<HeaderStyle Width="20px"></HeaderStyle>
											</ExpandCollapseColumn>
											<Columns>
												<telerik:GridHyperLinkColumn FooterText="" DataTextFormatString="Low Mileage Construction Report" DataTextField="URL" 
												  DataNavigateUrlFields="URL" DataNavigateUrlFormatString="{0}"
												  UniqueName="LowMileageConstruction"  HeaderText="Low Mileage Construction" Target="_blank">
												</telerik:GridHyperLinkColumn>
											</Columns>
										</MasterTableView>
									</telerik:radgrid>
                            </td>
                            <td style="vertical-align:top; width:25%">
									<telerik:radgrid id="rgd_NOxExempt" runat="server" font-bold="False"
										font-italic="False" font-overline="False" font-strikeout="False" font-underline="False"
										gridlines="None" horizontalalign="Center" skin="Default" cssclass="tablecenter">
										<MasterTableView AutoGenerateColumns="False">
											<HeaderStyle Height="32px" HorizontalAlign="Center"/>
											<RowIndicatorColumn>
												<HeaderStyle Width="20px"></HeaderStyle>
											</RowIndicatorColumn>
											<ExpandCollapseColumn>
												<HeaderStyle Width="20px"></HeaderStyle>
											</ExpandCollapseColumn>
											<Columns>
												<telerik:GridHyperLinkColumn FooterText="" DataTextFormatString="NOx Exempt Report for <br />{0} Vehicles" DataTextField="Title" 
												  DataNavigateUrlFields="URL" DataNavigateUrlFormatString="{0}"
												  UniqueName="NOxExempt"  HeaderText="NOx Exempt" Target="_blank">
												</telerik:GridHyperLinkColumn>
											</Columns>
										</MasterTableView>
									</telerik:radgrid>
                            </td>
                        </tr>
						</table></td>
                    </tr>
				</table>
			</td>
		</tr>
        <tr>
			<td>

			</td><td style="text-align: center;" colspan="4">
				<p class="greendark"><b>Terminal Documents</b></p>
                <table width="100%">
                	<tr>
                    	<td style="vertical-align:top; width:33%">
                        	<telerik:radgrid id="rgd_TerminalComplianceCertification" runat="server" datasourceid="sds_TerminalComplianceCertification" font-bold="False" font-italic="False" font-overline="False" font-strikeout="False" font-underline="False" gridlines="None" horizontalalign="Center" skin="Default" cssclass="tablecenter">
                            	<MasterTableView AutoGenerateColumns="False" DataSourceID="sds_TerminalComplianceCertification">
                                	<HeaderStyle Height="32px" HorizontalAlign="Center"/>
                                    <RowIndicatorColumn><HeaderStyle Width="20px"></HeaderStyle></RowIndicatorColumn>
    								<ExpandCollapseColumn><HeaderStyle Width="20px"></HeaderStyle></ExpandCollapseColumn>
                                    <Columns>
                                        <telerik:GridHyperLinkColumn FooterText="" DataTextFormatString="{0}" DataTextField="TitleTerminalName" DataNavigateUrlFields="FilePath,FileName" DataNavigateUrlFormatString="{0}/{1}" UniqueName="TerminalComplianceCertification" HeaderText="Compliance Certification" Target="_blank"></telerik:GridHyperLinkColumn>
                                    </Columns>
                                </MasterTableView>
                         	</telerik:radgrid>
                        </td>
                        <td style="vertical-align:top; width:33%">
                            <telerik:radgrid id="rgd_TerminalFleetSummary" runat="server" datasourceid="sds_TerminalFleetSummary" font-bold="False"
                                font-italic="False" font-overline="False" font-strikeout="False" font-underline="False"
                                gridlines="None" horizontalalign="Center" skin="Default" cssclass="tablecenter">
                                <MasterTableView AutoGenerateColumns="False" DataSourceID="sds_TerminalFleetSummary">
                                    <HeaderStyle Height="32px" HorizontalAlign="Center"/>
                                    <RowIndicatorColumn><HeaderStyle Width="20px"></HeaderStyle></RowIndicatorColumn>
                                    <ExpandCollapseColumn><HeaderStyle Width="20px"></HeaderStyle></ExpandCollapseColumn>
                                    <Columns>
                                        <telerik:GridHyperLinkColumn FooterText="" DataTextFormatString="{0}" DataTextField="TitleTerminalName" 
                                          DataNavigateUrlFields="FilePath,FileName" DataNavigateUrlFormatString="{0}/{1}"
                                          UniqueName="TerminalFleetSummary" HeaderText="Fleet Summary" Target="_blank">
                                        </telerik:GridHyperLinkColumn>
                                    </Columns>
                                </MasterTableView>
                            </telerik:radgrid>
                        </td>
                        <td style="vertical-align:top; width:33%">
                            <telerik:radgrid id="rgd_TerminalOpacityTests" runat="server" datasourceid="sds_TerminalOpacityTests" font-bold="False"
                                font-italic="False" font-overline="False" font-strikeout="False" font-underline="False"
                                gridlines="None" horizontalalign="Center" skin="Default" cssclass="tablecenter">
                                <MasterTableView AutoGenerateColumns="False" DataSourceID="sds_TerminalOpacityTests">
                                    <HeaderStyle Height="32px" HorizontalAlign="Center"/>
                                    <RowIndicatorColumn><HeaderStyle Width="20px"></HeaderStyle></RowIndicatorColumn>
									<ExpandCollapseColumn><HeaderStyle Width="20px"></HeaderStyle></ExpandCollapseColumn>
                                    <Columns>
                                        <telerik:GridHyperLinkColumn FooterText="" DataTextFormatString="{0}" DataTextField="TitleTerminalName" 
                                          DataNavigateUrlFields="FilePath,FileName" DataNavigateUrlFormatString="{0}/{1}"
                                          UniqueName="TerminalOpacityTests" HeaderText="Opacity Tests" Target="_blank">
                                        </telerik:GridHyperLinkColumn>
                                    </Columns>
                                </MasterTableView>
                            </telerik:radgrid>
                        </td>
                    </tr>
               </table>
            </td>
        </tr>
	</table>-->
	
    
    <!-- Terminals Count (sds_Profile_Terminal) -->
	<asp:SqlDataSource ID="sds_Profile_Terminal" runat="server" ConnectionString="<%$ ConnectionStrings:CF_SQL_Connection %>"
	  SelectCommand="
        SELECT COUNT(*) 
        FROM [CFV_Profile_Terminal] 
        WHERE [IDProfileAccount] = @IDProfileAccount">
		<SelectParameters>
			<asp:SessionParameter Name="IDProfileAccount" SessionField="IDProfileAccount" />
		</SelectParameters>
	</asp:SqlDataSource>
    
    <!-- Fleets Count (sds_Profile_Fleet) -->
	<asp:SqlDataSource ID="sds_Profile_Fleet" runat="server" ConnectionString="<%$ ConnectionStrings:CF_SQL_Connection %>"
	  SelectCommand="
        SELECT COUNT(*) 
        FROM [CFV_Profile_Fleet] 
        WHERE [IDProfileAccount] = @IDProfileAccount">
		<SelectParameters>
			<asp:SessionParameter Name="IDProfileAccount" SessionField="IDProfileAccount" />
		</SelectParameters>
	</asp:SqlDataSource>
    
    <!-- Vehicles Count (sds_Profile_Vehicles) -->
	<asp:SqlDataSource ID="sds_Vehicles" runat="server" ConnectionString="<%$ ConnectionStrings:CF_SQL_Connection %>"
	  SelectCommand="
      	SELECT COUNT(*) 
        FROM [CFV_Vehicles] 
        WHERE [IDProfileAccount] = @IDProfileAccount">
		<SelectParameters>
			<asp:SessionParameter Name="IDProfileAccount" SessionField="IDProfileAccount" />
		</SelectParameters>
	</asp:SqlDataSource>
    
    <!-- Users Count (sds_Profile_Terminal) -->
	<asp:SqlDataSource ID="sds_Users" runat="server" ConnectionString="<%$ ConnectionStrings:CF_SQL_Connection %>"
	  SelectCommand="
      	SELECT COUNT(*) 
        FROM [CFV_Profile_Contact] 
        WHERE [IDProfileAccount] = @IDProfileAccount">
		<SelectParameters>
			<asp:SessionParameter Name="IDProfileAccount" SessionField="IDProfileAccount" />
		</SelectParameters>
	</asp:SqlDataSource>
    
    <!-- Compliance Certification Files (sds_ComplianceCertification) -->
<!--	<asp:SqlDataSource ID="sds_ComplianceCertification" runat="server" ConnectionString="<%$ ConnectionStrings:CF_SQL_Connection %>"
	  SelectCommand="
      	SELECT * FROM [CFV_Files_Account_Public]
        WHERE [IDProfileAccount] = @IDProfileAccount 
		AND UPPER(RTRIM(ISNULL(DocumentTypeRecordValue,''))) = 'COMPLIANCECERTIFICATE' ">
		<SelectParameters>
			<asp:SessionParameter Name="IDProfileAccount" SessionField="IDProfileAccount" />
		</SelectParameters>
	</asp:SqlDataSource>-->
    
    <!-- Fleet Summary Files (sds_FleetSummary) -->
	<!--<asp:SqlDataSource ID="sds_FleetSummary" runat="server" ConnectionString="<%$ ConnectionStrings:CF_SQL_Connection %>"
	  SelectCommand="
        SELECT * FROM [CFV_Files_Account_Public] 
        WHERE [IDProfileAccount] = @IDProfileAccount 
		AND UPPER(RTRIM(ISNULL(DocumentTypeRecordValue,''))) = 'FLEETSUMMARY' ">
		<SelectParameters>
			<asp:SessionParameter Name="IDProfileAccount" SessionField="IDProfileAccount" />
		</SelectParameters>
	</asp:SqlDataSource>-->
    
    <!-- Opacity Test Files (sds_OpacityTests) -->
   <!-- <asp:SqlDataSource ID="sds_OpacityTests" runat="server" ConnectionString="<%$ ConnectionStrings:CF_SQL_Connection %>"
	  SelectCommand="
      	SELECT * FROM [CFV_Files_Account_Public] 
        WHERE [IDProfileAccount] = @IDProfileAccount 
		AND UPPER(RTRIM(ISNULL(DocumentTypeRecordValue,''))) = 'OPACITYTESTS' ">
		<SelectParameters>
			<asp:SessionParameter Name="IDProfileAccount" SessionField="IDProfileAccount" />
		</SelectParameters>
	</asp:SqlDataSource>-->
    
    <!-- Engine Model Year Replacement Schedule Files (sds_EngineModelYearReplacementSchedule) -->
	<!--<asp:SqlDataSource ID="sds_EngineModelYearReplacementSchedule" runat="server" ConnectionString="<%$ ConnectionStrings:CF_SQL_Connection %>"
	  SelectCommand="
      	SELECT '~/includes/reports_console/08_Engine_Model_Year_Replacement_Schedule.aspx?Export=true&Worksheet=All&IDProfileAccount=' + LTRIM(STR(@IDProfileAccount)) + '&IDEngineReplacementScheduleClass=' + LTRIM(STR(IDOptionList)) AS URL, 
          DisplayValue AS Title 
        FROM CF_Option_List 
        WHERE UPPER(RTRIM(ISNULL(OptionName,''))) = UPPER('EngineReplacementScheduleClass') 
        ORDER BY DisplayValue">
		<SelectParameters>
			<asp:SessionParameter Name="IDProfileAccount" SessionField="IDProfileAccount" />
		</SelectParameters>
	</asp:SqlDataSource>-->
    
    <!-- STB Phase-In Option Files (sds_STBPhaseInOption) -->
<!--	<asp:SqlDataSource ID="sds_STBPhaseInOption" runat="server" ConnectionString="<%$ ConnectionStrings:CF_SQL_Connection %>"
	  SelectCommand="
      	SELECT '~/includes/reports_console/07_fleet_calculation_export.aspx?Export=true&Worksheet=STBPhase-InFleetPlan&IDProfileAccount=' + LTRIM(STR(@IDProfileAccount)) + '&IDProfileContact=' + LTRIM(STR(@IDProfileContact)) AS URL">
		<SelectParameters>
			<asp:SessionParameter Name="IDProfileAccount" SessionField="IDProfileAccount" />
			<asp:SessionParameter Name="IDProfileContact" SessionField="IDProfileContact" />
		</SelectParameters>
	</asp:SqlDataSource>-->
    
    <!-- Low Mileage Construction Files (sds_LowMileageConstruction) -->
<!--	<asp:SqlDataSource ID="sds_LowMileageConstruction" runat="server" ConnectionString="<%$ ConnectionStrings:CF_SQL_Connection %>"
	  SelectCommand="
      	SELECT '~/includes/reports_console/07_fleet_calculation_export.aspx?Export=true&Worksheet=LowMileageConst&IDProfileAccount=' + LTRIM(STR(@IDProfileAccount)) + '&IDProfileContact=' + LTRIM(STR(@IDProfileContact)) AS URL">
		<SelectParameters>
			<asp:SessionParameter Name="IDProfileAccount" SessionField="IDProfileAccount" />
			<asp:SessionParameter Name="IDProfileContact" SessionField="IDProfileContact" />
		</SelectParameters>
	</asp:SqlDataSource>-->
    
    <!-- NOx Exempt Files (sds_NOxExempt) -->
<!--	<asp:SqlDataSource ID="sds_NOxExempt" runat="server" ConnectionString="<%$ ConnectionStrings:CF_SQL_Connection %>"
	  SelectCommand="
      	SELECT '~/includes/reports_console/07_fleet_calculation_export.aspx?Export=true&Worksheet=NOxExempt&IDProfileAccount=' + LTRIM(STR(@IDProfileAccount)) + '&IDProfileContact=' + LTRIM(STR(@IDProfileContact)) + '&IDEngineReplacementScheduleClass=' + LTRIM(STR(IDOptionList)) AS URL, 
          DisplayValue AS Title 
        FROM CF_Option_List 
        WHERE UPPER(RTRIM(ISNULL(OptionName,''))) = UPPER('EngineReplacementScheduleClass') 
        ORDER BY DisplayValue">
		<SelectParameters>
			<asp:SessionParameter Name="IDProfileAccount" SessionField="IDProfileAccount" />
			<asp:SessionParameter Name="IDProfileContact" SessionField="IDProfileContact" />
		</SelectParameters>
	</asp:SqlDataSource>-->
    
    <!-- Terminal Compliance Certification Files (sds_TerminalComplianceCertification) -->
<!--	<asp:SqlDataSource ID="sds_TerminalComplianceCertification" runat="server" ConnectionString="<%$ ConnectionStrings:CF_SQL_Connection %>"
	  SelectCommand="
      	SELECT F.*, T.TerminalName, O.DisplayValue AS DocumentType, T.TerminalName + ' - ' + F.Title AS TitleTerminalName
        FROM CF_Files F
        LEFT JOIN CF_Profile_Terminal T ON F.IDProfileTerminal = T.IDProfileTerminal
        LEFT JOIN CF_Option_List O ON F.IDDocumentType = O.IDOptionList
        LEFT JOIN CF_Profile_Contact C ON C.IDProfileAccount = F.IDProfileAccount
		LEFT JOIN CF_UserTerminals P ON P.UserId = C.UserID AND P.IDProfileTerminal = T.IDProfileTerminal
        WHERE F.[IDProfileAccount] = @IDProfileAccount
        AND C.IDProfileContact = @IDProfileContact
        AND F.IDProfileTerminal IS NOT NULL
        AND RTRIM(ISNULL(O.OptionName, 'DocumentType')) = 'DocumentType' 
		AND UPPER(RTRIM(ISNULL(O.RecordValue,''))) = 'COMPLIANCECERTIFICATE' 
        AND P.PermissionLevel LIKE '[AB]'">
		<SelectParameters>
			<asp:SessionParameter Name="IDProfileAccount" SessionField="IDProfileAccount" />
            <asp:SessionParameter Name="IDProfileContact" SessionField="IDProfileContact" />
		</SelectParameters>
	</asp:SqlDataSource>-->
    
    <!-- Terminal Fleet Summary Files (sds_TerminalFleetSummary) -->
<!--	<asp:SqlDataSource ID="sds_TerminalFleetSummary" runat="server" ConnectionString="<%$ ConnectionStrings:CF_SQL_Connection %>"
	  SelectCommand="
      	SELECT F.*, T.TerminalName, O.DisplayValue AS DocumentType, T.TerminalName + ' - ' + F.Title AS TitleTerminalName
        FROM CF_Files F
        LEFT JOIN CF_Profile_Terminal T ON F.IDProfileTerminal = T.IDProfileTerminal
        LEFT JOIN CF_Option_List O ON F.IDDocumentType = O.IDOptionList
        LEFT JOIN CF_Profile_Contact C ON C.IDProfileAccount = F.IDProfileAccount
		LEFT JOIN CF_UserTerminals P ON P.UserId = C.UserID AND P.IDProfileTerminal = T.IDProfileTerminal
        WHERE F.[IDProfileAccount] = @IDProfileAccount
        AND C.IDProfileContact = @IDProfileContact
        AND F.IDProfileTerminal IS NOT NULL
        AND RTRIM(ISNULL(O.OptionName, 'DocumentType')) = 'DocumentType' 
		AND UPPER(RTRIM(ISNULL(O.RecordValue,''))) = 'FLEETSUMMARY' 
        AND P.PermissionLevel LIKE '[AB]'">
		<SelectParameters>
			<asp:SessionParameter Name="IDProfileAccount" SessionField="IDProfileAccount" />
            <asp:SessionParameter Name="IDProfileContact" SessionField="IDProfileContact" />
		</SelectParameters>
	</asp:SqlDataSource>-->
    
    <!-- Terminal Opacity Test Files (sds_TerminalOpacityTests) -->
    <!--<asp:SqlDataSource ID="sds_TerminalOpacityTests" runat="server" ConnectionString="<%$ ConnectionStrings:CF_SQL_Connection %>"
	  SelectCommand="
      	SELECT F.*, T.TerminalName, O.DisplayValue AS DocumentType, T.TerminalName + ' - ' + F.Title AS TitleTerminalName
        FROM CF_Files F
        LEFT JOIN CF_Profile_Terminal T ON F.IDProfileTerminal = T.IDProfileTerminal
        LEFT JOIN CF_Option_List O ON F.IDDocumentType = O.IDOptionList
        LEFT JOIN CF_Profile_Contact C ON C.IDProfileAccount = F.IDProfileAccount
		LEFT JOIN CF_UserTerminals P ON P.UserId = C.UserID AND P.IDProfileTerminal = T.IDProfileTerminal
        WHERE F.[IDProfileAccount] = @IDProfileAccount
        AND C.IDProfileContact = @IDProfileContact
        AND F.IDProfileTerminal IS NOT NULL
        AND RTRIM(ISNULL(O.OptionName, 'DocumentType')) = 'DocumentType' 
		AND UPPER(RTRIM(ISNULL(O.RecordValue,''))) = 'OPACITYTESTS' 
        AND P.PermissionLevel LIKE '[AB]'">
		<SelectParameters>
			<asp:SessionParameter Name="IDProfileAccount" SessionField="IDProfileAccount" />
            <asp:SessionParameter Name="IDProfileContact" SessionField="IDProfileContact" />
		</SelectParameters>
	</asp:SqlDataSource>-->
</asp:Content>
