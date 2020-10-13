<%@ Page Title="" Language="vb" AutoEventWireup="false" MasterPageFile="~/CF_Console.Master" CodeBehind="report_opacity_testing_results.aspx.vb" Inherits="cleanfleets_fms.report_opacity_testing_results" %>
<asp:Content ID="Content1" ContentPlaceHolderID="head" runat="server">
</asp:Content>
<asp:Content ID="Content2" ContentPlaceHolderID="RightColumnContentPlaceHolder" Runat="Server">

    <%--Adding this TextBox control to see if the content I added to SelectedIndexChanged is grabbing all the records; Andrew - 12/17/2019.--%>

    <%-- <asp:TextBox ID="RecordsButton" runat="server" Text="Temp_Text_sam" /> --%>

    <%--End of what was added by Andrew.--%>
    <style>
        .highlight {
            color: red;
            font-weight: bold;
        }
    </style>
	<h1>PSIP Report to Client</h1>
	<p>&nbsp;
		
	</p>
    <table>
    <tr>
    <td>
	    <div>
		    <p>Include most recent Test Results collected within the specified date range. <br />
                Leave Through Date blank to include the most recent Test Results.</p>
		    <asp:Label id="Label4" runat="server" AssociatedControlId="FromDate" >From Date:</asp:Label>
		    <asp:TextBox id="FromDate" runat="server" CssClass="datepicker" />
		    <asp:Label id="Label5" runat="server" AssociatedControlId="FromDate" >Through Date:</asp:Label>
		    <asp:TextBox  id="ThroughDate" runat="server" CssClass="datepicker" />

		    <br />		
            <br />

            <div style="width:75px;display:inline-block">
		    <asp:Label ID="Label1" runat="server" AssociatedControlID="ddl_Account">Account:</asp:Label></div>
		    <asp:DropDownList ID="ddl_Account" runat="server" Width="186px" DataSourceID="sds_ddl_Account"
			    DataTextField="AccountName" DataValueField="IDProfileAccount" AppendDataBoundItems="true"
			    AutoPostBack="true" OnSelectedIndexChanged="ddl_Account_SelectedIndexChanged">
			    <Items>
				    <asp:ListItem Text="- Select an Account-" Value="0" />

                    <%--Added by Andrew on 11/12/2019 for the purpose of letting the user select all PSIP records.--%>

                    <asp:ListItem Text="Select All Vehicles" Value="1000000000" />

                    <%--End of what was added by Andrew on 11/12/2019--%>

			    </Items>
		    </asp:DropDownList>
		    <asp:CustomValidator runat="server" ID="cv_ddl_Account" ControlToValidate="ddl_Account"
			    OnServerValidate="cf_ddl_Validate" ErrorMessage="Please select a valid account" ValidateEmpty="true" />
		    <br />
            <div style="width:75px;display:inline-block">
		    <asp:Label ID="Label2" runat="server" AssociatedControlID="ddl_Terminal">Terminal:</asp:Label></div>
		    <asp:DropDownList ID="ddl_Terminal" runat="server" Width="186px" AutoPostBack="true"
			    OnSelectedIndexChanged="ddl_Terminal_SelectedIndexChanged" />
                <br />
		    <div style="width:75px;display:inline-block">        
		    <asp:Label ID="Label3" runat="server" AssociatedControlID="ddl_Fleet">Fleet:</asp:Label></div>
		    <asp:DropDownList ID="ddl_Fleet" runat="server" Width="186px" AutoPostBack="true" />
		    <br />

		    <table>
			    <tbody>
				    <tr>
					    <td colspan="2" align="left"><br/>
						    <asp:Label ID="Messages" CssClass="highlight" runat="server" />
					    </td>
				    </tr>
			    </tbody>
		    </table>
	    </div>
	    <br />
	    <br />
    </td>
    <td>
         <%-- Custom PSIP Reporting experimentation - Sam 1/24 
        List of checked columns  
        Location	Unit No.	VIN	License Plate	Vehicle Make	
        Engine Manufacturer	   Engine Model Year	DECS Level	
        Pass/Fail	Test Avg (%)	Date Tested	 Tester	  Mileage --%>
        <asp:Panel id="ColumnPanel" runat="server">
            <h2>Select what information you'd like to see in the report:</h2>
        </asp:Panel>
    </td>
    </tr>
    </table>
	<script type="text/javascript">
    $(function() {
		$(".datepicker").datepicker();
	});
	</script>
	<asp:Button ID="btn_Report" runat="server" Text="Create Report" />
	<asp:SqlDataSource ID="sds_ddl_Account" runat="server" ConnectionString="<%$ ConnectionStrings:CF_SQL_Connection %>"
		SelectCommand="SELECT * FROM [CF_Profile_Account] ORDER BY [AccountName]"></asp:SqlDataSource>
</asp:Content>


