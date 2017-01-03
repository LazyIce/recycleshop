<%@ page import="com.recycle.utils.ShopUtil" %><%--
  Created by IntelliJ IDEA.
  User: xiebin
  Date: 2017/1/2
  Time: 下午1:51
  To change this template use File | Settings | File Templates.
--%>
<%@ page contentType="text/html;charset=UTF-8" language="java" %>
<html>
<head lang="en">
    <meta http-equiv="content-type" content="text/html; charset=utf-8"/>
    <title>我的购物车</title>
    <link rel="stylesheet" type="text/css" href="../styles/reset.css"/>
    <link rel="stylesheet" type="text/css" href="../styles/cart.css"/>
    <script src="../scripts/jquery-1.6.js" type="text/javascript"></script>
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
    <div class="cart_top ">
        <div><h1>购物车</h1></div>
    </div>
    <div class="cart_wrap">
        <div class="cart_main">
            <div class="cart_thead">
                <span class="t_checkbox">
                    <input type="checkbox" class="checkall checkbox" checked=false/>
                    全选
                </span>
                <span class="t_goods">商品</span >
                <span class="t_price">单价(元)</span>
                <span class="t_quantity">数量</span>
                <span class="t_sum">小计(元)</span>
                <span class="t_action">操作</span>
            </div>
            <div class="cart_list">
                <div class="item_list">
                    <%
                        String[][] orders= ShopUtil.getCartOrders(username);
                        for (int i = orders[0].length-1; i >=0; i--) {
                            String albumPath = ShopUtil.getAlbumPath(orders[2][i]);
                            String[][] proDetails = ShopUtil.getOneProduct(orders[2][i]);
                    %>
                    <div class="item_single item_selected clearfix">
                        <span class="p_checkbox">
                            <input type="checkbox" checked="checked" class="checkbox"/>
                        </span>
                        <div class="fl p_goods">
                            <div class="fl p_img">
                                <a href="proDetail.jsp?Pid=<%= orders[2][i] %>" target="_blank"><img src="../uploads/<%= albumPath %>" alt=""/></a>
                            </div>
                            <div class="fl p_name">
                                <a href="proDetail.jsp?Pid=<%= orders[2][i] %>" target="_blank"><%= proDetails[1][0] %></a>
                            </div>
                        </div>
                        <!--<span class="p_props"></span>-->
                        <span class="p_price"><%= proDetails[6][0] %></span>
                        <div class="fl p_quantity">
                            <div class="quantity_form">
                                <a class="fl amount_sub" href="javascript:void(0)">-</a>
                                <input type="text" class="amount_input" readonly="readonly" value="<%= orders[3][i] %>"/>
                                <a class="fr amount_add" href="javascript:void(0)">+</a>
                            </div>
                            <div class="quantity_txt">
                                有货
                            </div>
                        </div>
                        <span class="p_sum">
                        </span>
                        <span class="p_action">
                            <a class="cart_remove" href="javascript:void(0)">删除</a>
                        </span>
                    </div>
                    <% } %>
                </div>
            </div>
            <div class="cart_floatbar">
                <div class="toolbar_wrap">
                    <div class=" fl select_all">
                        <span class="t_checkbox">
                            <input type="checkbox" class="checkall checkbox" checked="checked"/>
                    全选
                        </span>
                    </div>
                    <div class="fl operation">
                        <a class="remove_all" href="javascript:void(0)">删除选中的商品</a>
                        <a class="follow_all" href="javascript:void(0)">移到我的关注</a>
                    </div>
                    <div class="fr toolbar_right">
                        <div class="btn_area">
                            <a class="cart_submit" href="order.jsp">去结算</a>
                        </div>
                        <div class="price_sum">
                            <span class="txt">总价（不含运费）：</span>
                            <span class="price sumPrice"><em>¥0.00</em></span>
                            <br>
                            <span class="txt">已节省：</span>
                            <span class="price totalRePrice">- ¥0.00</span>
                        </div>
                    </div>
                </div>
            </div>
        </div>
    </div>
    <script type="text/javascript" src="../scripts/cartPage.js"></script>
</div>
<div class="footer comwidth">
    <div class="footer_content">
        <dl>
            <dt>了解我们</dt>
            <dd>
                <div><a href="#">人才招聘</a></div>
                <div><a href="#">关于我们</a></div>
                <div><a href="#">新闻中心</a></div>
                <div><a href="#">移动终端</a></div>
            </dd>
        </dl>
        <dl>
            <dt>购物资讯</dt>
            <dd>
                <div><a href="#">热门商品</a></div>
                <div><a href="#">热门促销</a></div>
            </dd>
        </dl>
        <dl>
            <dt>支付方式</dt>
            <dd>
                <div><a href="#">XX支付</a></div>
                <div><a href="#">XX账户</a></div>
                <div><a href="#">支付宝与财付通</a></div>
                <div><a href="#">网上银行</a></div>
            </dd>
        </dl>
        <dl>
            <dt>物流信息</dt>
            <dd>
                <div><a href="#">物流公司</a></div>
                <div><a href="#">物流费用</a></div>
                <div><a href="#">物流排行</a></div>
                <div><a href="#">物流评分</a></div>
                <div><a href="#">物流投诉</a></div>
            </dd>
        </dl>
        <dl>
            <dt>帮助和购物指南</dt>
            <dd>
                <div><a href="#">订单查询</a></div>
                <div><a href="#">在线退换货</a></div>
                <div><a href="#">退货政策</a></div>
                <div><a href="#">帮助</a></div>
            </dd>
        </dl>
    </div>
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
