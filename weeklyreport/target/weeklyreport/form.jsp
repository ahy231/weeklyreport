<!--
 * @Copyright: free for non-commercial usage
 * @Author: ahy231
 * @Date: 2020-07-24 13:56:55
 * @LastEditor: ahy231
 * @LastEditTime: 2020-07-24 14:11:47
--> 
<%@ page language="java" import="java.util.*,java.sql.*,java.text.*,java.io.*" contentType="text/html; charset=gb2312"
    pageEncoding="gb2312"%>
<%@ include file="function.jsp" %>

<%! String name = new String();%>
<% name = request.getParameter("name"); %>

<html>
    <head>
        <meta charset="gb2312">
        <%
            out.println("<title>登录" + name + "的本周工作进度</title>");
        %>
    </head>
    <body>
        <center>[<a href=listEachPerson.jsp?name=<%=name%>><%=name%>的所有登录资料</a>][<a href=index.jsp>返回主选单</a>]</center>
        <%!
            String JDBC_DRIVER = "com.mysql.cj.jdbc.Driver";
            String DB_URL = "jdbc:mysql://localhost:3306/students?useSSL=false&allowPublicKeyRetrieval=true&serverTimezone=UTC";

            String USER = "stu_login";
            String PASS = "123";

            String[] prevTask = new String[5];
            String[] prevDate = new String[5];
            String[] thisTask = new String[5];
            String[] thisDate = new String[5];
            String[] finished = new String[5];
            String summary = new String();

            Connection conn = null;
            Statement stmt = null;
        %>

        <%
            try {
                //注册JDBC驱动
                Class.forName(JDBC_DRIVER);

                //打开链接
                conn = DriverManager.getConnection(DB_URL, USER, PASS);

                //执行查询
                String sql = "SELECT * FROM " + name + " ORDER BY weekid DESC";
                stmt = conn.createStatement();
                ResultSet rs = stmt.executeQuery(sql);
                
                if (rs.next()) {
                    java.util.Date dNow = new java.util.Date();
                    SimpleDateFormat ftw = new SimpleDateFormat("w");
                    SimpleDateFormat fty = new SimpleDateFormat("yyyy");
                    int thisweek = Integer.valueOf(ftw.format(dNow)) + 100 * Integer.valueOf(fty.format(dNow)); //当前年份加周数
                    if (thisweek == rs.getInt("weekid")) { //若和目前时间在同一周，则显示旧资料
                        for (int i = 0; i < 5; i++) {
                            finished[i] = new String(rs.getString("finished" + Integer.toString(i)).getBytes("ISO-8859-1"), "gbk");
                            thisTask[i] = new String(rs.getString("thisTask" + Integer.toString(i)).getBytes("ISO-8859-1"), "gbk");
                            thisDate[i] = new String(rs.getString("thisDate" + Integer.toString(i)).getBytes("ISO-8859-1"), "gbk");
                            summary = new String(rs.getString("summary").getBytes("ISO-8859-1"), "gbk");
                        }
                        if (rs.next()) { //找到第二笔资料，应该是上星期的资料
                            for (int i = 0; i < 5; i++) {
                                prevTask[i] = new String(rs.getString("thisTask" + Integer.toString(i)).getBytes("ISO-8859-1"), "gbk");
                                prevDate[i] = new String(rs.getString("thisDate" + Integer.toString(i)).getBytes("ISO-8859-1"), "gbk");
                            }
                        }
                    } else { //若和目前时间不在同一个星期...
                        for (int i = 0; i < 5; i++) {
                            prevTask[i] = new String(rs.getString("thisTask" + Integer.toString(i)).getBytes("ISO-8859-1"), "gbk");
                            prevDate[i] = new String(rs.getString("thisDate" + Integer.toString(i)).getBytes("ISO-8859-1"), "gbk");
                        }
                    }
                }
                rs.close();
                stmt.close();
                conn.close();
            } catch (SQLException se) {
                //处理JDBC错误
                se.printStackTrace();
            } catch (Exception e) {
                //处理Class.forName错误
                e.printStackTrace();
            } finally {
                //关闭资源
                try {
                    if (stmt != null) stmt.close();
                } catch (SQLException se2) {
                }
                try {
                    if (conn!=null) conn.close();
                } catch (SQLException se) {
                    se.printStackTrace();
                }
            }
        %>
        <form method=post action="register.jsp">
        <table border=1 align=center>
        <tr>
        <th align=center colspan=2>上周预定完成事项
        <th align=center rowspan=2>本周完成事项
        <th align=center colspan=2>下周预定完成事项
        <th align=center rowspan=2>综合说明
        <tr>
        <th align=center>工作描述<th align=center>预定完成日期
        <th align=center>工作描述<th align=center>预定完成日期
        <% 
            for (int i = 0; i < 5; i++) {
                out.print("<tr>");
                //上周预定完事项
                out.print("<td>" + prevTask[i] + "&nbsp;");
                //上周任务完成时间
                out.print("<td>" + prevDate[i] + "&nbsp;");
                //本周完成任务
                out.print("<td><textarea name=\"finished" + Integer.toString(i) + "\" cols=20 rows=3 wrap=virtual>" + finished[i] + "</textarea>");
                //下周预定完成时向
                out.print("<td><textarea name=\"thisTask" + Integer.toString(i) + "\" cols=20 rows=3 wrap=virtual>" + thisTask[i] + "</textarea>");
                //本周任务完成时间
                out.print("<td><textarea name=\"thisDate" + Integer.toString(i) + "\" cols=15 rows=3 wrap=virtual>" + thisDate[i] + "</textarea>");
                if (i == 0) {
                    //本周任务总结
                    out.print("<td rowspan=5><textarea name=\"summary\" cols=20 rows=18 wrap=virtual>" + summary + "</textarea>");
                }
            } 
        %>
        <%
            for (int i = 0; i < 5; i++) {
                session.setAttribute("prevTask" + Integer.toString(i), (prevTask[i]!=null)?(new String(prevTask[i].getBytes("ISO-8859-1"), "gbk")):"");
                session.setAttribute("prevDate" + Integer.toString(i), (prevDate[i]!=null)?(new String(prevDate[i].getBytes("ISO-8859-1"), "gbk")):"");
            }
        %>
        </table>
        <h3 align=center><font color=green><%=name%></font>的密码: <input type=password size=10 name="password">
        <input type=submit value="送出表单">
        <input type=reset  value="恢复原值">
        </h3>
        <p align=center>
        <input type=hidden name="name" value="<%=name%>">
        </form>
        <hr>
        <center>
        [<a target=_blank href="listEachWeek.jsp?weekDiff=0">本周登录之全部资料</a>]
        [<a target=_blank href="listAllPersonLastRecord.jsp">每位同学的最後一笔资料</a>]
        </center>
    </body>
</html>