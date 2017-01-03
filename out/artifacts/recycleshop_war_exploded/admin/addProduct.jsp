<%@ page import="com.recycle.utils.DbOperation" %><%--
  Created by IntelliJ IDEA.
  User: xiebin
  Date: 2016/12/19
  Time: 下午2:02
  To change this template use File | Settings | File Templates.
--%>
<%@ page contentType="text/html;charset=UTF-8" language="java" pageEncoding="utf-8" %>
<% request.setCharacterEncoding("utf-8"); %>
<html>
<head>
    <meta charset="utf-8">
    <title>添加分类</title>
    <link href="../styles/global.css"  rel="stylesheet"  type="text/css" media="all" />
    <script type="text/javascript" charset="utf-8" src="../plugins/kindeditor/kindeditor.js"></script>
    <script type="text/javascript" charset="utf-8" src="../plugins/kindeditor/lang/zh_CN.js"></script>
    <script type="text/javascript" src="../scripts/jquery-1.6.4.js"></script>
    <script>
        KindEditor.ready(function(K) {
            window.editor = K.create('#editor_id');
        });
        $(document).ready(function(){
            $("#selectFileBtn").click(function(){
                $fileField = $('<input type="file" name="thumbs[]"/>');
                $fileField.hide();
                $("#attachList").append($fileField);
                $fileField.trigger("click");
                $fileField.change(function(){
                    $path = $(this).val();
                    $filename = $path.substring($path.lastIndexOf("\\")+1);
                    $attachItem = $('<div class="attachItem"><div class="left">a.gif</div><div class="right"><a href="#" title="删除附件">删除</a></div></div>');
                    $attachItem.find(".left").html($filename);
                    $("#attachList").append($attachItem);
                });
            });
            $("#attachList>.attachItem").find('a').live('click',function(obj,i){
                $(this).parents('.attachItem').prev('input').remove();
                $(this).parents('.attachItem').remove();
            });
        });
    </script>
</head>
<%
    String sql = "select * from catalogue";
    int totalCount = DbOperation.getResultNum(sql);
    String[][] results = DbOperation.getRecord(sql);
    if (results.equals(null)) {
        out.print("<script>alert('没有相应分类，请先添加！');location.href='addCatalog.jsp';</script>");
    }
%>
<body>
<h3>添加商品</h3>
<form action="/AdminServlet?act=addPro" method="post" enctype="multipart/form-data">
    <table width="90%"  border="1" cellpadding="5" cellspacing="0" bgcolor="#cccccc" align="center">
        <tr>
            <td align="right">商品名称</td>
            <td><input type="text" name="pName"  placeholder="请输入商品名称"/></td>
        </tr>
        <tr>
            <td align="right">商品分类</td>
            <td>
                <select name="cId">
                    <%
                        for (int i = 0; i < totalCount; i++) {
                            out.print("<option value='"+results[0][i]+"'>"+results[1][i]+"</option>");
                        }
                    %>
                </select>
            </td>
        </tr>
        <tr>
            <td align="right">商品货号</td>
            <td><input type="text" name="pSn"  placeholder="请输入商品货号"/></td>
        </tr>
        <tr>
            <td align="right">商品数量</td>
            <td><input type="text" name="pNum"  placeholder="请输入商品数量"/></td>
        </tr>
        <tr>
            <td align="right">商品市场价</td>
            <td><input type="text" name="mPrice"  placeholder="请输入商品市场价"/></td>
        </tr>
        <tr>
            <td align="right">商品懒懒价</td>
            <td><input type="text" name="iPrice"  placeholder="请输入商品懒懒价"/></td>
        </tr>
        <tr>
            <td align="right">商品描述</td>
            <td>
                <textarea name="pDesc" id="editor_id" style="width:100%;height:150px;"></textarea>
            </td>
        </tr>
        <tr>
            <td align="right">商品图像</td>
            <td>
                <a href="javascript:void(0)" id="selectFileBtn">添加附件</a>
                <div id="attachList" class="clear"></div>
            </td>
        </tr>
        <tr>
            <td colspan="2"><input type="submit"  value="发布商品"/></td>
        </tr>
    </table>
</form>
</body>
</html>
