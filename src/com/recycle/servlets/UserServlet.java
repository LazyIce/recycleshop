package com.recycle.servlets;

import com.recycle.utils.Common;
import com.recycle.utils.DbOperation;
import com.recycle.utils.EmailUtils;

import javax.servlet.http.*;
import java.io.IOException;
import java.io.PrintWriter;

/**
 * Created by xiebin on 2016/12/16.
 */
public class UserServlet extends HttpServlet {

    public void doGet(HttpServletRequest request, HttpServletResponse response) throws IOException {
        doPost(request, response);
    }

    public void doPost(HttpServletRequest request, HttpServletResponse response) throws IOException {
        HttpSession session = request.getSession(true);
        request.setCharacterEncoding("UTF-8");
        String action = request.getParameter("act");
        if (action.equals("login")) {
            String username = request.getParameter("username");
            String password = request.getParameter("password");
            String autoFlag = request.getParameter("autoFlag");
            String sql = "select * from user where username = '" + username + "' and password = '" + password + "'";
            if (DbOperation.isExist(sql)) {
                if (autoFlag != null) {
                    Cookie ckUserName = new Cookie("userName", username);
                    ckUserName.setMaxAge(60*60*24*7);
                    response.addCookie(ckUserName);
                }
                session.setAttribute("userName", username);
                response.setHeader("refresh", "0.5;url = main/index.jsp");
            }
            else {
                Common.alertMessage(response, "<script>alert('Username or password is wrong! Please try again!');location.href='main/login.jsp';</script>");
            }
        }
        else if (action.equals("logout")) {
            session.invalidate();
            Cookie[] cookies = request.getCookies();
            for (Cookie cookie : cookies) {
                cookie.setMaxAge(0);
                cookie.setPath("/");
                response.addCookie(cookie);
            }
            response.setHeader("refresh", "0.5;url=main/login.jsp");
        }
        else if (action.equals("findPassword")) {
            String username=null;
            Cookie[] cookies = request.getCookies();
            for (Cookie cookie : cookies) {
                if (cookie.getName().equals("userName"))
                    username = cookie.getValue();
            }
            String sql = "select email from user where username='"+username+"'";
            String email = DbOperation.getRecord(sql)[0][0];
            EmailUtils.sendFindPasswordEmail(email, username);
            Common.alertMessage(response, "<script>alert('A email has sent to you!');location.href='main/login.jsp';</script>");
        }
    }
}
