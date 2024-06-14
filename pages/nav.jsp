<!DOCTYPE html>
<%@page contentType="text/html"%> 
<%@page pageEncoding="UTF-8"%>
<%@page import = "java.sql.*"%>
<%@page import = "java.util.Random"%>
<html lang="en">

<head>
    <meta charset="UTF-8">
    <meta name="viewport" content="width=device-width, initial-scale=1.0">
    <title>Document</title>
    <link rel="stylesheet" href="/E-Commerce-Front-end/assets/CSS/nav.css?time=<%=System.currentTimeMillis()%>">
    <link rel="preconnect" href="https://fonts.googleapis.com">
    <link rel="preconnect" href="https://fonts.gstatic.com" crossorigin>
    <script src="https://kit.fontawesome.com/9b3624985e.js" crossorigin="anonymous"></script>
    <link
        href="https://fonts.googleapis.com/css2?family=Nunito+Sans:ital,opsz,wght@0,6..12,200..1000;1,6..12,200..1000&display=swap"
        rel="stylesheet">
</head>

    <%	
        String sessionID = "";
        sessionID = request.getSession().getId();
        long millis=System.currentTimeMillis(); 
        Date date = new Date(millis);
        String username = "";
        String cartID = "";
        String id = "";
        String customerID = "";
        
        Cookie[] cookies = request.getCookies();
        if(cookies != null){
            int count = cookies.length;
            for(int i=0; i < count; i++){
                if(cookies[i].getName().equals("id")){
                    id = cookies[i].getValue();
                } else if(cookies[i].getName().equals("username")){
                    username = cookies[i].getValue();
                }
            }
        }

	    //out.print(sessionID);
	    try {
			Class.forName("com.mysql.jdbc.Driver");
			try {	
				String url="jdbc:mysql://localhost/members";
				Connection con=DriverManager.getConnection(url,"root","1234");
				if(con.isClosed())
				   out.println("連線建立失敗！");
				else{
					if(id == null || id.equals(""))
						customerID = sessionID;//注意，這邊應該是讀session存的ID
					else
						customerID = id;
					
					// try{
					// 	String sql1="INSERT IGNORE into `cart` (`customerID`,`dateCreated`)";//寫入購物車
					// 	sql1+="VALUES('"+customerID+"','"+date+"')";      
					
					// 	con.createStatement().executeUpdate(sql1);
					// }
					// catch (SQLException sExec) {
					// 	out.println("1111 錯誤！"+sExec.toString()); 
					// }
					// String sql2 = "SELECT * FROM `cart` WHERE `customerID`=?";
					// PreparedStatement pstmt = null;
					// pstmt=con.prepareStatement(sql2);
					// pstmt.setString(1,customerID);
					// ResultSet dataset = pstmt.executeQuery();
					// if(dataset.next()){
                    //     cartID = dataset.getString("cartID");
                    //     Cookie cartCookie = new Cookie("cartID",cartID);
                    //     cartCookie.setMaxAge(-1);
                    //     response.addCookie(cartCookie);
					// }
					// con.close();
				}
			}	
			catch (SQLException sExec) {
				out.println("2222 錯誤！"+sExec.toString()); 
			}
		}
        catch (ClassNotFoundException err) {
            out.println("class 錯誤！"+err.toString()); 
            }
    %>

<body class="nav">
    <header class="desktop">
        <div class="logo"><a href="/E-Commerce-Front-end/index.jsp"><img
                    src="/E-Commerce-Front-end/assets/img/logo.webp"></a></div>
        <div></div>
        <div><a href="/E-Commerce-Front-end/index.jsp">Home</a></div>
        <div><a href="/E-Commerce-Front-end/pages/aboutus.html">About Us</a></div>
        <div class="dropdown-menu">
            <div class="dropdown-icon-text">
                <div class="dropdown-text">Product</div>
                <div class="dropdown-arrow">
                    <svg height="10px" width="20px">
                        <line x1="0" y1="0" x2="10" y2="10" style="stroke:white;stroke-width:2" />
                        <line x1="10" y1="10" x2="20" y2="0" style="stroke:white;stroke-width:2" />
                    </svg>
                </div>
            </div>
            <div class="dropdown-content">
                <a href="/E-Commerce-Front-end/pages/product.jsp">App Base</a>
                <a href="/E-Commerce-Front-end/pages/product.jsp">Website</a>
                <a href="/E-Commerce-Front-end/pages/product.jsp">Database</a>
                <a href="/E-Commerce-Front-end/pages/product.jsp">AI Base</a>
                <a href="/E-Commerce-Front-end/pages/item-cus.jsp">Customized</a>
                <a href="/E-Commerce-Front-end/pages/product.jsp">See All</a>
            </div>
        </div>
        <div><a href="/E-Commerce-Front-end/pages/location.html">Location</a></div>
        <div class="search-bar">
            <form action="search.jsp">
                <input type="search" id="search" name="search" placeholder="Looking for...?" />
                <input type="submit" hidden />
            </form>
        </div>
        <div>
            <a href="/E-Commerce-Front-end/pages/cart.jsp"><i class="fa-solid fa-cart-shopping fa-lg"></i></a>
        </div>
        <div class="profile">
            <div>
                <%
                if(username == null || username.equals("")){
                %>
                <a href="/E-Commerce-Front-end/pages/login.jsp"><i class="fa-solid fa-circle-user fa-xl"></i></a>
                <%
                } else {
                %>
                <a href="/E-Commerce-Front-end/pages/profile.jsp"><i class="fa-solid fa-circle-user fa-xl"></i></a>
                <%
                }
                %>
            </div>
        </div>
    </header>

    <header class="mobile">
        <div class="logo"><a href="/E-Commerce-Front-end/index.jsp"><img
                    src="/E-Commerce-Front-end/assets/img/logo.webp"></a></div>
        <div class="small-logo"><a href="/E-Commerce-Front-end/index.jsp"><img
                    src="/E-Commerce-Front-end/assets/img/small-logo.webp"></a></div>
        <div class="search-bar line-height80">
            <form action="search.jsp">
                <input type="search" id="search" name="search" placeholder="Looking for...?" />
                <input type="submit" hidden />
            </form>
        </div>
        <div class="profile">
            <div class="profile-icon">
                <a href="/E-Commerce-Front-end/pages/cart.jsp"><i
                        class="fa-solid fa-cart-shopping fa-lg line-height80"></i></a>
            </div>
            <div class="profile-icon">
                <a href="/E-Commerce-Front-end/pages/profile.jsp"><i
                        class="fa-solid fa-circle-user fa-xl line-height80"></i></a>
            </div>
            <div class="profile-icon">
                <i class="fa-solid fa-bars line-height80 fa-xl" onclick="toggleMenu()"></i>
            </div>
        </div>
    </header>

    <div class="mega-menu" style="display: none;">
        <ul>
            <li onclick="location.href='/E-Commerce-Front-end/pages/aboutus.html';">About Us</li>
            <li onclick="location.href='/E-Commerce-Front-end/pages/location.html';">Location</li>
            <li onclick="location.href='/E-Commerce-Front-end/pages/product.jsp';">Products</a>
                <!-- Add more menu items as needed -->
        </ul>
    </div>

    <script>
        var prevScrollpos = window.pageYOffset;
        window.onscroll = function () {
            var currentScrollPos = window.pageYOffset;
            if (prevScrollpos > currentScrollPos) {
                document.getElementsByTagName("header")[0].style.top = "0";
            } else {
                document.getElementsByTagName("header")[0].style.top = "-80px";
            }
            prevScrollpos = currentScrollPos;
        }

        function toggleMenu() {
            var megaMenu = document.querySelector('.mega-menu');
            megaMenu.style.display = (megaMenu.style.display === 'block') ? 'none' : 'block';
        }

        console.log("nav bar loaded successfully")
    </script>
</body>

</html>