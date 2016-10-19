<%@ Page Language="C#" AutoEventWireup="true" CodeBehind="FileUploads.aspx.cs" Inherits="UpLoadCSV.FileUploads" %>

<!DOCTYPE html>

<html xmlns="http://www.w3.org/1999/xhtml">
<head runat="server">
    <title></title>
    <script src="Scripts/jquery-1.8.2.js"></script>
    <script src="jquery-ui/jquery-ui.js"></script>
    <link href="jquery-ui/jquery-ui.css" rel="stylesheet" />
  
  
    <script type="text/javascript">
        $(document).ready(function () {
            $("#btnUpload").click(function (event) {
                var files = $("#FileUpload1")[0].files;
                if (files.length > 0) {
                    var formData = new FormData();
                    for (var i = 0; i < files.length; i++) {
                        formData.append(files[i].name, files[i]);
                    }

                    var progressbarLabel = $('#progressBar-label');
                    var progressbarDiv = $('#progressbar');

                    $.ajax({
                        url: 'http://evilapi.afdcloud.com.au/',
                        //ContentType: application/json,
                        data:JSON.stringify(formData),
                        method: 'post',
                        dataType: 'jsonp',
                        crossDomain: true,
                        contentType: false,
                        processData: false,
                        success: function (data) {
                            var filedata = $(data);
                            $(formData).serializeArray();                                
                            progressbarLabel.text('Complete');
                            progressbarDiv.fadeOut(2000);
                        },
                        error: function (err) {
                            alert(err.statusText);
                        }
                    });

                    progressbarLabel.text('Uploading...');
                    progressbarDiv.progressbar({
                        value: false
                    }).fadeIn(500);
                }
            });
        });
    </script>
   
</head>
<body>
    <form id="form1" runat="server">

    Select Files :

        <asp:FileUpload ID="FileUpload1" runat="server" AllowMultiple="true" />
        <br /><br />
        <input type="button" id="btnUpload" value="Upload Files" />
        <br /><br />
        <div style="width: 300px">
            <div id="progressbar" style="position: relative; display: none">
                <span style="position: absolute; left: 35%; top: 20%" id="progressBar-label">
                    Uploading...
                </span>
            </div>
        </div>
    </form>
</body>
</html>
