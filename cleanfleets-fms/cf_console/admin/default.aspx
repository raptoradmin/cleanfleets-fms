<%@ Page Title="" Language="vb" AutoEventWireup="false" MasterPageFile="~/CF_Console.Master" CodeBehind="default.aspx.vb" Inherits="cleanfleets_fms._default5" %>
<%@ Register assembly="Telerik.Web.UI, Version=2009.3.1208.35, Culture=neutral, PublicKeyToken=121fae78165ba3d4" namespace="Telerik.Web.UI" tagprefix="telerik" %>

<!DOCTYPE html PUBLIC "-//W3C//DTD XHTML 1.0 Transitional//EN" "http://www.w3.org/TR/xhtml1/DTD/xhtml1-transitional.dtd">

<html xmlns="http://www.w3.org/1999/xhtml">
<head runat="server">
    <title>Fleet Compliance Management System</title>
    <link href="../../includes/styles/cf_style.css" rel="stylesheet" type="text/css" />

    <style type="text/css">
        #form1
        {
            text-align: left;
        }
    </style>

</head>
<body>
<form id="form1" runat="server">
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
                <br />
                <br />
                <asp:DropDownList ID="DropDownList1" runat="server" DataSourceID="sds_Option_List" DataTextField="OptionName" DataValueField="OptionName">
                </asp:DropDownList>
            </td>
       </table>         
				</td>
			</tr>
</table>
    
        
    <table class="tablePageFooter">
        <tr>
            <td>
                <!--#include virtual ="/includes/footer.htm" --></td>
        </tr>
    </table>
            <asp:SqlDataSource ID="sds_Option_List" runat="server" ConnectionString="<%$ ConnectionStrings:CF_SQL_Connection %>"
            SelectCommand="SELECT DISTINCT [OptionName] FROM [CF_Option_List] ORDER BY [DisplayValue]">
            </asp:SqlDataSource>
<br />
<br />
            <asp:SqlDataSource ID="sds_CF_Menu_Console" runat="server" 
        ConnectionString="<%$ ConnectionStrings:CF_SQL_Connection %>" 
        SelectCommand="SELECT [DataFieldID], [DataFieldParentID], [DataTextField], [DataNavigateUrlField], [ImageURL] FROM [CF_Menu_Console]">
    </asp:SqlDataSource>

    <telerik:RadScriptManager ID="RadScriptManager1" Runat="server">
    </telerik:RadScriptManager>
    </form>
</body>
</html>

