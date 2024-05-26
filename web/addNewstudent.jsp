<%@page import ="project.ConnectionProvider" %>
<%@page import ="java.sql.*" %>
<%
    String course = request.getParameter("course");
    String branch = request.getParameter("branch");
    String rollno = request.getParameter("rollno");
    String name = request.getParameter("name");
    String fathername = request.getParameter("fathername");
    String gender = request.getParameter("gender");
    
    try{
    Connection con=ConnectionProvider.getCon();
    Statement st=con.createStatement();
    st.executeUpdate("insert into Student values('"+course+"','"+branch+"','"+rollno+"','"+name+"','"+fathername+"','"+gender+"')");
     
    response.sendRedirect("adminHome.jsp");
    
    }
    catch(Exception e)
    {
    out.println(e);
    }
    %>