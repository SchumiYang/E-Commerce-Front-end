<!DOCTYPE html>
<html lang="en">
<head>
    <meta charset="UTF-8">
    <meta name="viewport" content="width=device-width, initial-scale=1.0">
    <title>Shopping Cart</title>
    <link rel="stylesheet" href="../assets//CSS/cart.css?time=<%=System.currentTimeMillis()%>">
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
        String id = Stream.of(request.getCookies()).filter(c->c.getName().equals("id")).map(c->c.getValue()).findFirst().orElse(null);
        if(id==null)
            return;
        String action = request.getParameter("action");
        if (action != null){
            switch(action){
                case "add":
                    sql = "UPDATE `cartdetails` SET `quantity` = "+ (Integer.parseInt(request.getParameter("quantity")) + 1)+" WHERE `id` = "+request.getParameter("detailId")+" ;";
                    break;
                case "sub":
                    int quantity = Integer.parseInt(request.getParameter("quantity"));
                    sql = (quantity - 1 == 0 ? "DELETE FROM `cartdetails` WHERE `id` = "+request.getParameter("detailId")+" ;" : "UPDATE `cartdetails` SET `quantity` = "+ (quantity - 1)+" WHERE `id` = "+request.getParameter("detailId")+" ;");
                    break;
                case "delete":
                    sql = "DELETE FROM `cartdetails` WHERE `id` = "+request.getParameter("detailId")+" ;";
                    break;
            }
            pstmt=con.prepareStatement(sql);
            pstmt.executeUpdate();
        }
    %>

    <main>
        <div class="cart-container">
            <div class="cart-header">
                <div class="product">Product</div>
                <div>Price</div>
                <div>Amount</div>
                <div>Subtotal</div>
                <div></div>
            </div>
            <%
                sql = "SELECT `cd`.productId, `cd`.quantity, `cd`.customized, `cd`.id FROM `cart` AS `c` INNER JOIN `cartdetails` AS `cd` ON `c`.`id` = `cd`.`cartId` WHERE `c`.`userId` = ? ORDER BY `c`.`timestamp` DESC;";
                pstmt=con.prepareStatement(sql);
                pstmt.setInt(1,Integer.parseInt(id));
                int total = 0;
                ResultSet dataset = pstmt.executeQuery();
                while(dataset.next()){
                    int productId = dataset.getInt(1);
                    int q = dataset.getInt(2);
                    int customized = dataset.getInt(3);
                    int detailId = dataset.getInt(4);
                    String sql2 = "SELECT * FROM `"+(customized == 1 ?"cus_product" : "products")+"` WHERE `id` = ?;";
                    pstmt=con.prepareStatement(sql2);
                    pstmt.setInt(1,productId);
                    ResultSet dataset2 = pstmt.executeQuery();
                    dataset2.next();
                    int price = dataset2.getInt(5);

            %>
            <div class="cart-item">
                <div class="product">
                    <img src="../assets/img/product/<%=(customized != 1 ? productId + ".svg" : "equa.webp")%>" alt="Product Image" />
                    <div class="detail">
                        <span><%=dataset2.getString(2)%></span>
                        <span class="spec">vCPU: <%=dataset2.getInt(6)%>c<br>vGPU: <%=dataset2.getInt(7)%>G<br>RAM: <%=dataset2.getInt(8)%>G<br>Mem. <%=dataset2.getInt(9)%>G<br>Bandwidth <%=dataset2.getInt(10)%>G</span>
                    </div>
                </div>
                <div>NT$ <%=price%></div>
                <div class="quantity-control">
                    <form method="post" action="cart.jsp">
                        <input type="hidden" name="action" value="sub">
                        <input type="hidden" name="product" value="<%=productId%>">
                        <input type="hidden" name="quantity" value="<%=q%>">
                        <input type="hidden" name="detailId" value="<%=detailId%>">
                        <input type="submit" value="-">
                    </form>
                    <span><%=q%></span>
                    <form method="post" action="cart.jsp">
                        <input type="hidden" name="action" value="add">
                        <input type="hidden" name="product" value="<%=productId%>">
                        <input type="hidden" name="quantity" value="<%=q%>">
                        <input type="hidden" name="detailId" value="<%=detailId%>">
                        <input type="submit" value="+">
                    </form>
                </div>
                <div>NT$ <%=q*price%></div>
                <div>
                    <form id="delete<%=detailId%>" method="post" action="cart.jsp">
                        <input type="hidden" name="action" value="delete">
                        <input type="hidden" name="product" value="<%=productId%>">
                        <input type="hidden" name="detailId" value="<%=detailId%>">
                        <i class="fa-solid fa-trash delete" onclick="$('#delete<%=detailId%>').submit();"></i>
                    </form>
                </div>
            </div>
            <%
                total += q*price;
                }
            %>
        </div>
        <div class="hrcontainer">
            <span class="line">
        </div>
        <br>
        <div class="total">
            <div class="total-item">
                <p>Total: </p>
                <p>NT$ <%=total%></p>
            </div>
        </div>
        <br>

        <form class="checkout" method="post" action="checkout.jsp">
            <input type="hidden" name="total" value="<%=total%>">
            <div class="checkout-btns">
                <div id="paypal-button-container"></div>
                <input type="submit" class="btn" value="Checkout">
            </div>
        </form>
        <script src="https://www.paypal.com/sdk/js?client-id=test&currency=TWD"></script>

        <script>
            // Render the PayPal button into #paypal-button-container
            paypal.Buttons({
                style: {
                    layout: 'horizontal'
                },

                // Call your server to set up the transaction
                createOrder: function (data, actions) {
                    return fetch('/demo/checkout/api/paypal/order/create/', {
                        method: 'post'
                    }).then(function (res) {
                        return res.json();
                    }).then(function (orderData) {
                        return orderData.id;
                    });
                },

                // Call your server to finalize the transaction
                onApprove: function (data, actions) {
                    return fetch('/demo/checkout/api/paypal/order/' + data.orderID + '/capture/', {
                        method: 'post'
                    }).then(function (res) {
                        return res.json();
                    }).then(function (orderData) {
                        // Three cases to handle:
                        //   (1) Recoverable INSTRUMENT_DECLINED -> call actions.restart()
                        //   (2) Other non-recoverable errors -> Show a failure message
                        //   (3) Successful transaction -> Show confirmation or thank you

                        // This example reads a v2/checkout/orders capture response, propagated from the server
                        // You could use a different API or structure for your 'orderData'
                        var errorDetail = Array.isArray(orderData.details) && orderData.details[0];

                        if (errorDetail && errorDetail.issue === 'INSTRUMENT_DECLINED') {
                            return actions.restart(); // Recoverable state, per:
                            // https://developer.paypal.com/docs/checkout/integration-features/funding-failure/
                        }

                        if (errorDetail) {
                            var msg = 'Sorry, your transaction could not be processed.';
                            if (errorDetail.description) msg += '\n\n' + errorDetail.description;
                            if (orderData.debug_id) msg += ' (' + orderData.debug_id + ')';
                            return alert(msg); // Show a failure message (try to avoid alerts in production environments)
                        }

                        // Successful capture! For demo purposes:
                        console.log('Capture result', orderData, JSON.stringify(orderData, null, 2));
                        var transaction = orderData.purchase_units[0].payments.captures[0];
                        alert('Transaction ' + transaction.status + ': ' + transaction.id + '\n\nSee console for all available details');

                        // Replace the above to show a success message within this page, e.g.
                        // const element = document.getElementById('paypal-button-container');
                        // element.innerHTML = '';
                        // element.innerHTML = '<h3>Thank you for your payment!</h3>';
                        // Or go to another URL:  actions.redirect('thank_you.html');
                    });
                }
            }).render('#paypal-button-container');
        </script>
    </main>
    <footer>
        <iframe src="/E-Commerce-Front-end/pages/footer.jsp" class="footer"></iframe>
    </footer>
</body>

</html>