<%@ page import="com.recycle.utils.DbOperation" %><%--
  Created by IntelliJ IDEA.
  User: xiebin
  Date: 2016/12/19
  Time: 下午2:04
  To change this template use File | Settings | File Templates.
--%>
<%@ page contentType="text/html;charset=UTF-8" language="java" pageEncoding="UTF-8" %>
<% request.setCharacterEncoding("gb2312"); %>
<html>
<head>
    <meta http-equiv="Content-Type" content="text/html; charset=UTF-8">
    <title>修改分类</title>
</head>
<%
    String id = request.getParameter("id");
    String sql = "select * from catalogue where id='"+id+"'";
    String[][] results = DbOperation.getRecord(sql);
%>
<body>
<h3>修改分类</h3>
<form action="/AdminServlet?act=editCate&id=<%= id %>" method="post">
    <table width="90%" border="1" cellpadding="5" cellspacing="0" bgcolor="#cccccc" align="center">
        <tr>
            <td align="right">分类名称</td>
            <td><input type="text" name="cName" value="<%= results[1][0]%>"/></td>
        </tr>
        <tr>
            <td colspan="2"><input type="submit"  value="修改分类"/></td>
        </tr>
    </table>
</form>
</body>
</html>
