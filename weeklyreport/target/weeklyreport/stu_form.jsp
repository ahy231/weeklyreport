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
        <title>登录<%=name%>的本周工作进度</title>
        <link rel="stylesheet" type="text/css" href="type.css">
    </head>
    <body>
        <form method=post action="handin.jsp">
        <table style="margin: 20px auto 10px">
        <caption><Strong><%=name%></strong>的本周工作登记表</caption>
        <tr>
        <th colspan=2>上周预定完成事项
        <th rowspan=2>本周完成事项
        <th colspan=2>下周预定完成事项
        <th rowspan=2>综合说明
        <tr>
        <th>工作描述<th>预定完成日期
        <th>工作描述<th>预定完成日期
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
        <input type=submit value="送出表单">
        <input type=reset  value="恢复原值">
        </h3>
        <input type=hidden name="name" value="<%=name%>">
        </form>
        <ol style="text-align: left">
        <li>请务必在每星期五下午五点前填写完毕。过了星期六午夜，系统自动跳到下一周，就无法再填写本周的进度了。
        <li>请务必每一栏都要填写，尤其是「本周预定完成事项」，一定要填入相关的「预定完成时间」。
        </ol>
        <hr>
        <div class="center">[<a href="listEachPerson.jsp?id=<%=getStuId(name)%>"><%=name%>的所有登录资料</a>][<a href=index.jsp>返回登录界面</a>]</div>
    </body>
</html>