<%@ page language="java" contentType="text/html; charset=gb2312"
    pageEncoding="gb2312"%>
<%@ include file="function.jsp"%>

<%!
    String name = null;
    String password1 = new String();
    String password2 = new String();
    String identity = new String();
    String inv_code = new String();
%>

<%
    name = new String(request.getParameter("name").toString().getBytes("ISO-8859-1"), "gbk");
    password1 = request.getParameter("password1").toString();
    password2 = request.getParameter("password2").toString();
    identity = request.getParameter("identity").toString();

    if (identity.equals("teachers")) {
        inv_code = request.getParameter("invest_code").toString();
    }
%>

<html>
    <head>
        <meta charset="gb2312">
        <title>注册结果</title>
        <style>
            h2 {text-align: center; color: red;}
            p {text-align: center;}
        </style>
    </head>
    <body>

        <%
            try {
                if (name.equals(""))
                {
                    out.println("<h2>注册失败</h2>");
                    out.println("<p>对不起，用户名不能为空！退回<a href=\"javascript:history.go(-1)\">前一页</a>重新注册。</p>");
                } else {
                    if (identity.equals("students")) {
                        if (ifExistsStu(name)) {
                            out.println("<h2>注册失败</h2>");
                            out.println("<p>对不起，该用户名已存在，请退回<a href=\"javascript:history.go(-1)\">前一页</a>重新注册。</p>");
                        } else {
                            if (!password1.equals(password2)) {
                                out.println("<h2>注册失败</h2>");
                                out.println("<p>两次输入的密码不同，请退回<a href=\"javascript:history.go(-1)\">前一页</a>重新注册。</p>");
                            } else {
                                if (stu_register(name, password1)) {
                                    out.println("<h2>注册成功</h2>");
                                    out.println("<p>恭喜你注册成功，可以前往<a href=\"index.jsp\">登陆页面</a>登录账号。</p>");
                                } else {
                                    out.println("<h2>注册失败</h2>");
                                    out.println("<p>对不起，服务器出了点小差错，请稍后重试。</p>");
                                    throw new Exception("Register failed!");
                                }
                            }
                        }
                    } else {
                        if (ifExistsTch(name)) {
                            out.println("<h2>注册失败</h2>");
                            out.println("<p>对不起，该用户名已存在，请退回<a href=\"javascript:history.go(-1)\">前一页</a>重新注册。</p>");
                        } else {
                            if (!password1.equals(password2)) {
                                out.println("<h2>注册失败</h2>");
                                out.println("<p>两次输入的密码不同，请退回<a href=\"javascript:history.go(-1)\">前一页</a>重新注册。</p>");
                            } else {
                                if (!checkInvestCode(inv_code)) {
                                    out.println("<h2>注册失败</h2>");
                                    out.println("<p>对不起，您输入的邀请码有误，请退回<a href=\"javascript:history.go(-1)\">前一页</a>重新注册。</p>");
                                } else {
                                    if (tch_register(name, password2)) {
                                        out.println("<h2>注册成功</h2>");
                                        out.println("<p>恭喜你注册成功，可以前往<a href=\"index.jsp\">登陆页面</a>登录账号。</p>");
                                    } else {
                                        out.println("<h2>注册失败</h2>");
                                        out.println("<p>对不起，服务器出了点小差错，请稍后重试。</p>");
                                        throw new Exception("Register failed!");
                                    }
                                }
                            }
                        }
                    }
                }
            } catch (Exception e) {
                e.printStackTrace();
            }
        %>

    </body>
</html>