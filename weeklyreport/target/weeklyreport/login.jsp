<%@ page language="java" import="java.util.*,java.sql.*" contentType="text/html; charset=gb2312"
    pageEncoding="gb2312"%>
<%@ include file="function.jsp"%>

<%!
    String name = null;
    String password = new String();
    String identity = new String();
%>

<%
    name = new String(request.getParameter("name").toString().getBytes("ISO-8859-1"), "gbk");
    password = request.getParameter("password").toString();
    identity = request.getParameter("identity").toString();

    session.setAttribute("name", name);
    session.setAttribute("password", password);
    session.setAttribute("identity", identity);
%>

<html>
    <head>
        <meta charset="gb2312">
        <title>正在登录中……</title>
        <style>
            p {text-align: center;}
        </style>
        <link rel="stylesheet" type="text/css" href="type.css">
    </head>
    <body>

        <%
            if (identity.equals("teachers")) {
                if (checkTchPassword(name, password)) {
                    response.setStatus(response.SC_MOVED_TEMPORARILY);
                    response.setHeader("Location", "teachers.jsp");
                }
            } else {
                if (checkStuPassword(name, password)) {
                    response.setStatus(response.SC_MOVED_TEMPORARILY);
                    response.setHeader("Location", "stu_form.jsp");
                }
            }
            //out.println("<p align=center>" + identity + "</p>");
            out.println("<p>亲爱的 <strong>" + name + "</strong>，您的认证资料错误，请回<a href=\"javascript:history.go(-1)\">前页</a>修改。");
        %>

    </body>
</html>