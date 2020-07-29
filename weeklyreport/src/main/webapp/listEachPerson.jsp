<%@ page language="java" contentType="text/html; charset=gb2312"
    pageEncoding="gb2312"%>
<%@ page import="java.sql.*"%>
<%@ include file="function.jsp" %>

<%!
    String name = new String();
    String title = new String();
%>

<%
    name = request.getParameter("name");
    title = "MIR 实验室工作进度：" + name + "的全部登录资料";
%>

<html>
    <head>
        <meta charset="gb2312">
        <title><%=title%></title>
    </head>
    <body>
        <center>[<a href=index.jsp>回到主选单</a>]</center>

        <%!
            String[] color = new String[9];
        %>

        <%
            color[0] = "#ffffdd";
            color[1] = "#ffeeee";
            color[2] = "#eeffee";
            color[3] = "#e0e0f9";
            color[4] = "#eeeeff";
            color[5] = "#ffe9d0";
            color[6] = "#ffffdd";
            color[7] = "#eeeeff";
            color[8] = "#e0e0f9";
        %>

        <p>
        <table border=1 align=center>
        <tr>
        <th align=center>姓名
        <th align=center>本周完成事项
        <th align=center>下周预定完成事项：<br>【<font color=red>预定完成日期</font>】工作描述
        <th align=center>综合说明
        <%-- <th align=center> 登录日期 --%>

        <%
            String JDBC_DRIVER = "com.mysql.cj.jdbc.Driver";
            String DB_URL = "jdbc:mysql://localhost:3306/students?useSSL=false&allowPublicKeyRetrieval=true&serverTimezone=UTC";

            String USER = "stu_login";
            String PASS = "123";

            Connection conn = null;
            Statement stmt = null;
            ResultSet rs = null;

            try {
                String sql = "SELECT * FROM " + name + " ORDER BY weekid DESC";
                conn = DriverManager.getConnection(DB_URL, USER, PASS);
                stmt = conn.createStatement();
                rs = stmt.executeQuery(sql);

                int j = 0;
                while (rs.next()) { //do while?
                        out.println("<tr>");
                        out.println("<td bgcolor=" + color[j] + " align=center><font color=green><b>" + name + "</b></font> </td>");
                        out.println("<td bgcolor=" + color[j] + " valign=top>" + PrintField(rs, "finished", 0) + "&nbsp; </td>");
                        out.println("<td bgcolor=" + color[j] + " valign=top>" + PrintDateTask(rs, "thisDate", "thisTask") + "&nbsp; </td>");
                        out.println("<td bgcolor=" + color[j] + " valign=top>" + new String(rs.getString("summary").getBytes("ISO-8859-1"), "gbk") + "&nbsp;</td>");
                    j += 1;
                    if (j == color.length) {
                        j = 0;
                    }
                }

                rs.close();
                stmt.close();
                conn.close();
            } catch (SQLException se) {
                se.printStackTrace();
            } catch (Exception e) {
                e.printStackTrace();
            } finally {
                try {
                    if (stmt != null) stmt.close();
                } catch (SQLException se2) {
                }
                try {
                    if (conn != null) conn.close();
                } catch (SQLException se) {
                    se.printStackTrace();
                }
            }
        %>
        </table>
    </body>
</html>