<%@ Page Title="" Language="vb" AutoEventWireup="false" MasterPageFile="~/CF_Console.Master" CodeBehind="AnnualMileageReport.aspx.vb" Inherits="cleanfleets_fms.AnnualMileageReport" %>

<asp:Content ID="Content1" ContentPlaceHolderID="head" runat="server">
    <link rel="stylesheet" type="text/css" href="/includes/javascript/jquery-ui.min.css" />
    <link rel="stylesheet" type="text/css" href="/includes/javascript/jquery-ui.theme.min.css" />
    <link rel="stylesheet" type="text/css" href="/includes/javascript/jquery-ui.structure.min.css" />
    <link rel="stylesheet" type="text/css" href="/includes/javascript/cf_style.css" />

    <script type="text/javascript" src="/includes/javascript/jquery-ui.min.js"></script>


</asp:Content>
<asp:Content ID="Content2" ContentPlaceHolderID="RightColumnContentPlaceHolder" runat="server">
    <h1>Annual Mileage Report</h1>
<br />
    <asp:UpdatePanel id="UpdatePanel1" runat="server">
        <ContentTemplate>
    <div>
        <p>
            Report includes the current year and the most recent past two years mileage summary.
           
        </p>
<%--        <asp:Label ID="Label4" runat="server" AssociatedControlID="FromDate">From Date:</asp:Label>
        <asp:TextBox ID="FromDate" runat="server" CssClass="datepicker" />
        <asp:Label ID="Label5" runat="server" AssociatedControlID="FromDate">Through Date:</asp:Label>
        <asp:TextBox ID="ThroughDate" runat="server" CssClass="datepicker" />--%>

        <br />
        <br />

        <div style="width: 75px; display: inline-block">
            <asp:Label ID="Label1" runat="server" AssociatedControlID="ddl_Account">Account:</asp:Label>
        </div>
        <%-- AppendDataBoundItems="true" DataTextField="AccountName" DataValueField="IDProfileAccount" DataSourceID="sds_ddl_Account" --%>
        <asp:DropDownList ID="ddl_Account" runat="server" Width="186px" AppendDataBoundItems="true" 
            AutoPostBack="true" OnSelectedIndexChanged="ddl_Account_SelectedIndexChanged">
            <Items>
                <asp:ListItem Text="--Select an Account--" Value="0" />
            </Items>
        </asp:DropDownList>
        <asp:CustomValidator runat="server" ID="cv_ddl_Account" ControlToValidate="ddl_Account"
            OnServerValidate="cf_ddl_Validate" ErrorMessage="Please select a valid account" ValidateEmpty="true" />
        <br />
        <div style="width: 75px; display: inline-block">
            <asp:Label ID="Label2" runat="server" AssociatedControlID="ddl_Terminal">Terminal:</asp:Label>
        </div>
        <asp:DropDownList ID="ddl_Terminal" runat="server" Width="186px" AutoPostBack="true"
            OnSelectedIndexChanged="ddl_Terminal_SelectedIndexChanged" />
        <br />
        <div style="width: 75px; display: inline-block">
            <asp:Label ID="Label3" runat="server" AssociatedControlID="ddl_Fleet">Fleet:</asp:Label>
        </div>
        <asp:DropDownList ID="ddl_Fleet" runat="server" Width="186px" AutoPostBack="true" />
        <br />

        <table>
            <tbody>
                <tr>
                    <td colspan="2" align="left">
                        <br />
                        <asp:Label ID="Messages" runat="server" />
                    </td>
                </tr>
            </tbody>
        </table>
    </div>

        </ContentTemplate>
    </asp:UpdatePanel>


    <script type="text/javascript">
        $(function () {
            $(".datepicker").datepicker({
                prevText: "",
                nextText: "",
                showOtherMonths: true,
                selectOtherMonths: true,
                changeMonth: true,
                changeYear: true,
                buttonImage: '<%= ResolveUrl("../../images/calendar-ico.png") %>',
                dayNamesMin: ["Sun", "Mon", "Tue", "Wed", "Thu", "Fri", "Sat"],
            });
        });
    </script>
    <asp:Button ID="btn_Report" runat="server" Text="Create Report" />

    <%--I am going to make a change to the SqlDataSource ConnectionString property because I dont think the CF_SQL_Connection--%>
    <%--is working. Change made by Andrew on 12/10/2019.--%>
    <%--Changing database back to CleanFleets in preparation for a migration from DEV to Production; Andrew - 12/10/2019.--%>

    <%--<asp:SqlDataSource ID="sds_ddl_Account" runat="server" ConnectionString="<%$ ConnectionStrings:CF_SQL_Connection %>"
        SelectCommand="SELECT * FROM [CF_Profile_Account] ORDER BY [AccountName]"></asp:SqlDataSource>--%>
    <%--Push made and reverting back; Andrew - 12/10/2019.--%>

    <asp:SqlDataSource ID="sds_ddl_Account" runat="server" ConnectionString="Server=tcp:SQL16\CFNET;Database=CleanFleets-DEV;User ID=sa;Password=Cl3anFl33ts1"
        SelectCommand="SELECT * FROM [CF_Profile_Account] ORDER BY [AccountName]"></asp:SqlDataSource>

    <%--End of change made by Andrew on 12/10/2019.--%>

</asp:Content>



