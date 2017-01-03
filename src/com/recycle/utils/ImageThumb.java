package com.recycle.utils;

import com.sun.image.codec.jpeg.JPEGCodec;
import com.sun.image.codec.jpeg.JPEGImageEncoder;

import javax.imageio.ImageIO;
import java.awt.*;
import java.awt.image.BufferedImage;
import java.io.File;
import java.io.FileOutputStream;
import java.io.IOException;

/**
 * Created by xiebin on 2016/12/21.
 */
public class ImageThumb {
    public static void thumb(String fileName, int size) throws IOException {
        java.io.File myFile = new java.io.File("/Users/xiebin/Library/Tomcat/webapps/recycleshop/web/uploads/"+fileName);
        BufferedImage image = ImageIO.read(myFile);
        int oldWidth = image.getWidth();
        int oldHeight = image.getHeight();
        if (oldWidth > oldHeight) {
            int x = oldWidth - oldHeight;
            image = image.getSubimage(x, 0, oldHeight, oldHeight);
        } else {
            int y = oldHeight - oldWidth;
            image = image.getSubimage(0, y, oldWidth, oldWidth);
        }
        BufferedImage bufferedImage = new BufferedImage(size, size, BufferedImage.TYPE_INT_RGB);
        bufferedImage.getGraphics().drawImage(image, 0, 0, size, size, null);
        FileOutputStream newImage = new FileOutputStream("/Users/xiebin/Library/Tomcat/webapps/recycleshop/web/image_"+size+"/"+fileName);
        JPEGImageEncoder encoder = JPEGCodec.createJPEGEncoder(newImage);
        encoder.encode(bufferedImage);
        newImage.close();
    }
}
