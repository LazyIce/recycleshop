<%@ page import="com.recycle.utils.Page" %>
<%@ page import="com.recycle.utils.DbOperation" %><%--
  Created by IntelliJ IDEA.
  User: xiebin
  Date: 2016/12/20
  Time: 下午10:00
  To change this template use File | Settings | File Templates.
--%>
<%@ page contentType="text/html;charset=UTF-8" language="java" pageEncoding="utf-8" %>
<% request.setCharacterEncoding("utf-8"); %>
<html>
<head>
    <meta charset="utf-8">
    <title>商品列表</title>
    <link rel="stylesheet" href="../styles/backstage.css">
    <link rel="stylesheet" href="../scripts/jquery-ui/css/ui-lightness/jquery-ui-1.10.4.custom.css" />
    <script src="../scripts/jquery-ui/js/jquery-1.10.2.js"></script>
    <script src="../scripts/jquery-ui/js/jquery-ui-1.10.4.custom.js"></script>
    <script src="../scripts/jquery-ui/js/jquery-ui-1.10.4.custom.min.js"></script>
</head>
<body>
<div id="showDetail"  style="display:none;">
</div>
<div class="details">
    <div class="details_operation clearfix">
        <div class="bui_select">
            <input type="button" value="添&nbsp;&nbsp;加" class="add" onclick="addPro()">
        </div>
        <div class="fr">
            <%
                String catasql = "select * from catalogue";
                String[][] catalogs = DbOperation.getRecord(catasql);
            %>
            <div class="text">
                <span>商品种类：</span>
                <div class="bui_select">
                    <select id="catalogue" class="select" onchange="catalog(this.value)">
                        <option>-请选择-</option>
                        <%
                            for (int i = 0; i < catalogs[0].length; i++) {
                        %>
                        <option value="<%= catalogs[0][i] %>" ><%= catalogs[1][i] %></option>
                        <% } %>
                    </select>
                </div>
            </div>
            <div class="text">
                <span>商品价格：</span>
                <div class="bui_select">
                    <select id="price" class="select" onchange="change(this.value)">
                        <option>-请选择-</option>
                        <option value="iPrice asc" >由低到高</option>
                        <option value="iPrice desc">由高到底</option>
                    </select>
                </div>
            </div>
            <div class="text">
                <span>上架时间：</span>
                <div class="bui_select">
                    <select id="time" class="select" onchange="change(this.value)">
                        <option>-请选择-</option>
                        <option value="pubTime desc" >最新发布</option>
                        <option value="pubTime asc">历史发布</option>
                    </select>
                </div>
            </div>
            <div class="text">
                <span>搜索</span>
                <input type="text" value="" class="search"  id="search" onkeypress="search()" >
            </div>
        </div>
    </div>
    <!--表格-->
    <table class="table" cellspacing="0" cellpadding="0" style="text-align: center">
        <thead>
        <tr>
            <th width="10%">编号</th>
            <th width="20%">商品名称</th>
            <th width="10%">商品分类</th>
            <th width="10%">是否上架</th>
            <th width="15%">上架时间</th>
            <th width="10%">懒懒价格</th>
            <th>操作</th>
        </tr>
        </thead>
        <tbody>
        <%
            String order = request.getParameter("order");
            String orderBy = order == null? "":"order by "+order;
            String catalogId = request.getParameter("catalogId");
            String keywords = request.getParameter("keywords");
            String where;
            if (catalogId == null && keywords == null) {
                where = "";
            }
            else if (catalogId != null && keywords == null) {
                where = "where cId="+catalogId;
            }
            else if (catalogId == null && keywords != null) {
                where = "where pName like '%"+keywords+"%'";
            }
            else {
                where = "where cId="+catalogId+" and pName like '%"+keywords+"%'";
            }
            int pageSize = 4;
            int pageNow = request.getParameter("page") == null? 1: Integer.parseInt(request.getParameter("page"));
            String[][] results;
            int totalPage;
            results = Page.getComPageResults("product", pageSize, pageNow, where, orderBy);
            totalPage = Page.getComTotalPage("product", pageSize, where, orderBy);
            if (totalPage == 0) {
                out.print("<script>alert('对不起，没有商品，请先添加！'); location.href = 'addProduct.jsp'</script>");
            }
            String index = pageNow == 1? "首页" : "<a href='listProduct.jsp?page=1'>首页</a>";
            String last = pageNow == totalPage? "尾页" : "<a href='listProduct.jsp?page="+totalPage+"'>尾页</a>";
            int prevPage = pageNow >= 1? pageNow-1: 1;
            int nextPage = pageNow >= totalPage? totalPage : pageNow+1;
            String prev = pageNow == 1? "上一页" : "<a href='listProduct.jsp?page="+prevPage +"'>上一页</a>";
            String next = pageNow == totalPage? "下一页" : "<a href='listProduct.jsp?page="+nextPage+"'>下一页</a>";

            for (int i = 0; i < results[0].length; i++) {
                String id = results[0][i];
                String pName = results[1][i];
                String cId = results[2][i];
                String pSn = results[3][i];
                String pNum = results[4][i];
                String mPrice = results[5][i];
                String iPrice = results[6][i];
                String pDesc = results[7][i];
                String pubTime = results[8][i];
                String isShow = results[9][i];
                String isHot = results[10][i];
                String cNameSql = "select cName from catalogue where id ="+cId;
                String cName = DbOperation.getRecord(cNameSql)[0][0];
        %>
        <tr>
            <td><input type="checkbox" id="c1" class="check" value=<%= id %>><label for="c1" class="label"><%= id %></label></td>
            <td><%= pName %></td>
            <td><%= cName %></td>
            <td><%= isShow.equals("1")? "上架" : "下架" %></td>
            <td><%= pubTime %></td>
            <td><%= iPrice %>元</td>
            <td align="center">
                <input type="button" value="详情" class="btn" onclick="showDetail(<%= id %>,'<%= pName%>')"><input type="button" value="修改" class="btn" onclick="editPro(<%= id %>)"><input type="button" value="删除" class="btn"onclick="delPro(<%= id %>)">
                <div id="showDetail<%= id %>" style="display:none;">
                    <table class="table" cellspacing="0" cellpadding="0">
                        <tr>
                            <td width="20%" align="right">商品名称</td>
                            <td><%= pName %></td>
                        </tr>
                        <tr>
                            <td width="20%"  align="right">商品类别</td>
                            <td><%= cName %></td>
                        </tr>
                        <tr>
                            <td width="20%"  align="right">商品货号</td>
                            <td><%= pSn %></td>
                        </tr>
                        <tr>
                            <td width="20%"  align="right">商品数量</td>
                            <td><%= pNum %></td>
                        </tr>
                        <tr>
                            <td  width="20%"  align="right">商品价格</td>
                            <td><%= mPrice %></td>
                        </tr>
                        <tr>
                            <td  width="20%"  align="right">懒懒网价格</td>
                            <td><%= iPrice %></td>
                        </tr>
                        <tr>
                            <td width="20%"  align="right">商品图片</td>
                            <td>
                                <%
                                    String sql = "select albumPath from album where Pid="+id;
                                    String[] albumPaths = DbOperation.getRecord(sql)[0];
                                    for (int j = 0; j < albumPaths.length; j++) {
                                %>
                                <img src="../uploads/<%= albumPaths[j] %>" width="100" height="100"/>&nbsp;
                                <%}%>
                            </td>
                        </tr>
                        <tr>
                            <td width="20%"  align="right">是否上架</td>
                            <td>
                                <%= isShow.equals("1")? "上架" : "下架" %>
                            </td>
                        </tr>
                        <tr>
                            <td width="20%"  align="right">是否热卖</td>
                            <td>
                                <%= isHot.equals("1")? "热卖" : "正常" %>
                            </td>
                        </tr>
                    </table>
                    <span style="display:block;width:80%; ">
                        商品描述<br/>
                        <%= pDesc %>
                    </span>
                </div>
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
                                p = "<a href='listProduct.jsp?page="+i+"'>["+String.valueOf(i)+"]</a>";
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
    function showDetail(id,t){
        $("#showDetail"+id).dialog({
            height:"auto",
            width: "auto",
            position: {my: "center", at: "center",  collision:"fit"},
            modal:false,//是否模式对话框
            draggable:true,//是否允许拖拽
            resizable:true,//是否允许拖动
            title:"商品名称："+t,//对话框标题
            show:"slide",
            hide:"explode"
        });
    }
    function addPro(){
        window.location='addProduct.jsp';
    }
    function editPro(id){
        window.location='editProduct.jsp?id='+id;
    }
    function delPro(id){
        if(window.confirm("您确认要删除嘛？添加一次不易，且删且珍惜!")){
            window.location="/AdminServlet?act=delPro&id="+id;
        }
    }
    function search(){
        if(event.keyCode==13){
            var val=document.getElementById("search").value;
            window.location="listProduct.jsp?keywords="+val;
        }
    }
    function change(val){
        window.location="listProduct.jsp?order="+val;
    }
    function catalog(val) {
        window.location="listProduct.jsp?catalogId="+val;
    }
</script>
</body>
</html>
