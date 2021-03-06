<%--
  Created by IntelliJ IDEA.
  User: xiebin
  Date: 2016/12/20
  Time: 下午4:04
  To change this template use File | Settings | File Templates.
--%>
<%@ page contentType="text/html;charset=UTF-8" language="java" pageEncoding="UTF-8" %>
<html>
<head lang="en">
    <meta http-equiv="Content-Type" content="text/html; charset=UTF-8">
    <title>注册XX</title>
    <link rel="stylesheet" href="../styles/reset.css" type="text/css"/>
    <link rel="stylesheet" href="../styles/register.css" type="text/css"/>
    <script src="../scripts/jquery-1.6.js" type="text/javascript"></script>
    <script type="text/javascript">
        function reloadImage() {
            var image = document.getElementById("verifyCodeImage");
            image.setAttribute("src", "/ImageServlet?nocachae="+Math.random());
        }
    </script>
</head>
<body>
<div class="header">
    <div class="comwidth">
        <div class="header_left">
            Hi，欢迎来到懒懒网商城！
        </div>
        <ul class="header_right">
            <li><a href="#">帮助</a></li>
            <li><a href="#">物流信息</a></li>
            <li><a href="#">我的订单</a></li>
            <li><a href="regist.jsp">[免费注册]</a></li>
            <li><a href="login.jsp">[请登录]</a></li>
        </ul>
    </div>
</div>
<div class="reg_main">
    <div class="reg_top comwidth">
        <span><a href="index.jsp"></a></span>
        <span><h1>欢迎注册</h1></span>
    </div>
    <div class="reg_wrap comwidth">
        <div id="regMenu" class="reg_menu clearfix">
            <ul>
                <li class="email_menu selected"><img src="image/icon/email_24.png"/>邮箱注册</li>
                <li class="phone_menu"><img src="image/icon/phone_24.png"/>手机注册</li>
            </ul>
        </div>
        <div id="regBoxEmail" class="reg_box email">
            <div>
                <form action="/RegistServlet" name="register" method="post">
                    <ul>
                        <li>
                            <div class="reg_txtbox">
                                <label class="lab_name">用户名：</label>
                                <!--<i class="icon_username"></i>-->
                                <img src="image/icon/login_user.png"/>
                                <input class="username" maxlength="20" type="text" name="username"/>
                                <label class="lab_note">请输入用户名</label>
                            </div>
                        </li>
                        <li>
                            <div class="reg_txtbox">
                                <label class="lab_name">邮箱：</label>
                                <!--<i class="icon_username"></i>-->
                                <img src="image/icon/email_16.png"/>
                                <input class="email" maxlength="20" type="text" name="email"/>
                                <label class="lab_note">请输入邮箱地址</label>
                            </div>
                        </li>
                        <li>
                            <div class="reg_txtbox">
                                <label class="lab_name">设置密码：</label>
                                <!--<i class="icon_passwd"></i>-->
                                <img src="image/icon/login_passwd.png"/>
                                <input class="passwd" maxlength="20" type="password" name="password"/>
                                <label class="lab_note">6-20个字符</label>
                            </div>
                        </li>
                        <li>
                            <div class="reg_txtbox">
                                <label class="lab_name">确认密码：</label>
                                <!--<i class="icon_passwd"></i>-->
                                <img src="image/icon/login_passwd.png"/>
                                <input class="confirm" maxlength="20" type="password"/>
                                <label class="lab_note">请再次输入密码</label>
                            </div>
                        </li>
                    </ul>
                    <div class="reg_verifycode">
                        <div class="verify_val">
                            <label class="lab_name">验证码：</label>
                            <input class="verify" maxlength="4" type="text" name="verify"/>
                        </div>
                        <span class="verify_img"><img id="verifyCodeImage" src="/ImageServlet"/></span>
                        <a href="javascript:reloadImage()" class="change_code">换一张</a>
                    </div>
                    <span class="agreement">
                        <input type="checkbox"/>
                        <label>我已经阅读并同意《<a href="#">懒懒网服务协议</a>》</label>
                    </span>
                    <input type="submit" value="注 册"/>
                </form>
            </div>
        </div>
        <div id="regBoxPhone" class="reg_box phone">
            <div>
                <form action="/RegistServlet" name="register" method="post">
                    <ul>
                        <li>
                            <div class="reg_txtbox">
                                <label class="lab_name">手机号：</label>
                                <!--<i class="icon_username"></i>-->
                                <img class="img_phone" src="image/icon/phone_16.png"/>
                                <input class="mobilephone" maxlength="11" type="text"/>
                                <label class="lab_note">请输入手机号码</label>
                            </div>
                        </li>
                        <li>
                            <div class="reg_txtbox">
                                <label class="lab_name">设置密码：</label>
                                <!--<i class="icon_passwd"></i>-->
                                <img src="image/icon/login_passwd.png"/>
                                <input maxlength="20" class="passwd" type="password"/>
                                <label class="lab_note">6-20个字符</label>
                            </div>
                        </li>
                        <li>
                            <div class="reg_txtbox">
                                <label class="lab_name">确认密码：</label>
                                <!--<i class="icon_passwd"></i>-->
                                <img src="image/icon/login_passwd.png"/>
                                <input maxlength="20" class="passwd confirm" type="password"/>
                                <label class="lab_note">请再次输入密码</label>
                            </div>
                        </li>
                    </ul>
                    <div class="reg_verifycode">
                        <div class="verify_val">
                            <label class="lab_name">验证码：</label>
                            <input class="verify" maxlength="4" type="text"/>
                        </div>
                        <span class="verify_img"><img src="/ImageServlet"/></span>
                        <a href="javascript:reloadImage()" class="change_code">换一张</a>
                    </div>
                    <span class="agreement">
                        <input type="checkbox"/>
                        <label>我已经阅读并同意《<a href="#">懒懒网服务协议</a>》</label>
                    </span>
                    <input type="submit" value="注 册"/>
                </form>
            </div>
        </div>
    </div>
</div>
<script type="text/javascript" src="../scripts/register.js"></script>
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
        <p>Copyright © 2016-2017  Lazyice</p>
    </div>
</div>
</body>
</html>

