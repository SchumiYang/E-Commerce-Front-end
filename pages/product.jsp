<!DOCTYPE html>
<html lang="en">

<head>
    <meta charset="UTF-8">
    <meta name="viewport" content="width=device-width, initial-scale=1.0">
    <script src="https://cdnjs.cloudflare.com/ajax/libs/jquery/3.7.1/jquery.min.js"></script>
    <script src="https://kit.fontawesome.com/9b3624985e.js" crossorigin="anonymous"></script>
    <link rel="stylesheet" href="../assets/CSS/product.css?time=<%=System.currentTimeMillis()%>">
    <link href="https://fonts.googleapis.com/css2?family=Noto+Sans:ital,wght@0,100..900;1,100..900&display=swap"
        rel="stylesheet">
    <title>Product</title>
</head>

<body>
    <%@ include file="config.jsp" %>
    <!--Navigation bar-->
    <div id="nav-placeholder">

    </div>

    <script>
        $(function () {
            $("#nav-placeholder").load("nav.jsp");
        });

    </script>
    <!--end of Navigation bar-->
    <main>
        <div class="ad"><img src="../assets/img/ads/ad1.webp"></div>

        <%
            // if(searchString != null && !searchString.isEmpty()){
            //     sql = "SELECT * FROM `coloredlens` WHERE `productName` LIKE ? AND `productStock` > 0 AND `instock` = 1";			
            //     pstmt=con.prepareStatement(sql);
            //     pstmt.setString(1, "%" + searchString + "%");
            // } else{
            sql = "SELECT * FROM `products` WHERE `instock` > 1";
            pstmt=con.prepareStatement(sql);
            // }
            
            
            ResultSet dataset = pstmt.executeQuery();
            while(dataset.next()){
         %>

        <div class="product productGrid">
            <div class="img-container">
                <img src="../assets/img/product/<%=dataset.getInt(1)%>.svg">
            </div>
            <div class="product-desc">
                <p class="title"><%=dataset.getString(2)%></p>
                <p class="desc"><%=dataset.getString(3)%></p>
                <p class="stock">In stock: <%=dataset.getInt(4)%></p>
                <div class="buy-section">
                    <i class="fa-solid fa-cart-plus cart-image"></i>
                    <form method="post" action="item.jsp">
                        <input type="hidden" name="product" value="<%=dataset.getInt(1)%>">
                        <input type="submit" class="buy-button" value="BUY">
                    </form>
                </div>
            </div>
        </div>
        
        <%
            }
        %>

        <div class="product customize productGridWide">
            <div class="img-container">
                <img src="../assets/img/cart.webp">
            </div>
            <div class="product-desc">
                <h1>Can't find the one you need?</h1>
                <p class="desc">Try the Customization service to get your Perfect VPS Program</p>
                <div class="buy-button" onclick="location.href='../pages/item-cus.jsp';">
                    <div class="buy-text">Start Now</div>
                </div>
            </div>
        </div>
    </main>
    <footer>
        <iframe src="/E-Commerce-Front-end/pages/footer.jsp" class="footer"></iframe>
    </footer>
</body>

</html>