<%@page contentType="text/html"%> 
<%@page pageEncoding="UTF-8"%>
<%@page import = "java.sql.*"%> 
<%
    request.setCharacterEncoding("UTF-8");
    String user = "root";
    String password = "1234";
    Connection con = null;
    PreparedStatement pstmt = null;
    String sql = null;
    try {
        Class.forName("com.mysql.cj.jdbc.Driver");
        con = DriverManager.getConnection("jdbc:mysql://localhost:3306/members?serverTimezone=UTC", user, password);
    } catch (Exception e) {
        e.printStackTrace();
        throw new ServletException("Database connection error.");
    }
%>
