<%@ page language="java" contentType="text/html; charset=gb2312"
    pageEncoding="gb2312"%>
<%@ page import="java.sql.*"%>
<%@ include file="function.jsp"%>

<html>
    <head>
        <meta charset="gb2312">
        <title>MIR 实验室工作进度：每个人的最后一笔资料</title>
    </head>
    <body>
        <center>[<a href=teachers.jsp>回到主选单</a>]</center>
        
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
        <th align=center>姓名</th>
        <th align=center>本周完成事项</th>
        <th align=center>下周预定完成事项：<br/>【<font color=red>预定完成日期</font>】工作描述</th>
        <th align=center>综合说明</th>
        <th align=center> 登录日期
        </tr>

        <%!
            String[] students = getMirStudentsName();
            int j = 0;

            String JDBC_DRIVER = "com.mysql.cj.jdbc.Driver";
            String DB_URL = "jdbc:mysql://localhost:3306/students?useSSL=false&allowPublicKeyRetrieval=true&serverTimezone=UTC";

            String USER = "stu_login";
            String PASS = "123";
        
            Connection conn = null;
            Statement stmt = null;
            ResultSet rs = null;
        %>

        <%
            try {
                
                Class.forName(JDBC_DRIVER);

                conn = DriverManager.getConnection(DB_URL, USER, PASS);

                for (int row = 0; row < getMirStudentsNum(); row++) {
                    String name = students[row];
                    stmt = conn.createStatement();
                    String sql = "SELECT * FROM " + name + " ORDER BY weekid DESC";
                    rs = stmt.executeQuery(sql);

                    if (rs.next()) {
                        out.println("<tr>");
                        out.println("<td bgcolor=" + color[j] + " align=center><a target=_blank href=\"listEachPerson.jsp?name=" + name + "\">" + name +"</a> </td>");
                        out.println("<td bgcolor=" + color[j] + " valign=top>" + PrintField(rs, "finished", 0) + " &nbsp; </td>");
                        out.println("<td bgcolor=" + color[j] + " valign=top>" + PrintDateTask(rs, "thisDate", "thisTask") + " &nbsp; </td>");
                        out.println("<td bgcolor=" + color[j] + " valign=top>" + new String(rs.getString("summary").getBytes("ISO-8859-1"), "gbk") + " &nbsp;</td>");
                        out.println("<td bgcolor=" + color[j] + " valign=top>" + new String(rs.getString("entryDate").getBytes("ISO-8859-1"), "gbk") + "<br>" + new String(rs.getString("entryTime").getBytes("ISO-8859-1"), "gbk") + " &nbsp;</td>");
                        out.println("</tr>");
                    } else {
                        out.println("<tr>");
                        out.println("<td bgcolor=" + color[j] + " align=center><a target=_blank href=\"listEachPerson.jsp?name=" + name + "\">" + name + "</a> </td>");
                        out.println("<td bgcolor=gray valign=top>&nbsp;</td>");
                        out.println("<td bgcolor=gray valign=top>&nbsp;</td>");
                        out.println("<td bgcolor=gray valign=top>&nbsp;</td>");
                        out.println("<td bgcolor=gray valign=top>&nbsp;</td>");
                        out.println("<td bgcolor=gray valign=top>&nbsp;</td>");
                        out.println("</tr>");
                    }
                    
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
        </p>
    </body>
</html>