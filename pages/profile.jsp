<!DOCTYPE html>
<%@page contentType="text/html"%> 
<%@page pageEncoding="UTF-8"%>
<%@page import = "java.sql.*"%>
<%@page import = "java.util.Random"%>
<html lang="en">

<head>
    <meta charset="UTF-8">
    <meta name="viewport" content="width=device-width, initial-scale=1.0">
    <title>Profile</title>
    <link rel="stylesheet" href="../assets//CSS/profile.css">
    <script src="../assets/JS/profile.js" defer></script>
    <script src="https://cdnjs.cloudflare.com/ajax/libs/jquery/3.7.1/jquery.min.js"></script>
    <script src="https://kit.fontawesome.com/9b3624985e.js" crossorigin="anonymous"></script>
    <link rel="preconnect" href="https://fonts.googleapis.com">
    <link rel="preconnect" href="https://fonts.gstatic.com" crossorigin>
    <link href="https://fonts.googleapis.com/css2?family=Noto+Sans:ital,wght@0,100..900;1,100..900&display=swap"
        rel="stylesheet">
</head>

<body>
    <div id="nav-placeholder">

    </div>

    <script>
        $(document).ready(function () {
            $("#nav-placeholder").load("nav.jsp");
        });
    </script>

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

        // Connection con = null;
        try {
		Class.forName("com.mysql.jdbc.Driver");
            try {
                String url = "jdbc:mysql://localhost/?serverTimezone=UTC";
                Connection con = DriverManager.getConnection(url, "root", "1234");
                if (con.isClosed()) {
                    out.println("連線建立失敗");
                } else {
                    con.createStatement().execute("use `members`");
                    String sql = "SELECT * FROM members WHERE id=" + id;
                    ResultSet resultSet = con.createStatement().executeQuery(sql);
                    
                    if (resultSet.next()) {
                        // Retrieve values from the result set
                        String password = resultSet.getString("pwd");
                        String email = resultSet.getString("email");
                        String address = resultSet.getString("address");
        %>

    <div class="tab-container">
        <div class="tab-sidebar">
            <div class="tab-category">
                <button class="tab-btn active"><i class="fa-solid fa-server"></i>Profile</button>
                <div class="tab-subcategory">
                    <button class="tab-subbtn active"><i class="fa-solid fa-plus"></i>Your Info</button>
                </div>
            </div>
            <div class="tab-category">
                <button class="tab-btn"><i class="fa-solid fa-folder"></i>Order</button>
                <div class="tab-subcategory">
                    <button class="tab-subbtn"><i class="fa-solid fa-book"></i>History</button>
                </div>
            </div>
        </div>
        <div class="tab-content">
            <div class="tab-panel active">
                <div class="header">
                    <h1>Your Info</h1>
                </div>
                <div id="info" class="info">
                    <div class="flex">
                        <div class="label">Username:</div>
                        <div class="value"><%=username%></div>
                    </div>

                    <div class="flex">
                        <div class="label">Password:</div>
                        <div class="value"><%=password%></div>
                    </div>

                    <div class="flex">
                        <div class="label">E-mail:</div>
                        <div class="value"><%=email%></div>
                    </div>

                    <div class="flex">
                        <div class="label">Address:</div>
                        <div class="value"><%=address%></div>
                    </div>

                    <div class="flex">
                        <div class="label">Phone:</div>
                        <div class="value">[Phone]</div>
                    </div>



                    <button class="edit" value="Edit" onclick="ed()">Edit</button>
                </div>
                <div id="edit" class="tform">
                    <form action="updateProfile.jsp" method="post">
                        <div class="details">
                            <div class="product">
                                <div class="label">Username:</div>
                                <input type="text" name="newname" value="<%=username%>">
                                <div class="label">Password:</div>
                                <input type="text" name="password" value="<%=password%>">
                                <div class="label">E-mail:</div>
                                <input type="email" name="email" value="<%=email%>">
                                <div class="label">Address:</div>
                                <input type="text" name="address" value="<%=address%>">
                                <div class="label">Phone:</div>
                                <input type="number" name="phone" value="">
                            </div>
                        </div>
                        <div class="button-section">
                            <input type="reset" class="button cancel" value="Reset">
                            <input type="submit" class="button submit" value="Submit">
                        </div>
                    </form>
                    <button class="edit" value="back" onclick="back()">back</button>
                </div>

                <%
                        }
                    con.close();
                }
            } catch (SQLException e) {
                out.println("SQL錯誤: " + e.toString());
            }
        } catch (ClassNotFoundException err) {
            out.println("Class錯誤: " + err.toString());
        }
    %>
            </div>
            <div class="tab-panel">
                <div class="header">
                    <h1>History</h1>
                </div>
                <div class="order-container">
                    <div class="tag">
                        <div class="order-item">
                            <div class="order-img">
                                <img src="../assets/img/cpu.webp" />
                            </div>
                            <div class="order-detail">
                                <p class="order-num">Order #123456</p>
                                <p class="order-product">AI Based</p>
                                <p class="order-amount">x4</p>
                            </div>
                            <div class="order-action">
                                <button id="commet" class="comment-btn order-done">Reivew</button>
                            </div>
                        </div>
                        <div class="review-form-container" style="display: none;">
                            <form class="review-form">
                                <h2>Comment:</h2>
                                <div class="form-group">
                                    <label for="rating">Rating:</label>
                                    <div class="stars">
                                        <input type="radio" name="rating" id="star5" value="5"><label
                                            for="star5">★</label>
                                        <input type="radio" name="rating" id="star4" value="4"><label
                                            for="star4">★</label>
                                        <input type="radio" name="rating" id="star3" value="3"><label
                                            for="star3">★</label>
                                        <input type="radio" name="rating" id="star2" value="2"><label
                                            for="star2">★</label>
                                        <input type="radio" name="rating" id="star1" value="1"><label
                                            for="star1">★</label>
                                    </div>
                                </div>
                                <div class="form-group">
                                    <label for="user">User:</label>
                                    <input type="text" id="user" name="User" required>
                                </div>
                                <div class="form-group">
                                    <label for="content">Content:</label>
                                    <textarea id="content" name="content" rows="5" required></textarea>
                                </div>
                                <input type="submit" value="Submit" />
                            </form>
                        </div>
                    </div>
                    <div class="tag">
                        <div class="order-item">
                            <div class="order-img">
                                <img src="../assets/img/cpu.webp" />
                            </div>
                            <div class="order-detail">
                                <p class="order-num">Order #123457</p>
                                <p class="order-product">AI Based</p>
                                <p class="order-amount">x4</p>
                            </div>
                            <div class="order-action">
                                <button id="commet" class="comment-btn order-done">Reivew</button>
                            </div>
                        </div>
                        <div class="review-form-container" style="display: none;">
                            <form class="review-form">
                                <h2>Comment:</h2>
                                <div class="form-group">
                                    <label for="rating">Rating:</label>
                                    <div class="stars">
                                        <input type="radio" name="rating" id="star5" value="5"><label
                                            for="star5">★</label>
                                        <input type="radio" name="rating" id="star4" value="4"><label
                                            for="star4">★</label>
                                        <input type="radio" name="rating" id="star3" value="3"><label
                                            for="star3">★</label>
                                        <input type="radio" name="rating" id="star2" value="2"><label
                                            for="star2">★</label>
                                        <input type="radio" name="rating" id="star1" value="1"><label
                                            for="star1">★</label>
                                    </div>
                                </div>
                                <div class="form-group">
                                    <label for="user">User:</label>
                                    <input type="text" id="user" name="User" required>
                                </div>
                                <div class="form-group">
                                    <label for="content">Content:</label>
                                    <textarea id="content" name="content" rows="5" required></textarea>
                                </div>
                                <input type="submit" value="Submit" />
                            </form>
                        </div>
                    </div>
                </div>
            </div>
        </div>
    </div>
    <footer>
        <iframe src="/E-Commerce-Front-end/pages/footer.html" class="footer"></iframe>
    </footer>
</body>

</html>