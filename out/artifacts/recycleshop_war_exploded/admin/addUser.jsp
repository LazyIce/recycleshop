<%--
  Created by IntelliJ IDEA.
  User: xiebin
  Date: 2016/12/19
  Time: 下午2:03
  To change this template use File | Settings | File Templates.
--%>
<%@ page contentType="text/html;charset=UTF-8" language="java" pageEncoding="UTF-8" %>
<% request.setCharacterEncoding("utf-8"); %>
<html>
<head>
    <meta http-equiv="Content-Type" content="text/html; charset=UTF-8">
    <title>添加用户</title>
</head>
<body>
<h3>添加用户</h3>
<form action="/AdminServlet?act=addUser" method="post" enctype="multipart/form-data">
    <table width="90%" border="1" cellpadding="5" cellspacing="0" bgcolor="#cccccc" align="center">
        <tr>
            <td align="right">用户名</td>
            <td><input type="text" name="username" placeholder="请输入用户名"/></td>
        </tr>
        <tr>
            <td align="right">密码</td>
            <td><input type="password" name="password" /></td>
        </tr>
        <tr>
            <td align="right">邮箱</td>
            <td><input type="text" name="email" placeholder="请输入邮箱"/></td>
        </tr>
        <tr>
            <td align="right">性别</td>
            <td><input type="radio" name="sex" value="男" checked="checked"/>男
                <input type="radio" name="sex" value="女" />女
                <input type="radio" name="sex" value="保密" />保密
            </td>
        </tr>
        <tr>
            <td align="right">头像</td>
            <td><input type="file" name="face" /></td>
        </tr>
        <tr>
            <td colspan="2"><input type="submit"  value="添加用户"/></td>
        </tr>

    </table>
</form>
</body>
</html>
