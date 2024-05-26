<%@page import="project.ConnectionProvider" %>
<%@page import="java.sql.*" %>
<%@page contentType="text/html;charset=UTF-8" %>

<%
    String rollno = request.getParameter("rollno");
    if (rollno == null || rollno.trim().isEmpty()) {
        response.sendRedirect("errorDgiOneView.html");
        return;
    }

    Connection con = null;
    PreparedStatement pst = null;
    ResultSet rs = null;
    try {
        con = ConnectionProvider.getCon();
        String query = "SELECT Student.courseName, Student.branchName, Student.rollno, Student.name, Student.fatherName, Student.gender, " +
                       "Result.NAS101, Result.NAS102, Result.NAS103, Result.NEE101, Result.NEC101, Result.NAS152, Result.NAS151 " +
                       "FROM Student INNER JOIN Result ON Student.rollno = Result.rollno WHERE Student.rollno = ?";
        pst = con.prepareStatement(query);
        pst.setString(1, rollno);
        rs = pst.executeQuery();
        
        if (rs.next()) {
%>

<!DOCTYPE html>
<html lang="en">
<head>
    <meta charset="UTF-8">
    <title>Student Result</title>
    <style>
        @import url('https://fonts.googleapis.com/css?family=Roboto:400,500,300,700');
        
        body {
            background: linear-gradient(to right, #25c481, #25b7c4);
            font-family: 'Roboto', sans-serif;
        }
        table {
            width: 100%;
            table-layout: fixed;
            border-collapse: collapse;
        }
        th, td {
            padding: 15px;
            text-align: left;
        }
        th {
            background: #625D5D;
            color: white;
        }
        tbody tr:nth-child(odd) {
            background: #D1D0CE;
        }
        .footer {
            text-align: right;
            font-weight: bold;
        }
        .new1 {
            border-top: 3px solid #bbb;
        }
    </style>
</head>
<body>
    <img src="logo.png" align="left" width="150" height="150">
    <center>
        <img src="dgi.png" width="150" height="150">
        <img src="apj sir.png" align="right" width="150" height="150">
    </center>
    <a href="dgiOneView.html">Back</a>
    <hr class="new1">

    <div class="tbl-header">
        <table cellpadding="0" cellspacing="0" border="0">
            <thead>
                <tr>
                    <th>Institution Name: DGI</th>
                    <th>Course Name: <%= rs.getString("courseName") %></th>
                    <th>Branch Name: <%= rs.getString("branchName") %></th>
                    <th>Roll No: <center><%= rs.getString("rollno") %></center></th>
                </tr>
            </thead>
            <thead>
                <tr>
                    <th>Name: <%= rs.getString("name") %></th>
                    <th>Father Name: <%= rs.getString("fatherName") %></th>
                    <th>Gender: <%= rs.getString("gender") %></th>
                    <th>
                        <center>
                            <a title="Print" alt="Print" onclick="window.print();" style="cursor:pointer;">
                                <img src="print.png">
                            </a>
                        </center>
                    </th>
                </tr>
            </thead>
        </table>
    </div>

    <table>
        <thead>
            <tr>
                <td colspan="3">Course</td>
                <td rowspan="2">Type</td>
                <td rowspan="2">Full Marks</td>
                <td rowspan="2">Passing Marks</td>
                <td rowspan="2">Obtained Marks</td>
            </tr>
            <tr>
                <td>Code</td>
                <td colspan="2">Name</td>
            </tr>
        </thead>
        <tbody>
            <tr>
                <td>NAS101</td>
                <td colspan="2">DSA</td>
                <td>Theory</td>
                <td>100</td>
                <td>30</td>
                <td><%= rs.getInt("NAS101") %></td>
            </tr>
            <tr>
                <td>NAS102</td>
                <td colspan="2">OS</td>
                <td>Theory</td>
                <td>100</td>
                <td>30</td>
                <td><%= rs.getInt("NAS102") %></td>
            </tr>
            <tr>
                <td>NAS103</td>
                <td colspan="2">CA</td>
                <td>Theory</td>
                <td>100</td>
                <td>30</td>
                <td><%= rs.getInt("NAS103") %></td>
            </tr>
            <tr>
                <td>NEE101</td>
                <td colspan="2">DBMS</td>
                <td>Theory</td>
                <td>100</td>
                <td>30</td>
                <td><%= rs.getInt("NEE101") %></td>
            </tr>
            <tr>
                <td>NEC101</td>
                <td colspan="2">JAVA</td>
                <td>Theory</td>
                <td>100</td>
                <td>30</td>
                <td><%= rs.getInt("NEC101") %></td>
            </tr>
            <tr>
                <td>NAS152</td>
                <td colspan="2">ALGO</td>
                <td>Practical</td>
                <td>30</td>
                <td>15</td>
                <td><%= rs.getInt("NAS152") %></td>
            </tr>
            <tr>
                <td>NAS151</td>
                <td colspan="2">CN</td>
                <td>Practical</td>
                <td>30</td>
                <td>15</td>
                <td><%= rs.getInt("NAS151") %></td>
            </tr>
        </tbody>
        <tfoot>
            <tr>
                <td colspan="4" class="footer">Total Marks</td>
                <td>560</td>
                <td>180</td>
                <td><%
                    int sum = rs.getInt("NAS101") + rs.getInt("NAS102") + rs.getInt("NAS103") + 
                              rs.getInt("NEE101") + rs.getInt("NEC101") + rs.getInt("NAS152") + 
                              rs.getInt("NAS151");
                    out.println(sum);
                %></td>
            </tr>
            <tr>
                <td colspan="4" class="footer">Percentage</td>
                <td colspan="3"><%= (sum * 100) / 560 %></td>
            </tr>
        </tfoot>
    </table>
    <hr class="new1">
    <center>
        <h6>Note: Institution doesn't own for the errors or omissions, if any, in this statement.</h6>
        <h6>Designed & Developed by MCA Days Team</h6>
        <h6>MCA days :: 2015-2020</h6>
    </center>
    <hr class="new1">
</body>
</html>

<%
        } else {
            response.sendRedirect("errorDgiOneView.html");
        }
    } catch (Exception e) {
        e.printStackTrace();
        response.sendRedirect("errorDgiOneView.html");
    } finally {
        if (rs != null) try { rs.close(); } catch (SQLException ignored) {}
        if (pst != null) try { pst.close(); } catch (SQLException ignored) {}
        if (con != null) try { con.close(); } catch (SQLException ignored) {}
    }
%>
