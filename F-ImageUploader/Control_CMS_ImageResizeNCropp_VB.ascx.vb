
Partial Class F_ImageUploader_Control_CMS_ImageResizeNCropp_VB
    Inherits System.Web.UI.UserControl

    Private width_ As Int16 = 600
    Public Property Width() As Int16
        Get
            Return width_
        End Get
        Set(ByVal value As Int16)
            Try
                width_ = If(value <> "", Int16.Parse(value), 600)
            Catch ex As Exception
                width_ = 600
            End Try

        End Set
    End Property

    Private height_ As Int16 = 480
    Public Property Height() As Int16
        Get
            Return height_
        End Get
        Set(ByVal value As Int16)
            Try
                height_ = If(value <> "", Int16.Parse(value), 480)
            Catch ex As Exception
                height_ = 480
            End Try
        End Set
    End Property

    Private cssClass_ As String = ""
    Public Property CssClass() As String
        Get
            Return cssClass_
        End Get
        Set(ByVal value As String)
            cssClass_ = value
        End Set
    End Property

    Private buttonName_ As String = "Upload Image"
    Public Property ButtonName() As String
        Get
            Return buttonName_
        End Get
        Set(ByVal value As String)
            buttonName_ = value
        End Set
    End Property

    Private Sub F_ImageUploader_Control_CMS_ImageResizeNCropp_VB_Init(sender As Object, e As EventArgs) Handles Me.Init

    End Sub
End Class
