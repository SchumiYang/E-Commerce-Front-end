<%@page contentType="text/html"%> 
<%@page pageEncoding="UTF-8"%>
<%@page import = "java.sql.*" %>

<html>
    <head><title>Success!</title></head>
    <body>
    <%
		String username = request.getParameter("username");
		String password = request.getParameter("password");
		String confirmPassword = request.getParameter("confirmPassword");
		String email = request.getParameter("email");
		String address = request.getParameter("address");

		try { 
            Class.forName("com.mysql.jdbc.Driver");	  
			String url="jdbc:mysql://localhost/members";
			Connection con=DriverManager.getConnection(url,"root","1234");   				
			if(con.isClosed()){
				out.println("連線建立失敗");
			}
			else{		
				String sql = "INSERT INTO `members` (`username`, `pwd`, `email`, `address`) " +
							 "VALUES ('"+username+"', '"+password+"', '"+email+"', '"+address+"')";
				int no=con.createStatement().executeUpdate(sql); 
				if (no>0){
					out.println("<script>alert('註冊成功!');location.href='login.html'</script>");
				}
				con.close();
            }
		}      
		catch (SQLException sExec) {
			out.print(sExec);
			response.sendRedirect("register.jsp?messageUsername=" + "The username has been used, please choose other username." + "&duplicated=true");
		}     
    %>

    </body>
</html>
    </body>
</html>
