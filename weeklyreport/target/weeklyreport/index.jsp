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
    <title><link rel="shortcut icon" href="redball.gif">MIR ʵ���ҹ������ȵ�¼��ҳ</title>
    <style type="text/css">
        body {background-color:aqua;}
        /* p {color:crimson;} */
        form {background-color:blue;}
        h2 {color:red}
    </style>
</head>
<body>
    <h2 align="center">MIR ʵ���ҹ������ȵ�¼ҳ��</h2>
    <form name="login" action="login.jsp" method=POST align="center">
        <div align="center">
            name: <input type="text" name="name"><br/>
            password: <input type="password" name="password"><br/>
            <input type="radio" name="identity" value="students" checked="checked">ѧ����¼<br/>
            <input type="radio" name="identity" value="teachers">��ʦ��¼<br/>
            <input type="submit" value="��¼">
            <input type="reset" value="����">
        </div>
    </form>
</body>