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
import java.util.Objects;

/**
 * Created by xiebin on 2017/1/1.
 */
public class RecycleServlet extends HttpServlet {
    public void doPost (HttpServletRequest request, HttpServletResponse response) throws IOException {
        HttpSession session = request.getSession(true);
        request.setCharacterEncoding("utf-8");
        response.setCharacterEncoding("utf-8");
        String action = request.getParameter("act");
        if (action.equals("addOrder")) {
            SimpleDateFormat df = new SimpleDateFormat("yyyy-MM-dd,HH:mm:ss");
            String date =  df.format(new Date());
            String type = request.getParameter("type");
            String number = request.getParameter("number");
            String username = request.getParameter("username");
            String credit = String.valueOf(Integer.parseInt(number)*5);
            String sql = "select address from user where username='"+username+"'";
            String address = DbOperation.getRecord(sql)[0][0];
            String sql1 = "insert into recycleOrders (uName, orderDate, address, type, number, status, credit) values ('"+username+"','"+date+"','"+address+"','"+type+"',"+number+",'处理',"+credit+")";
            String sql2 = "select account from user where username = '"+username+"'";
            String account = DbOperation.getRecord(sql2)[0][0];
            String newAccount = String.valueOf(Integer.parseInt(credit)+Integer.parseInt(account));
            String sql3 = "update user set account="+newAccount+" where username='"+username+"'";
            if (DbOperation.excute(sql1)&&DbOperation.excute(sql3)) {
                Common.alertMessage(response, "<script>alert('Recycle goods succeed submitting! ');location.href='recycle/checkout.jsp';</script>");
            }
            else {
                Common.alertMessage(response, "<script>alert('Recycle goods failed submitting! ');location.href='recycle/checkout.jsp';</script>");
            }
        }
    }

    public void doGet (HttpServletRequest request, HttpServletResponse response) throws IOException {
        doPost(request, response);
    }

}

