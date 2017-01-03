<%--
  Created by IntelliJ IDEA.
  User: xiebin
  Date: 2016/12/23
  Time: 下午9:01
  To change this template use File | Settings | File Templates.
--%>
<%@ page contentType="text/html;charset=UTF-8" language="java" pageEncoding="UTF-8" %>
<% request.setCharacterEncoding("utf-8"); %>
<!doctype html>
<html>
<head>
    <meta charset="utf-8">
    <title>登陆</title>
    <link type="text/css" rel="stylesheet" href="../styles/reset.css">
    <link type="text/css" rel="stylesheet" href="../styles/admin.css">
    <script type="text/javascript">
        function reloadImage() {
            var image = document.getElementById("verifyCodeImage");
            image.setAttribute("src", "/ImageServlet?nocachae="+Math.random());
        }
    </script>
</head>
<body>
<div class="headerBar">
    <div class="logoBar login_logo">
        <div class="comWidth">
            <div class="logo fl">
                <a href="#"><img src="../images/logo.jpg" alt="懒懒网"></a>
            </div>
            <h3 class="welcome_title">欢迎登陆</h3>
        </div>
    </div>
</div>
<div class="loginBox">
    <div class="login_cont">
        <form action="/AdminServlet?act=login" method="post">
            <ul class="login">
                <li class="l_tit">管理员帐号</li>
                <li class="mb_10"><input type="text"  name="adminname" placeholder="请输入管理员帐号"class="login_input user_icon"></li>
                <li class="l_tit">密码</li>
                <li class="mb_10"><input type="password"  name="password" class="login_input password_icon"></li>
                <li class="l_tit">验证码</li>
                <li class="mb_10"><input type="text" name="verify" class="login_input password_icon"></li>
                <img id="verifyCodeImage" src="/ImageServlet" alt="验证码" /><a href="javascript:reloadImage()">看不清楚，换一张</a>
                <li class="autoLogin"><input type="checkbox" id="a1" class="checked" name="autoFlag" value="1"><label for="a1">自动登陆(一周内自动登陆)</label></li>
                <li><input type="submit" value="" class="login_btn"></li>
            </ul>
        </form>
    </div>
</div>
<div class="hr_25"></div>
<div class="footer">
    <p><a href="#">懒懒简介</a><i>|</i><a href="#">懒懒公告</a><i>|</i> <a href="#">招纳贤士</a><i>|</i><a href="#">联系我们</a><i>|</i>客服热线：400-675-1234</p>
    <p>Copyright &copy; 2016 - 2017 懒懒版权所有&nbsp;&nbsp;&nbsp;沪ICP备09037834号&nbsp;&nbsp;&nbsp;沪ICP证B1034-8373号&nbsp;&nbsp;&nbsp;上海市公安局普陀区分局备案编号：123456789123</p>
    <p class="web"><a href="#"><img src="images/webLogo.jpg" alt="logo"></a><a href="#"><img src="images/webLogo.jpg" alt="logo"></a><a href="#"><img src="images/webLogo.jpg" alt="logo"></a><a href="#"><img src="images/webLogo.jpg" alt="logo"></a></p>
</div>
</body>
</html>

