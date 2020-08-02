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
                // document.write("invest_code is running……");
                var tbl = document.getElementsByName("table1")[0];
                var node = tbl.insertRow(4);
                var cell1 = node.insertCell(0);
                cell1.innerHTML="请输入教师邀请码：";
                var cell2 = node.insertCell(1);
                cell2.innerHTML="<input type=\"text\" name=\"invest_code\">";
                // document.write("invest_code stoped.");
            }
            function clear_code() {
                // document.write("clear is running……");
                var tbl = document.getElementsByName("table1")[0];
                tbl.deleteRow(4);
                // document.write("clear stoped.");
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
                    <td colspan=2>
                        <input type="radio" name="identity" value="students" onclick="clear_code()" checked>学生注册
                        <input type="radio" name="identity" value="teachers" onclick="invest_code()">教师注册
                    </td>
                </tr>
            </table>
            <center>
                <input type="submit" value="提交">
                <input type="reset" value="重置" onclick="clear_code()">
            </center>
        </form>
    </body>
</html>
