<%@ page import="com.recycle.utils.DbOperation" %>
<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>
<%@ page session= "true"%>
<!DOCTYPE html>
<html>
<head>
    <title>Signle2</title>
    <link href="../styles/bootstrap.css" rel="stylesheet" type="text/css" media="all" />
    <script src="../scripts/jquery.min.js"></script>
    <link href="../styles/style.css" rel="stylesheet" type="text/css" media="all" />
    <meta name="viewport" content="width=device-width, initial-scale=1">
    <meta http-equiv="Content-Type" content="text/html; charset=utf-8" />
    <meta name="keywords" content="recycle" />
    <script type="application/x-javascript"> addEventListener("load", function() { setTimeout(hideURLbar, 0); }, false); function hideURLbar(){ window.scrollTo(0,1); } </script>
    <link href='http://fonts.useso.com/css?family=Lato:100,300,400,700,900' rel='stylesheet' type='text/css'>
    <link href='http://fonts.useso.com/css?family=Roboto:400,100,300,500,700,900' rel='stylesheet' type='text/css'>
    <link href="../styles/memenu.css" rel="stylesheet" type="text/css" media="all" />
    <script type="text/javascript" src="../scripts/memenu.js"></script>
    <script>$(document).ready(function(){$(".memenu").memenu();});</script>
    <script src="../scripts/simpleCart.min.js"> </script>
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
                    <li ><a href="checkout.jsp" ><%= username %></a></li>
                    <li><a href="../main/regist.jsp"  >注册</a></li>
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
                    <li><a class="color1" href="index.jsp">主页</a></li>
                    <li class="active grid"><a class="color8" href="#">回收种类</a>
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
<!--content-->
<!---->
<div class="product">
    <div class="container">
        <div class="col-md-3 product-price">
            <div class=" rsidebar span_1_of_left">
                <div class="of-left">
                    <h3 class="cate">Categories</h3>
                </div>
                <ul class="menu">
                    <li class="item1"><a href="#">电池 </a>
                    </li>
                    <li class="item2"><a href="#">LED灯 </a>
                    </li>
                </ul>
            </div>
            <!--initiate accordion-->
            <script type="text/javascript">
                $(function() {
                    var menu_ul = $('.menu > li > ul'),
                            menu_a  = $('.menu > li > a');
                    menu_ul.hide();
                    menu_a.click(function(e) {
                        e.preventDefault();
                        if(!$(this).hasClass('active')) {
                            menu_a.removeClass('active');
                            menu_ul.filter(':visible').slideUp('normal');
                            $(this).addClass('active').next().stop(true,true).slideDown('normal');
                        } else {
                            $(this).removeClass('active');
                            $(this).next().stop(true,true).slideUp('normal');
                        }
                    });

                });
            </script>
            <!---->
            <div class="product-middle">
                <div class="fit-top">
                    <h6 class="shop-top">Lorem Ipsum</h6>
                    <a href="single.jsp" class="shop-now">SHOP NOW</a>
                    <div class="clearfix"> </div>
                </div>
            </div>
        </div>
        <div class="col-md-9 product-price1">
            <div class="col-md-5 single-top">
                <div class="flexslider">
                    <ul class="slides">
                        <li data-thumb="../images/LED.jpg">
                            <img src="../images/LED.jpg" />
                        </li>
                        <li data-thumb="../images/LED.jpg">
                            <img src="../images/LED.jpg" />
                        </li>
                        <li data-thumb="../images/LED.jpg">
                            <img src="../images/LED.jpg" />
                        </li>
                        <li data-thumb="../images/LED.jpg">
                            <img src="../images/LED.jpg" />
                        </li>
                    </ul>
                </div>
                <!-- FlexSlider -->
                <script defer src="../scripts/jquery.flexslider.js"></script>
                <link rel="stylesheet" href="../styles/flexslider.css" type="text/css" media="screen" />
                <script>
                    // Can also be used with $(document).ready()
                    $(window).load(function() {
                        $('.flexslider').flexslider({
                            animation: "slide",
                            controlNav: "thumbnails"
                        });
                    });
                </script>
            </div>
            <div class="col-md-7 single-top-in simpleCart_shelfItem">
                <form  method="post" action="/RecycleServlet?act=addOrder&username=<%= username %>">
                    <div class="single-para ">
                        <h4>废旧灯泡 </h4>
                        <div class="star-on">
                            <ul class="star-footer">
                                <li><a href="#"><i> </i></a></li>
                                <li><a href="#"><i> </i></a></li>
                                <li><a href="#"><i> </i></a></li>
                                <li><a href="#"><i> </i></a></li>
                                <li><a href="#"><i> </i></a></li>
                            </ul>
                            <div class="review">
                                <a href="#"> 1 customer review </a>
                            </div>
                            <div class="clearfix"> </div>
                        </div>
                        <h5 class="item_price">5积分/per</h5>
                        <p>请在下方选择要发布的灯泡的数量及种类，种类若不明确，请参考左图   </p>
                        <div class="available">
                            <ul>
                                <li>数量
                                    <select id="number" name="number">
                                        <option>1</option>
                                        <option>5</option>
                                        <option>10</option>
                                        <option>100</option>
                                    </select></li>
                                <li class="size-in">种类<select id="type" name="type">
                                    <option>钨丝灯 </option>
                                    <option>荧光灯 </option>
                                    <option>LED灯 </option>
                                </select></li>
                                <div class="clearfix"> </div>
                            </ul>
                        </div>
                        <ul class="tag-men">
                            <li><span>标签</span>
                                <span class="women1">: 灯泡  回收</span></li>
                        </ul>
                        <input type="submit" value="提交">
                    </div>
                </form>
            </div>
            <div class="clearfix"> </div>
            <!---->
            <div class="cd-tabs">
                <ul class="cd-tabs-content">
                    <li data-content="fashion" >
                        <div class="facts">
                            <p > There are many variations of passages of Lorem Ipsum available, but the majority have suffered alteration in some form, by injected humour, or randomised words which don't look even slightly believable. If you are going to use a passage of Lorem Ipsum, you need to be sure there isn't anything embarrassing hidden in the middle of text. All the Lorem Ipsum generators on the Internet tend to repeat predefined chunks as necessary, making this the first true generator on the Internet. It uses a dictionary of over 200 Latin words, combined </p>
                            <ul>
                                <li>Research</li>
                                <li>Design and Development</li>
                                <li>Porting and Optimization</li>
                                <li>System integration</li>
                                <li>Verification, Validation and Testing</li>
                                <li>Maintenance and Support</li>
                            </ul>
                        </div>
                    </li>
                    <li data-content="cinema" >
                        <div class="facts1">
                            <div class="color"><p>Color</p>
                                <span >Blue, Black, Red</span>
                                <div class="clearfix"></div>
                            </div>
                            <div class="color">
                                <p>Size</p>
                                <span >S, M, L, XL</span>
                                <div class="clearfix"></div>
                            </div>
                        </div>
                    </li>
                    <div class="clearfix"></div>
                </ul>
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
        <p >Copyright &copy; 2015.Company name All rights reserved.More Templates <a href="http://www.cssmoban.com/" target="_blank" title="æ¨¡æ¿ä¹å®¶">æ¨¡æ¿ä¹å®¶</a> - Collect from <a href="http://www.cssmoban.com/" title="ç½é¡µæ¨¡æ¿" target="_blank">ç½é¡µæ¨¡æ¿</a></p>
    </div>
</div>
</body>
</html>
