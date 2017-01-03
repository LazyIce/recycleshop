package com.recycle.servlets;

import com.recycle.utils.Common;
import com.recycle.utils.DbOperation;

import javax.servlet.ServletException;
import javax.servlet.http.HttpServlet;
import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;
import java.io.IOException;

/**
 * Created by xiebin on 2017/1/3.
 */
public class ActivateAccountServlet extends HttpServlet {
    protected void doGet(HttpServletRequest request, HttpServletResponse response) throws ServletException, IOException {
        String username = request.getParameter("username");
        String sql = "update user set activeFlag=1 where username='"+username+"'";
        if (DbOperation.excute(sql)) {
            Common.alertMessage(response,  "<script language='javascript'>alert('Succeed activating!');location.href='main/login.jsp';</script>");
        }
    }

    protected void doPost(HttpServletRequest request, HttpServletResponse response) throws ServletException, IOException {
        doGet(request, response);
    }
}
