package com.recycle.servlets;

import com.jspsmart.upload.SmartUpload;
import com.jspsmart.upload.SmartUploadException;
import com.recycle.utils.Common;
import com.recycle.utils.DbOperation;
import com.recycle.utils.EmailUtils;
import com.recycle.utils.ImageDelete;

import javax.servlet.ServletException;
import javax.servlet.http.HttpServlet;
import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;
import java.io.File;
import java.io.IOException;
import java.io.UnsupportedEncodingException;
import java.sql.SQLException;
import java.text.SimpleDateFormat;
import java.util.Date;

/**
 * Created by xiebin on 2016/12/23.
 */
public class RegistServlet extends HttpServlet {
    public void doGet(HttpServletRequest request, HttpServletResponse response) throws ServletException, IOException {
        doPost(request, response);
    }

    public void doPost(HttpServletRequest request, HttpServletResponse response) throws IOException, ServletException {
        request.setCharacterEncoding("utf-8");
        String verifyCode = (String)request.getSession().getAttribute("verifyCode");
        String verify = request.getParameter("verify");
        verifyCode = verifyCode.toUpperCase();
        verify = verify.toUpperCase();
        String username = request.getParameter("username");
        String password = request.getParameter("password");
        String email = request.getParameter("email");
        SimpleDateFormat df = new SimpleDateFormat("yyyy-MM-dd,HH:mm:ss");
        String regTime =  df.format(new Date());
        if (verifyCode.equals(verify)) {
            EmailUtils.sendAccountActivateEmail(email, username);
            String sql = "insert into user (username, password, email, regTime) values ( '"+username+"','"+password+"','"+email+"','"+regTime+"')";
            if (DbOperation.excute(sql)) {
                Common.showMessage(response, "注册成功!<br/>验证邮件已发送！3秒钟后跳转到登陆页面!<meta http-equiv='refresh' content='3;url=main/login.jsp'/>");
            } else {
                Common.showMessage(response,"注册失败!<br/><a href='regist.jsp'>重新注册</a>|<a href='main/index.jsp'>查看首页</a>");
            }
        }
        else {
            Common.alertMessage(response, "<script language='javascript'>alert('Verify code is wrong!');location.href='main/regist.jsp';</script>");
        }
    }
}
