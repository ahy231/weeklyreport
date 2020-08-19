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

<%!
    String name = null;
    String prevTask[] = new String[5];
    String prevDate[] = new String[5];
    String finished[] = new String[5];
    String thisTask[] = new String[5];
    String thisDate[] = new String[5];
    String summary = null;
%>

<%
    name = session.getAttribute("name").toString();
    for (int i = 0; i < 5; i++) {
        prevTask[i] = session.getAttribute("prevTask" + i).toString();
        prevDate[i] = session.getAttribute("prevDate" + i).toString();
        finished[i] = session.getAttribute("finished" + i).toString();
        thisTask[i] = session.getAttribute("thisTask" + i).toString();
        thisDate[i] = session.getAttribute("thisDate" + i).toString();
    }
    summary = session.getAttribute("summary").toString();
%>

<html>
    <head>
        <meta charset="gb2312">
        <title>��¼<%=name%>�ı��ܹ�������</title>
        <link rel="stylesheet" type="text/css" href="type.css">
    </head>
    <body>
        <form method=post action="handin.jsp">
        <table style="margin: 20px auto 10px">
        <caption><Strong><%=name%></strong>�ı��ܹ����ǼǱ�</caption>
        <tr>
        <th colspan=2>����Ԥ���������
        <th rowspan=2>�����������
        <th colspan=2>����Ԥ���������
        <th rowspan=2>�ۺ�˵��
        <tr>
        <th>��������<th>Ԥ���������
        <th>��������<th>Ԥ���������
        <% 
            for (int i = 0; i < 5; i++) {
        %>
                <tr>
                <td><%=(prevTask[i]==null?"":prevTask[i])%>&nbsp;
                <td><%=(prevDate[i]==null?"":prevDate[i])%>&nbsp;
                <td><textarea name=<%="finished" + i%> cols=20 rows=3 wrap=virtual><%=(finished[i]==null?"":finished[i])%></textarea>
                <td><textarea name=<%="thisTask" + i%> cols=20 rows=3 wrap=virtual><%=(thisTask[i]==null?"":thisTask[i])%></textarea>
                <td><textarea name=<%="thisDate" + i%> cols=15 rows=3 wrap=virtual><%=(thisDate[i]==null?"":thisDate[i])%></textarea>
            <%
                if (i == 0) {
            %>
                    <td rowspan=5><textarea name=summary cols=20 rows=18 wrap=virtual><%=(summary==null?"":summary)%></textarea>
            <%
                }
            } 
        %>
        </table>
        <h3 class="center">
        <input type=submit value="�ͳ���">
        <input type=reset  value="�ָ�ԭֵ">
        </h3>
        <input type=hidden name="name" value="<%=name%>">
        </form>
        <ol style="text-align: left">
        <li>�������ÿ�������������ǰ��д��ϡ�������������ҹ��ϵͳ�Զ�������һ�ܣ����޷�����д���ܵĽ����ˡ�
        <li>�����ÿһ����Ҫ��д�������ǡ�����Ԥ����������һ��Ҫ������صġ�Ԥ�����ʱ�䡹��
        </ol>
        <hr>
        <div class="center">[<a href="listEachPerson.jsp?id=<%=getStuId(name)%>"><%=name%>�����е�¼����</a>][<a href=index.jsp>���ص�¼����</a>]</div>
    </body>
</html>