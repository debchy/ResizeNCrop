<%@ WebHandler Language="VB" Class="HandlerImageUploader" %>

Imports System
Imports System.Web
Imports System.IO

Public Class HandlerImageUploader : Implements IHttpHandler



    Public Sub ProcessRequest(ByVal context As HttpContext) Implements IHttpHandler.ProcessRequest

        context.Response.ContentType = "text/json"
        Dim base64 = context.Request.Form(0) ' context.Request.Form("file")  

        Dim bytes As Byte() = Convert.FromBase64String((base64.Split(",")(1)))

        Dim c As String, filename As String
        c = Day(Now()) & Month(Now()) & Year(Now()) & Hour(TimeOfDay) & Minute(TimeOfDay) & Second(TimeOfDay) & ".png"
        filename = "Content/Cropped_" & c

        IO.File.WriteAllBytes(System.AppDomain.CurrentDomain.BaseDirectory() & "/Admin/" & filename, Convert.FromBase64String(base64.Split(",")(1)))

        'Dim image__1 As System.Drawing.Image
        'Using ms As New MemoryStream(bytes)
        '    image__1 = System.Drawing.Image.FromStream(ms)
        'End Using
        'image__1.Save(System.AppDomain.CurrentDomain.BaseDirectory() & "/Admin/" & filename)

        context.Response.Write("{""url"":""" & filename & """}")

    End Sub


    Public ReadOnly Property IsReusable() As Boolean Implements IHttpHandler.IsReusable
        Get
            Return False
        End Get
    End Property


End Class