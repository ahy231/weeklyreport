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
            out.println("<title>��¼" + name + "�ı��ܹ�������</title>");
        %>
    </head>
    <body>
        <center>[<a href="listEachPerson.jsp?id=<%=getStuId(name)%>"><%=name%>�����е�¼����</a>][<a href=index.jsp>���ص�¼����</a>]</center>
        <ol>
        <li>�������ÿ�������������ǰ��д��ϡ�������������ҹ��ϵͳ�Զ�������һ�ܣ����޷�����д���ܵĽ����ˡ�
        <li>�����ÿһ����Ҫ��д�������ǡ�����Ԥ����������һ��Ҫ������صġ�Ԥ�����ʱ�䡹��
        </ol>
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
            for (int i = 0; i < 5; i++) {
                prevTask[i] = "";
                prevDate[i] = "";
                thisTask[i] = "";
                thisDate[i] = "";
                finished[i] = "";
            }
            summary = "";
            
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
                            finished[i] = rs.getString("finished" + Integer.toString(i));
                            thisTask[i] = rs.getString("thisTask" + Integer.toString(i));
                            thisDate[i] = rs.getString("thisDate" + Integer.toString(i));
                            summary = rs.getString("summary");
                        }
                        if (rs.next()) { //�ҵ��ڶ������ϣ�Ӧ���������ڵ�����
                            for (int i = 0; i < 5; i++) {
                                prevTask[i] = rs.getString("thisTask" + Integer.toString(i));
                                prevDate[i] = rs.getString("thisDate" + Integer.toString(i));
                            }
                        }
                    } else { //����Ŀǰʱ�䲻��ͬһ������...
                        for (int i = 0; i < 5; i++) {
                            prevTask[i] = rs.getString("thisTask" + Integer.toString(i));
                            prevDate[i] = rs.getString("thisDate" + Integer.toString(i));
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
        <form method=post action="handin.jsp">
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
                out.print("<td>" + (prevTask[i]==null?"":prevTask[i]) + "&nbsp;");
                //�����������ʱ��
                out.print("<td>" + (prevDate[i]==null?"":prevDate[i]) + "&nbsp;");
                //�����������
                out.print("<td><textarea name=\"finished" + Integer.toString(i) + "\" cols=20 rows=3 wrap=virtual>" + (finished[i]==null?"":finished[i]) + "</textarea>");
                //����Ԥ�����ʱ��
                out.print("<td><textarea name=\"thisTask" + Integer.toString(i) + "\" cols=20 rows=3 wrap=virtual>" + (thisTask[i]==null?"":thisTask[i]) + "</textarea>");
                //�����������ʱ��
                out.print("<td><textarea name=\"thisDate" + Integer.toString(i) + "\" cols=15 rows=3 wrap=virtual>" + (thisDate[i]==null?"":thisDate[i]) + "</textarea>");
                if (i == 0) {
                    //���������ܽ�
                    out.print("<td rowspan=5><textarea name=\"summary\" cols=20 rows=18 wrap=virtual>" + (summary==null?"":summary) + "</textarea>");
                }
            } 
        %>
        <%
            for (int i = 0; i < 5; i++) {
                session.setAttribute("prevTask" + Integer.toString(i), (prevTask[i]!=null)?prevTask[i]:"");
                session.setAttribute("prevDate" + Integer.toString(i), (prevDate[i]!=null)?prevDate[i]:"");
            }
        %>
        </table>
        <h3 align=center>
        <input type=submit value="�ͳ���">
        <input type=reset  value="�ָ�ԭֵ">
        </h3>
        <input type=hidden name="name" value="<%=name%>">
        </form>
        <hr>
        <center>
        <%-- [<a target=_blank href="listEachPerson.jsp?name=<%=name%>"><%=name%>��¼֮ȫ������</a>] --%>
        <%-- [<a target=_blank href="listAllPersonLastRecord.jsp">ÿλͬѧ������һ������</a>] --%>
        </center>
    </body>
</html>