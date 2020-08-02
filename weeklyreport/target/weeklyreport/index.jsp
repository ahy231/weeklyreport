<!--
 * @Copyright: free for non-commercial usage
 * @Author: ahy231
 * @Date: 2020-07-29 13:47:59
 * @LastEditor: ahy231
 * @LastEditTime: 2020-07-30 10:39:13
--> 
<%@ page language="java" contentType="text/html; charset=gb2312"
    pageEncoding="gb2312"%>
    
<head>
    <meta charset="gb2312">
    <title>MIR 实验室工作进度登录网页</title>
    <style type="text/css">
        body {background-color:aqua;}
        /* p {color:crimson;} */
        form {background-color:blue;}
        h2 {color:red}
        a {color:red}
    </style>
</head>
<body>
    <h2 align="center">MIR 实验室工作进度登录页面</h2>
    <form name="login" action="login.jsp" method=POST align="center">
        <table border=0 align=center>
            <tr>
                <td>name: </td>
                <td><input type="text" name="name"></td>
            </tr>
            <tr>
                <td>password: </td>
                <td><input type="password" name="password"></td>
            </tr>
        </table>
        <center>
                <input type="radio" name="identity" value="students" checked="checked">学生登录
                <input type="radio" name="identity" value="teachers">教师登录<br/>
                <input type="submit" value="登录">
                <input type="reset" value="重置">
        </center>
        <div style="text-align: right;">
            <a href="register.jsp">账号注册</a>
        </div>
    </form>
</body>