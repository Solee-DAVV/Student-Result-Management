<%@page import ="project.ConnectionProvider" %>
<%@page import ="java.sql.*" %>
<%
    String rollno = request.getParameter("rollno");
    String s1 = request.getParameter("s1");
    String s2 = request.getParameter("s2");
    String s3 = request.getParameter("s3");
    String s4 = request.getParameter("s4");
    String s5 = request.getParameter("s5");
    String s6 = request.getParameter("s6");
    String s7 = request.getParameter("s7");
    
    try{
    Connection con=ConnectionProvider.getCon();
    Statement st=con.createStatement();
    st.executeUpdate("insert into Result values('"+rollno+"','"+s1+"','"+s2+"','"+s3+"','"+s4+"','"+s5+"','"+s6+"','"+s7+"')");
     
    response.sendRedirect("adminHome.jsp");
    
    }
    catch(Exception e)
    {
    out.println(e);
    }
    %>