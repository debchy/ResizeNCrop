<%@ Page Language="C#" AutoEventWireup="true" CodeFile="CMS_ImageResizeNCropp_CS.aspx.cs" Inherits="F_ImageUploader_CMS_ImageResizeNCropp_CS" %>

<!DOCTYPE html>

<%--reference https://developer.mozilla.org/en/docs/Web/API/CanvasRenderingContext2D/drawImage--%>
<html xmlns="http://www.w3.org/1999/xhtml">
<head runat="server">
    <title>Image Resize and Crop</title>
    <meta charset="utf-8">
    <meta http-equiv="X-UA-Compatible" content="IE=edge">
    <meta name="viewport" content="width=device-width, initial-scale=1">
    <meta name="author" content="Debashis Chowdhury" />
    <meta http-Equiv="Cache-Control" Content="no-cache" />
    <meta http-Equiv="Pragma" Content="no-cache" />
    <meta http-Equiv="Expires" Content="0" />
    <!-- HTML5 shim and Respond.js for IE8 support of HTML5 elements and media queries -->
    <!-- WARNING: Respond.js doesn't work if you view the page via file:// -->
    <!--[if lt IE 9]>
      <script src="https://oss.maxcdn.com/html5shiv/3.7.3/html5shiv.min.js"></script>
      <script src="https://oss.maxcdn.com/respond/1.4.2/respond.min.js"></script>
    <![endif]-->
     <!-- Latest compiled and minified CSS -->
    <link rel="stylesheet" href="https://maxcdn.bootstrapcdn.com/bootstrap/3.3.7/css/bootstrap.min.css" >
    <!-- Optional theme -->
    <link rel="stylesheet" href="https://maxcdn.bootstrapcdn.com/bootstrap/3.3.7/css/bootstrap-theme.min.css">
    
    <style>
        .jcrop-holder{
                display: inline-block;
                background-color: #000;
                border: rgba(128, 128, 128, 0.33) dashed 1px;
        }
    </style>
</head>
<body>
    <form id="form1" runat="server">
    <div class="container theme-showcase" role="main" style="width: 100%;">
      <!-- Main jumbotron for a primary marketing message or call to action -->
      <div class="jumbotron">
          <div class="panel panel-primary" id="pnlUpload">
            <div class="panel-body">
                <h2><small>Upload Image</small></h2>
        <div class="input-group"  style="margin-bottom:10px">
          <span class="input-group-addon" id="basic-addon1">Browse File</span>
          <input type="file" id="FileUpload1" accept=".jpg,.png,.gif" class="form-control" />
        </div>
            </div>
        </div>
        
        <div class="panel panel-primary" id="pnlCrpper">
            <div class="panel-body">
                <img id="Image1" src="" alt="" style="display: none" />
                <div class="row"  style="margin-top:0px; margin-bottom:8px;">
                    <div class="col-xs-3">
                        <div class="input-group">
                            <span class="input-group-addon" id="basic-addon1">X</span>
                            <input type="text" name="imgX1" id="imgX1" readonly="true" class="form-control" />
                        </div>
                    </div>
                    <div class="col-xs-3">
                        <div class="input-group">
                            <span class="input-group-addon" id="basic-addon1">Y</span>
                            <input type="text" name="imgY1" id="imgY1" readonly="true"  class="form-control"/>
                        </div>
                    </div>
                    <div class="col-xs-3">
                        <div class="input-group">
                            <span class="input-group-addon" id="basic-addon1">Width</span>
                            <input type="text" name="imgWidth" id="imgWidth" readonly="true" class="form-control" />
                        </div>
                    </div>
                    <div class="col-xs-3">
                        <div class="input-group">
                            <span class="input-group-addon" id="basic-addon1">Height</span>
                            <input type="text" name="imgHeight" id="imgHeight" readonly="true" class="form-control" />
                        </div>
                    </div>
                </div>
                <div class="row" >
                    <div class="col-xs-12 text-center">
                        <canvas id="canvasSource"  runat="server" style="background-color:white;"></canvas>
                        <div style="margin-top:10px">
                            <button type="button" id="btnCrop" style="display: none" class="btn btn-primary"><i class="glyphicon glyphicon-screenshot" aria-hidden="true"></i> Crop</button>
                            <asp:Button ID="btnUpload" runat="server" Text="Upload" OnClick="Upload" Style="display: none" CssClass="btn btn-success" />
                            <a id="btnUploadAjax" style="display: none" class="btn btn-success" href="javascript:;"><i class="glyphicon glyphicon-open" aria-hidden="true"></i> Upload</a>
                        </div>
                    </div>
                    
                    
                </div>
                
                

                <div  style="margin-top:10px">
                    <div class="Preview" style="display:none">
                        <h3><span class="label label-default">Preview:</span></h3>
                        <canvas id="canvas" style="border: rgba(128, 128, 128, 0.33) dashed 1px;"></canvas>
                    </div>
                    <input type="hidden" name="imgCropped" id="imgCropped" />
                </div>


            </div>

            <div class="panel-footer">
                
                
            </div>
        </div>
    
        <div class="panel panel-primary" id="pnlResult" style="display:none;">
            <div class="panel-body text-center">
                <asp:Literal ID="ltrMessage" runat="server"></asp:Literal>
                <asp:Label ID="lblMessage" runat="server"></asp:Label>
                <asp:Image ID="imgResultImage" runat="server"  style="border: rgba(128, 128, 128, 0.33) dashed 1px;"/>                
            </div>
        </div>
    
    
    
    
    
   

      </div>
    </div>
    </form>

    
    <script src="https://ajax.googleapis.com/ajax/libs/jquery/1.12.4/jquery.min.js"></script>
   <!-- Latest compiled and minified JavaScript -->
    <%--<script src="https://maxcdn.bootstrapcdn.com/bootstrap/3.3.7/js/bootstrap.min.js" integrity="sha384-Tc5IQib027qvyjSMfHjOMaLkfuWVxZxUPnCJA7l2mCWNIpG9mGCD8wGNIcPD7Txa" crossorigin="anonymous"></script>--%>

    <!--http://jcrop.org-->
    <script type="text/javascript" src="https://cdn.rawgit.com/tapmodo/Jcrop/master/js/jquery.Jcrop.min.js"></script>
    <link rel="stylesheet" href="https://cdn.rawgit.com/tapmodo/Jcrop/master/css/jquery.Jcrop.min.css" type="text/css" />
    <!--END http://jcrop.org-->

    <script type="text/javascript">
        var controlID = '<%= Request.QueryString["controlID"] %>';
        var resizedWidth='<%= resizedWidth%>';
        var resizedHeight = '<%= resizedHeight %>';

    </script>
    <script src="ImageResizeNCrop.js"></script>
</body>
</html>
