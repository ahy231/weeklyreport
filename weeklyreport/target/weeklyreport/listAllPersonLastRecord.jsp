<%@ page language="java" contentType="text/html; charset=gb2312"
    pageEncoding="gb2312"%>
<%@ page import="java.sql.*"%>
<%@ include file="function.jsp"%>

<html>
    <head>
        <meta charset="gb2312">
        <title>MIR 实验室工作进度：每个人的最后一笔资料</title>
        <link rel="stylesheet" type="text/css" href="type.css">
    </head>
    <body>
        [<a href=teachers.jsp class="center">回到主选单</a>]
        
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
        <table>
        <caption>所有学生的最后一份资料</caption>
        <tr>
        <th>姓名</th>
        <th>本周完成事项</th>
        <th>下周预定完成事项：<br/>【<span class="red">预定完成日期</span>】工作描述</th>
        <th>综合说明</th>
        <th> 登录日期
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
                        out.println("<td style=\"background-color: " + color[j] + ";\"><a target=_blank href=\"listEachPerson.jsp?id=" + getStuId(name) + "\">" + name +"</a> </td>");
                        out.println("<td style=\"background-color: " + color[j] + ";\">" + PrintField(rs, "finished", 0) + " &nbsp; </td>");
                        out.println("<td style=\"background-color: " + color[j] + ";\">" + PrintDateTask(rs, "thisDate", "thisTask") + " &nbsp; </td>");
                        out.println("<td style=\"background-color: " + color[j] + ";\">" + (rs.getString("summary")==null?"":rs.getString("summary")) + " &nbsp;</td>");
                        out.println("<td style=\"background-color: " + color[j] + ";\">" + rs.getString("entryDate") + "<br>" + rs.getString("entryTime") + " &nbsp;</td>");
                        out.println("</tr>");
                    } else {
                        out.println("<tr>");
                        out.println("<td style=\"background-color: " + color[j] + ";\"><a target=_blank href=\"listEachPerson.jsp?id=" + getStuId(name) + "\">" + name + "</a> </td>");
                        out.println("<td style=\"background-color: grey\">&nbsp;</td>");
                        out.println("<td style=\"background-color: grey\">&nbsp;</td>");
                        out.println("<td style=\"background-color: grey\">&nbsp;</td>");
                        out.println("<td style=\"background-color: grey\">&nbsp;</td>");
                        out.println("<td style=\"background-color: grey\">&nbsp;</td>");
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