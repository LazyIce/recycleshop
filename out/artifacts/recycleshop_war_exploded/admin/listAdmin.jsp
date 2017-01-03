<%@ page import="com.recycle.utils.DbOperation" %>
<%@ page import="com.recycle.utils.Page" %><%--
  Created by IntelliJ IDEA.
  User: xiebin
  Date: 2016/12/19
  Time: 下午1:43
  To change this template use File | Settings | File Templates.
--%>
<%@ page contentType="text/html;charset=UTF-8" language="java" pageEncoding="UTF-8" %>
<html>
<head>
    <meta charset="utf-8">
    <title>管理员列表</title>
    <link rel="stylesheet" href="../styles/backstage.css">
</head>
<body>
<div class="details">
    <div class="details_operation clearfix">
        <div class="bui_select">
            <input type="button" value="添&nbsp;&nbsp;加" class="add"  onclick="addAdmin()">
        </div>
    </div>
    <!--表格-->
    <table class="table" cellspacing="0" cellpadding="0" style="text-align: center">
        <thead>
        <tr>
            <th width="15%">编号</th>
            <th width="25%">管理员名称</th>
            <th width="30%">管理员邮箱</th>
            <th>操作</th>
        </tr>
        </thead>
        <tbody>
        <%
            int pageSize = 4;
            int pageNow = request.getParameter("page") == null? 1: Integer.parseInt(request.getParameter("page"));
            String[][] results = Page.getPageResults("admin", pageSize, pageNow);
            int totalPage = Page.getTotalPage("admin", pageSize);
            if (totalPage == 0) {
                out.print("<script>alert(''对不起，没有管理员，请先添加！); location.href = 'addAdmin.jsp'</script>");
            }
            String index = pageNow == 1? "首页" : "<a href='listAdmin.jsp?page=1'>首页</a>";
            String last = pageNow == totalPage? "尾页" : "<a href='listAdmin.jsp?page="+totalPage+"'>尾页</a>";
            int prevPage = pageNow >= 1? pageNow-1: 1;
            int nextPage = pageNow >= totalPage? totalPage : pageNow+1;
            String prev = pageNow == 1? "上一页" : "<a href='listAdmin.jsp?page="+prevPage +"'>上一页</a>";
            String next = pageNow == totalPage? "下一页" : "<a href='listAdmin.jsp?page="+nextPage+"'>下一页</a>";

            for (int i = 0; i < results[0].length; i++) {
            String id = results[0][i];
            String adminname = results[1][i];
            String email = results[3][i]; %>
        <tr>
            <td><input type="checkbox" id="c1" class="check"><label for="c1" class="label"><%= id %></label></td>
            <td><%= adminname %></td>
            <td><%= email %></td>
            <td align="center"><input type="button" value="修改" class="btn" onclick="editAdmin(<%= id %>)"><input type="button" value="删除" class="btn" onclick="delAdmin(<%= id %>)"></td>
        </tr>
        <% } %>
        <tr>
            <td colspan="4">
                <span>总共<%= totalPage%>页/当前是第<%= pageNow%>页</span>
                <span><% out.print(index); %></span>
                <span><% out.print(prev); %></span>
                <span>
                    <%
                        String p = null;
                        for (int i = 1; i <= totalPage; i++) {
                            if (pageNow == i) {
                                p = String.valueOf(i);
                                out.print(p);
                            }
                            else {
                                p = "<a href='listAdmin.jsp?page="+i+"'>["+String.valueOf(i)+"]</a>";
                                out.print(p);}
                        }
                    %>
                </span>
                <span><% out.print(next); %></span>
                <span><% out.print(last); %></span>
            </td>
        </tr>
        </tbody>
    </table>
</div>
</body>
<script type="text/javascript">

    function addAdmin(){
        window.location="addAdmin.jsp";
    }
    function editAdmin(id){
        window.location="editAdmin.jsp?id="+id;
    }
    function delAdmin(id){
        if(window.confirm("您确定要删除吗？删除之后不能恢复哦！！！")){
            window.location="/AdminServlet?act=delAdmin&id="+id;
        }
    }
</script>
</html>
