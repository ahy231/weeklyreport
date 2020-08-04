<%@ page language="java" contentType="text/html; charset=gb2312"
    pageEncoding="gb2312"%>
<%@ page import="java.sql.*"%>
<%@ include file="function.jsp" %>

<%!
    String name = null;
    String title = new String();
%>

<%
    //name = new String(request.getParameter("name").toString().getBytes("ISO-8859-1"), "gbk");
    int id = Integer.valueOf(request.getParameter("id"));
    name = getStuNameById(id);
    if (session.getAttribute("identity").toString().equals("students")) {
        if (!session.getAttribute("name").toString().equals(name)) {
            response.setStatus(response.SC_MOVED_TEMPORARILY);
            response.setHeader("Location", "identityError.jsp");
        }
    }
    title = "MIR ʵ���ҹ������ȣ�" + name + "��ȫ����¼����";
%>

<html>
    <head>
        <meta charset="gb2312">
        <title><%=title%></title>
        <link rel="stylesheet" type="text/css" href="type.css">
    </head>
    <body>
        <%-- <center>[<a href=index.jsp>�ص���ѡ��</a>]</center> --%>
        <%
            if (session.getAttribute("identity").toString().equals("students")) {
                out.println("[<a href=stu_form.jsp class=\"center\">�ص����ܹ�������</a>]");
            } else {
                out.println("[<a href=teachers.jsp class=\"center\">�ص���ѡ��</a>]");
            }
        %>

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
        <caption><strong><%=name%>�����е�¼����</strong></caption>
        <tr>
        <th>����
        <th>�����������
        <th>����Ԥ��������<br>��<span class="red">Ԥ���������</span>����������
        <th>�ۺ�˵��
        <th> ��¼����

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
                        out.println("<td style=\"background-color: " + color[j] + ";\"><strong><b>" + name + "</b></strong> </td>");
                        out.println("<td style=\"background-color: " + color[j] + ";\">" + PrintField(rs, "finished", 0) + "&nbsp; </td>");
                        out.println("<td style=\"background-color: " + color[j] + ";\">" + PrintDateTask(rs, "thisDate", "thisTask") + "&nbsp; </td>");
                        out.println("<td style=\"background-color: " + color[j] + ";\">" + (rs.getString("summary")==null?"":rs.getString("summary")) + "&nbsp;</td>");
                        out.println("<td style=\"background-color: " + color[j] + ";\">" + rs.getString("entryDate") + "<br>" + new String(rs.getString("entryTime").getBytes("ISO-8859-1"), "gbk") + "&nbsp;</td>");
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