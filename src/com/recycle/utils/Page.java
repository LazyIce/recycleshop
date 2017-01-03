package com.recycle.utils;

import java.sql.SQLException;

/**
 * Created by xiebin on 2016/12/20.
 */
public class Page {

    public static int getTotalPage(String table, int pageSize) throws SQLException {
        String sql = "select * from "+table;
        int totalCount = DbOperation.getResultNum(sql);
        int totalPage = totalCount%pageSize==0? totalCount/pageSize : totalCount/pageSize+1;
        return totalPage;
    }

    public static String[][] getPageResults(String table, int pageSize, int pageNow) throws SQLException {
        String sql = "select * from "+table+" limit " + ((pageNow-1)*pageSize)+","+pageSize;
        String[][] results = DbOperation.getRecord(sql);
        return results;
    }

    public static int getComTotalPage(String table, int pageSize, String where, String orderBy) throws SQLException {
        String sql = "select * from "+table+" "+where+" "+orderBy;
        int totalCount = DbOperation.getResultNum(sql);
        int totalPage = totalCount%pageSize==0? totalCount/pageSize : totalCount/pageSize+1;
        return totalPage;
    }

    public static String[][] getComPageResults(String table, int pageSize, int pageNow, String where, String orderBy) throws SQLException {
        String sql = "select * from "+table+" "+where+" "+orderBy+" limit " + ((pageNow-1)*pageSize)+","+pageSize;
        String[][] results = DbOperation.getRecord(sql);
        return results;
    }


}
