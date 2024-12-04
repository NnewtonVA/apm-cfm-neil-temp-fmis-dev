Public Class ReportViewerUpdateReport
    Inherits System.Web.UI.Page

    Protected Sub Page_Load(ByVal sender As Object, ByVal e As System.EventArgs) Handles Me.Load
        Response.Redirect("http://vacosqlrep12.dva.va.gov/Reports12/Pages/Report.aspx?ItemPath=/CFM/CFM_CFMIS/ProjectUpdateHisoty")
    End Sub

End Class