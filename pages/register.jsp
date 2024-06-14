<!DOCTYPE html>
<%@page contentType="text/html"%> 
<%@page pageEncoding="UTF-8"%>
<%@ page import = "java.sql.*" %>
<html lang="en">
<head>
    <meta charset="UTF-8">
    <meta name="viewport" content="width=device-width, initial-scale=1.0">
    <title>Register Page</title>
    <link rel="stylesheet" href="../assets/CSS/reg.css">
    <link rel="preconnect" href="https://fonts.googleapis.com">
    <link rel="preconnect" href="https://fonts.gstatic.com" crossorigin>
    <script src="https://cdnjs.cloudflare.com/ajax/libs/jquery/3.7.1/jquery.min.js"></script>
    <link href="https://fonts.googleapis.com/css2?family=Noto+Sans:ital,wght@0,100..900;1,100..900&display=swap" rel="stylesheet">
</head>
<body>
    <!--Navigation bar-->
    <div id="nav-placeholder">

    </div>

    <script>
    $(function(){
    $("#nav-placeholder").load("nav.jsp");
    });
    </script>

    <%
    String username = request.getParameter("username");
    String password = request.getParameter("password");
    String email = request.getParameter("email");
    String address = request.getParameter("address");

    boolean isDup = false;
    if(request.getParameter("duplicated") != null){
        if(request.getParameter("duplicated").equals("true")){
            isDup = Boolean.parseBoolean(request.getParameter("duplicated"));

        }
    }

    %>
    <script>
    var result = "<%=request.getParameter("duplicated")%>";
    if (result == "true"){
        var msg = "<%=request.getParameter("messageUsername")%>";
        alert(msg);
    }
    </script>

    <main>
        <div class="container">
            <div class="left">
                <h1>Register</h1>
                <p>Start Your Shopping Now</p>
                <a href="login.jsp">Already Have An Account? Click Here</a>
            </div>
            <div class="right">
                <form class="input-form" action="checkRegister.jsp" method="post">
                    <!-- <label for="username">Username</label> -->
                    <input type="text" placeholder="Enter Username" id="username" name="username" value="" required>
                    <!-- <label for="password">Password</label> -->
                    <input type="password" placeholder="Enter Password" id="password" name="password" value="" required>
                    <!-- <label for="confirm-password">Confirm Password</label> -->
                    <input type="password" placeholder="Enter Password Again" id="confirm-password" name="confirm-password" required>
                    <!-- <label for="email">E-mail</label> -->
                    <input type="email" placeholder="Email you will remember" id="email" name="email" required>
                    <!-- <label for="address">Address</label> -->
                    <input type="text" placeholder="Enter Address" id="address" name="address" required>
                    <br><br>
                    <button type="submit">Submit</button>
                    <button type="reset">Reset</button>
                </form>
                <a href="login.jsp" class="hidden">Already Have An Account? Click Here</a>
            </div>
        </div>
    </main>
    <footer>
        <iframe src="/E-Commerce-Front-end/pages/footer.jsp" class="footer"></iframe>
    </footer>
</body>
</html>
