<!DOCTYPE html>
<html lang="en">

<head>
    <meta charset="UTF-8">
    <meta name="viewport" content="width=device-width, initial-scale=1.0">
    <title>item-cus</title>
    <link rel="stylesheet" href="../assets/CSS/item-cus.css">
    <script src="https://cdnjs.cloudflare.com/ajax/libs/jquery/3.7.1/jquery.min.js"></script>
    <link rel="preconnect" href="https://fonts.googleapis.com">
    <link rel="preconnect" href="https://fonts.gstatic.com" crossorigin>
    <link href="https://fonts.googleapis.com/css2?family=Noto+Sans:ital,wght@0,100..900;1,100..900&display=swap"
        rel="stylesheet">
    <script src="../assets/JS/item-cus.js"></script>
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
    <%
        String vcpu = request.getParameter("vcpu");
        String gpu = request.getParameter("gpu");
        String ram = request.getParameter("ram");
        String mem = request.getParameter("mem");
        String bw = request.getParameter("bw");
        String price = request.getParameter("price");
        String action = request.getParameter("action");

        if(action != null && action.equals("add-cart")){
            sql = "INSERT IGNORE INTO `cus_product` (`defaultPrice`,`defaultCPU`,`defaultGPU`,`defaultRAM`,`defaultMEM`,`defaultBW`) VALUES (?,?,?,?,?,?);";
            pstmt = con.prepareStatement(sql);
            pstmt.setString(1, price);
            pstmt.setString(2, vcpu);
            pstmt.setString(3, gpu);
            pstmt.setString(4, ram);
            pstmt.setString(5, mem);
            pstmt.setString(6, bw);
            pstmt.executeUpdate(); 

            sql = "SELECT * FROM `cus_product` ORDER BY `id` DESC LIMIT 1;";
            pstmt=con.prepareStatement(sql);
            ResultSet dataset = pstmt.executeQuery();
            dataset.next();
            int productId = dataset.getInt(1);

            String cartId = Stream.of(request.getCookies()).filter(c->c.getName().equals("cartid")).map(c->c.getValue()).findFirst().orElse(null);
            if(cartId == null)
                return;
            sql="INSERT IGNORE INTO `cartdetails` (`cartId`, `productId`, `customized`, `quantity`) VALUES (?,?,?,?);";
            pstmt = con.prepareStatement(sql);
            pstmt.setString(1, cartId);
            pstmt.setInt(2, productId);
            pstmt.setInt(3, 1);
            pstmt.setInt(4, 1);
            pstmt.executeUpdate(); 
            out.println("<script>alert('Added to cart!');</script>");
        }

        sql = "SELECT * FROM `cus_product` WHERE `id` = 1;";
        pstmt=con.prepareStatement(sql);
        
        ResultSet dataset = pstmt.executeQuery();
        dataset.next();
    %>
    <main>
        <section class="product">
            <div class="product-image">
                <img src="../assets/img/equa.webp"></img>
            </div>
            <div class="product-details">
                <h1><%=dataset.getString(2)%></h1>
                <p><%=dataset.getString(3)%></p>
                <div class="flex">
                    <p class="instock">| In stock: <%=dataset.getInt(4)%></p>
                </div>
                <div class="flex">
                    <p class="price">Select your specifications to get the price</p>
                </div>
            </div>
        </section>

        <form method="post" action="item-cus.jsp">
            <section class="configuration">
                <div class="config-img">
                    <div class="pro-img-bor cpu"></div>
                    <div class="pro-img-bor gpu"></div>
                    <div class="pro-img-bor ram"></div>
                    <div class="pro-img-bor mem"></div>
                    <img class="t" src="../assets/img/board.webp"></img>
                </div>
                <div class="conf-number">
                    <div class="config-item" data-target="cpu" data-step="2">
                        <label for="vcpu">vCPU</label>
                        <input type="button" class="minus" value="-">
                        <input type="number" id="cpu" name="vcpu" value="1" min="1" max="128" readonly>
                        <input type="button" class="plus" value="+">
                        <label class="gb">Cores</label>
                    </div>
                    <div class="config-item" data-target="gpu" data-step="2">
                        <label for="ram">vGPU</label>
                        <input type="button" class="minus" value="-">
                        <input type="number" id="gpu" name="gpu" value="1" min="1" max="256" readonly>
                        <input type="button" class="plus" value="+">
                        <label class="gb">GB</label>
                    </div>
                    <div class="config-item" data-target="ram" data-step="2">
                        <label for="ram">RAM</label>
                        <input type="button" class="minus" value="-">
                        <input type="number" id="ram" name="ram" value="1" min="1" max="512" readonly>
                        <input type="button" class="plus" value="+">
                        <label class="gb">GB</label>
                    </div>
                    <div class="config-item" data-target="mem" data-step="2">
                        <label for="mem">Mem.</label>
                        <input type="button" class="minus" value="-">
                        <input type="number" id="mem" name="mem" value="16" min="16" max="2048" readonly>
                        <input type="button" class="plus" value="+">
                        <label class="gb">GB</label>
                    </div>
                    <div class="config-item" data-target="bandwidth" data-step="100">
                        <label for="bandwidth">Bandwidth</label>
                        <input type="button" class="minus" value="-">
                        <input type="number" id="bw" name="bw" value="100" min="100" max="2000" readonly>
                        <input type="button" class="plus" value="+">
                        <label class="gb">GB</label>
                    </div>
                </div>
            </section>
            <div class="flex-col cuspro">
                <div class="flex">
                    <p>$</p>
                    <input id="price" class="price" name="price" type="text" value="560" min="560" readonly>
                    <p class="per-mo">/ Per month</p>
                </div>
                <!-- <input id="getp" class="buy-now" type="button" value="Get Your Price" onclick="getprice()"> -->
                <input type="hidden" name="action" value="add-cart">
                <input id="submit" type="submit" class="buy-now" value="Buy Now">
            </div>
        </form>

        <div class="below">
            <section class="reviews">
                <h2>Reviews</h2>
                <div class="reviews-container">
                    <iframe src="reviews.jsp?product=1&customized=1"></iframe>
                 </div>  
            </section>
            <section class="brand">
                <h2>Why VPS?</h2>
                <p>Unlock the full potential of your business with our VPS services! Experience unmatched flexibility,
                    speed, and scalability that outshines traditional cloud hosting and on-premise servers. Enjoy
                    dedicated resources, enhanced security, and 24/7 expert support, all at a fraction of the cost.
                    Upgrade to our VPS and transform your digital infrastructure today!</p>
                <h2>Our VPS has...</h2>
                <div class="brand-tag-container">
                    <div class="brand-tag">
                        <div class="tag-text">Best Price</div>
                    </div>
                    <div class="brand-tag">
                        <div class="tag-text">Best Warranty</div
                            ></div>
                    <div class="brand-tag">
                        <div class="tag-text">Best Service</div>
                    </div>
                </div>
            </section>
        </div>

        <section class="other-items">
            <%
                sql = "SELECT * FROM `products`;";
                pstmt=con.prepareStatement(sql);
                dataset = pstmt.executeQuery();

                for(int i =0;i<3;i++){
                    dataset.next();
            %>
            <div class="other-item">
                <h3><%=dataset.getString(2)%></h3>
                <p><%=dataset.getString(3)%></p>
                <a>More</a>
            </div>
            <%
                }
            %>
        </section>
    </main>
    <footer>
        <iframe src="/E-Commerce-Front-end/pages/footer.jsp" class="footer"></iframe>
    </footer>
</body>

</html>