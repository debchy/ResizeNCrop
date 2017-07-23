<%@ Page Language="C#" AutoEventWireup="true" CodeFile="Default.aspx.cs" Inherits="_Default" %>

<!DOCTYPE html>

<html xmlns="http://www.w3.org/1999/xhtml">
<head runat="server">
    <title></title>
    <meta charset="utf-8">
    <meta http-equiv="X-UA-Compatible" content="IE=edge">
    <meta name="viewport" content="width=device-width, initial-scale=1">
    <meta name="author" content="Debashis Chowdhury" />

    <!-- HTML5 shim and Respond.js for IE8 support of HTML5 elements and media queries -->
    <!-- WARNING: Respond.js doesn't work if you view the page via file:// -->
    <!--[if lt IE 9]>
      <script src="https://oss.maxcdn.com/html5shiv/3.7.3/html5shiv.min.js"></script>
      <script src="https://oss.maxcdn.com/respond/1.4.2/respond.min.js"></script>
    <![endif]-->

    <script src="https://ajax.googleapis.com/ajax/libs/jquery/1.12.4/jquery.min.js"></script>
    
    <!-- Latest compiled and minified CSS -->
    <link rel="stylesheet" href="https://maxcdn.bootstrapcdn.com/bootstrap/3.3.7/css/bootstrap.min.css" integrity="sha384-BVYiiSIFeK1dGmJRAkycuHAHRg32OmUcww7on3RYdg4Va+PmSTsz/K68vbdEjh4u" crossorigin="anonymous">
    <!-- Optional theme -->
    <link rel="stylesheet" href="https://maxcdn.bootstrapcdn.com/bootstrap/3.3.7/css/bootstrap-theme.min.css" integrity="sha384-rHyoN1iRsVXV4nD0JutlnGaslCJuC7uwjduW9SVrLvRYooPp2bWYgmgJQIXwl/Sp" crossorigin="anonymous">
    <!-- Latest compiled and minified JavaScript -->
    <script src="https://maxcdn.bootstrapcdn.com/bootstrap/3.3.7/js/bootstrap.min.js" integrity="sha384-Tc5IQib027qvyjSMfHjOMaLkfuWVxZxUPnCJA7l2mCWNIpG9mGCD8wGNIcPD7Txa" crossorigin="anonymous"></script>

    
    <!-- Add fancyBox -->
    <link rel="stylesheet" href="https://cdnjs.cloudflare.com/ajax/libs/fancybox/2.1.7/css/jquery.fancybox.min.css" type="text/css" media="screen" />
    <script type="text/javascript" src="https://cdnjs.cloudflare.com/ajax/libs/fancybox/2.1.7/js/jquery.fancybox.min.js"></script>
    <script>
        $(document).ready(function () {
            
            $(".imageUpload").fancybox({
                
                //fitToView: false,
                //                  maxWidth: 800,
                //                  maxHeight: 600,
                autoHeight: true,
                autoWidth: true,
                fitToView: true,
                width: '90%',
                height: '80%',
                //autoSize: false,
                closeClick: false,
                openEffect: 'elastic',
                closeEffect: 'elastic',
                //afterClose: function () {                    
                //}
            });

            
        });
        function GetImage(imageURL) {
            $('img[id$="imgResultImage"]').attr("src", imageURL).show();
        }

    </script>
</head>
<body>
    <form id="form1" runat="server">
    <div class="container theme-showcase" role="main" style="width: 100%;">
        <div class="jumbotron">

        <div class="panel panel-primary">
            <div class="panel-body">
                <asp:Image ID="imgResultImage" runat="server" style="display:none" ClientIDMode="Static" />   
                <a href='/F-ImageUploader/CMS_ImageResizeNCropp_VB.aspx?weight=500&height=440'  class="imageUpload btn btn-primary fancybox.iframe" >Upload Image</a>                
                <%--<a data-fancybox data-type="iframe" data-src='/F-ImageUploader/CMS_ImageResizeNCropp_VB.aspx?weight=500&height=440' href="javascript:;" class="imageUpload button" >Upload Image</a>--%>
            </div>
        </div>
        </div>
    </div>
    </form>
</body>
</html>
