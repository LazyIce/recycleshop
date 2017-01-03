<%--
  Created by IntelliJ IDEA.
  User: xiebin
  Date: 2016/12/19
  Time: 下午2:00
  To change this template use File | Settings | File Templates.
--%>
<%@ page contentType="text/html;charset=UTF-8" language="java" pageEncoding="utf-8" %>
<% request.setCharacterEncoding("utf-8"); %>
<html>
<head>
    <meta http-equiv="Content-Type" content="text/html; charset=UTF-8">
    <title>添加分类</title>
</head>
<body>
<h3>添加分类</h3>
<form action="/AdminServlet?act=addCate" method="post">
    <table width="90%" border="1" cellpadding="5" cellspacing="0" bgcolor="#cccccc" align="center">
        <tr>
            <td align="right">分类名称</td>
            <td><input type="text" name="cName" placeholder="请输入分类名称"/></td>
        </tr>
        <tr>
            <td colspan="2"><input type="submit"  value="添加分类"/></td>
        </tr>
    </table>
</form>
</body>
</html>
