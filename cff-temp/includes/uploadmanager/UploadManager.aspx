<%@ Page Language="vb" AutoEventWireup="false" CodeBehind="UploadManager.aspx.vb" Inherits="cleanfleets_fms.UploadManager" %>

<%@ Register Src="../../controls/Footer.ascx" TagName="Footer" TagPrefix="uc1" %>

<!DOCTYPE html>

<html xmlns="http://www.w3.org/1999/xhtml">
<head runat="server">
    <title>Fleet Compliance Management System</title>
    <link rel="stylesheet" type="text/css" href="../../includes/styles/cf_style.css" />
    <link rel="stylesheet" type="text/css" href="../../includes/styles/bootstrapish.css" />
    <style>
        .caption-div {
            width: 40%;
            margin-left: auto;
            margin-right: auto;
        }

        #drop-area {
            border-style: dashed;
            border-color: forestgreen;
            color: forestgreen;
            font-family: sans-serif;
            font-weight: bold;
            margin: 10px auto;
            padding: 10px;
            width: 600px;
            height: 300px;
            display: block;
            overflow: auto;
        }

        #drop-area.highlight {
            border-color: purple;
        }

        #progress-bar {
            position: relative;
            margin-left: 25%;
            width: 300px;
        }

        p {
            margin-top: 0;
        }

        .my-form {
            margin-bottom: 10px;
        }

        #gallery {
            margin-top: 10px;
        }

        #gallery img {
            width: 150px;
            margin-bottom: 10px;
            margin-right: 10px;
            vertical-align: middle;
            position: relative;
            float: left;
        }

        .button {
            display: inline-block;
            padding: 5px;
            background: #ccc;
            cursor: pointer;
            border-radius: 3px;
            border: 1px solid #ccc;
            font-size: small;
        }

        .button:hover {
            background: #ddd;
        }

        #fileElem {
            margin-left: 35%;
        }

        #fileElement {
            display: none;
        }
    </style>
        <script type="text/javascript" src="/includes/javascript/jquery-1.7.2.min.js"></script>
</head>
<body>
    <form runat="server">

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
                                        ForeColor="White" />
                                </div>
                            </td>
                        </tr>
                    </table>
                </td>
            </tr>
            <tr>
                <td>
                    <div class="container">
                        <div class="row">
                            <div class="col bgc p10 w100pct" style="height:600px;overflow: auto; display: block">
                                <asp:Panel runat="server" ID="pnlImageHeading">
                                    <h1>Upload Images</h1>

                                </asp:Panel>
                                <asp:Panel runat="server" ID="pnlFileHeading">
                                    <h1>Upload Files</h1>

                                </asp:Panel>
                                <p>You may enter a title to be saved with each uploaded item.</p>
                                    <div class="caption-div">
                                        <asp:TextBox runat="server" ID="txtCaption" Width="250" OnTextChanged="Caption_TextChanged" AutoPostBack="true" PlaceHolder="Enter an optional title here"></asp:TextBox>
                                    </div>
                                <br />
                                <p>Document Type is not required but if nothing is selected "Other" will be saved with each uploaded item.</p>
                                    <asp:Panel runat="server" ID="pnlDocType" CssClass="caption-div">
                                        <asp:DropDownList runat="server" ID="ddlDocType" Width="250" OnSelectedIndexChanged="ddlDocType_SelectedIndexChanged" AutoPostBack="true">
                                            <asp:ListItem Value="0" Text="Select Document Type" Selected="True"></asp:ListItem>
                                            <asp:ListItem Value="689" Text="Compliance Certificate"></asp:ListItem>
                                            <asp:ListItem Value="690" Text="Fleet Summary"></asp:ListItem>
                                            <asp:ListItem Value="850" Text="Opacity Test"></asp:ListItem>
                                            <asp:ListItem Value="877" Text="Other"></asp:ListItem>
                                        </asp:DropDownList>
                                    </asp:Panel>
                                    <br />

                                    <asp:Panel runat="server" ID="pnlNotes" CssClass="caption-div">
                                        <asp:TextBox runat="server" ID="txtNotes" Width="350" TextMode="MultiLine" Rows="4" OnTextChanged="Caption_TextChanged" AutoPostBack="true" PlaceHolder="Enter an optional description here"></asp:TextBox>
                                    </asp:Panel>

                                    <hr class="w90pct" />
                                <asp:Panel runat="server" id="DropZone"></asp:Panel>
                                <div id="drop-area">
                                    
                                    <p>To upload, Drag & Drop items on the dashed region or click the "Choose Files" button. <br /> <br />
                                    <input type="file" id="fileElem" multiple accept="image/*,.pdf,.doc,.docx,.xls,.xlsx,.txt" onchange="handleFiles(this.files)" />
                                                                       <br />

                                    <br />
                                    <progress id="progress-bar" max="100" value="0"></progress>
                                    <br /><br /></p>
                                     <label class="button" onclick="javascript: Close();">Done With Uploads</label>

                                    <hr class="w90pct" />
                                    <div id="gallery" />
                                </div>
                            </div>
                        </div>
                    </div>
                </td>
            </tr>

            <tr>
                <td>
                    <div id="footer">
                        <uc1:Footer ID="Footer1" runat="server" />

                    </div>
                </td>

            </tr>
        </table>


        <asp:HiddenField ID="hfType" runat="server" />
        <asp:HiddenField ID="hf_IDVehicles" runat="server" />
        <asp:HiddenField ID="hf_IDEngines" runat="server" />
        <asp:HiddenField ID="hf_IDDECS" runat="server" />
        <asp:HiddenField ID="hf_IDProfileAccount" runat="server" />
        <asp:HiddenField ID="hf_IDProfileTerminal" runat="server" />
        <asp:HiddenField ID="hf_IDProfileFleet" runat="server" />

    </form>
    <script type="text/javascript" src="/includes/javascript/jquery-1.7.2.min.js"></script>

    <script>
        $(document).ready(function () {
            if (hfType.Value == "vi" || hfType.Value == "ei" || hfType.Value == "di") $('#fileElem').attr('accept', 'image/*');
            if (hfType.Value == "vf" || hfType.Value == "ef" || hfType.Value == "df") $('#fileElem').attr('accept', '".xlsx,.xls,.doc,.docx,.ppt,.pptx,.txt,.pdf"');

        });
            // ************************ Drag and drop ***************** //
            let dropArea = document.getElementById("drop-area")

                // Prevent default drag behaviors
                ;['dragenter', 'dragover', 'dragleave', 'drop'].forEach(eventName => {
                    dropArea.addEventListener(eventName, preventDefaults, false)
                })

                // Highlight drop area when item is dragged over it
                ;['dragenter', 'dragover'].forEach(eventName => {
                    dropArea.addEventListener(eventName, highlight, false)
                })

                ;['dragleave', 'drop'].forEach(eventName => {
                    dropArea.addEventListener(eventName, unhighlight, false)
                })

            // Handle dropped files
            dropArea.addEventListener('drop', handleDrop, false)

            function preventDefaults(e) {
                e.preventDefault()
                e.stopPropagation()
            }

            function highlight(e) {
                dropArea.classList.add('highlight')
            }

            function unhighlight(e) {
                dropArea.classList.remove('active')
            }

            function handleDrop(e) {
                var dt = e.dataTransfer
                var files = dt.files

                handleFiles(files)
            }

            let uploadProgress = []
            let progressBar = document.getElementById('progress-bar')

            function initializeProgress(numFiles) {
                progressBar.value = 0
                uploadProgress = []

                for (let i = numFiles; i > 0; i--) {
                    uploadProgress.push(0)
                }
            }

            function updateProgress(fileNumber, percent) {
                uploadProgress[fileNumber] = percent
                let total = uploadProgress.reduce((tot, curr) => tot + curr, 0) / uploadProgress.length
                //console.debug('update', fileNumber, percent, total)
                progressBar.value = total
            }

            function handleFiles(files) {
                files = [...files]
                initializeProgress(files.length)
                files.forEach(uploadFile)
                files.forEach(previewFile)
            }

            function SetAccept() {
                if (true) {
                    return "image/*";
                }
                else {
                    return ".doc,.docx,.pdf,.txt,.xls,.xlsx, application/vnd.openxmlformats-officedocument.spreadsheetml.sheet,application/vnd.ms-excel"
                }
            }

            function previewFile(file) {
                let reader = new FileReader()
                reader.readAsDataURL(file)
                reader.onloadend = function () {

                    let img = document.createElement('img');

                    img.src = reader.result;

                    if (file.name.indexOf('.txt') !== -1) {
                        img.src = '../../../images/dox.png';
                    }
                    else if (file.name.indexOf('.pdf') !== -1) {
                        img.src = '../../../images/pdf.png';
                    }
                    else if (file.name.indexOf('.doc') !== -1 || file.name.indexOf('.docx') !== -1) {
                        img.src = '../../../images/word.png';
                    }
                    else if (file.name.indexOf('.xls') !== -1 || file.name.indexOf('.xlsx') !== -1) {
                        img.src = '../../../images/xl.jpg';
                    }
                    else if (file.name.indexOf('.zip') !== -1) {
                        img.src = '../../../images/zip.jpg';
                    }
                    else {
                        img.src = reader.result;
                    }
                    document.getElementById('gallery').appendChild(img);
                }
            }

            function uploadFile(file, i) {
                var url = '../../includes/uploadmanager/uploadmanager.aspx'
                var xhr = new XMLHttpRequest()
                var formData = new FormData()
                xhr.open('POST', url, true)
                xhr.setRequestHeader('X-Requested-With', 'XMLHttpRequest')
                xhr.setRequestHeader('UploadRequest', 'true')

                // Update progress (can be used to show progress indicator)
                xhr.upload.addEventListener("progress", function (e) {
                    updateProgress(i, (e.loaded * 100.0 / e.total) || 100)
                })

                xhr.addEventListener('readystatechange', function (e) {
                    if (xhr.readyState == 4 && xhr.status == 200) {
                        updateProgress(i, 100) // <- Add this
                    }
                    else if (xhr.readyState == 4 && xhr.status != 200) {
                        // Error. Inform the user
                    }
                })

                formData.append('upload_preset', 'ujpu6gyk')
                formData.append('file', file)
                xhr.send(formData)
            }

            function Close() {
                window.opener.document.forms[0].submit();
                self.close();
            }
        


    </script>
</body>
</html>
