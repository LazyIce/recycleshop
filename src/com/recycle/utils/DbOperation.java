package com.recycle.utils;


import java.sql.*;
import java.util.Vector;

public class DbOperation {
    private static final String JDBC_DRIVER = "com.mysql.jdbc.Driver";
    private static final String DB_URL = "jdbc:mysql://localhost:3306/recycleshop?useUnicode=true&characterEncoding=UTF-8";
    private static final String USER = "root";
    private static final String PASSWORD = "xb0225";

    private static Connection conn = null;
    private static Statement stmt = null;
    private static ResultSet res = null;

    public static Connection getConnect() {
        try {
            Class.forName(JDBC_DRIVER);
            System.out.println("Succeed loading Mysql Driver!");
        } catch (Exception e) {
            System.out.print("Fail loading Mysql Driver!");
            e.printStackTrace();
        }

        try {
            conn = DriverManager.getConnection(DB_URL, USER, PASSWORD);
            System.out.println("Succeed connecting Mysql server!");
        } catch (Exception e) {
            System.out.print(" Fail connecting Mysql server!");
            e.printStackTrace();
        }
        return conn;
    }

    public static boolean excute(String sql) {
        int data = 0;
        try {
            conn = getConnect();
            stmt = conn.createStatement();
            data = stmt.executeUpdate(sql);
            conn.close();
        } catch (SQLException e) {
            e.printStackTrace();
        }
        if (data == 0)
            return false;
        else
            return true;
    }

    public static String[][] getRecord(String sql) {
        try {
            conn = getConnect();
            stmt = conn.createStatement();
            res = stmt.executeQuery(sql);
            int col = res.getMetaData().getColumnCount();
            Vector v[] = new Vector[col];
            for (int i = 0; i < col; i++)
                v[i] = new Vector();
            while (res.next()) {
                for (int i = 0; i < col; i ++)
                    v[i].addElement(res.getString(i+1));
            }
            String[][] results = new String[col][v[0].size()];
            for (int i = 0; i < col; i++)
                v[i].copyInto(results[i]);
            for (int i = 0; i <results.length; i++) {
                for (int j = 0; j < results[0].length; j++) {
                    if (results[i][j] == null)
                        results[i][j]="";
                }
            }
            conn.close();
            return results;
        } catch (SQLException e) {
            e.printStackTrace();
        }
        return null;
    }

    public static boolean isExist(String sql) {
        boolean flag = false;
        try {
            conn = getConnect();
            stmt = conn.createStatement();
            res = stmt.executeQuery(sql);
            if (res.next())
                flag = true;
            conn.close();
        } catch (SQLException e) {
            e.printStackTrace();
        }
        return flag;
    }

    public static int getResultNum(String sql) throws SQLException {
        int totalCount = 0;
        try {
            conn = getConnect();
            stmt = conn.createStatement();
            res = stmt.executeQuery(sql);
            while (res.next())
                totalCount ++;
            conn.close();
        } catch (SQLException e) {
            e.printStackTrace();
        }
        return totalCount;
    }
}
