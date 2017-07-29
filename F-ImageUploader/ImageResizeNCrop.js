
$(function () {

    var jcrop_api;
    $('#FileUpload1').change(function () {
        $('#Image1').hide();

        var reader = new FileReader();
        reader.onload = function (e) {
            //$('#Image1').show();
            $('#Image1').attr("src", e.target.result);

            var canvas = document.getElementById("canvasSource");
            var canvasContext = canvas.getContext("2d");

            canvas.removeAttribute("width");//clear old canvas width
            canvas.removeAttribute("height");//clear old canvas height


            img = new Image();
            img.src = e.target.result;
            img.onload = function () {
                //console.log(canvas.width);
                var x = 0, y = 0, canvasImgWidth, canvasImgHeight, resultX = 0, resultY = 0;
                canvas.setAttribute("width", resizedWidth);
                canvas.setAttribute("height", resizedHeight);
                ImageResizer(canvasContext, img, resizedWidth, resizedHeight, img.width, img.height, x, y, resultX, resultY);



                var cropperMargin = 10; //locate the cropper inside the image, instead of starting from (0,0)co-ordinate.

                $('#canvasSource').Jcrop({
                    allowSelect: !0,
                    allowMove: !0,
                    allowResize: !0,
                    bgColor: 'black',
                    bgOpacity: .4,
                    setSelect: [parseInt(resizedWidth) - cropperMargin, parseInt(resizedHeight) - cropperMargin, cropperMargin, cropperMargin],
                    aspectRatio: parseInt(resizedWidth) / parseInt(resizedHeight),
                    onChange: SetCoordinates,
                    onSelect: SetCoordinates
                }, function () {
                    jcrop_api = this;
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
    $('a[id*="btnUploadAjax"]').on('click', (function (e) {

        e.preventDefault();
        var data = new FormData();
        data.append('File', $('#imgCropped').val());

        transferImageToParent(controlID, '');

        $.ajax({
            async: true,
            type: 'POST',
            processData: false,
            contentType: false,
            //contentType: "application/x-www-form-urlencoded; charset=utf-8",
            data: data,
            dataType: "json",//The type of data that you're expecting back from the server
            cache: false,
            url: "/F-ImageUploader/HandlerImageUploader.ashx",
            success: function (data) {
                console.log("success");
                console.log(data.url);
                $('#pnlResult').show(); $('#pnlCrpper').hide(); $('#pnlUpload').hide();
                $("#lblMessage").html("<div class='alert alert-success' role='alert'><i class='glyphicon glyphicon-ok' aria-hidden='true'></i> Successfully Uploaded! Close the window to continue.</div>");
                $("#imgResultImage").attr("src", '/Admin/' + data.url);

                transferImageToParent(controlID, data.url);
            },
            error: function (data) {
                console.log("error");
                console.log(data);
            }
        });
    }));
});

function transferImageToParent(openerControlID, imageURL) {

    if (parent != null) {
        console.log("opener window's image has targeted. openerControlID=" + openerControlID);
        try {
            //parent.GetImage('/Admin/' + data.url); //target via parent function
            //target element via jQuery directly
            $(parent.document).find("input[id='" + openerControlID + "_hdnResultImage']").val(imageURL);
            var imgResultImage = $(parent.document).find("img[id='" + openerControlID + "_imgResultImage']");
            imgResultImage.attr('src', '/Admin/' + imageURL);
            if (imageURL == "") imgResultImage.hide();
            else imgResultImage.show();
        } catch (e) { }

    }
}

function ImageResizer(canvasContext, img, canvasWidth, canvasHeight, sourceWidth, sourceHeight, destinationX, destinationY, destinationWidth, destinationHeight) {
    var canvasRatio = canvasWidth / canvasHeight;
    var sourceRatio = sourceWidth / sourceHeight;

    if (sourceWidth > canvasWidth || sourceHeight > canvasHeight) {
        //if the image do not fit into the required canvas
        if (canvasRatio >= 1) {
            //if the canvas is landscape

            if (sourceRatio <= 1) {
                //if the image is portrait
                destinationHeight = canvasHeight;
                destinationWidth = destinationHeight * sourceRatio;
                destinationX = (canvasWidth - destinationWidth) / 2;
                destinationY = 0;
            }
            else if (sourceRatio > 1) {
                //if the image is landscape
                if (canvasRatio < sourceRatio) {
                    //make the landscape image fit inside the required Canvas. 
                    //In this case ImageX is bigger than canvasWidth & ImageY is small than canvasHeight
                    destinationWidth = canvasWidth;
                    destinationHeight = destinationWidth / sourceRatio;
                    destinationX = 0;
                    destinationY = (canvasHeight - destinationHeight) / 2;
                } else if (canvasRatio >= sourceRatio) {
                    //In this case ImageY is bigger than canvasHeight & ImageX is small than canvasWidth
                    destinationHeight = canvasHeight;
                    destinationWidth = destinationHeight * sourceRatio;
                    destinationX = (canvasWidth - destinationWidth) / 2;
                    destinationY = 0;
                }
            }


        }
        else if (canvasRatio < 1) {
            //if the canvas is portrait
            if (sourceRatio >= 1) {
                //if the image is landscape
                console.log("phase1");
                destinationWidth = canvasWidth;
                destinationHeight = destinationWidth / sourceRatio;
                destinationX = 0;
                destinationY = (canvasHeight - destinationHeight) / 2;
            }
            else if (sourceRatio < 1) {
                //if the image is portrait
                if (canvasRatio > sourceRatio) {
                    console.log("phase2");
                    //make the portrait image fit inside the required Canvas. 
                    //In this case ImageY is bigger than canvasHeight & ImageX is small than canvasWidth
                    destinationHeight = canvasHeight;
                    destinationWidth = destinationHeight * sourceRatio;
                    destinationX = (canvasWidth - destinationWidth) / 2;
                    destinationY = 0;
                } else if (canvasRatio <= sourceRatio) {
                    //In this case ImageX is bigger than canvasWidth & ImageY is small than canvasHeight
                    console.log("phase3");
                    destinationWidth = canvasWidth;
                    destinationHeight = destinationWidth / sourceRatio;
                    destinationX = 0;
                    destinationY = (canvasHeight - destinationHeight) / 2;
                }
            }

        }
    }
    else {
        console.log("phase4");
        //image will directly fit inside the canvas
        destinationWidth = sourceWidth;
        destinationHeight = sourceHeight;
        destinationX = (canvasWidth - sourceWidth) / 2;
        destinationY = (canvasHeight - sourceHeight) / 2;
    }


    console.log("img.width=" + sourceWidth + " img.height=" + sourceHeight + " destinationX=" + destinationX + " destinationY=" + destinationY + " destinationWidth=" + destinationWidth + " destinationHeight=" + destinationHeight);
    canvasContext.drawImage(img, 0, 0, sourceWidth, sourceHeight, destinationX, destinationY, destinationWidth, destinationHeight);
}
