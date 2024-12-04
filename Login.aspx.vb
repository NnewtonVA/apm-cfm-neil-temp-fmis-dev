Imports System.IO
Imports System.Configuration
Imports System.Data
Imports System.Data.SqlClient

Public Class Login
    Inherits System.Web.UI.Page

    ''' <summary>
    ''' The Homw and Search Icons will be hidden for this page.
    ''' </summary>
    Protected Sub Page_Load(ByVal sender As Object, ByVal e As System.EventArgs) Handles Me.Load
        Dim menu As ContentPlaceHolder = CType(Master.FindControl("cphQuickMenu"), ContentPlaceHolder)
        menu.Visible = False
    End Sub
   
    
End Class