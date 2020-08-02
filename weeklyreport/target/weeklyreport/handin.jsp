<%@ page language="java" contentType="text/html; charset=gb2312"
    pageEncoding="gb2312"%>
<%@ page import="java.util.Date,java.sql.*,java.text.*"%>
<%@ include file="function.jsp"%>

<html>

<%!
    String name = null;
    String title = new String();
%>

<%
    name = new String(request.getParameter("name").toString().getBytes("ISO-8859-1"), "gbk");
    //name = request.getParameter("name").toString();
    title = name + "�������ȵǼǱ�";
%>

<head>
<meta charset="gb2312">
<title><%=title%></title>
</head>
<body>

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
            //System.out.println("rs.get1");
            if (thisweek == rs.getInt("weekid")) {
                insertNewData = 0;
            }
        }// else {
            //throw new Exception("Rs contents nothing!");
        //}

        if (insertNewData == 1) {
            //����������
            sql = "INSERT INTO " + name + "(weekid, entryDate, entryTime, summary, ";
            sql += "finished0, finished1, finished2, finished3, finished4, ";
            sql += "thisTask0, thisTask1, thisTask2, thisTask3, thisTask4, ";
            sql += "thisDate0, thisDate1, thisDate2, thisDate3, thisDate4)  VALUES('";
            sql += Integer.toString(thisweek) + "', '";
            sql += getDate() + "', '" + getTime() + "', '";
            sql += new String(request.getParameter("summary").getBytes("ISO-8859-1"), "gbk") + "', '";
            sql += new String(request.getParameter("finished0").toString().getBytes("ISO-8859-1"), "gbk") + "', '" + new String(request.getParameter("finished1").toString().getBytes("ISO-8859-1"), "gbk") + "', '" + new String(request.getParameter("finished2").toString().getBytes("ISO-8859-1"), "gbk") + "', '" + new String(request.getParameter("finished3").toString().getBytes("ISO-8859-1"), "gbk") + "', '" + new String(request.getParameter("finished4").toString().getBytes("ISO-8859-1"), "gbk") + "', '";
            sql += new String(request.getParameter("thisTask0").toString().getBytes("ISO-8859-1"), "gbk") + "', '" + new String(request.getParameter("thisTask1").toString().getBytes("ISO-8859-1"), "gbk") + "', '" + new String(request.getParameter("thisTask2").toString().getBytes("ISO-8859-1"), "gbk") + "', '" + new String(request.getParameter("thisTask3").toString().getBytes("ISO-8859-1"), "gbk") + "', '" + new String(request.getParameter("thisTask4").toString().getBytes("ISO-8859-1"), "gbk") + "', '";
            sql += new String(request.getParameter("thisDate0").toString().getBytes("ISO-8859-1"), "gbk") + "', '" + new String(request.getParameter("thisDate1").toString().getBytes("ISO-8859-1"), "gbk") + "', '" + new String(request.getParameter("thisDate2").toString().getBytes("ISO-8859-1"), "gbk") + "', '" + new String(request.getParameter("thisDate3").toString().getBytes("ISO-8859-1"), "gbk") + "', '" + new String(request.getParameter("thisDate4").toString().getBytes("ISO-8859-1"), "gbk") + "')";
        } else {
            //��������
            sql = "UPDATE " + name + " SET ";
            sql += "finished0='" + new String(request.getParameter("finished0").toString().getBytes("ISO-8859-1"), "gbk") + "', ";
            sql += "finished1='" + new String(request.getParameter("finished1").toString().getBytes("ISO-8859-1"), "gbk") + "', ";
            sql += "finished2='" + new String(request.getParameter("finished2").toString().getBytes("ISO-8859-1"), "gbk") + "', ";
            sql += "finished3='" + new String(request.getParameter("finished3").toString().getBytes("ISO-8859-1"), "gbk") + "', ";
            sql += "finished4='" + new String(request.getParameter("finished4").toString().getBytes("ISO-8859-1"), "gbk") + "', ";
            sql += "thisTask0='" + new String(request.getParameter("thisTask0").toString().getBytes("ISO-8859-1"), "gbk") + "', ";
            sql += "thisTask1='" + new String(request.getParameter("thisTask1").toString().getBytes("ISO-8859-1"), "gbk") + "', ";
            sql += "thisTask2='" + new String(request.getParameter("thisTask2").toString().getBytes("ISO-8859-1"), "gbk") + "', ";
            sql += "thisTask3='" + new String(request.getParameter("thisTask3").toString().getBytes("ISO-8859-1"), "gbk") + "', ";
            sql += "thisTask4='" + new String(request.getParameter("thisTask4").toString().getBytes("ISO-8859-1"), "gbk") + "', ";
            sql += "thisDate0='" + new String(request.getParameter("thisDate0").toString().getBytes("ISO-8859-1"), "gbk") + "', ";
            sql += "thisDate1='" + new String(request.getParameter("thisDate1").toString().getBytes("ISO-8859-1"), "gbk") + "', ";
            sql += "thisDate2='" + new String(request.getParameter("thisDate2").toString().getBytes("ISO-8859-1"), "gbk") + "', ";
            sql += "thisDate3='" + new String(request.getParameter("thisDate3").toString().getBytes("ISO-8859-1"), "gbk") + "', ";
            sql += "thisDate4='" + new String(request.getParameter("thisDate4").toString().getBytes("ISO-8859-1"), "gbk") + "', ";
            sql += "entryDate='" + getDate() + "', ";
            sql += "entryTime='" + getTime() + "', ";
            sql += "summary='" + new String(request.getParameter("summary").toString().getBytes("ISO-8859-1"), "gbk") + "' ";
            //System.out.println("rs.get2");
            sql += "WHERE weekid=" + rs.getInt("weekid");
        }
        stmt.execute(sql);
        //System.out.println(sql);

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
        out.println("<th align=center>��¼����");
        out.println("<tr>");
        out.println("<td valign=top>" + PrintSession(session, "prevDate", "prevTask") + " &nbsp; </td>");
        //System.out.println("rs.get3");
        out.println("<td valign=top>" + PrintField(rs, "finished", 0) + " &nbsp;</td>");
        out.println("<td valign=top>" + PrintDateTask(rs, "thisDate", "thisTask") + " &nbsp; </td>");
        out.println("<td valign=top>" + rs.getString("summary").toString() + " &nbsp;</td>");
        out.println("<td valign=top>" + rs.getString("entryDate").toString() + "<br>" + rs.getString("entryTime").toString() + " &nbsp;</td>");
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
[<a target=_blank href="listEachPerson.jsp?id=<%=getStuId(name)%>"><strong style="color:green"><%=name%></strong>��¼֮ȫ������</a>]
<%-- [<a target=_blank href="listAllPersonLastRecord.jsp">ÿλͬѧ������һ������</a>] --%>
</center>

</body>
</html>