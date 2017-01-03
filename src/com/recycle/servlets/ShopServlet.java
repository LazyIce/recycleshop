package com.recycle.servlets;

import com.recycle.utils.Common;
import com.recycle.utils.DbOperation;

import javax.servlet.http.HttpServlet;
import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;
import javax.servlet.http.HttpSession;
import java.io.IOException;
import java.io.UnsupportedEncodingException;
import java.text.SimpleDateFormat;
import java.util.Date;

/**
 * Created by xiebin on 2017/1/2.
 */
public class ShopServlet extends HttpServlet {
    public void doPost(HttpServletRequest request, HttpServletResponse response) throws IOException {
        HttpSession session = request.getSession(true);

        request.setCharacterEncoding("utf-8");
        response.setCharacterEncoding("utf-8");

        String action = request.getParameter("act");
        if (action.equals("search")) {
            String keyword = request.getParameter("search");
            response.setHeader("refresh", "0.5;url=main/products.jsp?keyword="+keyword);
        }
        else if (action.equals("addCart")) {
            String amount = request.getParameter("amount");
            String uName = (String)session.getAttribute("userName");
            String pId = request.getParameter("pId");
            SimpleDateFormat df = new SimpleDateFormat("yyyy-MM-dd,HH:mm:ss");
            String addTime =  df.format(new Date());
            String sql = "insert into orders (uName, pId, amount, time) values ('"+uName+"',"+pId+","+amount+",'"+addTime+"')";
            if (DbOperation.excute(sql)) {
                response.setHeader("refresh","0.5;url=main/proDetail.jsp?Pid="+pId);
            }
        }
        else if (action.equals("payOrders")) {
            String totalMoney = (String) session.getAttribute("totalMoney");
            String username = (String) session.getAttribute("userName");
            String sql = "select account from user where username='"+username+"'";
            String newAccount = String.valueOf(Integer.parseInt(DbOperation.getRecord(sql)[0][0])-Integer.parseInt(totalMoney));
            String sql1 = "update orders set statue=1 where statue=0 and uName='"+username+"'";
            String sql2 = "update user set account ="+newAccount+" where username='"+username+"'";
            if (DbOperation.excute(sql1)&&DbOperation.excute(sql2)) {
                System.out.println(String.valueOf(DbOperation.excute(sql1)));
                System.out.println(String.valueOf(DbOperation.excute(sql2)));
                Common.alertMessage(response, "<script language='javascript'>alert('Succeed paying!');location.href='main/myOrder.jsp';</script>");
            }
            else {
                Common.alertMessage(response, "<script language='javascript'>alert('Failed paying!');location.href='main/order.jsp';</script>");
            }
        }
        else if (action.equals("getProduct")) {
            String oId = request.getParameter("id");
            String sql = "update orders set statue=2 where id="+oId;
            if (DbOperation.excute(sql)) {
                Common.alertMessage(response, "<script language='javascript'>alert('Succeed getting products!');location.href='main/myOrder.jsp';</script>");
            }
        }
    }

    public void doGet(HttpServletRequest request, HttpServletResponse response) throws IOException {
        doPost(request, response);
    }
}
