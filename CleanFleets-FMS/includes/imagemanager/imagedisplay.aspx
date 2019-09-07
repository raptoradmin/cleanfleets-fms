<%@ Page Language="vb" AutoEventWireup="false" CodeBehind="imagedisplay.aspx.vb" Inherits="cleanfleets_fms.imagedisplay" %>

<!DOCTYPE html>

<html xmlns="http://www.w3.org/1999/xhtml">
<head runat="server">
    <title></title>
    <style type="text/css">


.RadGrid_Telerik
{
    font:12px/16px "segoe ui",arial,sans-serif;
}

.RadGrid_Telerik
{
    border:1px solid #828282;
    background:#fff;
    color:#000;
}

.RadGrid_Telerik .rgMasterTable
{
    border-collapse:separate;
}

.RadGrid_Telerik .rgMasterTable
{
    font:12px/16px "segoe ui",arial,sans-serif;
}

.RadGrid_Telerik .rgHeader
{
    color:#333;
    text-decoration:none;
}

.RadGrid_Telerik .rgHeader
{
	border:0;
	border-bottom:1px solid #828282;
	padding-top:5px;
	padding-bottom:4px;
	background:#f3f3f3 0 -2300px repeat-x url('mvwres://Telerik.Web.UI, Version=2009.3.1208.35, Culture=neutral, PublicKeyToken=121fae78165ba3d4/Telerik.Web.UI.Skins.Telerik.Grid.sprite.gif');
	text-align:left;
	font-weight:normal;
}

.RadGrid_Telerik .rgHeader
{
	padding-left:7px;
	padding-right:7px;
}

.RadGrid_Telerik .rgHeader
{
	cursor:default;
}

    </style>
</head>
<body>
    <form id="form1" runat="server">
    <div style="text-align: center">
    
                                                <telerik:RadGrid ID="rg_VehicleImages" runat="server" DataSourceID="sds_ImagesVehicle" 
                                                    GridLines="None" Skin="Telerik" >
                                                    <mastertableview datasourceid="sds_ImagesVehicle" 
                                                    autogeneratecolumns="False" datakeynames="IDImages">
                                                        <rowindicatorcolumn>
                                                            <HeaderStyle Width="20px" />
                                                        </rowindicatorcolumn>
                                                        <expandcollapsecolumn>
                                                            <HeaderStyle Width="20px" />
                                                        </expandcollapsecolumn>
                                                        <Columns>
                                                            <telerik:GridImageColumn DataType="System.String"
                                                                DataImageUrlFields="FilePath, FileName"                                                                
																DataImageUrlFormatString="{0}/{1}?Width=800&Height=600&mode=max" 
																AlternateText="File"
                                                                DataAlternateTextField="FileName" ImageAlign="Middle"
                                                                HeaderText="" FooterText="ImageColumn footer">
                                                            </telerik:GridImageColumn>
                                                            </Columns>
                                                        <norecordstemplate>
                                                        </norecordstemplate>
                                                        </mastertableview>
                                                    </telerik:RadGrid>
    
                                                <br />
                                                <asp:Button ID="Button1" runat="server" Text="Close" />
    
    </div>
    <asp:SqlDataSource ID="sds_ImagesVehicle" runat="server" 
        ConnectionString="<%$ ConnectionStrings:CF_SQL_Connection %>" 
        SelectCommand="SELECT [IDImages], [FilePath], [FileName] FROM [CF_Images] WHERE ([IDImages] = @IDImages)">
        <SelectParameters>
            <asp:QueryStringParameter Name="IDImages" QueryStringField="IDImages" 
                 />
        </SelectParameters>
    </asp:SqlDataSource>
    <telerik:RadScriptManager ID="RadScriptManager1" Runat="server">
    </telerik:RadScriptManager>
    </form>
</body>
</html>
