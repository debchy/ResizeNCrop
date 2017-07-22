Imports System.IO

Partial Class VB
    Inherits System.Web.UI.Page

    Protected Sub Upload(sender As Object, e As System.EventArgs)
        Dim base64 As String = Request.Form("imgCropped")
        Dim bytes As Byte() = Convert.FromBase64String(base64.Split(",")(1))
        Using stream As New FileStream(Server.MapPath("~/Images/Cropped.png"), FileMode.Create)
            stream.Write(bytes, 0, bytes.Length)
            stream.Flush()
        End Using
    End Sub
End Class
