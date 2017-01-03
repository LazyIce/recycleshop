<%@ page import="com.recycle.utils.Page" %><%--
  Created by IntelliJ IDEA.
  User: xiebin
  Date: 2016/12/19
  Time: 下午2:08
  To change this template use File | Settings | File Templates.
--%>
<%@ page contentType="text/html;charset=utf-8" language="java" pageEncoding="UTF-8"%>
<% request.setCharacterEncoding("UTF-8"); %>
<html>
<head>
    <meta http-equiv="Content-Type" content="text/html; charset=UTF-8">
    <title>目录列表</title>
    <link rel="stylesheet" href="../styles/backstage.css">
</head>
<body>
<div class="details">
    <div class="details_operation clearfix">
        <div class="bui_select">
            <input type="button" value="添&nbsp;&nbsp;加" class="add"  onclick="addCate()">
        </div>

    </div>
    <!--表格-->
    <table class="table" cellspacing="0" cellpadding="0" style="text-align: center">
        <thead>
        <tr>
            <th width="15%">编号</th>
            <th width="25%">分类</th>
            <th>操作</th>
        </tr>
        </thead>
        <tbody>
        <%
            int pageSize = 4;
            int pageNow = request.getParameter("page") == null? 1: Integer.parseInt(request.getParameter("page"));
            String[][] results = Page.getPageResults("catalogue", pageSize, pageNow);
            int totalPage = Page.getTotalPage("catalogue", pageSize);
            if (totalPage == 0) {
                out.print("<script>alert('对不起，没有分类，请先添加！'); location.href = 'addCatalog.jsp'</script>");
            }
            String index = pageNow == 1? "首页" : "<a href='listCatalog.jsp?page=1'>首页</a>";
            String last = pageNow == totalPage? "尾页" : "<a href='listCatalog.jsp?page="+totalPage+"'>尾页</a>";
            int prevPage = pageNow >= 1? pageNow-1: 1;
            int nextPage = pageNow >= totalPage? totalPage : pageNow+1;
            String prev = pageNow == 1? "上一页" : "<a href='listCatalog.jsp?page="+prevPage +"'>上一页</a>";
            String next = pageNow == totalPage? "下一页" : "<a href='listCatalog.jsp?page="+nextPage+"'>下一页</a>";

            for (int i = 0; i < results[0].length; i++) {
                String id = results[0][i];
                String cName = results[1][i];
        %>
        <tr>
            <td><input type="checkbox" id="c1" class="check"><label for="c1" class="label"><%= id %></label></td>
            <td><%= cName %></td>
            <td align="center"><input type="button" value="修改" class="btn" onclick="editCate(<%= id %>)"><input type="button" value="删除" class="btn"  onclick="delCate(<%= id %>)"></td>
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
                                p = "<a href='listCatalog.jsp?page="+i+"'>["+String.valueOf(i)+"]</a>";
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
<script type="text/javascript">
    function editCate(id){
        window.location="editCatalog.jsp?id="+id;
    }
    function delCate(id){
        if(window.confirm("您确定要删除吗？删除之后不能恢复哦！！！")){
            window.location="/AdminServlet?act=delCate&id="+id;
        }
    }
    function addCate(){
        window.location="addCatalog.jsp";
    }
</script>
</body>
</html>
