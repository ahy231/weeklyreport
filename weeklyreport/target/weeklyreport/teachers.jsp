<%@ page language="java" import="java.util.*,java.sql.*" contentType="text/html; charset=gb2312"
    pageEncoding="gb2312"%>
<%@ include file="function.jsp"%>

<html>
    <head>
        <meta charset="gb2312">
        <title>MIR ʵ���ҹ������ȵ�¼��ҳ</title>
        <link rel="stylesheet" type="text/css" href="type.css">
        <style>
            body {text-align: left;}
        </style>
    </head>

    <%!
        int studentsNum = getMirStudentsNum();
        String[] students = getMirStudentsName();
    %>

    <body>
        <h3><img src="redball.gif">����ѧ������</h3>
        <form style="text-align:center;" name=form1 action="tch_form.jsp" method=POST target=_blank>
            <select name="name" onChange="this.form.submit()">
                <option>=== ��ѡ��ѧ�������� ===</option>
                <%
                    for(int i = 0; i < studentsNum; i++){
                        out.println("<option>"+students[i]+"</option>");
                    }
                %>
            </select>
        </form>
        <%-- <ol>
        <li>�������ÿ�������������ǰ��д��ϡ�������������ҹ��ϵͳ�Զ�������һ�ܣ����޷�����д���ܵĽ����ˡ�
        <li>�����ÿһ����Ҫ��д�������ǡ�����Ԥ����������һ��Ҫ������صġ�Ԥ�����ʱ�䡹��
        </ol> --%>
        <hr>

        <h3><img src="redball.gif">�����б�</h3>
        <ul>
        <li>ÿ����д֮���ϣ�
            <a target=_blank href="listEachWeek.jsp?weekDiff=0">����</a>��
            <a target=_blank href="listEachWeek.jsp?weekDiff=-1">ǰһ��</a>��
            <a target=_blank href="listEachWeek.jsp?weekDiff=-2">ǰ����</a>��
            <a target=_blank href="listEachWeek.jsp?weekDiff=-3">ǰ����</a>��
            <a target=_blank href="listEachWeek.jsp?weekDiff=-4">ǰ����</a>
        <li>ÿ���˵���ʷ���ϣ�
        <%
            for (int i=0; i < studentsNum; i++){
                if (i==0){
                    out.print("<a target=_blank href=listEachPerson.jsp?id=" + getStuId(students[i]) + ">" + students[i] + "</a>");
                } else {
                    out.print("��<a target=_blank href=listEachPerson.jsp?id=" + getStuId(students[i]) + ">" + students[i] + "</a>");
                }
            }
        %>
        <li><a target=_blank href="listAllPersonLastRecord.jsp">ÿ���˵�����һ������</a>
        </ul>
        <hr>

        <h3><img src="redball.gif">�йر�ϵͳ</h3>
        <ul>
            <li>��ϵͳ�ص㣺���������ã��ʺ�æµ�Ĺ�����
            <li>��Ҫ������ϵͳ��ֲ���Լ���ʵ����ʹ����û���⣬��ֱ�Ӻͱ�ϵͳ��չ��<a href="http://www.cs.nthu.edu.tw/~jang">������</a>��Ǣ��
        </ul>
        <p style="text-align: right">By <a href="http://www.cs.nthu.edu.tw/~jang">Roger Jang</a>
        <hr>
        <div class=center>
        [<a target=_blank href="listEachWeek.jsp?weekDiff=0">���ܵ�¼֮ȫ������</a>]
        [<a target=_blank href="listAllPersonLastRecord.jsp">ÿλͬѧ������һ������</a>]
        </div>
    </body>
</html>