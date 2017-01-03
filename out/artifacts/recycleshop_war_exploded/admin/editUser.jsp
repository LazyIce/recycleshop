<%@ page import="com.recycle.utils.DbOperation" %><%--
  Created by IntelliJ IDEA.
  User: xiebin
  Date: 2016/12/19
  Time: 下午2:07
  To change this template use File | Settings | File Templates.
--%>
<%@ page contentType="text/html;charset=UTF-8" language="java" pageEncoding="UTF-8" %>
<% request.setCharacterEncoding("utf-8"); %>
<html>
<head>
    <meta http-equiv="Content-Type" content="text/html; charset=UTF-8">
    <title>编辑用户</title>
</head>
<body>
<h3>编辑用户</h3>
<%
    String id = request.getParameter("id");
    String sql = "select * from user where id='"+id+"'";
    String[][] results = DbOperation.getRecord(sql);
%>
<form action="/AdminServlet?act=editUser&id=<%= id %>" method="post">
    <table width="90%" border="1" cellpadding="5" cellspacing="0" bgcolor="#cccccc" align="center">
        <tr>
            <td align="right">用户名</td>
            <td><input type="text" name="username" value="<%= results[1][0] %>"/></td>
        </tr>
        <tr>
            <td align="right">密码</td>
            <td><input type="password" name="password"/></td>
        </tr>
        <tr>
            <td align="right">邮箱</td>
            <td><input type="text" name="email" value="<%= results[3][0] %>"/></td>

        </tr>
        <tr>
            <td align="right">性别</td>
            <td><input type="radio" name="sex" value="男"  <%= results[4][0].equals("男") ? "checked='checked'":"" %> />男
                <input type="radio" name="sex" value="女" <%= results[4][0].equals("男") ? "checked='checked'":"" %> />女
                <input type="radio" name="sex" value="保密" <%= results[4][0].equals("男")? "checked='checked'":"" %> />保密
            </td>
        </tr>
        <tr>
            <td colspan="2"><input type="submit"  value="编辑用户"/></td>
        </tr>
    </table>
</form>
</body>
</html>
