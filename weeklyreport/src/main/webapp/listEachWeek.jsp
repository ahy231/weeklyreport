<%@ page language="java" contentType="text/html; charset=gb2312"
    pageEncoding="gb2312"%>
<%@ page import="java.sql.*,java.util.Date,java.text.*"%>
<%@ include file="function.jsp"%>

<%!
    int weekDiff = 1;
    String title = new String();
%>

<%
    weekDiff = Integer.valueOf(request.getParameter("weekDiff").toString());//和目前日期差几周，-1 代表前一周，-2 代表前两周，等等

    if(weekDiff == 0) {
        title = "MIR 实验室本周登录之工作进度";
    } else {
        title = "MIR 实验室前 " + Integer.toString(-weekDiff) + " 周登录之工作进度";
    }
%>

<html>
    <head>
        <meta charset="gb2312">
        <title><%=title%></title>
        <link rel="stylesheet" type="text/css" href="type.css">
    </head>
    <body>
        [<a href=teachers.jsp class=center>回到主选单</a>]
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

        <%-- <%
            //抓出往前倒推 weekDiff 星期的第一天和最後一天
        %> --%>

        <p>
        <table>
        <caption><%=title%></caption>
        <tr>
        <th>姓名
        <th>本周完成事项
        <th>下周预定完成事项：<br>【<span class="red">预定完成日期</span>】工作描述
        <th>综合说明
        <th> 登录日期

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

            Date dNow = new Date();
            SimpleDateFormat ftw = new SimpleDateFormat("w");
            SimpleDateFormat fty = new SimpleDateFormat("yyyy");
            int weekid = 0;
        %>

        <%
            weekid = Integer.valueOf(ftw.format(dNow)) + 100 * Integer.valueOf(fty.format(dNow));

            for (int row = 0; row < getMirStudentsNum(); row++) {
                
                String name = students[row];

                try {
                    
                    Class.forName(JDBC_DRIVER);

                    conn = DriverManager.getConnection(DB_URL, USER, PASS);

                    String sql = "SELECT * FROM " + name + " WHERE weekid=" + Integer.toString(weekid + weekDiff);
                    stmt = conn.createStatement();
                    rs = stmt.executeQuery(sql);

                    if (rs.next()) { //有此人之登陆资料
                        out.println("<tr>");
                        out.println("<td style=\"background-color: " + color[j] + "\"><a target=_blank href=\"listEachPerson.jsp?id=" + getStuId(name) + "\">" + name + "</a> </td>");
                        out.println("<td style=\"background-color: " + color[j] + "\">" + PrintField(rs, "finished", 0) + "&nbsp;</td>");
                        out.println("<td style=\"background-color: " + color[j] + "\">" + PrintDateTask(rs, "thisDate", "thisTask") + "&nbsp; </td>");
                        out.println("<td style=\"background-color: " + color[j] + "\">" + (rs.getString("summary")==null?"":rs.getString("summary")) + "&nbsp;</td>");
                        out.println("<td style=\"background-color: " + color[j] + "\">" + rs.getString("entryDate") + "<br>" + rs.getString("entryTime") + "&nbsp;</td>");
                    } else {
                        out.println("<tr>");
                        out.println("<td style=\"background-color: " + color[j] + "\"><a target=_blank href=\"listEachPerson.jsp?id=" + getStuId(name) + "\">" + name + "</a> </td>");
                        out.println("<td style=\"background-color: gray\">&nbsp;</td>");
                        out.println("<td style=\"background-color: gray\">&nbsp;</td>");
                        out.println("<td style=\"background-color: gray\">&nbsp;</td>");
                        out.println("<td style=\"background-color: gray\">&nbsp;</td>");
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
                    } catch (SQLException se2){
                    }
                    try {
                        if (conn != null) conn.close();
                    } catch (SQLException se) {
                        se.printStackTrace();
                    }
                }
                j += 1;
                if (j == color.length) {
                    j = 0;
                }
            }
        %>
        </table>
    </body>
</html>