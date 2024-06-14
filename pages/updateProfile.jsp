<%@page contentType="text/html"%> 
<%@page pageEncoding="UTF-8"%>
<%@ page import = "java.sql.*" %>
<%@ page import = "java.net.URLEncoder"%>
<%@ page import = "java.net.URLDecoder"%>
<%@ page import = "java.nio.charset.StandardCharsets" %>

<%
	String id = "";
	
	Cookie[] cookies = request.getCookies();
	if(cookies != null){
		int count = cookies.length;
		for(int i=0; i < count; i++){
			if(cookies[i].getName().equals("id")){
				id = cookies[i].getValue();
				//out.print("get cookie memberID: " + memberID);
			}
		}
	}
	
	String username = request.getParameter("username");
	String password = request.getParameter("password");
    String email = request.getParameter("email");
	String address = request.getParameter("address");
	// out.print(name + gender + birthday + left + right + email);
	
	try {
		Class.forName("com.mysql.jdbc.Driver");
    try {
        String url = "jdbc:mysql://localhost/?serverTimezone=UTC";
        Connection con = DriverManager.getConnection(url, "root", "1234");
        if (con.isClosed()) {
            out.println("連線建立失敗");
        } else {
            con.createStatement().execute("use `members`");
			String sql = "UPDATE `members` SET `username`=?, `pwd`=?, `email`=?, `address`=? WHERE `id`=?";
			PreparedStatement pstmt = null;
			pstmt=con.prepareStatement(sql);
			pstmt.setString(1,username);
			pstmt.setString(2,password);
			pstmt.setString(3,email);
			pstmt.setString(4,address);
			pstmt.setString(5,id);
			
			pstmt.executeUpdate();
			con.close();
			
			response.sendRedirect("profile.jsp?returnMessage=Change successful!");
		}
    } catch (SQLException e){
        out.println("SQL錯誤: " + e.toString());
    }
	} catch (ClassNotFoundException err){
		out.println("Class錯誤: " + err.toString());
	}
%>