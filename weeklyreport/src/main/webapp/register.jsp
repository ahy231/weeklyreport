<%@ page language="java" contentType="text/html; charset=gb2312"
    pageEncoding="gb2312" %>

<html>
    <head>
        <meta charset="gb2312">
        <title>�˺�ע��</title>
        <style type="text/css">
            h2 {text-align: center;}
        </style>
        <script>
            function invest_code() {
                document.getElementById("msg").innerHTML="�������ʦ�����룺";
                document.getElementById("input").innerHTML="<input type=\"text\" name=\"invest_code\">"
            }
        </script>
    </head>
    <body>
        <h2>�˺�ע��</h2>
        <form name="user_info" action="register2.jsp" method=POST>
            <table name="table1" border=1 align=center>
                <tr>
                    <td>�û�����</td>
                    <td><input type="text" name="name"></td>
                </tr>
                <tr>
                    <td>���룺</td>
                    <td><input type="password" name="password1"></td>
                </tr>
                <tr>
                    <td>�ٴ��������룺</td>
                    <td><input type="password" name="password2"></td>
                </tr>
                <tr>
                    <td><input type="radio" name="identity" value="students" checked="checked">ѧ��ע��</td>
                    <td><input type="radio" name="identity" value="teachers" onclick="">��ʦע��</td>
                </tr>
                <tr>
                    <td><p id="msg"></p></td>
                    <td><p id="input"></p></td>
                </tr>
            </table>
        </form>
    </body>
</html>
