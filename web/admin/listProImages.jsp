<%@ page import="com.recycle.utils.DbOperation" %>
<%@ page import="com.recycle.utils.Page" %><%--
  Created by IntelliJ IDEA.
  User: xiebin
  Date: 2016/12/25
  Time: 下午8:05
  To change this template use File | Settings | File Templates.
--%>
<%@ page contentType="text/html;charset=UTF-8" language="java" pageEncoding="UTF-8" %>
<% request.setCharacterEncoding("utf-8"); %>
<html>
<head>
    <meta charset="utf-8">
    <title>商品图片列表</title>
    <link rel="stylesheet" href="../styles/backstage.css">
</head>
<body>
<div class="details">
    <div class="details_operation clearfix">
    </div>
    <!--表格-->
    <table class="table" cellspacing="0" cellpadding="0" style="text-align: center">
        <thead>
        <tr>
            <th width="10%">编号</th>
            <th width="20%">商品名称</th>
            <th width="50">商品图片</th>
            <th>操作</th>
        </tr>
        </thead>
        <tbody>
        <%
            int pageSize = 4;
            int pageNow = request.getParameter("page") == null? 1: Integer.parseInt(request.getParameter("page"));
            String[][] results = Page.getPageResults("product", pageSize, pageNow);
            int totalPage = Page.getTotalPage("product", pageSize);
            if (totalPage == 0) {
                out.print("<script>alert(''对不起，没有商品，请先添加！); location.href = 'addProduct.jsp'</script>");
            }
            String index = pageNow == 1? "首页" : "<a href='listProImages.jsp?page=1'>首页</a>";
            String last = pageNow == totalPage? "尾页" : "<a href='listProImages.jsp?page="+totalPage+"'>尾页</a>";
            int prevPage = pageNow >= 1? pageNow-1: 1;
            int nextPage = pageNow >= totalPage? totalPage : pageNow+1;
            String prev = pageNow == 1? "上一页" : "<a href='listProImages.jsp?page="+prevPage +"'>上一页</a>";
            String next = pageNow == totalPage? "下一页" : "<a href='listProImages.jsp?page="+nextPage+"'>下一页</a>";

            for (int i = 0; i < results[0].length; i++) {
        %>
        <tr>
            <td><input  type="checkbox" id="<%= results[0][i] %>" class="check" value="<%= results[0][i] %>"><label for="<%= results[0][i] %>" class="label"><%= results[0][i] %></label></td>
            <td><%= results[1][i] %></td>
            <td>
                <%
                    String sql2 = "select * from album where Pid = "+results[0][i];
                    String[][] pics = DbOperation.getRecord(sql2);
                    for (int j = 0; j < pics[0].length; j++) {
                %>
                <img width="100" height="100" src="../uploads/<%= pics[2][j] %>" alt=""/> &nbsp;&nbsp;
                <% } %>
            </td>
            <td>
                <input type="button" value="添加文字水印" onclick="doImg('<%= results[0][i] %>','waterText')" class="btn"/>
                <br/>
                <input type="button" value="删除图片" onclick="doImg('<%= results[0][i] %>','delPic')" class="btn"/>
            </td>
        </tr>
        <% } %>
        <tr>
            <td colspan="7">
                <span>总共<%= totalPage%>页/当前是第<%= pageNow%>页</span>
                <span><% out.print(index); %></span>
                <span><% out.print(prev); %></span>
                <span>
                    <%
                        String p;
                        for (int i = 1; i <= totalPage; i++) {
                            if (pageNow == i) {
                                p = String.valueOf(i);
                                out.print(p);
                            }
                            else {
                                p = "<a href='listProImages.jsp?page="+i+"'>["+String.valueOf(i)+"]</a>";
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
    function doImg(id,act){
        window.location="/AdminServlet?act="+act+"&id="+id;
    }
</script>
</body>
</html>