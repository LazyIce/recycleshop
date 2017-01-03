package com.recycle.servlets;

import com.recycle.utils.VerifyCode;

import javax.imageio.ImageIO;
import javax.servlet.http.HttpServlet;
import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;
import javax.servlet.http.HttpSession;
import java.awt.*;
import java.awt.image.BufferedImage;
import java.io.IOException;
import java.io.OutputStream;
import java.util.Random;

/**
 * Created by xiebin on 2016/12/16.
 */
public class ImageServlet extends HttpServlet {

    public void doGet(HttpServletRequest request, HttpServletResponse response) throws IOException {
        HttpSession session = request.getSession();

        response.setContentType("image/jpg");
        response.setHeader("Pragma", "no-cache");
        response.setHeader("Cache-Control", "no-cache");
        response.setDateHeader("Expires", 0);

        session.setAttribute("verifyCode", VerifyCode.generateCode());
        VerifyCode.printImage(response.getOutputStream());
    }

    public void doPost(HttpServletRequest request, HttpServletResponse response) throws IOException {

    }
}
