<%@ page language="java" import="java.util.*,java.sql.*" contentType="text/html; charset=gb2312"
    pageEncoding="gb2312"%>
<%@ include file="function.jsp"%>

<%!
    String name = new String();
    String password = new String();
    String identity = new String();
%>

<%
    name = request.getParameter("name").toString();
    password = request.getParameter("password").toString();
    identity = request.getParameter("identity").toString();

    session.setAttribute("name", name);
    session.setAttribute("password", password);
    session.setAttribute("identity", identity);
%>

<html>
    <head>
        <meta charset="gb2312">
        <title><link rel="shortcut icon" href="redball.gif">认证资料错误！</title>
    </head>
    <body>

        <%
            if (identity.equals("teachers")) {
                if (checkStuPassword(name, password)) {
                    response.setStatus(response.SC_MOVED_TEMPORARILY);
                    response.setHeader("Location", "teachers.jsp");
                }
            } else {
                if (checkTchPassword(name, password)) {
                    response.setStatus(response.SC_MOVED_TEMPORARILY);
                    response.setHeader("Location", "stu_form.jsp");
                }
            }
            out.println("<p align=center>" + identity + "</p>");
            out.println("<p align=center>亲爱的 <font color=green>" + session.getAttribute("name") + "</font>，您的认证资料错误，请回<a href=\"javascript:history.go(-1)\">前页</a>修改。");
        %>

    </body>
</html>