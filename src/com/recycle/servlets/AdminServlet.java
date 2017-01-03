package com.recycle.servlets;

import com.jspsmart.upload.SmartUpload;
import com.jspsmart.upload.SmartUploadException;
import com.recycle.utils.*;

import javax.servlet.ServletException;
import javax.servlet.http.*;
import java.io.*;
import java.sql.SQLException;
import java.text.SimpleDateFormat;
import java.util.Date;

/**
 * Created by xiebin on 2016/12/18.
 */
public class AdminServlet extends HttpServlet {

    public void doPost(HttpServletRequest request, HttpServletResponse response) throws IOException, ServletException {
        HttpSession session = request.getSession(true);

        request.setCharacterEncoding("utf-8");
        response.setCharacterEncoding("utf-8");

        String action = request.getParameter("act");
        if (action.equals("login")) {
            String verifyCode = (String)request.getSession().getAttribute("verifyCode");
            String verify = request.getParameter("verify");
            String adminname = request.getParameter("adminname");
            String password = request.getParameter("password");
            String autoFlag = request.getParameter("autoFlag");
            verifyCode = verifyCode.toUpperCase();
            verify = verify.toUpperCase();
            if (verifyCode.equals(verify)) {
                String sql = "select * from admin where adminname = '" + adminname + "' and password = '" + password + "'";
                if (DbOperation.isExist(sql)) {
                    if (autoFlag != null) {
                        Cookie ckUserName = new Cookie("adminName", adminname);
                        ckUserName.setMaxAge(60*60*24*7);
                        response.addCookie(ckUserName);
                    }
                    session.setAttribute("adminName", adminname);
                    response.setHeader("refresh", "0.5;url=admin/adminIndex.jsp");
                }
                else {
                    Common.alertMessage(response, "<script language='javascript'>alert('Either admin's name or password is wrong! Please log in again!');location.href='admin/adminLogin.jsp';</script>");
                }
            }
            else {
                Common.alertMessage(response, "<script language='javascript'>alert('Verifycode is wrong!');location.href='admin/adminLogin.jsp';</script>");
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
            response.setHeader("refresh", "0.5;url=admin/adminLogin.jsp");
        }
        else if (action.equals("addAdmin")) {
            String adminname = request.getParameter("adminname");
            String password = request.getParameter("password");
            String email = request.getParameter("email");
            String sql = "insert into admin (adminname, password, email) values ( '"+adminname+"','"+password+"','"+email+"')";
            if (DbOperation.excute(sql)) {
                Common.showMessage(response, "添加成功!<br/><a href='admin/addAdmin.jsp'>继续添加</a>|<a href='admin/listAdmin.jsp'>查看管理员列表</a>");
            } else {
                Common.showMessage(response,"添加失败!<br/><a href='admin/addAdmin.jsp'>重新添加</a>");
            }
        }
        else if (action.equals("editAdmin")) {
            String id = request.getParameter("id");
            String adminname = request.getParameter("adminname");
            String password = request.getParameter("password");
            String email = request.getParameter("email");
            String sql = "update admin set adminname='"+adminname+"',password='"+password+"',email='"+email+"' where id="+id;
            if (DbOperation.excute(sql)) {
                Common.showMessage(response, "编辑成功!<br/><a href='admin/listAdmin.jsp'>查看管理员列表</a>");
            } else {
                Common.showMessage(response, "编辑失败!<br/><a href='admin/listAdmin.jsp'>请重新修改</a>");
            }
        }
        else if (action.equals("delAdmin")) {
            String id = request.getParameter("id");
            String sql = "delete from admin where id="+id;
            if (DbOperation.excute(sql)) {
                Common.showMessage(response, "删除成功!<br/><a href='admin/listAdmin.jsp'>查看管理员列表</a>");
            } else {
                Common.showMessage(response, "删除失败!<br/><a href='admin/listAdmin.jsp'>请重新删除</a>");
            }
        }
        else if (action.equals("addCate")) {
            String catalog = request.getParameter("cName");
            String sql = "insert into catalogue (cName) values ( '"+catalog+"')";
            if (DbOperation.excute(sql)) {
                Common.showMessage(response, "添加成功!<br/><a href='admin/addCatalog.jsp'>继续添加</a>|<a href='admin/listCatalog.jsp'>查看分类列表</a>");
            } else {
                Common.showMessage(response, "添加失败!<br/><a href='admin/addCatalog.jsp'>重新添加</a>");
            }
        }
        else if (action.equals("editCate")) {
            String id = request.getParameter("id");
            String cName = request.getParameter("cName");
            String sql = "update catalogue set cName ='"+cName+"'where id="+id;
            if (DbOperation.excute(sql)) {
                Common.showMessage(response, "编辑成功!<br/><a href='admin/listCatalog.jsp'>查看分类列表</a>");
            } else {
                Common.showMessage(response, "编辑失败!<br/><a href='admin/listCatalog.jsp'>请重新修改</a>");
            }
        }
        else if (action.equals("delCate")) {
            String id = request.getParameter("id");
            String check = "select * from product where cId="+id;
            if (DbOperation.isExist(check)) {
                Common.alertMessage(response, "<script>alert('不能删除该分类，请先删除该分类下的商品！');location.href='admin/listProduct.jsp';</script>");
            }
            else {
                String sql = "delete from catalogue where id="+id;
                if (DbOperation.excute(sql)) {
                    Common.showMessage(response, "删除成功!<br/><a href='admin/listCatalog.jsp'>查看分类列表</a>");
                } else {
                    Common.showMessage(response, "删除失败!<br/><a href='admin/listCatalog.jsp'>请重新删除</a>");
                }
            }
        }
        else if (action.equals("addPro")) {
            String filePath = "/Users/xiebin/Library/Tomcat/webapps/recycleshop/web/uploads";
            File file = new File(filePath);
            if (!file.exists()) {
                file.mkdir();
            }
            SmartUpload smartUpload = new SmartUpload();
            smartUpload.initialize(this.getServletConfig(), request, response);
            try {
                smartUpload.setMaxFileSize(5*1024*1024);
                smartUpload.setTotalMaxFileSize(20*1024*1024);
                smartUpload.setAllowedFilesList("jpg,png,jpeg,gif");
                smartUpload.setDeniedFilesList("exe,jsp,txt");
                smartUpload.upload();
                smartUpload.save(filePath);
            } catch (SQLException e) {
                e.printStackTrace();
            } catch (SmartUploadException e) {
                if (e.getMessage().contains("1015")) {
                    Common.alertMessage(response, "<script>alert('上传失败：上传文件类型不正确！');location.href='admin/addProduct.jsp';</script>");
                }
                else if (e.getMessage().contains("1010")) {
                    Common.alertMessage(response, "<script>alert('上传失败：上传文件类型不正确！');location.href='admin/addProduct.jsp';</script>");
                }
                else if (e.getMessage().contains("1105")) {
                    Common.alertMessage(response, "<script>alert('上传失败：上传文件大小大于允许上传的最大值！');location.href='admin/addProduct.jsp';</script>");
                }
                else if (e.getMessage().contains("1110")) {
                    Common.alertMessage(response, "<script>alert('上传失败：上传文件总大小大于允许上传的最大值！');location.href='admin/addProduct.jsp';</script>");
                }
                e.printStackTrace();
            }
            int uploadCount = smartUpload.getFiles().getCount();
            String[] fileName = new String[uploadCount];
            String[] fileExt = new String[uploadCount];
            int[] fileSize = new int[uploadCount];
            for (int i = 0; i < uploadCount; i++) {
                com.jspsmart.upload.File myFile =smartUpload.getFiles().getFile(i);
                if(myFile.isMissing())
                    continue;
                fileName[i] = myFile.getFileName();
                fileExt[i] = myFile.getFileExt();
                fileSize[i] = myFile.getSize();
                ImageThumb.thumb(fileName[i], 50);
                ImageThumb.thumb(fileName[i], 220);
                ImageThumb.thumb(fileName[i], 350);
                ImageThumb.thumb(fileName[i], 800);
            }
            String pName = smartUpload.getRequest().getParameter("pName");
            String cId = smartUpload.getRequest().getParameter("cId");
            String pSn = smartUpload.getRequest().getParameter("pSn");
            String pNum = smartUpload.getRequest().getParameter("pNum");
            String mPrice = smartUpload.getRequest().getParameter("mPrice");
            String iPrice = smartUpload.getRequest().getParameter("iPrice");
            String pDesc = smartUpload.getRequest().getParameter("pDesc");
            SimpleDateFormat df = new SimpleDateFormat("yyyy-MM-dd,HH:mm:ss");
            String pubTime =  df.format(new Date());
            String sql = "insert into product (pName, cId, pSn, pNum, mPrice, iPrice, pDesc, pubTime) values ( '"+pName+"',"+cId+",'"+pSn+"',"+pNum+","+mPrice+","+iPrice+",'"+pDesc+"','"+pubTime+"')";
            if (DbOperation.excute(sql)) {
                String idSql = "select id from product where pSn='"+pSn+"'";
                int pId = Integer.parseInt(DbOperation.getRecord(idSql)[0][0]);
                for (String aFileName : fileName) {
                    String sql2 = "insert into album (Pid, albumPath) values ( " + pId + ",'"+aFileName + "')";
                    if (DbOperation.excute(sql2)) {
                    } else {
                        Common.showMessage(response, "添加图片失败!<br/><a href='admin/addProduct.jsp' target='mainFrame'>重新添加</a>");
                    }
                }
                Common.showMessage(response, "添加成功!<br/><a href='admin/addProduct.jsp' target='mainFrame'>继续添加</a>|<a href='admin/listProduct.jsp'>查看商品列表</a>");
            } else {
                for (String aFileName:fileName)
                    ImageDelete.deleteImages(aFileName);
                Common.showMessage(response,"添加商品失败!<br/><a href='admin/addProduct.jsp' target='mainFrame'>重新添加</a>");
            }
        }
        else if (action.equals("editPro")) {
            String filePath = "/Users/xiebin/Library/Tomcat/webapps/recycleshop/web/uploads";
            SmartUpload smartUpload = new SmartUpload();
            smartUpload.initialize(this.getServletConfig(), request, response);
            try {
                smartUpload.setMaxFileSize(5*1024*1024);
                smartUpload.setTotalMaxFileSize(20*1024*1024);
                smartUpload.setAllowedFilesList("jpg,png,jpeg,gif");
                smartUpload.setDeniedFilesList("exe,jsp,txt");
                smartUpload.upload();
                smartUpload.save(filePath);
            } catch (SQLException e) {
                e.printStackTrace();
            } catch (SmartUploadException e) {
                if (e.getMessage().contains("1015")) {
                    Common.alertMessage(response, "<script>alert('上传失败：上传文件类型不正确！');location.href='admin/addProduct.jsp';</script>");
                }
                else if (e.getMessage().contains("1010")) {
                    Common.alertMessage(response, "<script>alert('上传失败：上传文件类型不正确！');location.href='admin/addProduct.jsp';</script>");
                }
                else if (e.getMessage().contains("1105")) {
                    Common.alertMessage(response, "<script>alert('上传失败：上传文件大小大于允许上传的最大值！');location.href='admin/addProduct.jsp';</script>");
                }
                else if (e.getMessage().contains("1110")) {
                    Common.alertMessage(response, "<script>alert('上传失败：上传文件总大小大于允许上传的最大值！');location.href='admin/addProduct.jsp';</script>");
                }
                e.printStackTrace();
            }
            int uploadCount = smartUpload.getFiles().getCount();
            String[] fileName = new String[uploadCount];
            for (int i = 0; i < uploadCount; i++) {
                com.jspsmart.upload.File myFile =smartUpload.getFiles().getFile(i);
                if(myFile.isMissing())
                    continue;
                fileName[i] = myFile.getFileName();
                ImageThumb.thumb(fileName[i], 50);
                ImageThumb.thumb(fileName[i], 220);
                ImageThumb.thumb(fileName[i], 350);
                ImageThumb.thumb(fileName[i], 800);
            }
            String id = request.getParameter("id");
            String pName = smartUpload.getRequest().getParameter("pName");
            String cId = smartUpload.getRequest().getParameter("cId");
            String pSn = smartUpload.getRequest().getParameter("pSn");
            String pNum = smartUpload.getRequest().getParameter("pNum");
            String mPrice = smartUpload.getRequest().getParameter("mPrice");
            String iPrice = smartUpload.getRequest().getParameter("iPrice");
            String pDesc = smartUpload.getRequest().getParameter("pDesc");
            SimpleDateFormat df = new SimpleDateFormat("yyyy-MM-dd,HH:mm:ss");
            String pubTime =  df.format(new Date());
            String sql = "update product set pName='"+pName+"',cId="+cId+",pSn='"+pSn+"',pNum="+pNum+",mPrice="+mPrice+",iPrice="+iPrice+",pDesc='"+pDesc+"',pubTime='"+pubTime+"' where id="+id;
            String pId = id;
            if (DbOperation.excute(sql)) {
                for (String aFileName : fileName) {
                    String sql2 = "insert into album (Pid, albumPath) values ( " + pId + ",'"+aFileName + "')";
                    if (DbOperation.excute(sql2)) {
                    } else {
                        Common.showMessage(response, "添加图片失败!<br/><a href='admin/editProduct.jsp' target='mainFrame'>重新添加</a>");
                    }
                }
                Common.showMessage(response, "编辑成功!<br/><a href='admin/listProduct.jsp'>查看商品列表</a>");
            } else {
                for (String aFileName : fileName)
                    ImageDelete.deleteImages(aFileName);
                Common.showMessage(response, "编辑失败!<br/><a href='admin/editProduct.jsp'>请重新修改</a>");
            }
        }
        else if (action.equals("delPro")) {
            String id = request.getParameter("id");
            String sql1 = "delete from product where id="+id;
            String sql2 = "delete from album where Pid="+id;
            if (DbOperation.excute(sql1)&&DbOperation.excute(sql2)) {
                String sql3 = "select albumPath from album where Pid="+id;
                String[] pics = DbOperation.getRecord(sql3)[0];
                for (int i = 0; i < pics.length; i++) {
                    ImageDelete.deleteImages(pics[i].substring(61));
                }
                Common.showMessage(response, "删除成功!<br/><a href='admin/listProduct.jsp'>查看商品列表</a>");
            } else {
                Common.showMessage(response, "删除失败!<br/><a href='admin/listProduct.jsp'>请重新删除</a>");
            }
        }
        else if (action.equals("addUser")) {
            String filePath = "/Users/xiebin/Library/Tomcat/webapps/recycleshop/web/faces";
            File file = new File(filePath);
            if (!file.exists()) {
                file.mkdir();
            }
            SmartUpload smartUpload = new SmartUpload();
            smartUpload.initialize(this.getServletConfig(), request, response);
            try {
                smartUpload.setMaxFileSize(5*1024*1024);
                smartUpload.setTotalMaxFileSize(20*1024*1024);
                smartUpload.setAllowedFilesList("jpg,png,jpeg,gif");
                smartUpload.setDeniedFilesList("exe,jsp,txt");
                smartUpload.upload();
                smartUpload.save(filePath);
            } catch (SQLException e) {
                e.printStackTrace();
            } catch (SmartUploadException e) {
                if (e.getMessage().contains("1015")) {
                    Common.alertMessage(response, "<script>alert('上传失败：上传文件类型不正确！');location.href='admin/addProduct.jsp';</script>");
                }
                else if (e.getMessage().contains("1010")) {
                    Common.alertMessage(response, "<script>alert('上传失败：上传文件类型不正确！');location.href='admin/addProduct.jsp';</script>");
                }
                else if (e.getMessage().contains("1105")) {
                    Common.alertMessage(response, "<script>alert('上传失败：上传文件大小大于允许上传的最大值！');location.href='admin/addProduct.jsp';</script>");
                }
                else if (e.getMessage().contains("1110")) {
                    Common.alertMessage(response, "<script>alert('上传失败：上传文件总大小大于允许上传的最大值！');location.href='admin/addProduct.jsp';</script>");
                }
                e.printStackTrace();
            }
            String username = smartUpload.getRequest().getParameter("username");
            String password = smartUpload.getRequest().getParameter("password");
            String email = smartUpload.getRequest().getParameter("email");
            com.jspsmart.upload.File myFile =smartUpload.getFiles().getFile(0);
            String face = "/faces/"+myFile.getFileName();
            String sex = smartUpload.getRequest().getParameter("sex");
            SimpleDateFormat df = new SimpleDateFormat("yyyy-MM-dd,HH:mm:ss");
            String regTime =  df.format(new Date());
            String sql = "insert into user (username, password, email, sex, face, regTime) values ( '"+username+"','"+password+"','"+email+"','"+sex+"','"+face+"','"+regTime+"')";
            if (DbOperation.excute(sql)) {
                Common.showMessage(response, "添加成功!<br/><a href='admin/addUser.jsp' target='mainFrame'>继续添加</a>|<a href='admin/listUser.jsp'>查看用户列表</a>");
            } else {
                ImageDelete.deleteFace(myFile.getFileName());
                Common.showMessage(response,"添加用户失败!<br/><a href='admin/addUser.jsp' target='mainFrame'>重新添加</a>");
            }
        }
        else if (action.equals("editUser")) {
            String id = request.getParameter("id");
            String username = request.getParameter("username");
            String password = request.getParameter("password");
            String email = request.getParameter("email");
            String sex = request.getParameter("sex");
            String sql = "update user set username='"+username+"',password='"+password+"',email='"+email+"',sex='"+sex+"' where id="+id;
            if (DbOperation.excute(sql)) {
                Common.showMessage(response, "编辑成功!<br/><a href='admin/listUser.jsp'>查看用户列表</a>");
            } else {
                Common.showMessage(response, "编辑失败!<br/><a href='admin/listUser.jsp'>请重新修改</a>");
            }
        }
        else if (action.equals("delUser")) {
            String id = request.getParameter("id");
            String sql = "delete from user where id="+id;
            if (DbOperation.excute(sql)) {
                Common.showMessage(response, "删除成功!<br/><a href='admin/listUser.jsp'>查看用户列表</a>");
            } else {
                Common.showMessage(response, "删除失败!<br/><a href='admin/listUser.jsp'>请重新删除</a>");
            }
        }
        else if (action.equals("waterText")) {
            String id = request.getParameter("id");
            String sql = "select albumPath from album where Pid="+id;
            String[][] pics = DbOperation.getRecord(sql);
            for (int i = 0; i < pics[0].length; i++) {
                WaterText.createMark(pics[0][i]);
            }
            Common.alertMessage(response, "<script>alert('图片水印添加成功！');location.href='admin/listProImages.jsp';</script>");
        }
        else if (action.equals("delPic")) {
            String id = request.getParameter("id");
            String sql = "delete from album where Pid="+id;
            if (DbOperation.excute(sql)) {
                Common.showMessage(response, "删除成功!<br/><a href='admin/listProImages.jsp'>查看商品图片列表</a>");
            } else {
                Common.showMessage(response, "删除失败!<br/><a href='admin/listProImage.jsp'>请重新删除</a>");
            }
        }
    }

    public void doGet(HttpServletRequest request, HttpServletResponse response) throws IOException, ServletException {
        doPost(request, response);
    }

}
