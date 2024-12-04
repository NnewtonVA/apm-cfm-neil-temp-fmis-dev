Imports System.Configuration
Imports System.Data
Imports System.Data.SqlClient
Imports System.Web.Services
Imports AjaxControlToolkit
Imports System.Web.UI.HtmlControls
Imports System.DirectoryServices
Imports System.Net.Mail
Imports System.Net


Public Class StationDetails
    Inherits System.Web.UI.Page

    Dim ConnStr As String = ConfigurationManager.ConnectionStrings("MainConn").ConnectionString
    Dim strLoggedUser As String
    ''' <summary>
    ''' strLoggedUser will get the username from the session. Also, the VA Logo at the top will be hidden for this page.
    ''' </summary>
    Protected Sub Page_Load(ByVal sender As Object, ByVal e As System.EventArgs) Handles Me.Load
        strLoggedUser = Session("UserNm")
        Dim menu1 As ContentPlaceHolder = CType(Master.FindControl("cphMainMenu"), ContentPlaceHolder)
        menu1.Visible = False

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
    ''' Clicking the Save button in station detail form will run the UpdateStation stored procedure 
    ''' to update the station infromation.
    ''' </summary>
    Protected Sub btnEdtStn_Click(sender As Object, e As EventArgs)
        Dim varStnId As String = Convert.ToString(Request.QueryString("station_pk"))
        Dim varStnNo As String = CType(fvStationDatails.FindControl("txtEdtStnNo"), TextBox).Text
        Dim varStnName As String = CType(fvStationDatails.FindControl("txtEdtStnName"), TextBox).Text
        Dim varStnDesc As String = CType(fvStationDatails.FindControl("txtEdtStnDesc"), TextBox).Text
        Dim varStnAddress As String = CType(fvStationDatails.FindControl("txtEdtAddress"), TextBox).Text
        Dim varStnCity As String = CType(fvStationDatails.FindControl("txtEdtCity"), TextBox).Text
        Dim varStnZip As String = CType(fvStationDatails.FindControl("txtEdtZip"), TextBox).Text
        Dim varStnZip4 As String = CType(fvStationDatails.FindControl("txtEdtZip4"), TextBox).Text
        Dim varAdminOffice As String = CType(fvStationDatails.FindControl("ddlEdtAdminOffice"), DropDownList).SelectedValue
        Dim varState As String = CType(fvStationDatails.FindControl("ddlEdtState"), DropDownList).SelectedValue
        Dim varRegion As String = CType(fvStationDatails.FindControl("ddlEdtRegion"), DropDownList).SelectedValue
        Dim varDelete As CheckBox = CType(fvStationDatails.FindControl("cbEdtInactv"), CheckBox)

        Using conn As New SqlConnection(ConnStr)
            Dim cmd As New SqlCommand
            cmd.Connection = conn
            cmd.CommandText = "UpdateStation"
            cmd.CommandType = CommandType.StoredProcedure

            cmd.Parameters.AddWithValue("@StationId", DbNullOrStringValue(varStnId))
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

    End Sub
    ''' <summary>
    ''' Clicking the Exit button will close this form and open the station search page
    ''' </summary>
    Protected Sub btnExitStn_Click(sender As Object, e As EventArgs)
        Response.Redirect("StationInfo.aspx")
    End Sub
End Class