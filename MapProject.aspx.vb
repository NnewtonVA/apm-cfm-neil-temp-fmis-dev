Imports System
Imports System.Collections.Generic
Imports System.Linq
Imports System.Web
Imports System.Web.UI
Imports System.Web.UI.WebControls
Imports System.Web.Services
Imports System.Collections
Imports System.Data.SqlClient
Imports System.Data
Imports System.Configuration

Public Class MapProject
    Inherits System.Web.UI.Page

    Protected Sub Page_Load(ByVal sender As Object, ByVal e As System.EventArgs) Handles Me.Load

    End Sub
    <WebMethod()> Public Shared Function GetCities() As List(Of Hashtable)
        Dim htList As New List(Of Hashtable)()
        Dim ht As Hashtable
        Dim con As New SqlConnection(ConfigurationManager.ConnectionStrings("MainConn").ConnectionString)
        If con.State = ConnectionState.Closed Then
            con.Open()
        End If

        Dim cmd As New SqlCommand("SELECT C.latitude As latitude, C.longitude As longitude, P.city AS City FROM citydata AS C RIGHT OUTER JOIN vw_ProjectCopy AS P ON C.state = P.stateCode AND C.city = P.city WHERE (P.subProjectFlag = 0) AND (P.status_fk NOT IN (9, 12, 7, 18, 16, 3, 8))", con)
        Dim adp As New SqlDataAdapter(cmd)
        Dim ds As New DataSet()
        adp.Fill(ds)
        If ds IsNot Nothing Then
            If ds.Tables.Count > 0 Then
                For Each dr As DataRow In ds.Tables(0).Rows
                    Try
                        ht = New Hashtable()
                        ht.Add("latitude", dr("latitude").ToString())
                        ht.Add("longitude", dr("longitude").ToString())
                        ht.Add("City", dr("City").ToString())
                        htList.Add(ht)
                    Catch
                    End Try
                Next
            End If
        End If
        Return htList
    End Function
End Class