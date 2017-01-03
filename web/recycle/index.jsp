<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8" %>
<% request.setCharacterEncoding("UTF-8"); %>
<%@ page session="true" %>
<!DOCTYPE html>
<html>
<head>
    <title>Home</title>
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
</head>
<body>
<!--header-->
<div class="header">
    <div class="header-top">
        <div class="container">
            <div class="header-left">
                <ul>
                    <li><a href="checkout.jsp"><%= username %>
                    </a></li>
                    <li><a href="../main/regist.jsp">注册</a></li>
                </ul>
                <div class="cart box_1">
                    <a href="checkout.jsp">
                        <h3><img src="../images/cart.png" alt=""/></h3>
                    </a>
                </div>
                <div class="clearfix"></div>
            </div>
            <div class="clearfix"></div>
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
            <div class="clearfix"></div>
        </div>
    </div>

</div>

<div class="banner">
    <div class="container">
        <script src="../scripts/responsiveslides.min.js"></script>
        <script>
            $(function () {
                $("#slider").responsiveSlides({
                    auto: true,
                    nav: true,
                    speed: 500,
                    namespace: "callbacks",
                    pager: true
                });
            });
        </script>
        <div id="top" class="callbacks_container">
            <ul class="rslides" id="slider">
                <li>
                    <div class="banner-text">
                        <h3>废旧电池的危害及现状</h3>
                        <p>
                            据国际消费据统计，日前全世界每年生产各类点池约250亿只，而我国就占了总量的1/2左右，而且并正在以每年20%的速度递增，国内市场每年消费量约为100亿只左右。据有关资料显示：电池中含有大量的重金属，如锌、铅、镉、汞、锰等。据专家测试，一粒纽扣电池能污染600立方米水。一节一号电池烂在地里，能使一平方米的土地失去利用价值。</p>
                        <a href="single.jsp">Learn More</a>
                    </div>
                </li>
                <li>
                    <div class="banner-text">
                        <h3>我们的目标</h3>
                        <p>废品回收利用的目的是；以节省资源，促进资源的循环利用。
                            现代生活中，废旧物品可谓无处不在。然而，当我们随手丢弃一些废旧物品的时候，我国每年正面临着严重的环境污染，花费着大量的治理费用！为此，国内许多专家认为，废品的回收和利用是一篇大文章，不仅节约资源保护生态环境，还有不少商机在里面。</p>
                        <a href="single.jsp">Learn More</a>
                    </div>
                </li>
                <li>
                    <div class="banner-text">
                        <h3>方便快捷的服务</h3>
                        <p>
                            我们为每个用户提供一个可以方便快捷地进行废品处理的平台，每个用户可以在该平台上发布自己想要丢弃的物品，通过回收点的上门收购来获取相应的积分，这些积分可以用来购买新的物品。同时，一些大型用户还可以通过直接联系收购商，从线上发展到线下，形成废品利用的良性循环。</p>
                        <a href="single.jsp">Learn More</a>
                    </div>
                </li>
            </ul>
        </div>
    </div>
</div>
<!--content-->
<div class="content">
    <div class="container">
        <div class="content-top">
            <h1>回收种类</h1>
            <div class="grid-in">
                <div class="clearfix"></div>
            </div>
            <div class="grid-in">
                <div class="col-md-4 grid-top">
                    <a href="single.jsp" class="b-link-stripe b-animate-go  thickbox"><img class="img-responsive" src="../images/battery.jpg" alt="">
                        <div class="b-wrapper">
                            <h3 class="b-animate b-from-left b-delay03 ">
                                <span>电池</span>
                            </h3>
                        </div>
                    </a>
                    <p><a href="single.jsp">电池</a></p>
                </div>
                <div class="col-md-4 grid-top">
                    <a href="single2.jsp" class="b-link-stripe b-animate-go thickbox"><img class="img-responsive" src="../images/LED.jpg" alt="">
                        <div class="b-wrapper">
                            <h3 class="b-animate b-from-left    b-delay03 ">
                                <span>LED</span>
                            </h3>
                        </div>
                    </a>
                    <p><a href="single2.jsp">LED</a></p>
                </div>
                <div class="col-md-4 grid-top">
                    <a href="single.jsp" class="b-link-stripe b-animate-go thickbox"><img class="img-responsive" src="../images/battery.jpg" alt="">
                        <div class="b-wrapper">
                            <h3 class="b-animate b-from-left    b-delay03 ">
                                <span>电池</span>
                            </h3>
                        </div>
                    </a>
                    <p><a href="single.jsp">电池</a></p>
                </div>
                <div class="clearfix"></div>
            </div>
        </div>
        <!----->

        <!---->

    </div>
    <div class="footer">
        <div class="container">
            <div class="footer-top-at">

                <div class="col-md-4 amet-sed">
                    <h4>MORE INFO</h4>
                    <ul class="nav-bottom">
                        <li><a href="#">How to order</a></li>
                        <li><a href="#">FAQ</a></li>
                        <li><a href="contact.jsp">Location</a></li>
                        <li><a href="#">Shipping</a></li>
                        <li><a href="#">Membership</a></li>
                    </ul>
                </div>
                <div class="col-md-4 amet-sed ">
                    <h4>CONTACT US</h4>

                    <p>
                        Contrary to popular belief</p>
                    <p>The standard chunk</p>
                    <p>office: +12 34 995 0792</p>
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
                        <input type="text" value="" onFocus="this.value='';" onBlur="if (this.value == '') {this.value ='';}">
                        <input type="submit" value="Sign up">
                    </form>
                </div>
                <div class="clearfix"></div>
            </div>
        </div>
    </div>
</div>
</body>
</html>