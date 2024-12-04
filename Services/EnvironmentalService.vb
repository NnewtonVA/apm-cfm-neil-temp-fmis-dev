Imports System.Data.SqlClient
Public Class EnvironmentalService

    Public Function GetProspectusScheduleforEnvironmental(projectpk, milestonenumber) As Object 'get note
        Dim strResult As String
        Dim connStr As String = ConfigurationManager.ConnectionStrings("MainConn").ConnectionString
        Using conn As New SqlConnection(connStr)
            Dim dt As New DataTable

            Dim com As New SqlCommand With {
                            .Connection = conn,
                            .CommandType = CommandType.StoredProcedure,
                            .CommandText = "GetProspectusSchedule"
            }
            com.Parameters.AddWithValue("@project_pk", SqlDbType.Int).Value = projectpk
            com.Parameters.AddWithValue("@milestone_pk", SqlDbType.Int).Value = milestonenumber

            com.Parameters.Add("@Result", SqlDbType.NVarChar, 200)
            com.Parameters("@Result").Direction = ParameterDirection.Output
            conn.Open()
            com.ExecuteNonQuery()
            strResult = com.Parameters("@Result").Value.ToString
            If strResult = "Jan  1 1900 12:00AM" Then
                conn.Close()
            Else
                Return strResult
                conn.Close()
            End If

        End Using
    End Function
    Public Function GetOriginalScheduleforEnvironmental(projectpk, milestonenumber) As Object 'get note
        Dim strResult As String
        Dim connStr As String = ConfigurationManager.ConnectionStrings("MainConn").ConnectionString
        Using conn As New SqlConnection(connStr)
            Dim dt As New DataTable

            Dim com As New SqlCommand With {
                            .Connection = conn,
                            .CommandType = CommandType.StoredProcedure,
                            .CommandText = "GetOriginalSchedule"
            }
            com.Parameters.AddWithValue("@project_pk", SqlDbType.Int).Value = projectpk
            com.Parameters.AddWithValue("@milestone_pk", SqlDbType.Int).Value = milestonenumber

            com.Parameters.Add("@Result", SqlDbType.NVarChar, 200)
            com.Parameters("@Result").Direction = ParameterDirection.Output
            conn.Open()
            com.ExecuteNonQuery()
            strResult = com.Parameters("@Result").Value.ToString
            If strResult = "Jan  1 1900 12:00AM" Then
                conn.Close()
            Else
                Return strResult
                conn.Close()
            End If

        End Using
    End Function

    Public Function GetRevisedScheduleforEnvironmental(projectpk, milestonenumber) As Object 'get note
        Dim strResult As String
        Dim connStr As String = ConfigurationManager.ConnectionStrings("MainConn").ConnectionString
        Using conn As New SqlConnection(connStr)
            Dim dt As New DataTable

            Dim com As New SqlCommand With {
                            .Connection = conn,
                            .CommandType = CommandType.StoredProcedure,
                            .CommandText = "GetRevisedSchedule"
            }
            com.Parameters.AddWithValue("@project_pk", SqlDbType.Int).Value = projectpk
            com.Parameters.AddWithValue("@milestone_pk", SqlDbType.Int).Value = milestonenumber

            com.Parameters.Add("@Result", SqlDbType.NVarChar, 200)
            com.Parameters("@Result").Direction = ParameterDirection.Output
            conn.Open()
            com.ExecuteNonQuery()
            strResult = com.Parameters("@Result").Value.ToString
            If strResult = "Jan  1 1900 12:00AM" Then
                conn.Close()
            Else
                Return strResult
                conn.Close()
            End If

        End Using
    End Function

    Public Function GetActualScheduleforEnvironmental(projectpk, milestonenumber) As Object 'get note
        Dim strResult As String
        Dim connStr As String = ConfigurationManager.ConnectionStrings("MainConn").ConnectionString
        Using conn As New SqlConnection(connStr)
            Dim dt As New DataTable

            Dim com As New SqlCommand With {
                            .Connection = conn,
                            .CommandType = CommandType.StoredProcedure,
                            .CommandText = "GetActualSchedule"
            }
            com.Parameters.AddWithValue("@project_pk", SqlDbType.Int).Value = projectpk
            com.Parameters.AddWithValue("@milestone_pk", SqlDbType.Int).Value = milestonenumber

            com.Parameters.Add("@Result", SqlDbType.NVarChar, 200)
            com.Parameters("@Result").Direction = ParameterDirection.Output
            conn.Open()
            com.ExecuteNonQuery()
            strResult = com.Parameters("@Result").Value.ToString
            If strResult = "Jan  1 1900 12:00AM" Then
                conn.Close()
            Else
                Return strResult
                conn.Close()
            End If

        End Using
    End Function


    Public Function InsertScheduleforEnvironmental(prospectus, original, revised, actual, milestone, projectpk, struser) As Object 'get note
        Dim connStr As String = ConfigurationManager.ConnectionStrings("MainConn").ConnectionString
        'varId = Convert.ToString(Request.QueryString("project_pk"))
        'Dim struser As String = lblUserNm.Text
        Using conn As New SqlConnection(connStr)
            Dim com As New SqlCommand With {
                            .Connection = conn,
                            .CommandType = CommandType.StoredProcedure,
                            .CommandText = "InsertScheduleforEnvironmental"
            }
            com.Parameters.AddWithValue("@project_pk", SqlDbType.Int).Value = projectpk
            If prospectus = "" Then
                com.Parameters.AddWithValue("@prospectus", SqlDbType.VarChar).Value = DBNull.Value
            Else
                com.Parameters.AddWithValue("@prospectus", SqlDbType.VarChar).Value = prospectus
            End If
            If original = "" Then
                com.Parameters.AddWithValue("@original", SqlDbType.VarChar).Value = DBNull.Value
            Else
                com.Parameters.AddWithValue("@original", SqlDbType.VarChar).Value = original
            End If
            If revised = "" Then
                com.Parameters.AddWithValue("@revised", SqlDbType.VarChar).Value = DBNull.Value
            Else
                com.Parameters.AddWithValue("@revised", SqlDbType.VarChar).Value = revised
            End If
            If actual = "" Then
                com.Parameters.AddWithValue("@actual", SqlDbType.VarChar).Value = DBNull.Value
            Else
                com.Parameters.AddWithValue("@actual", SqlDbType.VarChar).Value = actual
            End If
            com.Parameters.AddWithValue("@milestone_pk", SqlDbType.VarChar).Value = milestone
            com.Parameters.AddWithValue("@mainProject_pk", SqlDbType.VarChar).Value = projectpk
            com.Parameters.AddWithValue("@IsActualProspectus", SqlDbType.VarChar).Value = ""
            com.Parameters.Add("@User", SqlDbType.VarChar).Value = struser
            conn.Open()
            com.ExecuteNonQuery()
            conn.Close()
        End Using
    End Function


    Public Function InsertScheduleforEnvironmentalTemp(prospectus, original, revised, actual, milestone, projectpk, struser) As Object 'get note
        Dim connStr As String = ConfigurationManager.ConnectionStrings("MainConn").ConnectionString
        'varId = Convert.ToString(Request.QueryString("project_pk"))
        'Dim struser As String = lblUserNm.Text
        Using conn As New SqlConnection(connStr)
            Dim com As New SqlCommand With {
                            .Connection = conn,
                            .CommandType = CommandType.StoredProcedure,
                            .CommandText = "InsertScheduleforEnvironmentalTemp"
            }
            com.Parameters.AddWithValue("@project_pk", SqlDbType.Int).Value = projectpk
            If prospectus = "" Then
                com.Parameters.AddWithValue("@prospectus", SqlDbType.VarChar).Value = DBNull.Value
            Else
                com.Parameters.AddWithValue("@prospectus", SqlDbType.VarChar).Value = prospectus
            End If
            If original = "" Then
                com.Parameters.AddWithValue("@original", SqlDbType.VarChar).Value = DBNull.Value
            Else
                com.Parameters.AddWithValue("@original", SqlDbType.VarChar).Value = original
            End If
            If revised = "" Then
                com.Parameters.AddWithValue("@revised", SqlDbType.VarChar).Value = DBNull.Value
            Else
                com.Parameters.AddWithValue("@revised", SqlDbType.VarChar).Value = revised
            End If
            If actual = "" Then
                com.Parameters.AddWithValue("@actual", SqlDbType.VarChar).Value = DBNull.Value
            Else
                com.Parameters.AddWithValue("@actual", SqlDbType.VarChar).Value = actual
            End If
            com.Parameters.AddWithValue("@milestone_pk", SqlDbType.VarChar).Value = milestone
            com.Parameters.AddWithValue("@mainProject_pk", SqlDbType.VarChar).Value = projectpk
            com.Parameters.AddWithValue("@IsActualProspectus", SqlDbType.VarChar).Value = ""
            com.Parameters.Add("@User", SqlDbType.VarChar).Value = struser
            conn.Open()
            com.ExecuteNonQuery()
            conn.Close()
        End Using
    End Function


    Public Function ConvertToInteger(ByRef value As String) As Integer
        If String.IsNullOrEmpty(value) Then
            value = "0"
        End If
        Return Convert.ToInt32(value)
    End Function

End Class
