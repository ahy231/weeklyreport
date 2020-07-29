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
            out.println("<title>��¼" + name + "�ı��ܹ�������</title>");
        %>
    </head>
    <body>
        <center>[<a href=listEachPerson.jsp?name=<%=name%>><%=name%>�����е�¼����</a>][<a href=index.jsp>������ѡ��</a>]</center>
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
                //ע��JDBC����
                Class.forName(JDBC_DRIVER);

                //������
                conn = DriverManager.getConnection(DB_URL, USER, PASS);

                //ִ�в�ѯ
                String sql = "SELECT * FROM " + name + " ORDER BY weekid DESC";
                stmt = conn.createStatement();
                ResultSet rs = stmt.executeQuery(sql);
                
                if (rs.next()) {
                    java.util.Date dNow = new java.util.Date();
                    SimpleDateFormat ftw = new SimpleDateFormat("w");
                    SimpleDateFormat fty = new SimpleDateFormat("yyyy");
                    int thisweek = Integer.valueOf(ftw.format(dNow)) + 100 * Integer.valueOf(fty.format(dNow)); //��ǰ��ݼ�����
                    if (thisweek == rs.getInt("weekid")) { //����Ŀǰʱ����ͬһ�ܣ�����ʾ������
                        for (int i = 0; i < 5; i++) {
                            finished[i] = new String(rs.getString("finished" + Integer.toString(i)).getBytes("ISO-8859-1"), "gbk");
                            thisTask[i] = new String(rs.getString("thisTask" + Integer.toString(i)).getBytes("ISO-8859-1"), "gbk");
                            thisDate[i] = new String(rs.getString("thisDate" + Integer.toString(i)).getBytes("ISO-8859-1"), "gbk");
                            summary = new String(rs.getString("summary").getBytes("ISO-8859-1"), "gbk");
                        }
                        if (rs.next()) { //�ҵ��ڶ������ϣ�Ӧ���������ڵ�����
                            for (int i = 0; i < 5; i++) {
                                prevTask[i] = new String(rs.getString("thisTask" + Integer.toString(i)).getBytes("ISO-8859-1"), "gbk");
                                prevDate[i] = new String(rs.getString("thisDate" + Integer.toString(i)).getBytes("ISO-8859-1"), "gbk");
                            }
                        }
                    } else { //����Ŀǰʱ�䲻��ͬһ������...
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
                //����JDBC����
                se.printStackTrace();
            } catch (Exception e) {
                //����Class.forName����
                e.printStackTrace();
            } finally {
                //�ر���Դ
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
        <th align=center colspan=2>����Ԥ���������
        <th align=center rowspan=2>�����������
        <th align=center colspan=2>����Ԥ���������
        <th align=center rowspan=2>�ۺ�˵��
        <tr>
        <th align=center>��������<th align=center>Ԥ���������
        <th align=center>��������<th align=center>Ԥ���������
        <% 
            for (int i = 0; i < 5; i++) {
                out.print("<tr>");
                //����Ԥ��������
                out.print("<td>" + prevTask[i] + "&nbsp;");
                //�����������ʱ��
                out.print("<td>" + prevDate[i] + "&nbsp;");
                //�����������
                out.print("<td><textarea name=\"finished" + Integer.toString(i) + "\" cols=20 rows=3 wrap=virtual>" + finished[i] + "</textarea>");
                //����Ԥ�����ʱ��
                out.print("<td><textarea name=\"thisTask" + Integer.toString(i) + "\" cols=20 rows=3 wrap=virtual>" + thisTask[i] + "</textarea>");
                //�����������ʱ��
                out.print("<td><textarea name=\"thisDate" + Integer.toString(i) + "\" cols=15 rows=3 wrap=virtual>" + thisDate[i] + "</textarea>");
                if (i == 0) {
                    //���������ܽ�
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
        <h3 align=center><font color=green><%=name%></font>������: <input type=password size=10 name="password">
        <input type=submit value="�ͳ���">
        <input type=reset  value="�ָ�ԭֵ">
        </h3>
        <p align=center>
        <input type=hidden name="name" value="<%=name%>">
        </form>
        <hr>
        <center>
        [<a target=_blank href="listEachWeek.jsp?weekDiff=0">���ܵ�¼֮ȫ������</a>]
        [<a target=_blank href="listAllPersonLastRecord.jsp">ÿλͬѧ������һ������</a>]
        </center>
    </body>
</html>