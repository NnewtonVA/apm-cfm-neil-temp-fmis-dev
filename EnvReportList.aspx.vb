Imports System.Configuration

Public Class EnvReportList
    Inherits System.Web.UI.Page

    Protected Sub Page_Load(ByVal sender As Object, ByVal e As System.EventArgs) Handles Me.Load
        Dim strEnvironment As String = ConfigurationManager.AppSettings("EnvironmentMode").ToString
        If strEnvironment = "PROD" Then
            hlFundingHistoryDetail.Visible = False
        End If
    End Sub
    ''' <summary>
    ''' The page will open with different menu based on the logged on user's group permission.
    ''' </summary>
    Private Sub Page_PreRender(sender As Object, e As EventArgs) Handles Me.PreRender
        If Session("GroupID") >= 400 Then
            UCMenuAdmin.Visible = True
            UCMenuGeneral.Visible = False
        Else
            UCMenuAdmin.Visible = False
            UCMenuGeneral.Visible = True
        End If
    End Sub
End Class