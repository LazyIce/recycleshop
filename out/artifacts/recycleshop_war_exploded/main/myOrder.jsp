<%@ page import="com.recycle.utils.ShopUtil" %><%--
  Created by IntelliJ IDEA.
  User: xiebin
  Date: 2017/1/2
  Time: 下午1:50
  To change this template use File | Settings | File Templates.
--%>
<%@ page contentType="text/html;charset=UTF-8" language="java" %>
<html>
<head lang="en">
    <meta http-equiv="content-type" content="text/html; charset=UTF-8">
    <title>我的订单</title>
    <link rel="stylesheet" href="../styles/reset.css" type="text/css"/>
    <link rel="stylesheet" href="../styles/myOrder.css" type="text/css"/>
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
                <li><a href="#">我的订单</a></li>
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
    <div class="header_bottom comwidth">
        <div class="logo">
            <span>
            </span>
        </div>
        <div class="search">
            <form target="_blank" method="post" action="/ShopServlet?act=search">
                <input type="text" name="search"/>
                <input type="submit" value="搜索" />
            </form>
        </div>
        <div id="user" class="user">
            <div id="userText" class="user_text">
                <span>关于我</span>
            </div>
            <div id="userList" class="user_list">
                <ul>
                    <li><a href="myOrder.jsp">我的账户</a></li>
                    <li><a href="#">我的订单</a></li>
                    <li><a href="#">评价商品</a></li>
                    <li><a href="#">会员专区</a></li>
                </ul>
            </div>
        </div>
        <script type="text/javascript" src="../scripts/userList.js"></script>
        <div id="cart" class="cart clearfix">
            <div class="shop_text">
                <img src="image/icon/cart_24.png" alt="cart"/>
                <a href="cart.jsp">购物车</a>
                <span class="angle down"></span>
            </div>
            <div class="shop_num"><%= ShopUtil.totalOrders(username) %></div>
        </div>
        <div class="cat_list">
            <ul>
                <li><a href="index.jsp">首页</a></li>
                <%
                    String[][] cName = ShopUtil.getAllCates();
                    for (int i = 0; i < cName[0].length; i++) {
                %>
                <li><a href="products.jsp?catalogue=<%= cName[0][i] %>"><%= cName[0][i] %></a></li>
                <% } %>
            </ul>
        </div>
    </div>
</div>
<div class="main comwidth clearfix">
    <div class="mini_site">
        <a href="index.jsp">懒懒网首页</a>
        <span class="right_next">&gt;</span>
        <span>我的订单</span>
    </div>
    <div class="fl con_left">
        <div class="usercenter">
            <h2 class="ucenter_title">
                个人中心
            </h2>
            <div class="ucenter_main">
                <div class="usernav">
                    <h3>交易管理</h3>
                    <ul>
                        <li id="myOrder"><a href="myOrder.jsp">我的订单</a></li>
                        <li><a href="#">我的收藏</a></li>
                        <li><a href="#">我的VIP</a></li>
                    </ul>
                </div>
                <div class="usernav">
                    <h3>服务中心</h3>
                    <ul>
                        <li><a href="#">我的退/换货</a></li>
                        <li><a href="#">我的咨询</a></li>
                        <li><a href="#">我的评论</a></li>
                        <li><a href="#">我的投诉</a></li>
                        <li><a href="#">我的信息</a></li>
                    </ul>
                </div>
                <div class="usernav">
                    <h3>个人信息管理</h3>
                    <ul>
                        <li><a href="#">编辑个人资料</a></li>
                        <li><a href="#">账号安全</a></li>
                        <li><a href="#">地址管理</a></li>
                    </ul>
                </div>
            </div>
        </div>
    </div>
    <div class="fr con_right">
        <div class="zjdd">
            <div class="dd_title">
                <h2>最近订单</h2>
                <div class="fr more">
                    <a href="#">更多订单<span class="right"></span>
                    </a>
                </div>
            </div>
            <div class="dd_main">
                <div class="list-t">
                    <span class="li-1">商品信息</span>
                    <span class="li-2">数量</span>
                    <span class="li-3">懒懒网价格</span>
                    <span class="li-4">实际付款</span>
                    <span class="li-5">订单状态</span>
                    <span class="li-6">操作</span>
                </div>
                <%
                    String[][] orders = ShopUtil.getAllOrders(username);
                    for (int i = orders[0].length-1; i >= 0 ; i--) {
                        String albumPath = ShopUtil.getAlbumPath(orders[2][i]);
                        String[][] proDetail = ShopUtil.getOneProduct(orders[2][i]);
                %>
                <div class="list-m">
                    <table class="t1">
                        <thead>
                        <tr>
                            <th colspan="6">订单编号：<%= orders[0][i] %>
                                <span class="fr">下单时间：<%= orders[4][i] %></span>
                            </th>
                        </tr>
                        </thead>
                        <tbody>
                        <tr>
                            <td class="img_list">
                                <a href="proDetail.jsp?Pid=<%= orders[2][i] %>" target="_blank"><img src="../uploads/<%= albumPath %>"/><span style="float: right"><%= proDetail[1][0] %></span></a>
                            </td>
                            <td class="logistics">
                                <p><a target="_blank" href="#"><%=  orders[3][i] %></a></p>
                            </td>
                            <td class="pre_time">
                                <p><%= proDetail[6][0] %></p>
                            </td>
                            <td>
                                <div class="total">
                                    <p><%= Double.parseDouble(proDetail[6][0])*Double.parseDouble(orders[3][i]) %></p></div>
                            </td>
                            <td class="order_status">
                                <p>
                                    <%= orders[5][i].equals("1")?"<a href='/ShopServlet?act=getProduct&id="+orders[0][i]+"'>确认收货</a>":"交易完成" %>
                                </p>
                            </td>
                            <td class="operate">
                                <p><a target="_blank" href="order.jsp">查看订单</a></p>
                            </td>
                        </tr>
                        </tbody>
                    </table>
                </div>
                <% } %>
            </div>
        </div>
    </div><!--END CON_RIGHT-->
</div><!--END MAIN-->
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
        <p>Copyright © 2014-2015  XX xx.com 版权所有</p>
    </div>
</div><!--END FOOTER-->
</body>
</html>
