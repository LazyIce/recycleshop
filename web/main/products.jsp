<%@ page import="com.recycle.utils.ShopUtil" %><%--
  Created by IntelliJ IDEA.
  User: xiebin
  Date: 2017/1/2
  Time: 下午3:24
  To change this template use File | Settings | File Templates.
--%>
<%@ page contentType="text/html;charset=UTF-8" language="java" %>
<% request.setCharacterEncoding("UTF-8"); %>
<html>
<head lang="en">
    <meta http-equiv="content-type" content="text/html; charset=UTF-8">
    <title>懒懒网网上商城</title>
    <link rel="stylesheet" href="../styles/reset.css" type="text/css"/>
    <link rel="stylesheet" href="../styles/notebook.css" type="text/css"/>
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
    }
    String keywords = request.getParameter("keyword");
    String catalogue = request.getParameter("catalogue");
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
    <div class="cat_list comwidth clearfix">
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
<div class="main comwidth">
    <div class="mini_site">
        <a href="index.jsp">懒懒网首页</a>
        <span class="right_next">&gt;</span>
        <span>笔记本</span>
    </div>
    <div class="goods_main clearfix">
        <div id="goodsLeft" class="fl goods_left">
            <dl>
                <dt>
                    <span class="angle right"></span>
                    热门国外品牌
                </dt>
                <dd><a href="#">Apple</a></dd>
                <dd><a href="#">Dell</a></dd>
                <dd><a href="#">HP</a></dd>
                <dd><a href="#">Samsung</a></dd>
                <dd><a href="#">Sony</a></dd>
            </dl>
            <dl>
                <dt>
                    <span class="angle right"></span>
                    热门国内品牌
                </dt>
                <dd><a href="#">联想</a></dd>
                <dd><a href="#">华硕</a></dd>
                <dd><a href="#">联想ThinkPad</a></dd>
                <dd><a href="#">宏碁</a></dd>
                <dd><a href="#">雷神</a></dd>
                <dd><a href="#">神舟</a></dd>
            </dl>
            <dl>
                <dt>
                    <span class="angle right"></span>
                    电脑整机
                </dt>
                <dd><a href="#">台式机</a></dd>
                <dd><a href="#">一体机</a></dd>
                <dd><a href="#">服务器</a></dd>
                <dd><a href="#">工作站</a></dd>
            </dl>
            <dl>
                <dt>
                    <span class="angle right"></span>
                    笔记本配件
                </dt>
                <dd><a href="#">笔记本CPU</a></dd>
                <dd><a href="#">笔记本内存</a></dd>
                <dd><a href="#">笔记本硬盘</a></dd>
                <dd><a href="#">笔记本散热器</a></dd>
                <dd><a href="#">笔记本电池</a></dd>
                <dd><a href="#">笔记本电脑包</a></dd>
            </dl>
        </div><!--END GOODS_LEFT-->
        <script type="text/javascript" src="../scripts/notebookLeftNav.js"></script>

        <div class="fr goods_right">
            <div class="goods_bottom">
                <div class="searchCond">
                    <div class="sort">
                        <a title="默认排序" href="javascript:void(0)" class="default">默认</a>
                        <a title="按时间从近到远" href="javascript:void(0)" class="price_up">时间</a>
                        <a title="按价格从高到低" href="javascript:void(0)" class="prices_down">价格</a>
                        <a title="按价格从低到高" href="javascript:void(0)" class="price_up">价格</a>
                    </div>
                </div>
                <div class="productTab clearfix">
                    <ul>
                        <%
                            String[][] products;
                            if (keywords == null) {
                                products = ShopUtil.getAllProducts(catalogue);
                            }
                            else
                                products = ShopUtil.searchAllProducts(keywords);
                            for (int i = 0; i < products[0].length; i++) {
                                String albumPath = ShopUtil.getAlbumPath(products[0][i]);
                        %>
                        <li>
                            <a href="proDetail.jsp?Pid=<%= products[0][i] %>" target="_blank"><img src="../uploads/<%= albumPath %>"/></a>
                            <div class="point">
                                <p><%= products[3][i] %></p>
                            </div>
                            <div class="infoBg">
                                <h3>
                                    <a href="proDetail.jsp?Pid=<%= products[0][i] %>" target="_blank">
                                        <p>
                                            <%= products[1][i] %>
                                        </p>
                                    </a>
                                </h3>
                            </div>
                            <div class="price_tag">
                                <p>&yen;<%= products[6][i] %></p>
                            </div>
                        </li>
                        <% } %>
                    </ul>
                </div>
                <div class="fr product_page">
                    <span class="prev_page">
                        <span class="angle left"></span>
                        上一页
                    </span>
                    <a href="#">1</a>
                    <a href="#">2</a>
                    <a href="#">3</a>
                    <a href="#">4</a>
                    <span>…</span>
                    <a href="#">10</a>
                    <span class="next_page">
                        下一页
                        <span class="angle right"></span>
                    </span>
                </div>
            </div><!--END GOODS_BOTTOM-->
        </div><!--END GOODS_RIGHT-->
        <script type="text/javascript" src="../scripts/goodsSelect.js"></script>
    </div><!--END GOODS_MAIN-->
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
        <p>Copyright © 2016-2017 Lazyice</p>
    </div>
</div><!--END FOOTER-->
</body>
</html>
