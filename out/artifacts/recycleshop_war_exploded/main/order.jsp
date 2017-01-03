<%@ page import="com.recycle.utils.ShopUtil" %><%--
  Created by IntelliJ IDEA.
  User: xiebin
  Date: 2017/1/2
  Time: 下午2:58
  To change this template use File | Settings | File Templates.
--%>
<%@ page contentType="text/html;charset=UTF-8" language="java" %>
<html>
<head lang="en">
    <meta http-equiv="content-type" content="text/html charset=utf-8"/>
    <title>订单结算</title>
    <link rel="stylesheet" type="text/css" href="../styles/reset.css"/>
    <link rel="stylesheet" type="text/css" href="../styles/order.css"/>
    <script type="text/javascript" src="../scripts/jquery-1.6.js"></script>
</head>
<body>
<%
    String username = "";
    if (session.getAttribute("userName") != null)
        username = (String) session.getAttribute("userName");
    else if (request.getCookies() != null) {
        Cookie[] cookies;
        cookies = request.getCookies();
        if (cookies != null) {
            for (Cookie cookie : cookies) {
                if (cookie.getName().equals("userName"))
                    username = cookie.getValue();
            }
        }
        session.setAttribute("userName", username);
    }
%>
<div class="header">
    <div class="header_top">
        <div class="comwidth">
            <div class="header_left">
                <img src="../images/logo.jpg" alt="logo.jpg" width="60" height="25"/>
                <span>Hi，欢迎来到懒懒网商城！</span>
            </div>
            <ul class="header_right">
                <li><a href="#">帮助</a></li>
                <li><a href="#">物流信息</a></li>
                <li><a href="myOrder.jsp">我的订单</a></li>
                <%
                    if (username.equals(""))
                        out.print(" <li><a href=\"regist.jsp\" target=\"_blank\">[免费注册]</a></li>\n" +
                                "<li><a href=\"login.jsp\" target=\"_blank\">[请登录]</a></li>");
                    else
                        out.print(" <li><span>欢迎您</span></li>\n" +
                                "<li><span>"+username+"</span></li>");
                %>
            </ul>
        </div>
    </div>
</div>
<div class="main comwidth">
    <div class="order_top clearfix">
        <span><a href="index.jsp"></a></span>
        <span><h1>填写订单</h1></span>
        <div class="fr progress">
            <ul>
                <li class="s1">1.我的购物车</li>
                <li class="s2">2.填写核对订单信息</li>
                <li class="s3">3.成功提交订单</li>
            </ul>
        </div>
    </div>
    <div class="order_main">
        <form action="/ShopServlet?act=payOrders" method="post" id="orderForm">
            <div class="cartnew_main">
                <div class="cartnew_info">
                    <div class="cartnew_title">
                        <h2>请填写并核对以下信息</h2>
                    </div>
                    <div class="cartnew_list">
                        <div class="box">
                            <div class="box_title">
                                <h3>
                                    商品清单：
                                    <a href="cart.jsp" class="fr return_edit">返回修改购物车</a>
                                </h3>
                            </div>
                            <div class="box_content">
                                <%
                                    String[][] orders= ShopUtil.getCartOrders(username);
                                    double totalMoney=0;
                                %>
                                <div class="order_review clearfix">
                                    <%
                                        for (int i = orders[0].length-1; i >=0; i--) {
                                            String albumPath = ShopUtil.getAlbumPath(orders[2][i]);
                                            String[][] proDetails = ShopUtil.getOneProduct(orders[2][i]);
                                            totalMoney += Double.parseDouble(proDetails[6][0]) * Double.parseDouble(orders[3][i]);
                                    %>
                                    <div class="goods_table">
                                        <table class="review_thead">
                                            <tbody>
                                            <tr>
                                                <td class="fore1">商品</td>
                                                <td class="fore2">价格</td>
                                                <td class="fore3">优惠</td>
                                                <td class="fore4">数量</td>
                                                <td class="fore5">库存状态</td>
                                            </tr>
                                            </tbody>
                                        </table>
                                        <div class="review_tbody">
                                            <table class="order_table">
                                                <tr>
                                                    <td class="fore1">
                                                        <div class="p_goods">
                                                            <div class="p_img">
                                                                <a href="proDetail.jsp?Pid=<%= orders[2][i] %>" target="_blank"><img src="../uploads/<%= albumPath %>"/></a>
                                                            </div>
                                                            <div class="p_detail">
                                                                <div class="p_name">
                                                                    <a href="proDetail.jsp?Pid<%= orders[2][i] %>" target="_blank"><%= proDetails[1][0] %></a>
                                                                </div>
                                                            </div>
                                                        </div>
                                                    </td>
                                                    <td class="p_price">
                                                        <strong>￥<%= proDetails[6][0] %></strong>
                                                    </td>
                                                    <td class="p_promotion">￥<%= Double.parseDouble(proDetails[5][0]) - Double.parseDouble(proDetails[6][0]) %></td>
                                                    <td class="p_quantity">x <%= orders[3][i] %></td>
                                                    <td class="p_inventory">有货</td>
                                                </tr>
                                            </table>
                                        </div>
                                    </div>
                                    <% } %>
                                    <div class="fr goods_summary">
                                        <div class="statistic">
                                            <dl>
                                                <dt><em><%= orders[0].length %></em>件商品，总商品金额：</dt>
                                                <dd>￥<%= totalMoney %></dd>
                                            </dl>
                                            <dl>
                                                <dt>运费：</dt>
                                                <dd>￥0.00</dd>
                                            </dl>
                                            <dl>
                                                <dt>应付总额：</dt>
                                                <dd>￥<%= totalMoney %></dd>
                                            </dl>
                                        </div>
                                    </div>
                                </div>
                            </div>
                        </div><!--商品清单-->
                        <div id="checkoutBox" class="checkout">
                            <input type="submit" class="checkout_submit" value="确认支付"/>
                            <span>
                                        应付总额：<strong id="payPriceId">￥<%= totalMoney %></strong> 元
                                    </span>
                        </div><!--提交订单-->
                    </div><!--END CARTNEW_LIST-->
                    <script type="text/javascript" src="../scripts/addressBox.js"></script>
                    <script type="text/javascript" src="../scripts/totalSubmit.js"></script>
                </div>
            </div><!--END CARTNEW_MAIN-->
        </form>
        <% session.setAttribute("totalMoney",String.valueOf((int)totalMoney)); %>
    </div>
</div><!--END MAIN-->
<div class="footer">
    <div class="footer_links">
        <a href="#">联系我们</a>|
        <a href="#">人才招聘</a>|
        <a href="#">商家入驻</a>|
        <a href="#">营销中心</a>|
        <a href="#">手机XX</a>|
        <a href="#">友情链接</a>
    </div>
    <div class="copyright">
        <p>Copyright © 2016-2017 Lazyice</p>
    </div>
</div><!--END FOOTER-->
</body>
</html>
