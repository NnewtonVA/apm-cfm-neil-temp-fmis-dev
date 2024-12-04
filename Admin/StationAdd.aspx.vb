Imports System.Configuration
Imports System.Data
Imports System.Data.SqlClient
Imports System.Web.Services
Imports AjaxControlToolkit
Imports System.Web.UI.HtmlControls
Imports System.DirectoryServices
Imports System.Net.Mail
Imports System.Net

Public Class StationAdd
    Inherits System.Web.UI.Page

    Dim ConnStr As String = ConfigurationManager.ConnectionStrings("MainConn").ConnectionString
    Dim strLoggedUser As String
    ''' <summary>
    ''' Get the logged on user name. The VA Logo at the top will be hidden for this page when the page loads.
    ''' </summary>
    Protected Sub Page_Load(ByVal sender As Object, ByVal e As System.EventArgs) Handles Me.Load
        strLoggedUser = Session("UserNm")
        Dim menu1 As ContentPlaceHolder = CType(Master.FindControl("cphMainMenu"), ContentPlaceHolder)
        menu1.Visible = False
    End Sub
    ''' <summary>
    ''' Clicking the Exit button will transfer the user to the search station page.
    ''' </summary>
    Protected Sub btnExitStn_Click(sender As Object, e As EventArgs)
        Response.Redirect("StationInfo.aspx")
    End Sub
    ''' <summary>
    ''' This function is to insert null in the database in case the text box is empty.
    ''' </summary>
    Public Function DbNullOrStringValue(ByVal value As String) As Object
        If String.IsNullOrEmpty(value) Then
            Return DBNull.Value
        Else
            Return value
        End If
    End Function
    ''' <summary>
    ''' Clicking the Save button will run the SP AddStation and add a new record in the table.
    ''' </summary>
    Protected Sub btnAddStn_Click(sender As Object, e As EventArgs)

        Dim varStnNo As String = CType(fvAddStn.FindControl("txtAddStnNo"), TextBox).Text
        Dim varStnName As String = CType(fvAddStn.FindControl("txtAddStnName"), TextBox).Text
        Dim varStnDesc As String = CType(fvAddStn.FindControl("txtAddStnDesc"), TextBox).Text
        Dim varStnAddress As String = CType(fvAddStn.FindControl("txtAddAddress"), TextBox).Text
        Dim varStnCity As String = CType(fvAddStn.FindControl("txtAddCity"), TextBox).Text
        Dim varStnZip As String = CType(fvAddStn.FindControl("txtAddZip"), TextBox).Text
        Dim varStnZip4 As String = CType(fvAddStn.FindControl("txtAddZip4"), TextBox).Text
        Dim varAdminOffice As String = CType(fvAddStn.FindControl("ddlAddAdminOffice"), DropDownList).SelectedValue
        Dim varState As String = CType(fvAddStn.FindControl("ddlAddState"), DropDownList).SelectedValue
        Dim varRegion As String = CType(fvAddStn.FindControl("ddlAddRegion"), DropDownList).SelectedValue
        Dim varDelete As CheckBox = CType(fvAddStn.FindControl("cbAddInactv"), CheckBox)

        Using conn As New SqlConnection(ConnStr)
            Dim cmd As New SqlCommand
            cmd.Connection = conn
            cmd.CommandText = "AddStation"
            cmd.CommandType = CommandType.StoredProcedure

            cmd.Parameters.AddWithValue("@StnNo", DbNullOrStringValue(varStnNo))
            cmd.Parameters.AddWithValue("@StnName", DbNullOrStringValue(varStnName))
            cmd.Parameters.AddWithValue("@StnDesc", DbNullOrStringValue(varStnDesc))
            cmd.Parameters.AddWithValue("@Address", DbNullOrStringValue(varStnAddress))
            cmd.Parameters.AddWithValue("@City", DbNullOrStringValue(varStnCity))
            cmd.Parameters.AddWithValue("@Zip", DbNullOrStringValue(varStnZip))
            cmd.Parameters.AddWithValue("@Zip4", DbNullOrStringValue(varStnZip4))
            cmd.Parameters.AddWithValue("@User", DbNullOrStringValue(strLoggedUser))
            cmd.Parameters.AddWithValue("@Admin", DbNullOrStringValue(varAdminOffice))
            cmd.Parameters.AddWithValue("@State", DbNullOrStringValue(varState))
            cmd.Parameters.AddWithValue("@region", DbNullOrStringValue(varRegion))
            If varDelete.Checked Then
                cmd.Parameters.AddWithValue("@Deleted", SqlDbType.Bit).Value = 1
            Else
                cmd.Parameters.AddWithValue("@Deleted", SqlDbType.Bit).Value = 0
            End If
            cmd.Parameters.Add("@Result", SqlDbType.VarChar, 100)
            cmd.Parameters("@Result").Direction = ParameterDirection.Output

            conn.Open()
            cmd.ExecuteNonQuery()
            conn.Close()
            lblResult.Text = cmd.Parameters("@Result").Value.ToString()

        End Using
        fvAddStn.DataBind()
    End Sub
End Class