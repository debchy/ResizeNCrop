<%@ Page Language="VB" AutoEventWireup="false" CodeFile="CMS_ImageResizeNCropp_VB.aspx.vb" Inherits="F_ImageUploader_CMS_ImageResizeNCropp_VB" %>

<!DOCTYPE html>

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
                    <div class="col-xs-12">
                        <canvas id="canvasSource"  runat="server"></canvas>
                        <div style="margin-top:10px">
                            <%--<form name="photo" id="imageUploadForm" enctype="multipart/form-data" action="/" method="post">

                            </form>--%>
                            <%--<input type="button" id="btnCrop" value="Crop" style="display: none" class="btn btn-primary" />--%>
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
                <asp:Image ID="imgResultImage" runat="server" />                
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
        $(function () {
            
            var resizedWidth='<%= resizedWidth%>';
            var resizedHeight='<%= resizedHeight %>';

            $('#FileUpload1').change(function () {
                $('#Image1').hide();

                var reader = new FileReader();
                reader.onload = function (e) {
                    $('#Image1').show();
                    $('#Image1').attr("src", e.target.result);

                    var canvas = document.getElementById("canvasSource");                    
                    var ctx = canvas.getContext("2d");

                    img = new Image();
                    img.src = e.target.result;
                    img.onload = function () {
                        //console.log(canvas.width);
                        var x = 0, y = 0, canvasImgWidth, canvasImgHeight;
                        if (img.height > img.width) {
                            ////portrate image                            
                            canvasImgHeight = resizedHeight;
                            canvasImgWidth = canvasImgHeight * (img.width / img.height);
                            canvas.height = canvasImgHeight;
                            canvas.width = canvasImgWidth;
                            
                        } else {
                            ////landscape image
                            canvasImgWidth = resizedWidth;
                            canvasImgHeight = canvasImgWidth * (img.height / img.width);
                            canvas.height = canvasImgHeight;
                            canvas.width = canvasImgWidth;
                            //console.log("x,y:" + x + ',' + y);                            
                        }

                        x = canvasImgWidth < img.width ? 0 : (canvasImgWidth - img.width) / 2; //starting position X
                        y = canvasImgHeight < img.height ? 0 : (canvasImgHeight - img.height) / 2; //starting position Y

                        if (img.width > canvas.width) {
                            ctx.drawImage(img, 0, 0, canvas.width, canvas.height);
                        } else {
                            ctx.drawImage(img, 0, 0, canvasImgWidth, canvasImgHeight, x, y, canvasImgWidth, canvasImgHeight);
                        }
                        
                        
                        var cropperMargin = 10; //locate the cropper inside the image, instead of starting from (0,0)co-ordinate.
                        $('#canvasSource').Jcrop({
                            allowSelect: !0,
                            allowMove: !0,
                            allowResize: !0,
                            bgColor: 'black',
                            bgOpacity: .4,
                            setSelect: [parseInt(resizedWidth) - cropperMargin, parseInt(resizedHeight) - cropperMargin, cropperMargin, cropperMargin],
                            aspectRatio: parseInt( resizedWidth) / parseInt( resizedHeight),
                            onChange: SetCoordinates,
                            onSelect: SetCoordinates
                        });
                    }

                    
                }
                reader.readAsDataURL($(this)[0].files[0]);
            });

            $('#btnCrop').click(function () {
                var x1 = $('#imgX1').val();
                var y1 = $('#imgY1').val();
                var width = $('#imgWidth').val();
                var height = $('#imgHeight').val();
                var canvas = $("#canvas")[0];
                var context = canvas.getContext('2d');

                canvas.height = height;
                canvas.width = width;
                var canvasSource = document.getElementById("canvasSource");
                context.drawImage(canvasSource, x1, y1, width, height, 0, 0, width, height);

                $('#imgCropped').val(canvas.toDataURL());
                //$('[id*=btnUpload]').show();
                $('[id*=btnUploadAjax]').show();
                $('.Preview').show();
            });

            
        });
        function SetCoordinates(c) {
            $('#imgX1').val(c.x);
            $('#imgY1').val(c.y);
            $('#imgWidth').val(c.w);
            $('#imgHeight').val(c.h);
            $('#btnCrop').show();
            
        };
        
        $(function () {
            $('a[id*="btnUploadAjax"]').on('click',  (function (e) {
               
                e.preventDefault();
                var data = new FormData();
                data.append('File', $('#imgCropped').val());
                if (!parent) {
                    parent.GetImage('');//clear the old file
                }
                
                $.ajax({
                    async: true,
                    type: 'POST',
                    processData: false,
                    contentType: false,
                    //contentType: "application/x-www-form-urlencoded; charset=utf-8",
                    data:  data,
                    dataType: "json",//The type of data that you're expecting back from the server
                    cache: false,
                    url: "/F-ImageUploader/HandlerImageUploader.ashx",
                    success: function (data) {
                        console.log("success");
                        console.log(data.url);
                        $('#pnlResult').show(); $('#pnlCrpper').hide(); $('#pnlUpload').hide();
                        $("#lblMessage").html("<div class='alert alert-success' role='alert'><i class='glyphicon glyphicon-ok' aria-hidden='true'></i> Successfully Uploaded! Close the window to continue.</div>");
                        $("#imgResultImage").attr("src", '/Admin/' + data.url)
                        if (!parent) {
                            parent.GetImage('/Admin/' + data.url);
                        }
                            

                    },
                    error: function (data) {
                        console.log("error");
                        console.log(data);
                    }
                });
            }));
        });
        

    </script>
</body>
</html>
