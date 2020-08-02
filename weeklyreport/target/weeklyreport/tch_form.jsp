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
<%
    name = new String(request.getParameter("name").toString().getBytes("ISO-8859-1"), "gbk");
%>

<html>
    <head>
        <meta charset="gb2312">
        <title>��¼<%=name%>�ı��ܹ�������</title>
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
        
        <%
            String forbiddenName = new String("=== ��ѡ��ѧ�������� ===");
            if (name.equals(forbiddenName)) {
                name = "stu_default";
                response.setStatus(response.SC_MOVED_TEMPORARILY);
                response.setHeader("Location", "pleaseChooseAName.jsp");
            }
        %>

        <center>[<a href="listEachPerson.jsp?id=<%=getStuId(name)%>"><%=name%>�����е�¼����</a>][<a href=teachers.jsp>������ѡ��</a>]</center>
        <%-- <ol>
        <li>�������ÿ�������������ǰ��д��ϡ�������������ҹ��ϵͳ�Զ�������һ�ܣ����޷�����д���ܵĽ����ˡ�
        <li>�����ÿһ����Ҫ��д�������ǡ�����Ԥ����������һ��Ҫ������صġ�Ԥ�����ʱ�䡹��
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
        <%-- <form method=post action="handin.jsp"> --%>
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
                out.print("<td bgcolor=" + color[j] + ">" + (prevTask[i]==null?"":prevTask[i]) + "&nbsp;");
                //�����������ʱ��
                out.print("<td bgcolor=" + color[j] + ">" + (prevDate[i]==null?"":prevDate[i]) + "&nbsp;");
                //�����������
                out.print("<td bgcolor=" + color[j] + ">" + (finished[i]==null?"":finished[i]) + "&nbsp;");
                //����Ԥ�����ʱ��
                out.print("<td bgcolor=" + color[j] + ">" + (thisTask[i]==null?"":thisTask[i]) + "&nbsp;");
                //�����������ʱ��
                out.print("<td bgcolor=" + color[j] + ">" + (thisDate[i]==null?"":thisDate[i]) + "&nbsp;");
                if (i == 0) {
                    //���������ܽ�
                    out.print("<td rowspan=5 bgcolor=" + color[j] + ">" + ((summary==null)?"":summary) + "&nbsp;");
                }
            } 
            j++;
            if (j == color.length) {
                j = 0;
            }
        %>
        <%-- <%
            for (int i = 0; i < 5; i++) {
                session.setAttribute("prevTask" + Integer.toString(i), (prevTask[i]!=null)?(prevTask[i]:"");
                session.setAttribute("prevDate" + Integer.toString(i), (prevDate[i]!=null)?(prevDate[i]:"");
            }
        %> --%>
        </table>
        <%-- <h3 align=center>
        <input type=submit value="�ͳ���">
        <input type=reset  value="�ָ�ԭֵ">
        </h3>
        <input type=hidden name="name" value="<%=name%>"> --%>
        <%-- </form> --%>
        <hr>
        <center>
        [<a target=_blank href="listEachWeek.jsp?weekDiff=0">���ܵ�¼֮ȫ������</a>]
        [<a target=_blank href="listAllPersonLastRecord.jsp">ÿλͬѧ������һ������</a>]
        </center>
    </body>
</html>