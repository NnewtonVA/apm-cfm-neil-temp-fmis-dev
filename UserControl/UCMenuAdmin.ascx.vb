Public Class UCMenuAdmin
    Inherits System.Web.UI.UserControl

    Protected Sub Page_Load(ByVal sender As Object, ByVal e As System.EventArgs) Handles Me.Load

    End Sub

   
    Protected Sub mFactsheet_MenuItemDataBound(sender As [Object], e As MenuEventArgs)
        If e.Item.NavigateUrl.Contains("?") Then
            e.Item.Target = "_blank"
        End If    
    End Sub

End Class