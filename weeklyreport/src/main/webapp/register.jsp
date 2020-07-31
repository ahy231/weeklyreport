<%@ page language="java" contentType="text/html; charset=gb2312"
    pageEncoding="gb2312" %>

<html>
    <head>
        <meta charset="gb2312">
        <title>账号注册</title>
        <style type="text/css">
            h2 {text-align: center;}
        </style>
        <script>
            function invest_code() {
                document.getElementById("msg").innerHTML="请输入教师邀请码：";
                document.getElementById("input").innerHTML="<input type=\"text\" name=\"invest_code\">"
            }
        </script>
    </head>
    <body>
        <h2>账号注册</h2>
        <form name="user_info" action="register2.jsp" method=POST>
            <table name="table1" border=1 align=center>
                <tr>
                    <td>用户名：</td>
                    <td><input type="text" name="name"></td>
                </tr>
                <tr>
                    <td>密码：</td>
                    <td><input type="password" name="password1"></td>
                </tr>
                <tr>
                    <td>再次输入密码：</td>
                    <td><input type="password" name="password2"></td>
                </tr>
                <tr>
                    <td><input type="radio" name="identity" value="students" checked="checked">学生注册</td>
                    <td><input type="radio" name="identity" value="teachers" onclick="">教师注册</td>
                </tr>
                <tr>
                    <td><p id="msg"></p></td>
                    <td><p id="input"></p></td>
                </tr>
            </table>
        </form>
    </body>
</html>
