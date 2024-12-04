Public Class UCMenuSustainability
    Inherits System.Web.UI.UserControl

    Protected Sub Page_Load(ByVal sender As Object, ByVal e As System.EventArgs) Handles Me.Load

    End Sub

    Protected Sub mSearch_MenuItemDataBound(sender As [Object], e As MenuEventArgs)
        If e.Item.NavigateUrl.Contains("?") Then
            e.Item.Target = "_blank"
        End If
    End Sub

End Class