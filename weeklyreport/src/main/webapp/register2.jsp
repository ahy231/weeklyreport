<%@ page language="java" contentType="text/html; charset=gb2312"
    pageEncoding="gb2312"%>
<%@ include file="function.jsp"%>

<%!
    String name = null;
    String password1 = new String();
    String password2 = new String();
    String identity = new String();
    String inv_code = new String();
%>

<%
    name = new String(request.getParameter("name").toString().getBytes("ISO-8859-1"), "gbk");
    password1 = request.getParameter("password1").toString();
    password2 = request.getParameter("password2").toString();
    identity = request.getParameter("identity").toString();

    if (identity.equals("teachers")) {
        inv_code = request.getParameter("invest_code").toString();
    }
%>

<html>
    <head>
        <meta charset="gb2312">
        <title>ע����</title>
        <style>
            h2 {text-align: center; color: red;}
            p {text-align: center;}
        </style>
    </head>
    <body>

        <%
            try {
                if (name.equals(""))
                {
                    out.println("<h2>ע��ʧ��</h2>");
                    out.println("<p>�Բ����û�������Ϊ�գ��˻�<a href=\"javascript:history.go(-1)\">ǰһҳ</a>����ע�ᡣ</p>");
                } else {
                    if (identity.equals("students")) {
                        if (ifExistsStu(name)) {
                            out.println("<h2>ע��ʧ��</h2>");
                            out.println("<p>�Բ��𣬸��û����Ѵ��ڣ����˻�<a href=\"javascript:history.go(-1)\">ǰһҳ</a>����ע�ᡣ</p>");
                        } else {
                            if (!password1.equals(password2)) {
                                out.println("<h2>ע��ʧ��</h2>");
                                out.println("<p>������������벻ͬ�����˻�<a href=\"javascript:history.go(-1)\">ǰһҳ</a>����ע�ᡣ</p>");
                            } else {
                                if (stu_register(name, password1)) {
                                    out.println("<h2>ע��ɹ�</h2>");
                                    out.println("<p>��ϲ��ע��ɹ�������ǰ��<a href=\"index.jsp\">��½ҳ��</a>��¼�˺š�</p>");
                                } else {
                                    out.println("<h2>ע��ʧ��</h2>");
                                    out.println("<p>�Բ��𣬷��������˵�С������Ժ����ԡ�</p>");
                                    throw new Exception("Register failed!");
                                }
                            }
                        }
                    } else {
                        if (ifExistsTch(name)) {
                            out.println("<h2>ע��ʧ��</h2>");
                            out.println("<p>�Բ��𣬸��û����Ѵ��ڣ����˻�<a href=\"javascript:history.go(-1)\">ǰһҳ</a>����ע�ᡣ</p>");
                        } else {
                            if (!password1.equals(password2)) {
                                out.println("<h2>ע��ʧ��</h2>");
                                out.println("<p>������������벻ͬ�����˻�<a href=\"javascript:history.go(-1)\">ǰһҳ</a>����ע�ᡣ</p>");
                            } else {
                                if (!checkInvestCode(inv_code)) {
                                    out.println("<h2>ע��ʧ��</h2>");
                                    out.println("<p>�Բ�����������������������˻�<a href=\"javascript:history.go(-1)\">ǰһҳ</a>����ע�ᡣ</p>");
                                } else {
                                    if (tch_register(name, password2)) {
                                        out.println("<h2>ע��ɹ�</h2>");
                                        out.println("<p>��ϲ��ע��ɹ�������ǰ��<a href=\"index.jsp\">��½ҳ��</a>��¼�˺š�</p>");
                                    } else {
                                        out.println("<h2>ע��ʧ��</h2>");
                                        out.println("<p>�Բ��𣬷��������˵�С������Ժ����ԡ�</p>");
                                        throw new Exception("Register failed!");
                                    }
                                }
                            }
                        }
                    }
                }
            } catch (Exception e) {
                e.printStackTrace();
            }
        %>

    </body>
</html>