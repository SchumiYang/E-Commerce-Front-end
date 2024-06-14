<%@page contentType="text/html"%> 
<%@page pageEncoding="UTF-8"%>
<%@ page import = "java.sql.*" %>
<%@ page import = "java.net.URLEncoder"%>
<%@ page import = "java.net.URLDecoder"%>
<%@ page import = "java.nio.charset.StandardCharsets" %>

<html>
    <head><title>Login Success!</title></head>
    <body>
    <%
		String username = request.getParameter("username");
		String password = request.getParameter("password");
		String redirectUrl = "/E-Commerce-Front-end/" +  request.getParameter("redirectUrl");
		try {
            Class.forName("com.mysql.jdbc.Driver");	  
			String url="jdbc:mysql://localhost/members";
			Connection con=DriverManager.getConnection(url,"root","1234"); 
			
	        if(con.isClosed()){
                out.println("連線建立失敗");
			}
			
            else{	
				String sql = "SELECT * FROM `members` WHERE `username`=? AND `pwd`=?";
				PreparedStatement pstmt = null;
				pstmt=con.prepareStatement(sql);
				pstmt.setString(1,username);
				pstmt.setString(2,password);
			
				ResultSet dataset = pstmt.executeQuery();
				if(dataset.next()){
					Cookie usernameCookie = new Cookie("username",username);
					Cookie nameCookie = new Cookie("username",dataset.getString("username"));
					Cookie idCookie = new Cookie("id",dataset.getString("id"));
					usernameCookie.setMaxAge(-1);
					usernameCookie.setPath("/");
					nameCookie.setMaxAge(-1);
					nameCookie.setPath("/");
					idCookie.setMaxAge(-1);
					idCookie.setPath("/");
					response.addCookie(usernameCookie);
					response.addCookie(nameCookie);
					response.addCookie(idCookie);

					con.close();//結束資料庫連結
					out.print(redirectUrl);
					response.sendRedirect(redirectUrl);
				}
				
				else{
					con.close();//結束資料庫連結
					out.print(redirectUrl);
					response.sendRedirect("login.jsp?&message=Username or password incorrect, please try again.");	
				}
			}
		}        
		catch (SQLException sExec) {
			out.print(sExec);
		}  

    %>

    </body>
</html>
