<%--
  Created by IntelliJ IDEA.
  User: xiebin
  Date: 2016/12/17
  Time: 下午6:48
  To change this template use File | Settings | File Templates.
--%>
<%@ page contentType="text/html;charset=UTF-8" language="java" pageEncoding="UTF-8" %>
<% request.setCharacterEncoding("utf-8"); %>
<html>
<head lang="en">
    <meta http-equiv="Content-Type" content="text/html; charset=UTF-8">
    <title>登录</title>
    <link rel="stylesheet" href="../styles/reset.css" type="text/css"/>
    <link rel="stylesheet" href="../styles/login.css" type="text/css"/>
    <script src="../scripts/jquery-1.6.js" type="text/javascript"></script>
</head>
<body>
<div class="header">
    <div class="login_top comwidth">
        <span><a href="index.jsp"></a></span>
        <span><h1>欢迎登录</h1></span>
    </div>
</div>
<div class="login_main comwidth">
    <form action="/UserServlet?act=login" name="login" method="post">
        <div class="login_txtbox">
            <label class="lab_input">用户名/邮箱/手机号</label>
            <img src="image/icon/login_user.png"/>
            <input type="text" name="username"/>
        </div>
        <div class="login_txtbox">
            <label class="lab_input">密码</label>
            <img src="image/icon/login_passwd.png"/>
            <input type="password" name="password"/>
        </div>
        <input type="checkbox" name="autoFlag" style="margin-top: 20px;"/>
        <label>自动登录</label>
        <input type="submit" value="登 录"/>
    </form>
    <p>
        <a href="/UserServlet?act=findPassword">忘记密码</a>|
        <a href="regist.jsp">免费注册</a>
    </p>
</div>
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
</div>
<script type="text/javascript" src="../scripts/login.js"></script>
</body>
</html>
