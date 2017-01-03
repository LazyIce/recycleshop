package com.recycle.utils;

import javax.servlet.http.HttpServletResponse;
import java.io.IOException;
import java.io.PrintWriter;

/**
 * Created by xiebin on 2016/12/21.
 */
public class Common {
    public static void alertMessage(HttpServletResponse response, String mes) throws IOException {
        response.setContentType("text ml; charset=utf-8");
        PrintWriter out = response.getWriter();
        out.print(mes);
        out.close();
    }

    public static void showMessage(HttpServletResponse response, String mes) throws IOException {
        response.setContentType("text/html; charset=utf-8");
        PrintWriter out = response.getWriter();
        out.print(mes);
        out.close();
    }
}
