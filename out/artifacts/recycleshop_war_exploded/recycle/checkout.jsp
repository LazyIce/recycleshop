<%@ page import="com.recycle.utils.DbOperation" %>
<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>
<% request.setCharacterEncoding("UTF-8"); %>
<html>
<head>
    <title>Checkout</title>
    <link href="../styles/bootstrap.css" rel="stylesheet" type="text/css" media="all"/>
    <script src="../scripts/jquery.min.js"></script>
    <link href="../styles/style.css" rel="stylesheet" type="text/css" media="all"/>
    <meta name="viewport" content="width=device-width, initial-scale=1">
    <meta http-equiv="Content-Type" content="text/html; charset=utf-8"/>
    <meta name="keywords" content="recycle"/>
    <script type="application/x-javascript"> addEventListener("load", function () {
        setTimeout(hideURLbar, 0);
    }, false);
    function hideURLbar() {
        window.scrollTo(0, 1);
    } </script>
    <link href='http://fonts.useso.com/css?family=Lato:100,300,400,700,900' rel='stylesheet' type='text/css'>
    <link href='http://fonts.useso.com/css?family=Roboto:400,100,300,500,700,900' rel='stylesheet' type='text/css'>
    <link href="../styles/memenu.css" rel="stylesheet" type="text/css" media="all"/>
    <script type="text/javascript" src="../scripts/memenu.js"></script>
    <script>$(document).ready(function () {
        $(".memenu").memenu();
    });</script>
    <script src="../scripts/simpleCart.min.js"></script>
</head>
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
<body>
<!--header-->
<div class="header">
    <div class="header-top">
        <div class="container">
            <div class="header-left">
                <ul>
                    <li ><a href="per_information.jsp"  ><%= username %></a></li>
                    <li><a  href="../main/regist.jsp"  >注册</a></li>
                </ul>
                <div class="cart box_1">
                    <a href="checkout.jsp">
                        <h3><img src="../images/cart.png" alt=""/></h3>
                    </a>
                </div>
                <div class="clearfix"> </div>
            </div>
            <div class="clearfix"> </div>
        </div>
    </div>
    <div class="container">
        <div class="head-top">
            <div class=" h_menu4">
                <ul class="memenu skyblue">
                    <li class="active grid"><a class="color8" href="index.jsp">主页</a></li>
                    <li><a class="color1" href="#">回收种类</a>
                        <div class="mepanel">
                            <div class="row">
                                <div class="col1">
                                    <div class="h_nav">
                                        <ul>
                                            <li><a href="single.jsp">电池</a></li>
                                            <li><a href="single2.jsp">LED</a></li>
                                        </ul>
                                    </div>
                                </div>
                            </div>
                        </div>
                    </li>
                    <li><a class="color1" href="feedback.jsp">给我们提建议</a></li>
                    <li><a class="color1" href="../main/index.jsp">积分兑换商城</a></li>
                </ul>
            </div>

            <div class="clearfix"> </div>
        </div>
    </div>
</div>
<div class="container">
    <%
        String sql = "select * from recycleOrders where uName='"+username+"'";
        int number = DbOperation.getResultNum(sql);
        String[][] orders = DbOperation.getRecord(sql);
    %>
    <div class="check">
        <h1>我的回收单 (<%= number %>)</h1>
        <div class="col-md-9 cart-items">
            <%
                int totalCredit = 0;
                for (int i=orders[0].length-1; i>=0;i--)
                {

                    out.println("<div class=\"cart-header"+i+"\">");
                    out.println("<div class=\"cart-sec simpleCart_shelfItem\">");
                    out.println("<div class=\"cart-item cyc\">");
                    if(orders[4][i].contains("电池"))
                    {
                        out.println("<img src=\"../images/battery.jpg\" class=\"img-responsive\" alt=\"\"/>");
                    }
                    else if(orders[4][i].contains("灯"))
                    {
                        out.println("<img src=\"../images/LED.jpg\" class=\"img-responsive\" alt=\"\"/>");
                    }
                    out.println("</div>");
                    out.println("<div class=\"cart-item-info\">");
                    out.println("<h3><a href=\"#\">"+orders[1][i]+"</a><span>提交时间："+orders[2][i]+"</span></h3>");
                    out.println("<ul class=\"qty\">");
                    out.println("<li><p>类型 : "+orders[4][i]+"</p></li>");
                    out.println("<li><p>数量 : "+orders[5][i]+"</p></li>");
                    out.println("</ul>");
                    out.println("<div class=\"delivery\">");
                    out.println("<p>获得积分："+orders[7][i]+"</p>");
                    out.println("<span>"+orders[6][i]+"</span>");
                    out.println("<div class=\"clearfix\"></div>");
                    out.println("</div>");
                    out.println("</div>");
                    out.println("<div class=\"clearfix\"></div>");
                    out.println("</div>");
                    out.println("</div>");
                    totalCredit += Integer.parseInt(orders[7][i]);
                }
            %>
        </div>
        <div class="col-md-3 cart-total">

            <div class="price-details">
                <h3>所获积分</h3>
                <span class="total1"><%= totalCredit %></span>
                <div class="clearfix"></div>
            </div>
        </div>

        <div class="clearfix"> </div>
    </div>
</div>


<!--//content-->
<div class="footer">
    <div class="container">
        <div class="footer-top-at">

            <div class="col-md-4 amet-sed">
                <h4>MORE INFO</h4>
                <ul class="nav-bottom">
                    <li><a href="#">How to order</a></li>
                    <li><a href="#">FAQ</a></li>
                    <li><a href="contact.html">Location</a></li>
                    <li><a href="#">Shipping</a></li>
                    <li><a href="#">Membership</a></li>
                </ul>
            </div>
            <div class="col-md-4 amet-sed ">
                <h4>CONTACT US</h4>

                <p>
                    Contrary to popular belief</p>
                <p>The standard chunk</p>
                <p>office:  +12 34 995 0792</p>
                <ul class="social">
                    <li><a href="#"><i> </i></a></li>
                    <li><a href="#"><i class="twitter"> </i></a></li>
                    <li><a href="#"><i class="rss"> </i></a></li>
                    <li><a href="#"><i class="gmail"> </i></a></li>

                </ul>
            </div>
            <div class="col-md-4 amet-sed">
                <h4>Newsletter</h4>
                <p>Sign Up to get all news update
                    and promo</p>
                <form>
                    <input type="text" value="" onfocus="this.value='';" onblur="if (this.value == '') {this.value ='';}">
                    <input type="submit" value="Sign up">
                </form>
            </div>
            <div class="clearfix"> </div>
        </div>
    </div>
    <div class="footer-class">
        <p >Copyright &copy; 2015.Company name All rights reserved.More Templates <a href="http://www.cssmoban.com/" target="_blank" title="模板之家">模板之家</a> - Collect from <a href="http://www.cssmoban.com/" title="网页模板" target="_blank">网页模板</a></p>
    </div>
</div>
</body>
</html>
