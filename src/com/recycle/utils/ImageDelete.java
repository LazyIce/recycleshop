package com.recycle.utils;

import com.jspsmart.upload.SmartUpload;
import com.jspsmart.upload.SmartUploadException;

import javax.servlet.ServletConfig;
import javax.servlet.ServletException;
import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;
import java.io.File;
import java.io.IOException;
import java.sql.SQLException;

/**
 * Created by xiebin on 2016/12/21.
 */
public class ImageDelete {

    public static void deleteImages(String fileName) {
        File file = new File("/Users/xiebin/Library/Tomcat/webapps/recycleshop/web/uploads/"+fileName);
        if (file.exists()) {
            File file1 = new File("/Users/xiebin/Library/Tomcat/webapps/recycleshop/web/image_50/"+fileName);
            File file2 = new File("/Users/xiebin/Library/Tomcat/webapps/recycleshop/web/image_220/"+fileName);
            File file3 = new File("/Users/xiebin/Library/Tomcat/webapps/recycleshop/web/image_350/"+fileName);
            File file4 = new File("/Users/xiebin/Library/Tomcat/webapps/recycleshop/web/image_800/"+fileName);
            if (file1.delete()&&file2.delete()&& file3.delete()&&file4.delete()&&file.delete())
                System.out.println("删除成功");
            else
                System.out.println("删除失败");
        }
    }

    public static void deleteFace(String fileName) {
        File file = new File("/Users/xiebin/Library/Tomcat/webapps/recycleshop/web/faces/"+fileName);
        if (file.exists()) {
            if (file.delete())
                System.out.println("删除成功");
            else
                System.out.println("删除失败");
        }
    }
}
