<%@ page language="java" contentType="text/html; charset=gb2312"
    pageEncoding="gb2312"%>
<%@ page import="java.util.Date,java.sql.*,java.text.*"%>
<%@ include file="function.jsp"%>

<html>

<%!
    String name = new String();
    String password = new String();
    String title = new String();
%>

<%
    name = request.getParameter("name");
    password = request.getParameter("password");
    title = name + "�������ȵǼǱ�";
%>

<head>
<meta charset="gb2312">
<title><%=title%></title>
</head>
<body>

<%
    if (!checkMirPassword(name, password)) {
        out.println("<p align=center>�װ��� <font color=green>" + name + "</font>��������֤���ϴ������<a href=\"javascript:history.go(-1)\">ǰҳ</a>�޸ġ�");
    }
%>

<%!
    int insertNewData=1;
    //int recordId=-1;

    String JDBC_DRIVER = "com.mysql.cj.jdbc.Driver";
    String DB_URL = "jdbc:mysql://localhost:3306/students?useSSL=false&allowPublicKeyRetrieval=true&serverTimezone=UTC";

    String USER = "stu_login";
    String PASS = "123";

    Connection conn = null;
    Statement stmt = null;
    ResultSet rs = null;
%>

<%
    try {
        Class.forName(JDBC_DRIVER);

        conn = DriverManager.getConnection(DB_URL, USER, PASS);

        String sql = "SELECT * FROM " + name + " ORDER BY weekid DESC";
        stmt = conn.createStatement();
        rs = stmt.executeQuery(sql);

        Date dNow = new Date();
        SimpleDateFormat ftw = new SimpleDateFormat("w");
        SimpleDateFormat fty = new SimpleDateFormat("yyyy");
        int thisweek = Integer.valueOf(ftw.format(dNow)) + 100 * Integer.valueOf(fty.format(dNow));

        if (rs.next()) {
            if (thisweek == rs.getInt("weekid")) {
                insertNewData = 0;
            }
        } else {
            throw new Exception("Rs contents nothing!");
        }

        if (insertNewData == 1) {
            //����������
            sql = "INSERT INTO " + name + "(weekid, summary, ";
            sql += "finished0, finished1, finished2, finished3, finished4, ";
            sql += "thisTask0, thisTask1, thisTask2, thisTask3, thisTask4, ";
            sql += "thisDate0, thisDate1, thisDate2, thisDate3, thisDate4)  VALUES('";
            sql += Integer.toString(thisweek) + "', '";
            sql += request.getParameter("summary") + "', '";
            sql += request.getParameter("finished0") + "', '" + request.getParameter("finished1") + "', '" + request.getParameter("finished2") + "', '" + request.getParameter("finished3") + "', '" + request.getParameter("finished4") + "', '";
            sql += request.getParameter("thisTask0") + "', '" + request.getParameter("thisTask1") + "', '" + request.getParameter("thisTask2") + "', '" + request.getParameter("thisTask3") + "', '" + request.getParameter("thisTask4") + "', '";
            sql += request.getParameter("thisDate0") + "', '" + request.getParameter("thisDate1") + "', '" + request.getParameter("thisDate2") + "', '" + request.getParameter("thisDate3") + "', '" + request.getParameter("thisDate4") + "'";
        } else {
            //��������
            sql = "UPDATE " + name + " SET ";
            sql += "finished0='" + request.getParameter("finished0") + "', ";
            sql += "finished1='" + request.getParameter("finished1") + "', ";
            sql += "finished2='" + request.getParameter("finished2") + "', ";
            sql += "finished3='" + request.getParameter("finished3") + "', ";
            sql += "finished4='" + request.getParameter("finished4") + "', ";
            sql += "thisTask0='" + request.getParameter("thisTask0") + "', ";
            sql += "thisTask1='" + request.getParameter("thisTask1") + "', ";
            sql += "thisTask2='" + request.getParameter("thisTask2") + "', ";
            sql += "thisTask3='" + request.getParameter("thisTask3") + "', ";
            sql += "thisTask4='" + request.getParameter("thisTask4") + "', ";
            sql += "thisDate0='" + request.getParameter("thisDate0") + "', ";
            sql += "thisDate1='" + request.getParameter("thisDate1") + "', ";
            sql += "thisDate2='" + request.getParameter("thisDate2") + "', ";
            sql += "thisDate3='" + request.getParameter("thisDate3") + "', ";
            sql += "thisDate4='" + request.getParameter("thisDate4") + "', ";
            sql += "summary='" + request.getParameter("summary") + "' ";
            sql += "WHERE weekid=" + rs.getInt("weekid");
        }
        stmt.execute(sql);

        //Retrieve the record just entered
        sql = "SELECT * FROM " + name + " ORDER BY weekid DESC";
        rs = stmt.executeQuery(sql);

        if (!rs.next()) {
            throw new Exception("Rs contents nothing!");
        }

        out.println("<p align=center>");
        out.println("�װ��� <font color=green>"+ name + "</font>����������������¡����д��󣬿ɻ�<a href=\"javascript:history.go(-1)\">ǰҳ</a>�޸ġ�");

        out.println("<p>");
        out.println("<table align=center border=1>");
        out.println("<tr>");
        out.println("<th align=center>����Ԥ��������<br>��<font color=red>Ԥ���������</font>����������");
        out.println("<th align=center>�����������");
        out.println("<th align=center>����Ԥ��������<br>��<font color=red>Ԥ���������</font>����������");
        out.println("<th align=center>�ۺ�˵��");
        out.println("<tr>");
        out.println("<td valign=top>" + PrintSession(session, "prevDate", "prevTask") + " &nbsp; </td>");
        out.println("<td valign=top>" + PrintField(rs, "finished", 0) + " &nbsp;</td>");
        out.println("<td valign=top>" + PrintDateTask(rs, "thisDate", "thisTask") + " &nbsp; </td>");
        out.println("<td valign=top>" + rs.getString("summary") + " &nbsp;</td>");
        out.println("</table>");

        rs.close();
        stmt.close();
        conn.close();

    } catch (SQLException se) {
        se.printStackTrace();
    } catch (Exception e) {
        e.printStackTrace();
    } finally {
        try {
            if (stmt != null) stmt.close();
        } catch (SQLException se2) {
        }
        try {
            if (conn != null) conn.close();
        } catch (SQLException se) {
            se.printStackTrace();
        }
    }
%>

<hr>
<center>
[<a target=_blank href="listEachWeek.jsp?weekDiff=0">���ܵ�¼֮ȫ������</a>]
[<a target=_blank href="listAllPersonLastRecord.jsp">ÿλͬѧ������һ������</a>]
</center>

</body>
</html>