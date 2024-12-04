Public Class SustainabilityReport
    Inherits System.Web.UI.Page

    Protected Sub Page_Load(ByVal sender As Object, ByVal e As System.EventArgs) Handles Me.Load
        Dim strEnvironment As String = ConfigurationManager.AppSettings("EnvironmentMode").ToString
        ' If strEnvironment = "PROD" Then
        ' hlFundingHistoryDetail.Visible = False
        ' End If
    End Sub
    ''' <summary>
    ''' The page will open with different menu based on the logged on user's group permission.
    ''' </summary>
    Private Sub Page_PreRender(sender As Object, e As EventArgs) Handles Me.PreRender

        'If Session("GroupID") >= 400 Then
        '    UCMenuAdmin.Visible = True
        '    UCMenuGeneral.Visible = False
        'ElseIf Session("GroupID") = 225 Or Session("GroupID") = 230 Then
        '    UCMenuAdmin.Visible = False
        '    UCMenuGeneral.Visible = False
        'Else
        '    UCMenuAdmin.Visible = False
        '    UCMenuGeneral.Visible = True
        'End If

        If Session("GroupID") >= 320 Then
            UCMenuAdmin.Visible = True
            UCMenuGeneral.Visible = False
            UCMenuEnvDirector.Visible = False
            UCMenuEnvEngineer.Visible = False
            UCMenuSustainability.Visible = False
        ElseIf Session("GroupID") = 210 Then
            UCMenuAdmin.Visible = False
            UCMenuGeneral.Visible = False
            UCMenuEnvDirector.Visible = False
            UCMenuEnvEngineer.Visible = True
            UCMenuSustainability.Visible = False
        ElseIf Session("GroupID") = 220 Then
            UCMenuAdmin.Visible = False
            UCMenuGeneral.Visible = False
            UCMenuEnvDirector.Visible = True
            UCMenuEnvEngineer.Visible = False
            UCMenuSustainability.Visible = False
        ElseIf Session("GroupID") = 225 Or Session("GroupID") = 230 Then
            UCMenuAdmin.Visible = False
            UCMenuGeneral.Visible = False
            UCMenuEnvDirector.Visible = False
            UCMenuEnvEngineer.Visible = False
            UCMenuSustainability.Visible = True
        Else
            UCMenuAdmin.Visible = False
            UCMenuGeneral.Visible = True
            UCMenuEnvDirector.Visible = False
            UCMenuEnvEngineer.Visible = False
            UCMenuSustainability.Visible = False
        End If


    End Sub

End Class