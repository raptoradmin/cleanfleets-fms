<%@ Page Title="" Language="vb" AutoEventWireup="false" MasterPageFile="~/CF_Console.Master" CodeBehind="dmvreport.aspx.vb" Inherits="cleanfleets_fms.dmvreport" %>

<asp:Content runat="server" ContentPlaceHolderID="RightColumnContentPlaceHolder">
    <telerik:RadTabStrip ID="RadTabStrip1" runat="server" MultiPageID="RadMultiPagetab" CausesValidation="false"
        Orientation="HorizontalTop" ShowBaseLine="true">
        <Tabs>
            <telerik:RadTab Text="Add Registration" Selected="true">
            </telerik:RadTab>
            <telerik:RadTab Text="View Records">
            </telerik:RadTab>
        </Tabs>
    </telerik:RadTabStrip>

    <telerik:RadMultiPage ID="RadMultiPagetab" runat="server">
        <telerik:RadPageView ID="DMV_Add" runat="server" Selected="true">
            <h1>Please enter VIN to autofill existing fields</h1>
            <p>VIN</p>
            <asp:TextBox ID="ChassisVIN" runat="server"></asp:TextBox>
            <asp:Button ID="PopulateFields" Text="Search Records" runat="server" CausesValidation="false"></asp:Button>
            <br />
            <asp:RequiredFieldValidator runat="server" ID="ChassisVIN_Validator" ControlToValidate="ChassisVIN" ErrorMessage="Please enter the VIN" />
            <asp:Label ID="ChassisVIN_Error" runat="server" CssClass="ui-state-error" Visible="false" Text="VIN not found in existing records, please enter information manually"></asp:Label>
            <h2>Test Fields</h2>

            <!-- Form fields begin !-->

            <table>
                <tr>
                    <td>&nbsp;</td>
                    <td>&nbsp;</td>
                    <td>
                        <p>Valid From Date<span style="color: red;">*</span></p>
                        <asp:TextBox ID="FromDate" CssClass="datepicker" runat="server"></asp:TextBox>
                        <asp:RequiredFieldValidator runat="server" ID="FromDate_Validator" ControlToValidate="FromDate" ErrorMessage="Please enter the start date" />
                    </td>
                    <td>&nbsp;</td>
                    <td>
                        <p>Valid Through Date<span style="color: red;">*</span></p>
                        <asp:TextBox ID="ThroughDate" CssClass="datepicker" runat="server"></asp:TextBox>
                        <asp:RequiredFieldValidator runat="server" ID="ThroughDate_Validator" ControlToValidate="ThroughDate" ErrorMessage="Please enter the expired date" />
                        <asp:CompareValidator ID="cv_Date" runat="server"
                            ControlToCompare="FromDate" CultureInvariantValues="true"
                            Display="Dynamic" EnableClientScript="true"
                            ControlToValidate="ThroughDate"
                            ErrorMessage="Start date must be earlier than finish date"
                            Type="Date" SetFocusOnError="true" Operator="GreaterThan"
                            Text="Start date must be earlier than finish date"></asp:CompareValidator>
                    </td>
                </tr>
                <!-- ROW BREAK IN PHYSICAL FORM !-->
                <tr>
                    <td>
                        <p>Make</p>
                        <asp:TextBox ID="Make" runat="server"></asp:TextBox>
                    </td>
                    <td>
                        <p>YR Model</p>
                        <asp:TextBox ID="Year" runat="server"></asp:TextBox>
                    </td>
                    <td>
                        <p>YR 1st Sold</p>
                        <asp:TextBox ID="YrFirstSold" runat="server"></asp:TextBox>
                    </td>
                    <td>
                        <p>VLF Class</p>
                        <asp:TextBox ID="VlfClass" runat="server"></asp:TextBox>
                    </td>
                    <td>
                        <p>Type Veh</p>
                        <asp:TextBox ID="TypeVeh" runat="server"></asp:TextBox>
                    </td>
                    <td>
                        <p>Type LIC</p>
                        <asp:TextBox ID="TypeLic" runat="server"></asp:TextBox>
                    </td>
                    <td>
                        <p>License Number<span style="color: red;">*</span></p>
                        <asp:TextBox ID="LicensePlateNo" runat="server"></asp:TextBox>
                        <asp:RequiredFieldValidator runat="server" ID="LicensePlateNo_Validator" ControlToValidate="LicensePlateNo" ErrorMessage="Please enter the License Number" />

                    </td>
                </tr>

                <!-- ROW BREAK IN PHYSICAL FORM !-->
                <tr>
                    <td>
                        <p>Body Type Model</p>
                        <asp:TextBox ID="BodyType" runat="server"></asp:TextBox>
                    </td>
                    <td>
                        <p>MP</p>
                        <asp:TextBox ID="MP" runat="server"></asp:TextBox>
                    </td>
                    <td>
                        <p>MO</p>
                        <asp:TextBox ID="MO" runat="server"></asp:TextBox>
                    </td>
                </tr>

                <!-- ROW BREAK IN PHYSICAL FROM !-->
                <tr>
                    <td>
                        <p>Type Vehicle Use</p>
                        <asp:TextBox ID="TypeVehicleUse" runat="server"></asp:TextBox>
                    </td>
                    <td>
                        <p>Date Issued<span style="color: red;">*</span></p>
                        <asp:TextBox ID="DateIssued" CssClass="datepicker" runat="server"></asp:TextBox>
                        <asp:RequiredFieldValidator runat="server" ID="DateIssued_Validator" ControlToValidate="DateIssued" ErrorMessage="Please enter the date issued" />

                    </td>
                    <td>
                        <p>CC/Alco</p>
                        <asp:TextBox ID="CCAlco" runat="server"></asp:TextBox>
                    </td>
                    <td>
                        <p>Date Fee Received<span style="color: red;">*</span></p>
                        <asp:TextBox ID="DateFeeReceived" CssClass="datepicker" runat="server"></asp:TextBox>
                        <asp:RequiredFieldValidator runat="server" ID="DateFeeReceived_Validator" ControlToValidate="DateFeeReceived" ErrorMessage="Please enter the fee received date" />

                    </td>
                    <td>
                        <p>PIC</p>
                        <asp:TextBox ID="Pic" runat="server"></asp:TextBox>
                    </td>
                    <td>
                        <p>Sticker Issued<span style="color: red;">*</span></p>
                        <asp:TextBox ID="StickerIssued" runat="server"></asp:TextBox>
                        <asp:RequiredFieldValidator runat="server" ID="StickerIssued_Validator" ControlToValidate="StickerIssued" ErrorMessage="Please enter the sticker issued" />

                    </td>
                </tr>

                <!-- ROW BREAK IN PHYSICAL FORM !-->

                <tr>
                    <td>
                        <p>Name<span style="color: red;">*</span></p>
                        <asp:TextBox ID="Name" runat="server" MaxLength="200"></asp:TextBox>
                        <asp:RequiredFieldValidator runat="server" ID="Name_Validator" ControlToValidate="Name" ErrorMessage="Please enter the name" />

                    </td>
                    <td>
                        <p>Amount Paid<span style="color: red;">*</span></p>
                        <asp:TextBox ID="AmountPaid" runat="server"></asp:TextBox>
                        <asp:RequiredFieldValidator runat="server" ID="AmountPaid_Validator" ControlToValidate="AmountPaid" ErrorMessage="Please enter the amount paid" />

                    </td>
                </tr>
                <tr>
                    <td>
                        <p>Address<span style="color: red;">*</span></p>
                        <asp:TextBox ID="Address" runat="server" MaxLength="200"></asp:TextBox>
                        <asp:RequiredFieldValidator runat="server" ID="Address_Validator" ControlToValidate="Address" ErrorMessage="Please enter the address" />

                    </td>
                </tr>
            </table>
            <!-- Form fields end !-->
            <asp:Button ID="SubmitRegistration" runat="server" Text="Submit Registration" />
            <script type="text/javascript">
                $(function () {
                    $(".datepicker").datepicker();
                });
            </script>
        </telerik:RadPageView>
        <telerik:RadPageView ID="PageView2" runat="server">
            <telerik:RadGrid ID="RadGrid1" runat="server" AllowSorting="True" DataSourceID="sds_Registration"
                GridLines="None" Width="771px" Skin="Telerik">
                <MasterTableView AutoGenerateColumns="False" DataSourceID="sds_Registration"
                    DataKeyNames="LicensePlateNo">
                    <RowIndicatorColumn>
                        <HeaderStyle Width="20px" />
                    </RowIndicatorColumn>
                    <ExpandCollapseColumn>
                        <HeaderStyle Width="20px" />
                    </ExpandCollapseColumn>
                    <Columns>
                        <telerik:GridBoundColumn DataField="LicensePlateNo" HeaderText="License Number"
                            SortExpression="LicensePlateNo" UniqueName="LicensePlateNo">
                        </telerik:GridBoundColumn>
                        <telerik:GridBoundColumn DataField="FromDate" HeaderText="Registration From"
                            SortExpression="FromDate" UniqueName="FromDate" DataFormatString="{0:M/d/yyyy}">
                        </telerik:GridBoundColumn>
                        <telerik:GridBoundColumn DataField="ThroughDate" HeaderText="Registration Through"
                            SortExpression="ThroughDate" UniqueName="ThroughDate" DataFormatString="{0:M/d/yyyy}">
                        </telerik:GridBoundColumn>
                        <telerik:GridBoundColumn DataField="Name" HeaderText="Name"
                            SortExpression="Name" UniqueName="Name">
                        </telerik:GridBoundColumn>
                    </Columns>
                </MasterTableView>
            </telerik:RadGrid>
            <asp:SqlDataSource ID="sds_Registration" runat="server" ConnectionString="<%$ ConnectionStrings:CF_SQL_Connection %>"
                SelectCommand="SELECT LicensePlateNo, FromDate, ThroughDate, Name FROM [CF_DMV]"></asp:SqlDataSource>
        </telerik:RadPageView>
    </telerik:RadMultiPage>
</asp:Content>

