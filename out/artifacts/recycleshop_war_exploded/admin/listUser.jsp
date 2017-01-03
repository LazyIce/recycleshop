<%@ page import="com.recycle.utils.Page" %><%--
  Created by IntelliJ IDEA.
  User: xiebin
  Date: 2016/12/19
  Time: 下午2:09
  To change this template use File | Settings | File Templates.
--%>
<%@ page contentType="text/html;charset=UTF-8" language="java" pageEncoding="UTF-8" %>
<% request.setCharacterEncoding("utf-8"); %>
<html>
<head>
    <meta charset="utf-8">
    <title>用户列表</title>
    <link rel="stylesheet" href="../styles/backstage.css">
</head>
<body>
<div class="details">
    <div class="details_operation clearfix">
        <div class="bui_select">
            <input type="button" value="添&nbsp;&nbsp;加" class="add"  onclick="addUser()">
        </div>
    </div>
    <!--表格-->
    <table class="table" cellspacing="0" cellpadding="0" style="text-align: center">
        <thead>
        <tr>
            <th width="15%">编号</th>
            <th width="20%">用户名称</th>
            <th width="20%">用户邮箱</th>
            <th width="20%">是否激活</th>
            <th>操作</th>
        </tr>
        </thead>
        <tbody>
        <%
            int pageSize = 4;
            int pageNow = request.getParameter("page") == null? 1: Integer.parseInt(request.getParameter("page"));
            String[][] results = Page.getPageResults("user", pageSize, pageNow);
            int totalPage = Page.getTotalPage("user", pageSize);
            if (totalPage == 0) {
                out.print("<script>alert('对不起，没有用户！请先添加！'); location.href = 'addUser.jsp'</script>");
            }
            String str = "总共"+totalPage+"页/当前是第"+pageNow+"页";
            String index = pageNow == 1? "首页" : "<a href='listUser.jsp?page=1'>首页</a>";
            String last = pageNow == totalPage? "尾页" : "<a href='listUser.jsp?page="+totalPage+"'>尾页</a>";
            int prevPage = pageNow >= 1? pageNow-1: 1;
            int nextPage = pageNow >= totalPage? totalPage : pageNow+1;
            String prev = pageNow == 1? "上一页" : "<a href='listUser.jsp?page="+prevPage +"'>上一页</a>";
            String next = pageNow == totalPage? "下一页" : "<a href='listUser.jsp?page="+nextPage+"'>下一页</a>";

            for (int i = 0; i < results[0].length; i++) {
                String id = results[0][i];
                String usernmae = results[1][i];
                String email = results[3][i];
                String isActive = results[7][i]; %>
        <tr>
            <td><input type="checkbox" id="c1" class="check"><label for="c1" class="label"><%= id %></label></td>
            <td><%= usernmae %></td>
            <td><%= email %></td>
            <td><%= isActive.equals("0")?"未激活":"激活" %></td>
            <td align="center"><input type="button" value="修改" class="btn" onclick="editUser(<%= id %>)"><input type="button" value="删除" class="btn"  onclick="delUser(<%= id %>)"></td>
        </tr>
        <% } %>
        <tr>
            <td colspan="5">
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
                                p = "<a href='listUser.jsp?page="+i+"'>["+String.valueOf(i)+"]</a>";
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

    function addUser(){
        window.location="addUser.jsp";
    }
    function editUser(id){
        window.location="editUser.jsp?id="+id;
    }
    function delUser(id){
        if(window.confirm("您确定要删除吗？删除之后不能恢复哦！！！")){
            window.location="/AdminServlet?act=delUser&id="+id;
        }
    }
</script>
</html>
