<%@ Page Language="vb" debug="true" AutoEventWireup="false" CodeFile="imageupload_DECS.aspx.vb" Inherits="ImageUpload_Detail" Title="Fleet Compliance Management System" %>

<%@ Register Assembly="Radactive.WebControls.ILoad" Namespace="Radactive.WebControls.ILoad" TagPrefix="RAWCIL" %>
    

<!DOCTYPE html PUBLIC "-//W3C//DTD XHTML 1.0 Transitional//EN" "http://www.w3.org/TR/xhtml1/DTD/xhtml1-transitional.dtd">

<html xmlns="http://www.w3.org/1999/xhtml">
<head id="Head1" runat="server">
    <title>Fleet Compliance Management System</title>
    <link rel="stylesheet" type="text/css" href="/includes/styles/cf_style.css"/>


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
				<td class="tablePageBodyLeftColumn">&nbsp;
				    </td>
				<td class="tablePageBodyRightColumn">
				                                <img src="../../images/imageuploadmanager.gif" 
                                    style="width: 462px; height: 51px" /><br />
                                <table border="0" cellpadding="10" cellspacing="0">
                                    <tr>
                                        <td align="left" style="white-space: nowrap;" valign="top">
                                            <table border="0" cellpadding="2" cellspacing="0">
                                                <tr>
                                                    <td align="left" valign="top">&nbsp;
                                                        </td>
                                                    <td align="left" valign="top">
                                                        <asp:HiddenField ID="hf_IDDECS" runat="server" />
                                                    </td>
                                                    <td align="left" valign="top">
                                                        <asp:HiddenField ID="hf_IDEngines" runat="server" />
                                                    </td>
                                                </tr>
                                                <tr>
                                                    <td align="left" valign="top">
                                                        <h3 style="text-align: right; font-size: small; color: #2C7500">
                                                        <strong>Title:</h3>
                                                                </strong></td>
                                                    <td align="left" valign="top" colspan="2">
                                                        <asp:TextBox ID="txtTitle" runat="server" maxlength="255" width="406px"></asp:TextBox>
                                                    </td>
                                                </tr>
                                                <tr>
                                                    <td align="left" valign="top">
                                                        <h3 style="text-align: right; font-size: small; color: #2C7500">
                                                        <strong>Picture:</strong></h3>
                                                    </td>
                                                    <td align="left" valign="top" colspan="2">
                                                        <RAWCIL:ILoad ID="CF_ImageUpload" runat="server">
                                                            <Configuration ManualTemporaryFolder="False" 
                                                                OnCompleteBehavior="KeepFilesInTemporaryFolder" 
                                                                WebPublishedDestinationFolder="True" CutMode="Automatic" KeepSourceImage="False" 
                                                                GenerateIconImage="False" GenerateSelectedImage="False" 
                                                                GenerateIndexXMLFile="False" InternalCode="" Title="Image Upload"><TemporaryFolder Path="" UrlMode="Automatic" ManualUrl=""></TemporaryFolder><DestinationFolder Path="" UrlMode="Automatic" ManualUrl=""></DestinationFolder><WebImageDefinitions><Radactive.WebControls.ILoad.Configuration.WebImageDefinition InternalCode="Default" Title="Default"><SizeConstraint Mode="FreeSize"><FixedSizeData Size="400, 300"></FixedSizeData><FixedAspectRatioSizeData Size="400, 300" LimitedDimension="Width"><Limits><LowLimit Enabled="False" Value="300"></LowLimit><HiLimit Enabled="False" Value="400"></HiLimit></Limits></FixedAspectRatioSizeData><FreeSizeData><LimitsW><LowLimit Enabled="False" Value="300"></LowLimit><HiLimit Enabled="False" Value="400"></HiLimit></LimitsW><LimitsH><LowLimit Enabled="False" Value="300"></LowLimit><HiLimit Enabled="False" Value="400"></HiLimit></LimitsH></FreeSizeData></SizeConstraint><OutputOptions FormatMode="Custom" Format="b96b3cae-0728-11d3-9d7b-0000f81ef32e" JPEGQuality="92" JPEGForceRecompression="False"></OutputOptions></Radactive.WebControls.ILoad.Configuration.WebImageDefinition></WebImageDefinitions><WindowsAppearance><ImageUploadWizardWindow 
                                                                WindowTitle="Image Upload" TopLogoImageUrl="~/images/cfimageuploadlogo.gif" ShowWelcomePage="False" 
                                                                ShowSummaryPage="False" WelcomePageText="Welcome to CleanFleets.net Image Upload
                                                                
                                                                                                        Please choose an image to upload. You may also provide a title for the image.
                                                                                                        
                                                                                                        The title should be descriptive.
                                                                                                        
                                                                                                        Thank you." 
                                                                ShowImagePreviewBeforeFileUpload="False" ShowSaveButtonDuringImageEdit="True" 
                                                                CropperCanvasColor="White" HTMLCropperCanvasColor="White" 
                                                                CropperBackColor="240, 240, 240" HTMLCropperBackColor="#F0F0F0" 
                                                                CropperForeColor="0, 0, 0" HTMLCropperForeColor="#000000" 
                                                                BackColor="240, 240, 240" HTMLBackColor="#F0F0F0" ForeColor="0, 0, 0" 
                                                                HTMLForeColor="#000000" HeaderBackColor="44, 117, 1" 
                                                                HTMLHeaderBackColor="#2C7501" HeaderForeColor="44, 117, 1" 
                                                                HTMLHeaderForeColor="#2C7501" AutoZoomCropperView="True" RightToLeft="False"></ImageUploadWizardWindow><PreviewWindow 
                                                                WindowTitle="Preview" AllowImageDownload="True" AllowImagePrint="True" 
                                                                RightToLeft="False" BackColor="240, 240, 240" HTMLBackColor="#F0F0F0" 
                                                                ForeColor="0, 0, 0" HTMLForeColor="#000000"></PreviewWindow></WindowsAppearance><InputOptions><UploadableFileSizeLimits><LowLimit Enabled="False" Value="1"></LowLimit><HiLimit Enabled="False" Value="2097152"></HiLimit></UploadableFileSizeLimits><SourceImageSizeLimitsW><LowLimit Enabled="False" Value="300"></LowLimit><HiLimit Enabled="False" Value="400"></HiLimit></SourceImageSizeLimitsW><SourceImageSizeLimitsH><LowLimit Enabled="False" Value="300"></LowLimit><HiLimit Enabled="False" Value="400"></HiLimit></SourceImageSizeLimitsH><FileExtensionValidator DefaultBehavior="AcceptAll" AcceptedFileExtensions="" NotAcceptedFileExtensions=""></FileExtensionValidator></InputOptions><ImageCropperOptions AllowImageResize="True" AllowImageZoom="True" AllowImageRotate="True" AllowImageFlip="True" AutoResizeImageIfLarger="True"></ImageCropperOptions></Configuration>
                                                        </RAWCIL:ILoad>
                                                        <br />
                                                        <RAWCIL:ILoadRequiredFieldValidator ID="FV_ImageUpload" runat="server" 
                                                            ControlToValidate="CF_ImageUpload" Display="Dynamic" 
                                                            ErrorMessage="&lt;br /&gt;* Please select image.">
                                                        </RAWCIL:ILoadRequiredFieldValidator>
                                                    </td>
                                                </tr>
												<tr>
                                                    <td align="left" valign="top">
													
                                                    </td>
                                                    <td align="left" valign="top">
                                                        <asp:CheckBox id="cb_DefaultImage" runat="server" text="Default DECS Image"/>
                                                    </td>
                                                </tr>
                                                <tr>
                                                    <td align="left" valign="top">
                                                    </td>
                                                    <td align="left" valign="top" colspan="2">
                                                        <br />
                                                        <asp:Button ID="saveButton" runat="server" causesvalidation="true" text="Save" />
                                                        <br />
                                                    </td>
                                                </tr>
                                            </table>
                                        </td>
                                    </tr>
                                </table>
				</td>
			</tr>
		</table>
		<table id="tableFooter" class="tablePageFooter">
			<tr>
				<td><!--#include virtual ="/includes/footer.htm" --></td>
			</tr>
		</table>
		</td>
	</tr>
</table>

				    <telerik:RadScriptManager ID="RadScriptManager1" Runat="server">
				    </telerik:RadScriptManager>

    </form>
</body>
</html>




