<%@ Page Language="C#" AutoEventWireup="true" CodeFile="Default.aspx.cs" Inherits="_Default" %>

<!DOCTYPE html>

<html xmlns="http://www.w3.org/1999/xhtml">
<head runat="server">
    <title></title>
</head>
<body>
    <form id="form1" runat="server">
    <div>
    
    <img src="http://jcrop-cdn.tapmodo.com/v0.9.10/demos/demo_files/sago.jpg" id="cropbox" width="500" >

        <script type="text/javascript" src="http://ajax.googleapis.com/ajax/libs/jquery/1.8.3/jquery.min.js"></script>
        <script src="http://jcrop-cdn.tapmodo.com/v0.9.12/js/jquery.Jcrop.min.js"></script>
        <link rel="stylesheet" href="http://jcrop-cdn.tapmodo.com/v0.9.12/css/jquery.Jcrop.css" type="text/css" />


        <input type="hidden" name="imgX1" id="imgX1" />
        <input type="hidden" name="imgY1" id="imgY1" />
        <input type="hidden" name="imgWidth" id="imgWidth" />
        <input type="hidden" name="imgHeight" id="imgHeight" />

        <script language="Javascript">

    jQuery(function($) {
        $('#cropbox').Jcrop({
            allowSelect: !0,
            allowMove:!0,
            onSelect: SetCoordinates,
            bgColor:     'black',
            bgOpacity:   .4,
            setSelect:   [ 100, 100, 50, 50 ],
            aspectRatio: 16 / 9
        });
    });
    function SetCoordinates(c) {
        $('#imgX1').val(c.x);
        $('#imgY1').val(c.y);
        $('#imgWidth').val(c.w);
        $('#imgHeight').val(c.h);
        //$('#btnCrop').show();
    };
</script>
    </div>
    </form>
</body>
</html>
