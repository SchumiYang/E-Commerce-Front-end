<!DOCTYPE html>
<html lang="en">
<head>
    <meta charset="UTF-8">
    <meta name="viewport" content="width=device-width, initial-scale=1.0">
    <title>item</title>
    <link rel="stylesheet" href="../assets/CSS/item.css">
    <script src="https://cdnjs.cloudflare.com/ajax/libs/jquery/3.7.1/jquery.min.js"></script>
    <link rel="preconnect" href="https://fonts.googleapis.com">
    <link rel="preconnect" href="https://fonts.gstatic.com" crossorigin>
    <link href="https://fonts.googleapis.com/css2?family=Noto+Sans:ital,wght@0,100..900;1,100..900&display=swap" rel="stylesheet">
</head>
<body>
    <%@ include file="config.jsp" %>
    <!--Navigation bar-->
    <div id="nav-placeholder">

    </div>

    <script>
    $(function(){
    $("#nav-placeholder").load("nav.jsp");
    });
    </script>
    <%
        String id = request.getParameter("product");
        String action = request.getParameter("action");
        if(action != null && action.equals("add-cart")){
            String cartId = Stream.of(request.getCookies()).filter(c->c.getName().equals("cartid")).map(c->c.getValue()).findFirst().orElse(null);
            if(cartId == null)
                return;
            sql="INSERT IGNORE INTO `cartdetails` (`cartId`, `productId`, `customized`, `quantity`) VALUES (?,?,?,?);";
            pstmt = con.prepareStatement(sql);
            pstmt.setString(1, cartId);
            pstmt.setString(2, id);
            pstmt.setInt(3, 0);
            pstmt.setString(4, request.getParameter("amount"));
            pstmt.executeUpdate(); 
            out.println("<script>alert('Added to cart!');</script>");
        }
    %>
    <main>
        <%
            sql = "SELECT * FROM `products` WHERE `id` = ?;";
            pstmt=con.prepareStatement(sql);
            pstmt.setInt(1,Integer.parseInt(id));
            
            
            ResultSet dataset = pstmt.executeQuery();
            dataset.next();
        %>
        <section class="product">
            <div class="product-image">
                <img src="../assets/img/product/<%=dataset.getInt(1)%>.svg" alt="<%=dataset.getString(2)%>"></img>
            </div>
            <div class="product-details">
                <h1><%=dataset.getString(2)%></h1>
                <p><%=dataset.getString(3)%></p>
                <div class="flex">
                    <!-- <p class="specs">with vCPU 1GB, RAM 4GB</p> -->
                    <p class="instock">| In stock: <%=dataset.getInt(4)%></p>
                </div>
                <div class="flex">
                    <p class="price">$<%=dataset.getInt(5)%></p>
                    <p class="per-mo">/ Per month</p>
                </div>
                <form method="post" action="item.jsp">
                    <input type="hidden" name="product" value="<%=id%>">
                    <input type="hidden" name="action" value="add-cart">
                    <div class="quantity-container">
                        <div class="quantity">
                            <input type="button" class="minus" value="-">
                            <input type="number" name="amount" value="1" min="1">
                            <input type="button" class="plus" value="+">
                        </div>
                        <input type="submit" class="buy-now" value="Buy Now">
                    </div>
                </form>
            </div>
        </section>

        <script src="../assets/JS/item.js"></script>
        <section class="configuration">
            <div class="config-img">
                <div class="pro-img-bor cpu"></div>
                <div class="pro-img-bor gpu"></div>
                <div class="pro-img-bor ram"></div>
                <div class="pro-img-bor mem"></div>
                <img class="t" src="../assets/img/board.webp"></img>
            </div>
            <div class="conf-number">
                <div class="config-item" data-target="cpu">
                    <label for="vcpu">vCPU</label>
                    <p><%=dataset.getInt(6)%></p>
                    <label class="gb">Cores</label>
                </div>
                <div class="config-item" data-target="gpu">
                    <label for="ram">vGPU</label>
                    <p><%=dataset.getInt(7)%></p>
                    <label class="gb">GB</label>
                </div>
                <div class="config-item" data-target="ram">
                    <label for="ram">RAM</label>
                    <p><%=dataset.getInt(8)%></p>
                    <label class="gb">GB</label>
                </div>
                <div class="config-item" data-target="mem">
                    <label for="mem">Mem.</label>
                    <p><%=dataset.getInt(9)%></p>
                    <label class="gb">GB</label>
                </div>
                <div class="config-item">
                    <label for="bandwidth">Bandwidth</label>
                    <p><%=dataset.getInt(10)%></p>
                    <label class="gb">GB</label>
                </div>
            </div>
        </section>
        
        <div class="below">
            <section class="reviews">
                <h2>Reviews</h2>
                <div class="reviews-container">
                    <iframe src="reviews.jsp?product=<%=id%>&customized=0"></iframe>
                 </div>  
            </section>
            <section class="brand">
                <h2>Why VPS?</h2>
                <p>Unlock the full potential of your business with our VPS services! Experience unmatched flexibility, speed, and scalability that outshines traditional cloud hosting and on-premise servers. Enjoy dedicated resources, enhanced security, and 24/7 expert support, all at a fraction of the cost. Upgrade to our VPS and transform your digital infrastructure today!</p>
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