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
                // document.write("invest_code is running����");
                var tbl = document.getElementsByName("table1")[0];
                var node = tbl.insertRow(4);
                var cell1 = node.insertCell(0);
                cell1.innerHTML="�������ʦ�����룺";
                var cell2 = node.insertCell(1);
                cell2.innerHTML="<input type=\"text\" name=\"invest_code\">";
                // document.write("invest_code stoped.");
            }
            function clear_code() {
                // document.write("clear is running����");
                var tbl = document.getElementsByName("table1")[0];
                tbl.deleteRow(4);
                // document.write("clear stoped.");
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
                    <td colspan=2>
                        <input type="radio" name="identity" value="students" onclick="clear_code()" checked>ѧ��ע��
                        <input type="radio" name="identity" value="teachers" onclick="invest_code()">��ʦע��
                    </td>
                </tr>
            </table>
            <center>
                <input type="submit" value="�ύ">
                <input type="reset" value="����" onclick="clear_code()">
            </center>
        </form>
    </body>
</html>
