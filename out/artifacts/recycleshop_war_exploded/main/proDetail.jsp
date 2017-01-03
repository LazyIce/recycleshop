<%@ page import="com.recycle.utils.ShopUtil" %><%--
  Created by IntelliJ IDEA.
  User: xiebin
  Date: 2017/1/2
  Time: 下午3:28
  To change this template use File | Settings | File Templates.
--%>
<%@ page contentType="text/html;charset=UTF-8" language="java" %>
<!DOCTYPE html>
<html>
<head lang="en">
    <meta http-equiv="content-type" content="text/html; charset=UTF-8">
    <title>商品详情页面</title>
    <link rel="stylesheet" href="../styles/reset.css" type="text/css"/>
    <link rel="stylesheet" href="../styles/goodsDetail.css" type="text/css"/>
    <script src="../scripts/jquery-1.6.js" type="text/javascript"></script>
</head>
<body>
<%
    String username = "";
    if (session.getAttribute("userName") != null)
        username = (String) session.getAttribute("userName");
    else if (request.getCookies() != null) {
        Cookie[] cookies;
        cookies = request.getCookies();
        if (cookies != null) {
            for (Cookie cookie : cookies) {
                if (cookie.getName().equals("userName"))
                    username = cookie.getValue();
            }
        }
        session.setAttribute("userName", username);
    }
    String Pid = request.getParameter("Pid");
    String Pcatalog = ShopUtil.getCatalogue(Pid);
    String Prophoto = ShopUtil.getAlbumPath(Pid);
    String[][] proDetail = ShopUtil.getOneProduct(Pid);
%>
<div class="header">
    <div class="header_top">
        <div class="comwidth">
            <div class="header_left">
                <span style="line-height: 30px;">Hi，欢迎来到懒懒网商城！</span>
            </div>
            <ul class="header_right">
                <li><a href="#">帮助</a></li>
                <li><a href="#">物流信息</a></li>
                <li><a href="#">我的订单</a></li>
                <%
                    if (username.equals(""))
                        out.print(" <li><a href=\"regist.jsp\" target=\"_blank\">[免费注册]</a></li>\n" +
                                "<li><a href=\"login.jsp\" target=\"_blank\">[请登录]</a></li>");
                    else
                        out.print(" <li><span>欢迎您</span></li>\n" +
                                "<li><span>"+username+"</span></li>");
                %>
            </ul>
        </div>
    </div>
    <div class="header_bottom comwidth">
        <div class="logo">
            <span>
            </span>
        </div>
        <div class="search">
            <form target="_blank" method="post" action="/ShopServlet?act=search">
                <input type="text" name="search"/>
                <input type="submit" value="搜索" />
            </form>
        </div>
        <div id="user" class="user">
            <div id="userText" class="user_text">
                <img src="image/icon/user_24.png" alt="user"/>
                <span>关于我</span>
            </div>
            <div id="userList" class="user_list">
                <ul>
                    <li><a href="myOrder.jsp">我的账户</a></li>
                    <li><a href="myOrder.jsp">我的订单</a></li>
                    <li><a href="#">评价商品</a></li>
                    <li><a href="#">会员专区</a></li>
                </ul>
            </div>
        </div>
        <!--购物车-->
        <div id="cart" class="cart clearfix">
            <div class="shop_text">
                <img src="image/icon/cart_24.png" alt="cart"/>
                <a href="cart.jsp">购物车</a>
                <span class="angle down"></span>
            </div>
            <div class="shop_num"><%= ShopUtil.totalOrders(username) %></div>
        </div>
    </div>
    <div class="cat_list comwidth clearfix">
        <ul>
            <li><a href="index.jsp">首页</a></li>
            <%
                String[][] cName = ShopUtil.getAllCates();
                for (int i = 0; i < cName[0].length; i++) {
            %>
            <li><a href="products.jsp?catalogue=<%= cName[0][i] %>"><%= cName[0][i] %></a></li>
            <% } %>
        </ul>
    </div>
</div>

<div class="main comwidth">
    <div class="mini_site">
        <a href="index.jsp">懒懒网首页</a>
        <span class="right_next">&gt;</span>
        <a href="products.jsp?catalogue=<%= Pcatalog %>"><%= Pcatalog %></a>
        <span class="right_next">&gt;</span>
    </div>
    <div class="detail_info clearfix">
        <div class="fl info_left">
            <div class="small_img">
                <img src="../uploads/<%= Prophoto %>"/>
                <div class="float_box"></div>
            </div>
            <div class="big_img">
                <img src="../uploads/<%= Prophoto %>"/>
            </div>

            <div class="img_list">
                <span class="angle left"></span>
                <ul class="clearfix">
                    <li><img src="../uploads/<%= Prophoto %>"/></li>
                </ul>
                <span class="angle right"></span>
            </div>
        </div>
        <script src="../scripts/fangdajing.js" type="text/javascript"></script>

        <div class="fr info_right">
            <div class="title">
                <h2><%= proDetail[1][0] %></h2>
                <p><%= proDetail[7][0] %></p>
            </div>
            <div class="price_tag">
                <span class="tag">市场价格</span>
                <span class="value">&yen;<%= proDetail[5][0] %></span>
            </div>
            <div class="price_tag">
                <span class="tag">懒懒网价格</span>
                <span class="value">&yen;<%= proDetail[6][0] %></span>
            </div>
            <form action="/ShopServlet?act=addCart&pId=<%= Pid %>" method="post" id="myform">
            <div class="buy_info">
                <dl class="buy_count">
                    <dt>购买数量</dt>
                    <dd>
                        <a id="amountSub" class="amount_sub" href="javascript:void(0)">-</a>
                        <input type="text" id="amountInput" class="amount_input" readonly="readonly" value="1" name="amount"/>
                        <a id="amountAdd" class="amount_add" href="javascript:void(0)">+</a>
                    </dd>
                </dl>
            </div>
            <div class="info_submit">
                <div class="addcart">
                    <a class="addcart_btn" onclick="mysubmit()">
                        <img src="image/icon/cart_24.png"/>添加到购物车</a>
                </div>
            </div>
            </form>
            <script>
                function mysubmit(){
                    var myform=document.getElementById("myform");
                    myform.submit();
                }
            </script>
        </div>
        <script type="text/javascript" src="../scripts/goodsBuy.js"></script>

    </div><!--END DETAIL_INFO-->
    <div class="goods_attr">
        <div id="goodsTab" class="goods_tab clearfix">
            <a class="tab_desc selected" href="javascript:void(0)">商品介绍</a>
            <a class="tab_param" href="javascript:void(0)">规格及包装</a>
            <a class="tab_sale" href="javascript:void(0)">售后服务</a>
            <a class="tab_comment" href="javascript:void(0)">评价</a>
            <a class="tab_refer" href="javascript:void(0)">商品咨询</a>
        </div>
        <div id="goodsDetail" class="goods_detail">
            <!--商品介绍-->
            <div class="detail_desc">
                <dl class="desc_info clearfix">
                    <dt>规格参数
                        <a href="javascript:void(0)" class="standard_more">查看更多 »</a>
                    </dt>
                    <dd title="售后服务：全国联保">售后服务：全国联保</dd>
                    <dd title="型号：MD760CH/B">型号：MD760CH/B</dd>
                    <dd title="预装系统：Mac OS X">预装系统：Mac OS X</dd>
                    <dd title="平台：Intel平台">平台：Intel平台</dd>
                    <dd title="CPU型号：Intel 酷睿i5 4260U">CPU型号：Intel 酷睿i5 4260U</dd>
                    <dd title="CPU核心数：双核">CPU核心数：双核</dd>
                    <dd title="CPU速度：1.4GHz">CPU速度：1.4GHz</dd>
                    <dd title="CPU三级缓存：3MB">CPU三级缓存：3MB</dd>
                    <dd title="内存容量：4GB">内存容量：4GB</dd>
                    <dd title="内存类型：DDR3 1600">内存类型：DDR3 1600</dd>
                    <dd title="最大内存支持：8GB">最大内存支持：8GB</dd>
                    <dd title="硬盘类型：SSD固态硬盘">硬盘类型：SSD固态硬盘</dd>
                    <dd title="硬盘容量：128GB">硬盘容量：128GB</dd>
                    <dd title="显卡类型：核芯显卡">显卡类型：核芯显卡</dd>
                    <dd title="显卡芯片：Intel GMA HD 5000">显卡芯片：Intel GMA HD 5000</dd>
                </dl>
            </div>
            <!--规格及包装-->
            <div class="detail_param">
                <h4>规格参数</h4>
                <dl class="standard">
                    <dt>售后</dt>
                    <dd>
                        <label>售后服务</label>
                        全国联保
                    </dd>
                </dl>
                <dl class="standard">
                    <dt>主体</dt>
                    <dd>
                        <label>型号</label>
                        MD760CH/B
                    </dd>
                    <dd>
                        <label>预装系统</label>
                        Mac OS X
                    </dd>
                    <dd>
                        <label>平台</label>
                        Intel平台
                    </dd>
                </dl>
                <dl class="standard">
                    <dt>处理器</dt>
                    <dd>
                        <label>CPU型号</label>
                        Intel 酷睿i5 4260U
                    </dd>
                    <dd>
                        <label>CPU核心数</label>
                        双核
                    </dd>
                    <dd>
                        <label>CPU速度</label>
                        1.4GHz
                    </dd>
                    <dd>
                        <label>CPU三级缓存</label>
                        3MB
                    </dd>
                </dl>
                <dl class="standard">
                    <dt>内存</dt>
                    <dd>
                        <label>内存容量</label>
                        4GB
                    </dd>
                    <dd>
                        <label>内存类型</label>
                        DDR3 1600
                    </dd>
                    <dd>
                        <label>最大内存支持</label>
                        8GB
                    </dd>
                </dl>
                <dl class="standard">
                    <dt>硬盘</dt>
                    <dd>
                        <label>硬盘类型</label>
                        SSD固态硬盘
                    </dd>
                    <dd>
                        <label>硬盘容量</label>
                        128GB
                    </dd>
                </dl>
                <dl class="standard">
                    <dt>显卡</dt>
                    <dd>
                        <label>显卡类型</label>
                        核芯显卡
                    </dd>
                    <dd>
                        <label>显卡芯片</label>
                        Intel GMA HD 5000
                    </dd>
                    <dd>
                        <label>显存容量</label>
                        共享系统内存
                    </dd>
                </dl>
                <dl class="standard">
                    <dt>显示屏</dt>
                    <dd>
                        <label>屏幕尺寸</label>
                        13英寸
                    </dd>
                    <dd>
                        <label>屏幕比例</label>
                        宽屏16:10
                    </dd>
                    <dd>
                        <label>物理分辨率</label>
                        1440*900
                    </dd>
                    <dd>
                        <label>触摸屏</label>
                        非触摸屏
                    </dd>
                </dl>
                <dl class="standard">
                    <dt>通信</dt>
                    <dd>
                        <label>蓝牙</label>
                        支持蓝牙
                    </dd>
                    <dd>
                        <label>内置3G网卡</label>
                        无内置3G网卡
                    </dd>
                    <dd>
                        <label>无线网卡</label>
                        有无线网卡
                    </dd>
                    <dd>
                        <label>蓝牙版本</label>
                        蓝牙4.0
                    </dd>
                </dl>
                <dl class="standard">
                    <dt>输入设备</dt>
                    <dd>
                        <label>光驱</label>
                        无光驱
                    </dd>
                    <dd>
                        <label>扬声器</label>
                        内置扬声器
                    </dd>
                    <dd>
                        <label>内置麦克风</label>
                        内置麦克风
                    </dd>
                    <dd>
                        <label>触摸板</label>
                        有触摸板
                    </dd>
                    <dd>
                        <label>键盘背光</label>
                        有背光灯
                    </dd>
                    <dd>
                        <label>指点杆</label>
                        无指点杆
                    </dd>
                </dl>
                <dl class="standard">
                    <dt>其他设备</dt>
                    <dd>
                        <label>内置摄像头</label>
                        有摄像头
                    </dd>
                    <dd>
                        <label>指纹识别</label>
                        不支持指纹识别
                    </dd>
                </dl>
                <dl class="standard">
                    <dt>端口</dt>
                    <dd>
                        <label>HDMI</label>
                        无HDMI接口
                    </dd>
                    <dd>
                        <label>视频端口</label>
                        mini DisplayPort
                    </dd>
                    <dd>
                        <label>音频端口</label>
                        耳机插孔、立体声扬声器
                    </dd>
                </dl>
                <dl class="standard">
                    <dt>电源</dt>
                    <dd>
                        <label>电池</label>
                        内置 54 瓦时锂聚合物电池
                    </dd>
                    <dd>
                        <label>续航时间</label>
                        长达 12 小时无线网络浏览
                    </dd>
                    <dd>
                        <label>电源适配器</label>
                        45 瓦 MagSafe 2 电源适配器
                    </dd>
                </dl>
                <dl class="standard">
                    <dt>机器规格</dt>
                    <dd>
                        <label>外观尺寸</label>
                        13英寸
                    </dd>
                    <dd>
                        <label>笔记本重量</label>
                        1.35KG
                    </dd>
                </dl>
                <p class="tit">包装清单</p>
                <p class="con">由于厂商产品批次不同，具体包装清单可能各有不同，请以实物为准 ！
                </p>
            </div>
            <!--售后服务-->
            <div class="detail_sale">
                <p class="tit">服务承诺</p>
                <p class="con">网站所售产品均为厂商正品，如有任何问题可与我们客服人员联系，我们会在第一时间跟您沟通处理。我们将争取以最低的价格、最优的服务来满足您最大的需求。开箱验货：请根据文描页开箱验货标准进行验收。如存在包装破损等影响签收的因素，请您可以拒收全部商品（包括赠品）；为了保护您的权益，建议您尽量不要委托他人代为签收；如由他人代为签收商品而没有在配送人员在场的情况下验货，则视为您所订购商品的包装无任何问题。</p>
                <p class="tit">温馨提示</p>
                <p>由于部分商品包装更换较为频繁，因此您收到的货品有可能与图片不完全一致，请您以收到的商品实物为准，同时我们会尽量做到及时更新，由此给您带来不便多多谅解，谢谢！</p>
            </div>
            <!--评价-->
            <div class="detail_comment"></div>
            <!--商品咨询-->
            <div class="detail_refer"></div>
        </div>
    </div><!--END GOODS_ATTR-->
    <script type="text/javascript" src="../scripts/goodsDetail.js"></script>
</div><!--END MAIN-->
<div class="footer comwidth">
    <div class="footer_content">
        <dl>
            <dt>了解我们</dt>
            <dd>
                <div><a href="#">人才招聘</a></div>
                <div><a href="#">关于我们</a></div>
                <div><a href="#">新闻中心</a></div>
                <div><a href="#">移动终端</a></div>
            </dd>
        </dl>
        <dl>
            <dt>购物资讯</dt>
            <dd>
                <div><a href="#">热门商品</a></div>
                <div><a href="#">热门促销</a></div>
            </dd>
        </dl>
        <dl>
            <dt>支付方式</dt>
            <dd>
                <div><a href="#">XX支付</a></div>
                <div><a href="#">XX账户</a></div>
                <div><a href="#">支付宝与财付通</a></div>
                <div><a href="#">网上银行</a></div>
            </dd>
        </dl>
        <dl>
            <dt>物流信息</dt>
            <dd>
                <div><a href="#">物流公司</a></div>
                <div><a href="#">物流费用</a></div>
                <div><a href="#">物流排行</a></div>
                <div><a href="#">物流评分</a></div>
                <div><a href="#">物流投诉</a></div>
            </dd>
        </dl>
        <dl>
            <dt>帮助和购物指南</dt>
            <dd>
                <div><a href="#">订单查询</a></div>
                <div><a href="#">在线退换货</a></div>
                <div><a href="#">退货政策</a></div>
                <div><a href="#">帮助</a></div>
            </dd>
        </dl>
    </div>
    <div class="footer_links">
        <a href="#">联系我们</a>|
        <a href="#">人才招聘</a>|
        <a href="#">商家入驻</a>|
        <a href="#">营销中心</a>|
        <a href="#">手机XX</a>|
        <a href="#">友情链接</a>
    </div>
    <div class="copyright">
        <p>Copyright © 2016-2017 Lazyice</p>
    </div>
</div><!--END FOOTER-->
</body>
</html>
