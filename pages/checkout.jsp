<!DOCTYPE html>
<html lang="en">

<head>
    <meta charset="UTF-8">
    <meta name="viewport" content="width=device-width, initial-scale=1.0">
    <title>Shopping Cart</title>
    <link rel="stylesheet" href="../assets/CSS/cart.css?time=<%=System.currentTimeMillis()%>">
    <script src="https://cdnjs.cloudflare.com/ajax/libs/jquery/3.7.1/jquery.min.js"></script>
    <script src="https://kit.fontawesome.com/9b3624985e.js" crossorigin="anonymous"></script>
</head>

<body>
    <%@ include file="config.jsp" %>
    <div id="nav-placeholder">
    </div>

    <script>
        $(document).ready(function () {
            $("#nav-placeholder").load("nav.jsp");
        });
    </script>
    <%
        String userId = Stream.of(request.getCookies()).filter(c->c.getName().equals("id")).map(c->c.getValue()).findFirst().orElse(null);
        if(userId==null)
            return;
        int total = Integer.parseInt(request.getParameter("total"));
        String cartId = Stream.of(request.getCookies()).filter(c->c.getName().equals("cartid")).map(c->c.getValue()).findFirst().orElse(null);
        if(cartId == null)
            return;

		sql = "INSERT IGNORE INTO `cart` (`userId`) VALUES ('"+userId+"');";
		con.createStatement().executeUpdate(sql);

        sql = "SELECT id FROM `cart` WHERE `userId` = ? ORDER BY `id` DESC LIMIT 1;";
        pstmt = con.prepareStatement(sql);
        pstmt.setInt(1,Integer.parseInt(userId));
        ResultSet dataset = pstmt.executeQuery();
        dataset.next();
        String newCartId = String.valueOf(dataset.getInt(1));
        Cookie cartCookie = new Cookie("cartid",newCartId);
        response.addCookie(cartCookie);

        sql = "INSERT IGNORE INTO `order` (`userId`,`total`) VALUES (?,?);";
        pstmt = con.prepareStatement(sql);
        pstmt.setString(1, userId);
        pstmt.setInt(2, total);
        pstmt.executeUpdate();

        sql = "SELECT id FROM `order` WHERE `userId` = ? ORDER BY id DESC LIMIT 1;";
        pstmt = con.prepareStatement(sql);
        pstmt.setString(1, userId);
        dataset = pstmt.executeQuery();
        dataset.next();
        int orderId = dataset.getInt(1);

        sql = "SELECT * FROM `cartdetails` WHERE `cartId` = ?;";
		pstmt = con.prepareStatement(sql);
		pstmt.setString(1, cartId);
		ResultSet dataset2 = pstmt.executeQuery();
		while(dataset2.next()){
            sql = "INSERT IGNORE INTO `orderdetails` (`orderId`,`productId`,`quantity`,`customized`) VALUES (?,?,?,?);";
			pstmt = con.prepareStatement(sql);
			pstmt.setInt(1, orderId);
            pstmt.setInt(2, dataset2.getInt(3));
            pstmt.setInt(3, dataset2.getInt(5));
            pstmt.setInt(4, dataset2.getInt(4));
			pstmt.executeUpdate();

            sql = "DELETE FROM `cartdetails` WHERE `id` = ?;";
            pstmt = con.prepareStatement(sql);
            pstmt.setInt(1, dataset2.getInt(1));
            pstmt.executeUpdate();
        }
    %>
    <div class="finished">
        <div class="done-animation">
            <i class="fa-solid fa-check colored check"></i>
        </div>
        <h2>Your order has been sent!</h2>
        <div class="action">
            <button class="action-btn" onclick="location.href='profile.jsp'">Orders</button>
            <button class="action-btn" onclick="location.href='../index.jsp'">Return</button>
        </div>
    </div>
    <footer>
        <iframe src="/E-Commerce-Front-end/pages/footer.jsp" class="footer"></iframe>
    </footer>
</body>


</html>