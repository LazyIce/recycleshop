<%@ page import="com.recycle.utils.DbOperation" %><%--
  Created by IntelliJ IDEA.
  User: xiebin
  Date: 2016/12/19
  Time: 下午1:54
  To change this template use File | Settings | File Templates.
--%>
<%@ page contentType="text/html;charset=UTF-8" language="java" pageEncoding="UTF-8" %>
<% request.setCharacterEncoding("utf-8"); %>
<html>
<head>
    <meta http-equiv="Content-Type" content="text/html; charset=UTF-8">
    <title>编辑管理员</title>
</head>
<body>
<h3>编辑管理员</h3>
<%
    String id = request.getParameter("id");
    String sql = "select * from admin where id='"+id+"'";
    String[][] results = DbOperation.getRecord(sql);
%>
<form action="/AdminServlet?act=editAdmin&id=<%= id %>" method="post">
    <table width="90%" border="1" cellpadding="5" cellspacing="0" bgcolor="#cccccc" align="center">
        <tr>
            <td align="right">管理员名称</td>
            <td><input type="text" name="adminname" value="<%= results[1][0] %>"/></td>
        </tr>
        <tr>
            <td align="right">管理员密码</td>
            <td><input type="password" name="password"  value="<%= results[2][0] %>"/></td>
        </tr>
        <tr>
            <td align="right">管理员邮箱</td>
            <td><input type="text" name="email" value="<%= results[3][0] %>"/></td>
        </tr>
        <tr>
            <td colspan="2"><input type="submit"  value="编辑管理员"/></td>
        </tr>
    </table>
</form>
</body>
</html>
