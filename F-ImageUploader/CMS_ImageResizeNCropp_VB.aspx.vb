
Imports System.IO

Partial Class F_ImageUploader_CMS_ImageResizeNCropp_VB
    Inherits System.Web.UI.Page

    Protected resizedWeight, resizedHeight As Int16
    Private Sub F_ImageUploader_CMS_ImageResizeNCropp_VB_Init(sender As Object, e As EventArgs) Handles Me.Init
        Try
            resizedWeight = If(Request.QueryString("weight") <> "", Int16.Parse(Request.QueryString("weight")), 700)
        Catch ex As Exception
            resizedWeight = 700
        End Try
        Try
            resizedHeight = If(Request.QueryString("height") <> "", Int16.Parse(Request.QueryString("height")), 200)
        Catch ex As Exception
            resizedHeight = 200
        End Try

        If resizedWeight >= resizedHeight Then
            canvasSource.Attributes.Add("weight", resizedWeight)
        Else
            canvasSource.Attributes.Add("height", resizedHeight)
        End If
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
