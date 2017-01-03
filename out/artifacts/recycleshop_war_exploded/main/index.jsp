<%@ page import="com.recycle.utils.ShopUtil" %>
<%@ page contentType="text/html;charset=UTF-8" language="java" %>
<% request.setCharacterEncoding("UTF-8"); %>
<html>
<head lang="en">
    <meta http-equiv="Content-Type" content="text/html; charset=UTF-8">
    <title>懒懒网网上购物商城：您购物的首选</title>
    <link rel="stylesheet" href="../styles/reset.css" type="text/css"/>
    <link rel="stylesheet" href="../styles/main.css" type="text/css"/>
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
    }

%>
<div class="header">
    <div class="header_top">
        <div class="comwidth">
            <div class="header_left">
                <span style="line-height: 30px;">Hi，欢迎来到懒懒网商城！</span>
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
        <div class="category clearfix">
            <span>
                <a href="#">全部商品分类</a>
            </span>
            <span class="angle down"></span>
        </div>
        <div class="search">
            <form target="_blank" method="post" action="/ShopServlet?act=search">
                <input type="text" name="search"/>
                <input type="submit" value="搜索" />
            </form>
        </div>
        <div id="user" class="user">
            <div id="userText" class="user_text">
                <img src="image/icon/user_24.png" alt="user"/>
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
        <!--购物车-->
        <div id="cart" class="cart clearfix">
            <div class="shop_text">
                <img src="image/icon/cart_24.png" alt="cart"/>
                <a href="cart.jsp">购物车</a>
                <span class="angle down"></span>
            </div>
            <div class="shop_num"><%= ShopUtil.totalOrders(username) %></div>
        </div>
    </div>
</div>
<div class="content comwidth">
    <div class="content_main clearfix">
        <div id="catLeft" class="cat_left">
            <%
                String[][] cName = ShopUtil.getAllCates();
            %>
            <ul>
                <%
                    for(int i = 0; i < cName[0].length; i++) {
                %>
                <li>
                    <s class="s1"></s>
                    <a href="products.jsp?catalogue=<%= cName[0][i] %>" target="_blank"><%= cName[0][i] %></a>
                    <span class="angle right"></span>
                    <div class="submenu">
                        <div class="leftdiv">
                            <dl>
                                <dt>二级菜单还没做</dt>
                                <dd>
                                    <a href="#">待开发</a> <a href="#">待开发</a> <a href="#">待开发</a> <a href="#">待开发</a> <a href="#">待开发</a> <a href="#">待开发</a>
                                </dd>
                            </dl>
                            <dl>
                                <dt>二级菜单还没做</dt>
                                <dd>
                                    <a href="#">待开发</a> <a href="#">待开发</a> <a href="#">待开发</a> <a href="#">待开发</a> <a href="#">待开发</a> <a href="#">待开发</a>
                                </dd>
                            </dl>
                            <dl>
                                <dt>二级菜单还没做</dt>
                                <dd>
                                    <a href="#">待开发</a> <a href="#">待开发</a> <a href="#">待开发</a> <a href="#">待开发</a> <a href="#">待开发</a> <a href="#">待开发</a>
                                </dd>
                            </dl>
                            <dl>
                                <dt>二级菜单还没做</dt>
                                <dd>
                                    <a href="#">待开发</a> <a href="#">待开发</a> <a href="#">待开发</a> <a href="#">待开发</a> <a href="#">待开发</a> <a href="#">待开发</a>
                                </dd>
                            </dl>
                        </div>
                    </div>
                </li>
                <% } %>
            </ul>
        </div><!--END CAT_LEFT-->

        <div class="nav_center">
            <div id="pic" class="pic">
                <ul>
                    <li style="display: block;">
                        <a href="#"><img src="image/ad/sale1.jpg"/></a>
                    </li>
                    <li>
                        <a href="#"><img src="image/ad/sale2.jpg"/></a>
                    </li>
                    <li>
                        <a href="#"><img src="image/ad/sale3.jpg"/></a>
                    </li>
                    <li>
                        <a href="#"><img src="image/ad/sale4.jpg"/></a>
                    </li>
                    <li>
                        <a href="#"><img src="image/ad/sale5.jpg"/></a>
                    </li>
                </ul>
            </div>
            <div id="num" class="num">
                <ul>
                    <li class="current"><a>1</a></li>
                    <li><a>2</a></li>
                    <li><a>3</a></li>
                    <li><a>4</a></li>
                    <li><a>5</a></li>
                </ul>
            </div>
        </div><!--END NAV_CENTER-->

        <div class="nav_right">
            <div class="logistics_top"><a target="_blank" href="logistics.jsp">物流排行榜</a></div>
            <div class="logistics_main">
                <dl class="month">
                    <dt>月物流之星</dt>
                    <dd>1. <img src="image/logo/sf.jpg" alt="SF"/><a href="#">顺丰物流</a></dd>
                    <dd>2. <img src="image/logo/yto.jpg" alt="YTO"/><a href="#">圆通物流</a></dd>
                    <dd>3. <img src="image/logo/db.jpg" alt="DB"/><a href="#">德邦物流</a></dd>
                </dl>
                <dl class="year">
                    <dt>年度物流之星</dt>
                    <dd>1. <img src="image/logo/sf.jpg" alt="SF"/><a href="#">顺丰物流</a></dd>
                    <dd>2. <img src="image/logo/yto.jpg" alt="YTO"/><a href="#">圆通物流</a></dd>
                    <dd>3. <img src="image/logo/zto.jpg" alt="ZTO"/><a href="#">中通物流</a></dd>
                    <dd>4. <img src="image/logo/db.jpg" alt="DB"/><a href="#">德邦物流</a></dd>
                    <dd>5. <img src="image/logo/ems.jpg" alt="EMS"/><a href="#">EMS物流</a></dd>
                </dl>
            </div>
        </div><!--END NAV_RIGHT-->
        <div class="content_recomm">
            <div class="recomm_title">
                <h2>生活优选</h2><h3>精彩每一天</h3>
            </div>
            <div class="recomm_goods">
                <%
                    String photoPath;
                    for (int i = 0; i < cName[0].length; i++) {
                        photoPath = ShopUtil.getRepresentPhoto(cName[0][i]);
                %>
                <div>
                    <div class="wrap_left">
                        <a class="s_link" href="#"></a>
                        <dl>
                            <dt><a href="products.jsp?catalogue=<%= cName[0][i] %>"><%= cName[0][i] %></a></dt>
                            <dd><a href="products.jsp?catalogue=<%= cName[0][i] %>">hot1</a></dd>
                            <dd><a href="products.jsp?catalogue=<%= cName[0][i] %>">hot2</a></dd>
                            <dd><a href="products.jsp?catalogue=<%= cName[0][i] %>">hot3</a></dd>
                        </dl>
                    </div>
                    <a href="products.jsp?catalogue=<%= cName[0][i] %>"><img src="../uploads/<%= photoPath %>" alt="代表图片"/></a>
                </div>
                <% } %>
            </div>
        </div>
    </div><!--END CONTENT_MAIN-->

</div><!--END CONTENT-->

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
</div>
<script type="text/javascript" src="../scripts/index.js"></script>
</body>
</html>

