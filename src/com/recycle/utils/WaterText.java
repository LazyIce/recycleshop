package com.recycle.utils;

import com.sun.image.codec.jpeg.JPEGCodec;
import com.sun.image.codec.jpeg.JPEGEncodeParam;
import com.sun.image.codec.jpeg.JPEGImageEncoder;

import javax.swing.*;
import java.awt.*;
import java.awt.image.BufferedImage;
import java.io.FileOutputStream;

/**
 * Created by xiebin on 2016/12/25.
 */
public class WaterText {

    public static boolean createMark(String fileName) {
        ImageIcon imgIcon = new ImageIcon("/Users/xiebin/Library/Tomcat/webapps/recycleshop/web/uploads/"+fileName);
        Image theImg = imgIcon.getImage();
        int width = theImg.getWidth(null);
        int height = theImg.getHeight(null);
        BufferedImage bimage = new BufferedImage(width, height, BufferedImage.TYPE_INT_RGB);
        Graphics2D g = bimage.createGraphics();
        g.setColor(Color.red);
        g.setBackground(Color.white);
        g.drawImage(theImg, 0, 0, null);
        g.drawString("LazyLazy.com", width / 5, height / 5);
        g.dispose();
        try {
            FileOutputStream out = new FileOutputStream("/Users/xiebin/Library/Tomcat/webapps/recycleshop/web/uploads/"+fileName);
            JPEGImageEncoder encoder = JPEGCodec.createJPEGEncoder(out);
            JPEGEncodeParam param = encoder.getDefaultJPEGEncodeParam(bimage);
            param.setQuality(8, true);
            encoder.encode(bimage, param);
            out.close();
        } catch (Exception e) {
            return false;
        }
        return true;
    }
}
