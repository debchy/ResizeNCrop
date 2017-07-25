
Imports System.IO

Partial Class F_ImageUploader_CMS_ImageResizeNCropp_VB
    Inherits System.Web.UI.Page

    Protected resizedWidth, resizedHeight As Int16
    Private Sub F_ImageUploader_CMS_ImageResizeNCropp_VB_Init(sender As Object, e As EventArgs) Handles Me.Init
        Response.Cache.SetCacheability(HttpCacheability.NoCache)
        Response.ClearHeaders()
        Response.AppendHeader("Cache-Control", "no-cache") '//HTTP 1.1
        Response.AppendHeader("Cache-Control", "private") '// HTTP 1.1
        Response.AppendHeader("Cache-Control", "no-store") '// HTTP 1.1
        Response.AppendHeader("Cache-Control", "must-revalidate") '// HTTP 1.1
        Response.AppendHeader("Cache-Control", "max-stale=0") '// HTTP 1.1 
        Response.AppendHeader("Cache-Control", "post-check=0") '// HTTP 1.1 
        Response.AppendHeader("Cache-Control", "pre-check=0") '// HTTP 1.1 
        Response.AppendHeader("Pragma", "no-cache") '// HTTP 1.1 
        Response.AppendHeader("Keep-Alive", "timeout=3, max=993") ' // HTTP 1.1 
        Response.AppendHeader("Expires", "Mon, 26 Jul 1997 05:00:00 GMT") ' // HTTP 1.1
        Try
            resizedWidth = If(Request.QueryString("Width") <> "", Int16.Parse(Request.QueryString("Width")), 700)
        Catch ex As Exception
            resizedWidth = 700
        End Try
        Try
            resizedHeight = If(Request.QueryString("height") <> "", Int16.Parse(Request.QueryString("height")), 200)
        Catch ex As Exception
            resizedHeight = 200
        End Try

        'If resizedWidth >= resizedHeight Then
        '    canvasSource.Attributes.Add("Width", resizedWidth)
        'Else
        '    'canvasImgHeight = resizedHeight;
        '    'resizedWidth = resizedHeight * (img.width / img.height);
        '    canvasSource.Attributes.Add("height", resizedHeight)
        '    canvasSource.Attributes.Add("Width", resizedWidth)
        'End If
    End Sub

    Protected Sub Upload(sender As Object, e As System.EventArgs)
        Dim base64 As String = Request.Form("imgCropped")
        Dim bytes As Byte() = Convert.FromBase64String(base64.Split(",")(1))

        Dim c As String, filename As String
        c = Day(Now()) & Month(Now()) & Year(Now()) & Hour(TimeOfDay) & Minute(TimeOfDay) & Second(TimeOfDay) & ".png"
        filename = "Content/Cropped_" & c

        Dim image__1 As System.Drawing.Image
        Using ms As New MemoryStream(bytes)
            image__1 = System.Drawing.Image.FromStream(ms)
        End Using
        image__1.Save(System.AppDomain.CurrentDomain.BaseDirectory() & "/Admin/" & filename)

        'IO.File.WriteAllBytes(System.AppDomain.CurrentDomain.BaseDirectory() & "/Admin/" & filename, Convert.FromBase64String(base64.Split(",")(1)))

        'Using stream As New IO.FileStream(Server.MapPath("~/Admin/" & filename), IO.FileMode.Create)
        '    stream.Write(bytes, 0, bytes.Length)
        '    stream.Flush()
        'End Using

        ltrMessage.Text = "<div class='alert alert-success' role='alert'>Successfully Uploaded</div>"
        imgResultImage.ImageUrl = "~/Admin/" & filename

        ClientScript.RegisterStartupScript(Me.GetType(), "uploaded",
                                          "<script>$('#pnlResult').show();$('#pnlCrpper').hide(); $('#pnlUpload').hide(); setCookie('croppedImage','" & "/Admin/" & filename & "',1);  parent.$.fancybox.close();  </script>")
    End Sub



End Class
