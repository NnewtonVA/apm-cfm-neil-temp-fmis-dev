Public Class ErrorPage
    Inherits System.Web.UI.Page

    ''' <summary>
    ''' The home and search icons will not be visible for this page.
    ''' </summary>
    Protected Sub Page_Load(ByVal sender As Object, ByVal e As System.EventArgs) Handles Me.Load
        Dim menu As ContentPlaceHolder = CType(Master.FindControl("cphQuickMenu"), ContentPlaceHolder)
        menu.Visible = False
    End Sub

End Class