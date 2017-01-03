<%@ page import="java.util.StringTokenizer" %><%--
  Created by IntelliJ IDEA.
  User: xiebin
  Date: 2016/12/19
  Time: 下午1:20
  To change this template use File | Settings | File Templates.
--%>
<%@ page contentType="text/html;charset=UTF-8" language="java" pageEncoding="UTF-8" %>
<% request.setCharacterEncoding("utf-8"); %>
<html>
<head>
    <meta http-equiv="Content-Type" content="text/html; charset=UTF-8">
    <title>后台管理主页</title>
</head>
<body>
<div style="text-align: center">
    <div style="margin: 50px 0;"></div>
    <h3>系统信息</h3>
    <table width="70%" border="1" cellpadding="5" cellspacing="0" bgcolor="#cccccc" align="center">
        <%
            String agent = request.getHeader("user-agent");
            StringTokenizer str = new StringTokenizer(agent, ";");
        %>
        <tr>
            <th>用户的浏览器名</th>
            <td><% out.print(str.nextToken()); %></td>
        </tr>
        <tr>
            <th>用户的操作系统名</th>
            <td><% out.print(str.nextToken()); %></td>
        </tr>
        <tr>
            <th>本机的操作系统名</th>
            <td><%= System.getProperty("os.name") %></td>
        </tr>
        <tr>
            <th>本机的操作系统版本</th>
            <td><%= System.getProperty("os.version") %></td>
        </tr>
    </table>
    <h3>软件信息</h3>
    <table width="70%" border="1" cellpadding="5" cellspacing="0" bgcolor="#cccccc" align="center">
        <tr>
            <th>系统名称</th>
            <td>懒懒网电子商城</td>
        </tr>
        <tr>
            <th>开发者</th>
            <td>LazyIce</td>
        </tr>
        <tr>
            <th>github地址</th>
            <td><a href="http://www.imooc.com">http://www.imooc.com</a></td>
        </tr>
        <tr>
            <th>开发时间</th>
            <td>2016-12-08@Copyright</td>
        </tr>
    </table>
</div>

</body>
</html>
