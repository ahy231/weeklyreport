<%@ page language="java" contentType="text/html; charset=gb2312"
    pageEncoding="gb2312"%>
<%@ page import="java.sql.*,java.util.Date,java.text.*"%>
<%@ include file="function.jsp"%>

<%!
    int weekDiff = 1;
    String title = new String();
%>

<%
    weekDiff = Integer.valueOf(request.getParameter("weekDiff").toString());//��Ŀǰ���ڲ�ܣ�-1 ����ǰһ�ܣ�-2 ����ǰ���ܣ��ȵ�

    if(weekDiff == 0) {
        title = "MIR ʵ���ұ��ܵ�¼֮��������";
    } else {
        title = "MIR ʵ����ǰ " + Integer.toString(-weekDiff) + " �ܵ�¼֮��������";
    }
%>

<html>
    <head>
        <meta charset="gb2312">
        <title><%=title%></title>
    </head>
    <body>
        <center>[<a href=index.jsp>�ص���ѡ��</a>]</center>
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
            //ץ����ǰ���� weekDiff ���ڵĵ�һ�������һ��
        %> --%>

        <p>
        <table border=1 align=center>
        <tr>
        <th align=center>����
        <th align=center>�����������
        <th align=center>����Ԥ��������<br>��<font color=red>Ԥ���������</font>����������
        <th align=center>�ۺ�˵��
        <th align=center> ��¼����

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

                    if (rs.next()) { //�д���֮��½����
                        out.println("<tr>");
                        out.println("<td bgcolor=" + color[j] + " align=center><a target=_blank href=\"listEachPerson.jsp?name=" + name + "\">" + name + "</a> </td>");
                        out.println("<td bgcolor=" + color[j] + " valign=top>" + PrintField(rs, "finished", 0) + "&nbsp;</td>");
                        out.println("<td bgcolor=" + color[j] + " valign=top>" + PrintDateTask(rs, "thisDate", "thisTask") + "&nbsp; </td>");
                        out.println("<td bgcolor=" + color[j] + " valign=top>" + new String(rs.getString("summary").getBytes("ISO-8859-1"), "gbk") + "&nbsp;</td>");
                        out.println("<td bgcolor=" + color[j] + " valign=top>" + new String(rs.getString("entryDate").getBytes("ISO-8859-1"), "gbk") + "<br>" + new String(rs.getString("entryTime").getBytes("ISO-8859-1"), "gbk") + "&nbsp;</td>");
                    } else {
                        out.println("<tr>");
                        out.println("<td bgcolor=" + color[j] + " align=center><a target=_blank href=\"listEachPerson.jsp?name=" + name + "\">" + name + "</a> </td>");
                        out.println("<td bgcolor=gray valign=top>&nbsp;</td>");
                        out.println("<td bgcolor=gray valign=top>&nbsp;</td>");
                        out.println("<td bgcolor=gray valign=top>&nbsp;</td>");
                        out.println("<td bgcolor=gray valign=top>&nbsp;</td>");
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