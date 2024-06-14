<%@ include file="config.jsp" %>
<%@page import = "java.text.SimpleDateFormat"%>
<%@page import = "java.util.Date"%>
<link rel="stylesheet" href="../assets/CSS/reviews.css">

<body>
    <section class="reviews-container">
        <%
            String id = request.getParameter("product");
            sql = "SELECT * FROM `comment` `c` INNER JOIN `members` m ON c.userId = m.id WHERE `c`.`productId` = ? ORDER BY `c`.`timestamp` DESC;";
            pstmt=con.prepareStatement(sql);
            pstmt.setInt(1,Integer.parseInt(id));
            
            ResultSet dataset = pstmt.executeQuery();
            while(dataset.next()){
        %>
        <div class="review">
            <div class="head">
                <div class="title">
                    <p><strong><%=dataset.getString(4)%></strong></p>
                </div>
                <div class="stars">
                <%
                    int rating = dataset.getInt(5);
                    for(int i=5;i>0;i--){
                        out.print("<input type=\"radio\" value=\""+i+"\" readonly "+(i==rating ? "checked" : "")+"><label for=\"star"+i+"\">&#9733;</label>");
                    }
                    %>
                </div>
            </div>
            <p><%=dataset.getString(6)%></p>
            <div class="tail">
                <p><em>- <%=dataset.getString("username")%></em></p>
            </div>
        </div>
        <%
            }
        %>
    </section>
</body>