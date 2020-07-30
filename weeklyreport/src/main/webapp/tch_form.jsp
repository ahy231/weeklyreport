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
<% name = session.getAttribute("name").toString(); %>

<html>
    <head>
        <meta charset="gb2312">
        <%
            out.println("<title>登录" + name + "的本周工作进度</title>");
        %>
    </head>

    <%!
        String[] color = new String[9];
        int j = 0;
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

    <body>
        <center>[<a href="listEachPerson.jsp?name=<%=name%>"><%=name%>的所有登录资料</a>][<a href=teachers.jsp>返回主选单</a>]</center>
        <%-- <ol>
        <li>请务必在每星期五下午五点前填写完毕。过了星期六午夜，系统自动跳到下一周，就无法再填写本周的进度了。
        <li>请务必每一栏都要填写，尤其是「本周预定完成事项」，一定要填入相关的「预定完成时间」。
        </ol> --%>
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
        <%-- <form method=post action="handin.jsp"> --%>
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
                out.print("<td bgcolor=" + color[j] + ">" + prevTask[i] + "&nbsp;");
                //上周任务完成时间
                out.print("<td bgcolor=" + color[j] + ">" + prevDate[i] + "&nbsp;");
                //本周完成任务
                out.print("<td bgcolor=" + color[j] + ">" + finished[i] + "&nbsp;");
                //下周预定完成时向
                out.print("<td bgcolor=" + color[j] + ">" + thisTask[i] + "&nbsp;");
                //本周任务完成时间
                out.print("<td bgcolor=" + color[j] + ">" + thisDate[i] + "&nbsp;");
                if (i == 0) {
                    //本周任务总结
                    out.print("<td rowspan=5 bgcolor=" + color[j] + ">" + summary + "&nbsp;");
                }
            } 
            j++;
            if (j == color.length) {
                j = 0;
            }
        %>
        <%-- <%
            for (int i = 0; i < 5; i++) {
                session.setAttribute("prevTask" + Integer.toString(i), (prevTask[i]!=null)?(new String(prevTask[i].getBytes("ISO-8859-1"), "gbk")):"");
                session.setAttribute("prevDate" + Integer.toString(i), (prevDate[i]!=null)?(new String(prevDate[i].getBytes("ISO-8859-1"), "gbk")):"");
            }
        %> --%>
        </table>
        <%-- <h3 align=center>
        <input type=submit value="送出表单">
        <input type=reset  value="恢复原值">
        </h3>
        <input type=hidden name="name" value="<%=name%>"> --%>
        <%-- </form> --%>
        <hr>
        <center>
        [<a target=_blank href="listEachWeek.jsp?weekDiff=0">本周登录之全部资料</a>]
        [<a target=_blank href="listAllPersonLastRecord.jsp">每位同学的最後一笔资料</a>]
        </center>
    </body>
</html>