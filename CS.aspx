<%@ Page Language="C#" AutoEventWireup="true" CodeFile="CS.aspx.cs" Inherits="CS" %>

<!DOCTYPE html PUBLIC "-//W3C//DTD XHTML 1.0 Transitional//EN" "http://www.w3.org/TR/xhtml1/DTD/xhtml1-transitional.dtd">
<html xmlns="http://www.w3.org/1999/xhtml">
<head runat="server">
    <title></title>
</head>
<body>
    <form id="form1" runat="server">
    <script type="text/javascript" src="https://ajax.googleapis.com/ajax/libs/jquery/1.8.3/jquery.min.js"></script>
    <script type="text/javascript" src="https://cdn.rawgit.com/tapmodo/Jcrop/master/js/jquery.Jcrop.min.js"></script>
    <link rel="stylesheet" href="https://cdn.rawgit.com/tapmodo/Jcrop/master/css/jquery.Jcrop.min.css" type="text/css" />
        <%--<script src="http://jcrop-cdn.tapmodo.com/v0.9.12/js/jquery.Jcrop.min.js"></script>--%>
        <%--<link rel="stylesheet" href="http://jcrop-cdn.tapmodo.com/v0.9.12/css/jquery.Jcrop.css" type="text/css" />--%>
    <script type="text/javascript">
        $(function () {
            $('#FileUpload1').change(function () {
                $('#Image1').hide();
                var reader = new FileReader();
                reader.onload = function (e) {
                    //$('#Image1').show();
                    $('#Image1').attr("src", e.target.result);

                    var canvas = document.getElementById("canvasSource");
                    var ctx = canvas.getContext("2d");

                    img = new Image();
                    img.src = e.target.result;
                    img.onload = function () {

                        canvas.height = canvas.width * (img.height / img.width);

                        ctx.drawImage(img, 0, 0, canvas.width, canvas.height);


                        $('#canvasSource').Jcrop({
                            allowSelect: !0,
                            allowMove: !0,
                            allowResize: !0,
                            bgColor: 'black',
                            bgOpacity: .4,
                            setSelect: [300, 250, 50, 50],
                            aspectRatio: 300 / 250,
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
                $('[id*=btnUpload]').show();
            });
        });
        function SetCoordinates(c) {
            $('#imgX1').val(c.x);
            $('#imgY1').val(c.y);
            $('#imgWidth').val(c.w);
            $('#imgHeight').val(c.h);
            $('#btnCrop').show();
        };
    </script>
    <input type="file" id="FileUpload1" accept=".jpg,.png,.gif" />
    <br />
    <br />
    <table border="0" cellpadding="0" cellspacing="5">
        <tr>
            <td>
                <img id="Image1" src="" alt="" style="display: none" />
                <canvas id="canvasSource"  width="600" ></canvas>
            </td>
            <td>
                <canvas id="canvas" height="5" width="5"></canvas>
            </td>
        </tr>
    </table>
    <br />
    <input type="button" id="btnCrop" value="Crop" style="display: none" />
    <asp:Button ID="btnUpload" runat="server" Text="Upload" OnClick="Upload" Style="display: none" />
    <input type="text" name="imgX1" id="imgX1" />
    <input type="text" name="imgY1" id="imgY1" />
    <input type="text" name="imgWidth" id="imgWidth" />
    <input type="text" name="imgHeight" id="imgHeight" />
    <input type="text" name="imgCropped" id="imgCropped" />
    </form>
</body>
</html>
