package com.recycle.utils;

import java.sql.SQLException;

/**
 * Created by xiebin on 2017/1/2.
 */
public class ShopUtil {
    public static int totalOrders(String username) throws SQLException {
        String sql = "select * from orders where uName='"+username+"' and statue=0";
        int totalOrders = DbOperation.getResultNum(sql);
        return totalOrders;
    }

    public static String[][] getAllCates() {
        String sql = "select cName from catalogue";
        return DbOperation.getRecord(sql);
    }

    public static String getRepresentPhoto(String catalog) {
        String sql1 = "select id from catalogue where cName='"+catalog+"'";
        String sql2 = "select id from product where cId ="+DbOperation.getRecord(sql1)[0][0];
        if (!DbOperation.isExist(sql2)) {
            return "";
        }
        else {
            String sql3 = "select albumPath from album where Pid="+DbOperation.getRecord(sql2)[0][0];
            return DbOperation.getRecord(sql3)[0][0];
        }
    }

    public static String[][] getAllProducts(String catalog) {
        String sql1 = "select id from catalogue where cName='"+catalog+"'";
        String sql2 = "select * from product where cId ="+ DbOperation.getRecord(sql1)[0][0];
        return DbOperation.getRecord(sql2);
    }

    public static String[][] searchAllProducts(String keywords) {
        String sql = "select * from product where pName like '%"+keywords+"%'";
        return DbOperation.getRecord(sql);
    }

    public static String getAlbumPath(String pid) {
        String sql = "select albumPath from album where Pid="+pid;
        return DbOperation.getRecord(sql)[0][0];
    }

    public static String getCatalogue(String pid) {
        String sql1 = "select cId from product where id ="+pid;
        String sql2 = "select cName from catalogue where id="+DbOperation.getRecord(sql1)[0][0];
        return DbOperation.getRecord(sql2)[0][0];
    }

    public static String[][] getOneProduct(String pid) {
        String sql = "select * from product where id="+pid;
        return DbOperation.getRecord(sql);
    }

    public static String[][] getAllOrders(String username) {
        String sql = "select * from orders where uName='"+username+"' and statue != 0";
        return DbOperation.getRecord(sql);
    }

    public static String[][] getCartOrders(String username) {
        String sql = "select * from orders where uName='"+username+"' and statue=0";
        return DbOperation.getRecord(sql);
    }
 }
