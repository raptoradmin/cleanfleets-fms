<%@ Page Language="vb" AutoEventWireup="false" CodeBehind="report_account_locations.aspx.vb" Inherits="cleanfleets_fms.report_account_locations" %>

<!DOCTYPE html>

<html xmlns="http://www.w3.org/1999/xhtml">
<head id="Head1" runat="server">
    <title></title>
    <link rel="stylesheet" type="text/css" href="/includes/styles/cf_style.css"/>
</head>


<body>
<form runat="server" id="mainForm" method="post">
   
        
<table id="tablePageBodyContainer" class="tablePageBodyContainer">
	<tr>
		<td>
		<table id="tablePageHeader" class="tablePageHeader">
			<tr>
				<td class="tablePageHeaderColumn">
					<div class="divPageHeader">
						<span style="font-size: small">Welcome:</span>
						<asp:LoginName ID="LoginName" runat="server" CssClass="controlLoginName" />
                        <br />
                        <asp:LoginStatus ID="LoginStatus" runat="server" 
                            class="controlLoginStatus" onMouseOver="this.style.color='Black' " 
                            onMouseOut="this.style.color='White' " CssClass="controlLoginStatus" 
                            ForeColor="White"/>
					</div>
				</td>
			</tr>
			</table>
			</td>
			</tr>
			</table>
		
    <table id="tablePageBody" class="tablePageBody">
        <tr>
            <td class="tablePageBodyLeftColumn">
                <telerik:RadPanelBar ID="RadPanelBar1" Runat="server" DataFieldID="DataFieldID" 
                    DataFieldParentID="DataFieldParentID" 
                    DataNavigateUrlField="DataNavigateUrlField" DataSourceID="sds_CF_Menu_Console" 
                    DataTextField="DataTextField" DataValueField="DataTextField" Height="400px" 
                    Skin="Forest" Width="180px" ExpandMode="FullExpandedItem" 
                    PersistStateInCookie="True">
                </telerik:RadPanelBar>
            </td>
            
            
            
            
            
            
            
            
            <td class="tablePageBodyRightColumn">
                <h1>Account Vehicle Report by Fleet</h1>
                <p>&nbsp;</p>
                <telerik:RadComboBox ID="RadComboBox1" Runat="server" 
                    DataSourceID="sds_accounts" DataTextField="AccountName" 
                    DataValueField="IDProfileAccount" AutoPostBack="True">
                </telerik:RadComboBox>
                <p>&nbsp;</p>
                <telerik:RadGrid ID="RadGrid1" runat="server" AllowSorting="True" 
                    DataSourceID="sds_Locations" GridLines="None">
<MasterTableView DataSourceID="sds_Locations" CommandItemDisplay="Top">
<CommandItemSettings ShowExportToCsvButton="True" />

   <GroupByExpressions>
     <telerik:GridGroupByExpression>
       <SelectFields>
         <telerik:GridGroupByField
           FieldAlias="IDProfileTerminal"
           FieldName="IDProfileTerminal" HeaderText=" " HeaderValueSeparator="&#149; " />
       </SelectFields>
       <GroupByFields>
         <telerik:GridGroupByField
           FieldAlias="IDProfileTerminal"
           FieldName="IDProfileTerminal" />
       </GroupByFields>
     </telerik:GridGroupByExpression>
   </GroupByExpressions>

<RowIndicatorColumn>
<HeaderStyle Width="20px"></HeaderStyle>
</RowIndicatorColumn>

<ExpandCollapseColumn>
<HeaderStyle Width="20px"></HeaderStyle>
</ExpandCollapseColumn>
</MasterTableView>
                </telerik:RadGrid>
                <p>&nbsp;</p>
                <p>&nbsp;</p>
                <p>&nbsp;</p>
                <br />
                
                

            </td>
       </table>
    



    
    
    <asp:SqlDataSource ID="sds_CF_Menu_Console" runat="server" 
        ConnectionString="<%$ ConnectionStrings:CF_SQL_Connection %>" 
        SelectCommand="SELECT [DataFieldID], [DataFieldParentID], [DataTextField], [DataNavigateUrlField], [ImageURL] FROM [CF_Menu_Console]">
    </asp:SqlDataSource>
    
    <telerik:RadFormDecorator ID="rfd_CleanFleets" Runat="server" Skin="Forest" />
    <telerik:RadScriptManager ID="rsm_CleanFleets" Runat="server"></telerik:RadScriptManager>
    

    
    <asp:SqlDataSource ID="sds_accounts" runat="server" 
    ConnectionString="<%$ ConnectionStrings:CF_SQL_Connection %>" 
    SelectCommand="SELECT [IDProfileAccount], [AccountName] FROM [CF_Profile_Account] ORDER BY [AccountName]">
</asp:SqlDataSource>
    

    
    <asp:SqlDataSource ID="sds_Locations" runat="server" 
    ConnectionString="<%$ ConnectionStrings:CF_SQL_Connection %>" 
    SelectCommand="SELECT [IDProfileTerminal], [TerminalName], [TerminalStreet], [TerminalCity], [TerminalState], [TerminalCounty], [TerminalZip], [TerminalTelephone1], [IDProfileFleet], [FleetName], [FleetStreet], [FleetCity], [FleetSate], [FleetCounty], [FleetZip], [FleetTelephone1] FROM [CFV_Report_Account_Locations] WHERE ([IDProfileAccount] = @IDProfileAccount)">
        <SelectParameters>
            <asp:ControlParameter ControlID="RadComboBox1" DefaultValue="IDProfileAccount" 
                Name="IDProfileAccount" PropertyName="SelectedValue" Type="Int32" />
        </SelectParameters>
</asp:SqlDataSource>
<br />
    

    
    </form>
</body>
</html>
