<!DOCTYPE html>
<%@page contentType="text/html"%> 
<%@page pageEncoding="UTF-8"%>
<%@ page import = "java.sql.*" %>
<%@ page import = "java.net.URLEncoder"%>

<html lang="en">
<head>
    <meta charset="UTF-8">
    <meta name="viewport" content="width=device-width, initial-scale=1.0">
    <title>Login Page</title>
    <link rel="stylesheet" href="../assets/CSS/login.css">
    <script src="https://cdnjs.cloudflare.com/ajax/libs/jquery/3.7.1/jquery.min.js"></script>
    <link rel="preconnect" href="https://fonts.googleapis.com">
    <link rel="preconnect" href="https://fonts.gstatic.com" crossorigin>
    <link href="https://fonts.googleapis.com/css2?family=Noto+Sans:ital,wght@0,100..900;1,100..900&display=swap" rel="stylesheet">
</head>
<body>
    <!--Navigation bar-->
    <div id="nav-placeholder">

    </div>

    <script>
    $(function(){
    $("#nav-placeholder").load("nav.html");
    });
    </script>

    <%
    String message=request.getParameter("message");
    String redirectUrl = request.getParameter("redirectUrl");
    if(redirectUrl == null || redirectUrl.equals("")){
        redirectUrl = "index.html";
    }

    String encodedUrl = URLEncoder.encode(redirectUrl, "UTF-8");
    %>

    <script>
    var msg = "<%=request.getParameter("message")%>";
    console.log(typeof(msg));
    if (msg !== "null"){
        alert(msg);
    }
    </script>

    <main>
        <div class="container">
            <div class="left">
                <h1>Login</h1>
                <p>Get Your Own VPS Server</p>
                <a href="register.jsp">First Time? Click Here To Register</a>
            </div>
            <div class="right">
                <form class="input-form" action="checkLogin.jsp?&redirectUrl=<%=encodedUrl%>" method = "post">
                    <label for="username">Username</label>
                    <input type="text" id="username" name="username" required>
                    <label for="password">Password</label>
                    <input type="password" id="password" name="password" required>
                    <button type="submit">Submit</button>
                </form>
                <a href="register.jsp" class="hidden">First Time? Click Here To Register</a>
            </div>
            
        </div>
    </main> 
    <footer>
        <iframe src="/E-Commerce-Front-end/pages/footer.html" class="footer"></iframe>
    </footer>
</body>
</html>
