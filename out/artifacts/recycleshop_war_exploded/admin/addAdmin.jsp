<%--
  Created by IntelliJ IDEA.
  User: xiebin
  Date: 2016/12/19
  Time: 下午1:42
  To change this template use File | Settings | File Templates.
--%>
<%@ page contentType="text/html;charset=UTF-8" language="java" pageEncoding="UTF-8" %>
<% request.setCharacterEncoding("utf-8"); %>
<html>
<head>
    <meta http-equiv="Content-Type" content="text/html; charset=UTF-8">
    <title>添加管理员</title>
</head>
<body>
<h3>添加管理员</h3>
<form action="/AdminServlet?act=addAdmin" method="post">
    <table width="90%" border="1" cellpadding="5" cellspacing="0" bgcolor="#cccccc" align="center">
        <tr>
            <td align="right">管理员名称</td>
            <td><input type="text" name="adminname" placeholder="请输入管理员名称"/></td>
        </tr>
        <tr>
            <td align="right">管理员密码</td>
            <td><input type="password" name="password" /></td>
        </tr>
        <tr>
            <td align="right">管理员邮箱</td>
            <td><input type="text" name="email" placeholder="请输入管理员邮箱"/></td>
        </tr>
        <tr>
            <td colspan="2"><input type="submit"  value="添加管理员"/></td>
        </tr>
    </table>
</form>
</body>
</html>
