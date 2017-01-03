<%--
  Created by IntelliJ IDEA.
  User: xiebin
  Date: 2016/12/18
  Time: 下午2:38
  To change this template use File | Settings | File Templates.
--%>
<%@ page contentType="text/html;charset=UTF-8" language="java" pageEncoding="UTF-8" %>
<html>
<head>
    <meta charset="utf-8">
    <title>管理员主页</title>
    <link rel="stylesheet" href="../styles/backstage.css">
</head>
<body>
<div class="head">
    <div class="logo fl"><a href="#"></a></div>
    <h3 class="head_text fr">懒懒网电子商务后台管理系统</h3>
</div>
<div class="operation_user clearfix">
    <div class="link fr">
        <b>欢迎您，
            <%
                String adminname = null;
                if (session.getAttribute("adminName") != null)
                    adminname = (String)session.getAttribute("adminName");
                else if (request.getCookies() != null) {
                    Cookie[] cookies;
                    cookies = request.getCookies();
                    if (cookies != null) {
                        for (int i = 0; i < cookies.length; i++) {
                            if (cookies[i].getName().equals("adminName"))
                                adminname = cookies[i].getValue();
                        }
                    }
                }
                if (adminname != null)
                    out.print(adminname);
                else
                    out.print("<script>alert('请先登录！');location.href='adminLogin.jsp';</script>");
            %>
        </b>&nbsp;&nbsp;&nbsp;&nbsp;<a href="#" class="icon icon_i">首页</a><span></span><a href="#" class="icon icon_j">前进</a><span></span><a href="#" class="icon icon_t">后退</a><span></span><a href="#" class="icon icon_n">刷新</a><span></span><a href="/AdminServlet?act=logout" class="icon icon_e">退出</a>
    </div>
</div>
<div class="content clearfix">
    <div class="main">
        <!--右侧内容-->
        <div class="cont">
            <div class="title">后台管理</div>
            <!-- 嵌套网页开始 -->
            <iframe src="adminMain.jsp" frameborder="0" name="mainFrame" width="100%" height="622"></iframe>
            <!-- 嵌套网页结束 -->
        </div>
    </div>
    <!--左侧列表-->
    <div class="menu">
        <div class="cont">
            <div class="title">管理员</div>
            <ul class="mList">
                <li>
                    <h3><span onclick="show('menu1','change1')" id="change1">+</span>商品管理</h3>
                    <dl id="menu1" style="display:none;">
                        <dd><a href="addProduct.jsp" target="mainFrame">添加商品</a></dd>
                        <dd><a href="listProduct.jsp" target="mainFrame">商品列表</a></dd>
                    </dl>
                </li>
                <li>
                    <h3><span onclick="show('menu2','change2')" id="change2">+</span>分类管理</h3>
                    <dl id="menu2" style="display:none;">
                        <dd><a href="addCatalog.jsp" target="mainFrame">添加分类</a></dd>
                        <dd><a href="listCatalog.jsp" target="mainFrame">分类列表</a></dd>
                    </dl>
                </li>
                <li>
                    <h3><span onclick="show('menu4','change4')" id="change4">+</span>用户管理</h3>
                    <dl id="menu4" style="display:none;">
                        <dd><a href="addUser.jsp" target="mainFrame">添加用户</a></dd>
                        <dd><a href="listUser.jsp" target="mainFrame">用户列表</a></dd>
                    </dl>
                </li>
                <li>
                    <h3><span onclick="show('menu5','change5')" id="change5">+</span>管理员管理</h3>
                    <dl id="menu5" style="display:none;">
                        <dd><a href="addAdmin.jsp" target="mainFrame">添加管理员</a></dd>
                        <dd><a href="listAdmin.jsp" target="mainFrame">管理员列表</a></dd>
                    </dl>
                </li>

                <li>
                    <h3><span onclick="show('menu6','change6')" id="change6">+</span>商品图片管理</h3>
                    <dl id="menu6" style="display:none;">
                        <dd><a href="listProImages.jsp" target="mainFrame">商品图片列表</a></dd>
                    </dl>
                </li>
            </ul>
        </div>
    </div>

</div>
<script type="text/javascript">
    function show(num,change){
        var menu=document.getElementById(num);
        var change=document.getElementById(change);
        if(change.innerHTML=="+"){
            change.innerHTML="-";
        }else{
            change.innerHTML="+";
        }
        if(menu.style.display=='none'){
            menu.style.display='';
        }else{
            menu.style.display='none';
        }
    }
</script>
</body>
</html>