<%@ Page Title="" Language="vb" AutoEventWireup="false" MasterPageFile="~/CF_Console.Master" CodeBehind="tabtest.aspx.vb" Inherits="cleanfleets_fms.tabtest" %>

<asp:Content runat="server" ContentPlaceHolderID="RightColumnContentPlaceHolder">
            <telerik:RadTabStrip ID="RadTabStrip1" runat="server" MultiPageID="RadMultiPagetab" AutoPostBack="true"
                Orientation="HorizontalTop" ShowBaseLine="true">
                <Tabs>
                    <telerik:RadTab Text="Overview" Selected="true">
                    </telerik:RadTab>
                    <telerik:RadTab Text="Attendance">
                    </telerik:RadTab>
                    <telerik:RadTab Text="Discipline">
                    </telerik:RadTab>
                </Tabs>
            </telerik:RadTabStrip>

            <telerik:RadMultiPage ID="RadMultiPagetab" runat="server">
                <telerik:RadPageView ID="PageView1" runat="server" ContentUrl="http://microsoft.com" Selected="true">
                </telerik:RadPageView>
                <telerik:RadPageView ID="PageView2" runat="server">
                    ..... some controls---------------
                </telerik:RadPageView>
                <telerik:RadPageView ID="PageView3" runat="server">
                    ----some controls---------------
                </telerik:RadPageView>
            </telerik:RadMultiPage>
</asp:Content>
