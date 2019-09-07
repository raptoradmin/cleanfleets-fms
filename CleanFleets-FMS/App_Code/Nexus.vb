Imports Microsoft.VisualBasic



Public Class CommonFunctions

    Public Shared Function FormatPhone(ByVal phoneNo As Object) As String

        Dim formattedPhone As String = phoneNo.ToString

        'Extracting numbers from the string

        formattedPhone = Regex.Replace(formattedPhone, "[^0-9]", "")

        'The format is in third parameter of the replace function

        formattedPhone = Regex.Replace(formattedPhone, "(\d{3})(\d{3})(\d{4})", "($1) $2-$3")

        Return If(String.IsNullOrWhiteSpace(formattedPhone), String.Empty, formattedPhone)

    End Function

End Class
