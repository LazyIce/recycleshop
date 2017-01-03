package com.recycle.utils;

import javax.mail.*;
import javax.mail.internet.AddressException;
import javax.mail.internet.InternetAddress;
import javax.mail.internet.MimeMessage;
import java.io.IOException;
import java.io.InputStream;
import java.util.Date;
import java.util.Properties;
import java.util.concurrent.SynchronousQueue;

/**
 * Created by xiebin on 2017/1/3.
 */
public class EmailUtils {
    private static final String FROM = "sei_xb2014@126.com";
    private static final String HOST = "smtp.126.com";
    private static final String PASSWORD = "Xb19960225lan";

    public static void sendAccountActivateEmail(String email, String username) {
        try{
            Transport transport = null;
            Properties properties = System.getProperties();
            properties.setProperty("mail.host", HOST);
            properties.setProperty("mail.transport.protocol", "smtp");
            properties.setProperty("mail.smtp.auth", "true");
            Session session = Session.getDefaultInstance(properties, new javax.mail.Authenticator(){
                protected PasswordAuthentication getPasswordAuthentication() {
                    return new PasswordAuthentication(
                            FROM, PASSWORD);
                }
            });
            session.setDebug(true);
            MimeMessage message = new MimeMessage(session);
            message.setFrom(new InternetAddress(FROM));
            message.addRecipient(Message.RecipientType.TO, new InternetAddress(email));
            message.setSubject("账户激活邮件");
            message.setContent("<a href='localhost:8080/ActivateAccountServlet?username="+username+"'>点击这里</a>", "text/html;charset=utf-8" );
            Transport.send(message);
        }catch (MessagingException mex) {
            mex.printStackTrace();
        }
    }

    public static void sendFindPasswordEmail(String email, String username) {
        try{
            Transport transport = null;
            Properties properties = System.getProperties();
            properties.setProperty("mail.host", HOST);
            properties.setProperty("mail.transport.protocol", "smtp");
            properties.setProperty("mail.smtp.auth", "true");
            Session session = Session.getDefaultInstance(properties,new javax.mail.Authenticator(){
                protected PasswordAuthentication getPasswordAuthentication() {
                    return new PasswordAuthentication(
                            FROM, PASSWORD);
                }
            });
            session.setDebug(true);
            MimeMessage message = new MimeMessage(session);
            message.setFrom(new InternetAddress(FROM));
            message.addRecipient(Message.RecipientType.TO, new InternetAddress(email));
            message.setSubject("找回密码邮件");
            message.setContent("<h3>"+username+"你的密码是111111</h3>", "text/html;charset=utf-8" );
            transport = session.getTransport();
            transport.connect(HOST, FROM, PASSWORD);
            transport.send(message,message.getAllRecipients());
        }catch (MessagingException mex) {
            mex.printStackTrace();
        }
    }
}
