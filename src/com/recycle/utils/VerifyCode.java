package com.recycle.utils;

import javax.imageio.ImageIO;
import java.awt.*;
import java.awt.image.BufferedImage;
import java.io.IOException;
import java.io.OutputStream;
import java.util.Random;

/**
 * Created by xiebin on 2016/12/17.
 */
public class VerifyCode {
    private final static int WIDTH = 125;   //图片宽度
    private final static int HEIGHT = 55;   //图片高度
    private final static int CODE_COUNT = 4;   //生成元素个数
    private final static int LINE_COUNT = 2;   //干扰线条数
    private final static float YAWP_RATE = 0.01f;   //噪点率
    private final static String IMG_TYPE = "JPG";
    private final static String ALPHANUMBER_CHARS = "abcdefghijklmnopqrstuvwxyzABCDEFGHIJKLMNOPQRSTUVWXYZ1234567890";

    private static Random random = new Random();
    private static BufferedImage codeImage = null;

    public static String generateCode() {
        int fontWidth = WIDTH / CODE_COUNT;   //字体的宽
        int fontHeight = HEIGHT - 2;   //字体的高
        int imageY = HEIGHT - 4;   //字体在整个图片中的Y坐标

        codeImage = new BufferedImage(WIDTH, HEIGHT, BufferedImage.TYPE_INT_RGB);
        Graphics image = codeImage.getGraphics();

        //设置图像背景色
        image.setColor(getRandomColor(200, 255));
        image.fillRect(0, 0, WIDTH, HEIGHT);

        //设置字体
        Font font = new Font("Fixedsys", Font.PLAIN, fontHeight);
        image.setFont(font);

        //画干扰线
        for (int i = 0; i < LINE_COUNT; i++) {
            int xStart = random.nextInt(WIDTH);
            int yStart = random.nextInt(HEIGHT);
            int xEnd = xStart + random.nextInt(WIDTH);
            int yEnd = yStart + random.nextInt(HEIGHT);

            image.setColor(getRandomColor(1, 255));
            image.drawLine(xStart, yStart, xEnd, yEnd);
        }

        //画噪点
        int area = (int)(WIDTH * HEIGHT * YAWP_RATE);
        for (int i = 0; i < area; i++) {
            int x = random.nextInt(WIDTH);
            int y = random.nextInt(HEIGHT);

            codeImage.setRGB(x, y, random.nextInt(255));
        }

        //画随机字符
        String randomCode = getRandomCodes(CODE_COUNT);
        for (int i = 0; i < CODE_COUNT; i++) {
            image.setColor(getRandomColor(1, 255));
            image.drawString(randomCode.substring(i, i+1), i * fontWidth + 2, imageY);
        }

        return randomCode;
    }

    private static String getRandomCodes(final int codeCount) {
        StringBuffer randomCode = new StringBuffer();

        for (int i = 0; i < codeCount; i++) {
            randomCode.append(ALPHANUMBER_CHARS.charAt((int)(Math.random()*(ALPHANUMBER_CHARS.length()-1))));
        }

        return randomCode.toString();
    }

    private static Color getRandomColor(int min, int max) {
        int red = min + random.nextInt(max-min);
        int green = min + random.nextInt(max-min);
        int blue = min + random.nextInt(max-min);

        return new Color(red, green, blue);
    }

    public static void printImage(OutputStream stream) {
        try {
            ImageIO.write(codeImage, IMG_TYPE, stream);
        } catch (IOException e) {
            e.printStackTrace();
        }
    }
}
