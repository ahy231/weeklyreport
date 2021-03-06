<%@ page language="java" import="java.util.*,java.sql.*" contentType="text/html; charset=gb2312"
    pageEncoding="gb2312"%>
<%@ include file="function.jsp"%>

<html>
    <head>
        <meta charset="gb2312">
        <title>MIR 实验室工作进度登录网页</title>

    </head>

    <%!
        int studentsNum = getMirStudentsNum();
        String[] students = getMirStudentsName();
    %>

    <body>
        <h3><img src="redball.gif">填写进度</h3>
        <form style="text-align:center;" name=form1 action="form.jsp" method=post target=_blank>
            <select name="name" onChange="this.form.submit()">
                <option>=== 请选您的名字 ===</option>
                <%
                    for(int i = 0; i < studentsNum; i++){
                        out.println("<option>"+students[i]+"</option>");
                    }
                %>
            </select>
        </form>
        <ol>
        <li>请务必在每星期五下午五点前填写完毕。过了星期六午夜，系统自动跳到下一周，就无法再填写本周的进度了。
        <li>请务必每一栏都要填写，尤其是「本周预定完成事项」，一定要填入相关的「预定完成时间」。
        </ol>
        <hr>

        <h3><img src="redball.gif">资料列表</h3>
        <ul>
        <li>每周填写之资料：
            <a target=_blank href="listEachWeek.jsp?weekDiff=0">本周</a>、
            <a target=_blank href="listEachWeek.jsp?weekDiff=-1">前一周</a>、
            <a target=_blank href="listEachWeek.jsp?weekDiff=-2">前两周</a>、
            <a target=_blank href="listEachWeek.jsp?weekDiff=-3">前三周</a>、
            <a target=_blank href="listEachWeek.jsp?weekDiff=-4">前四周</a>
        <li>每个人的历史资料：
        <%
            for (int i=0; i < studentsNum; i++){
                if (i==0){
                    out.print("<a target=_blank href=listEachPerson.jsp?name=" + students[i] + ">" + students[i] + "</a>");
                } else {
                    out.print("、<a target=_blank href=listEachPerson.jsp?name=" + students[i] + ">" + students[i] + "</a>");
                }
            }
        %>
        <li><a target=_blank href="listAllPersonLastRecord.jsp">每个人的最後一笔资料</a>
        </ul>
        <hr>

        <h3><img src="redball.gif">有关本系统</h3>
        <ul>
            <li>本系统特点：超级简单易用，适合忙碌的管理者
            <li>想要把整套系统移植到自己的实验室使用吗？没问题，请直接和本系统发展者<a href="http://www.cs.nthu.edu.tw/~jang">张智星</a>接洽。
        </ul>
        <hr>
        <p align=right><font size=-1>By <a href="http://www.cs.nthu.edu.tw/~jang">Roger Jang</a></font>
        <hr>
        <center>
        [<a target=_blank href="listEachWeek.jsp?weekDiff=0">本周登录之全部资料</a>]
        [<a target=_blank href="listAllPersonLastRecord.jsp">每位同学的最後一笔资料</a>]
        </center>
    </body>
</html>