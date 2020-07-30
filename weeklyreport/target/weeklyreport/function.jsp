<%@ page language="java" contentType="text/html; charset=gb2312"
    pageEncoding="gb2312"%>
<%@ page import="javax.servlet.http.HttpSession,java.io.*,java.util.Date,java.text.*"%>

<%!
    String getDate() {
        Date dNow = new Date();
        SimpleDateFormat fmd = new SimpleDateFormat("yyyy-MM-dd");
        return fmd.format(dNow);
    }
%>

<%!
    String getTime() {
        Date dNow = new Date();
        SimpleDateFormat fmt = new SimpleDateFormat("HH:mm:ss");
        return fmt.format(dNow);
    }
%>

<%!
    boolean checkStuPassword(String name, String password) {
        String JDBC_DRIVER = "com.mysql.cj.jdbc.Driver";
        String DB_URL = "jdbc:mysql://localhost:3306/students?useSSL=false&allowPublicKeyRetrieval=true&serverTimezone=UTC";

        String USER = "stu_login";
        String PASS = "123";

        Connection conn = null;
        PreparedStatement preState = null;

        boolean result = false;

        try {

            //注册JDBC驱动
            Class.forName(JDBC_DRIVER);

            //打开链接
            //System.out.println("连接数据库...");
            conn = DriverManager.getConnection(DB_URL, USER, PASS);

            //执行查询
            //System.out.println("实例化PreparedStatement对象...");
            String sql = "SELECT * FROM students WHERE name=? AND password=?";
            preState = conn.prepareStatement(sql);
            preState.setString(1, name);
            preState.setString(2, password);
            ResultSet rs = preState.executeQuery();

            if (rs.next()) { //right password
                result = true;
            } else { //bad password
                result = false;
            }

            rs.close();
            preState.close();
            conn.close();
        } catch (SQLException se) {
            se.printStackTrace();
        } catch (Exception e) {
            e.printStackTrace();
        } finally {
            try {
                if (preState != null) preState.close();
            } catch (SQLException se2) {
            }
            try {
                if (conn != null) conn.close();
            } catch (SQLException se) {
                se.printStackTrace();
            }
        }
        //System.out.println("Goodbye!");
        return result;
    }
%>

<%!
    boolean checkTchPassword(String name, String password) {
        String JDBC_DRIVER = "com.mysql.cj.jdbc.Driver";
        String DB_URL = "jdbc:mysql://localhost:3306/students?useSSL=false&allowPublicKeyRetrieval=true&serverTimezone=UTC";

        String USER = "stu_login";
        String PASS = "123";

        Connection conn = null;
        PreparedStatement preState = null;

        boolean result = false;

        try {

            //注册JDBC驱动
            Class.forName(JDBC_DRIVER);

            //打开链接
            //System.out.println("连接数据库...");
            conn = DriverManager.getConnection(DB_URL, USER, PASS);

            //执行查询
            //System.out.println("实例化PreparedStatement对象...");
            String sql = "SELECT * FROM teachers WHERE name=? AND password=?";
            preState = conn.prepareStatement(sql);
            preState.setString(1, name);
            preState.setString(2, password);
            ResultSet rs = preState.executeQuery();

            if (rs.next()) { //right password
                result = true;
            } else { //bad password
                result = false;
            }

            rs.close();
            preState.close();
            conn.close();
        } catch (SQLException se) {
            se.printStackTrace();
        } catch (Exception e) {
            e.printStackTrace();
        } finally {
            try {
                if (preState != null) preState.close();
            } catch (SQLException se2) {
            }
            try {
                if (conn != null) conn.close();
            } catch (SQLException se) {
                se.printStackTrace();
            }
        }
        //System.out.println("Goodbye!");
        return result;
    }
%>

<%-- <%!
    boolean checkMirPassword(String name, String password) {
        String JDBC_DRIVER = "com.mysql.cj.jdbc.Driver";
        String DB_URL = "jdbc:mysql://localhost:3306/students?useSSL=false&allowPublicKeyRetrieval=true&serverTimezone=UTC";

        String USER = "stu_login";
        String PASS = "123";

        Connection conn = null;
        PreparedStatement preState = null;

        boolean result = false;

        try {

            //注册JDBC驱动
            Class.forName(JDBC_DRIVER);

            //打开链接
            //System.out.println("连接数据库...");
            conn = DriverManager.getConnection(DB_URL, USER, PASS);

            //执行查询
            //System.out.println("实例化PreparedStatement对象...");
            String sql = "SELECT * FROM students WHERE name=? AND password=?";
            preState = conn.prepareStatement(sql);
            preState.setString(1, name);
            preState.setString(2, password);
            ResultSet rs = preState.executeQuery();

            if (rs.next()) { //right password
                result = true;
            } else { //bad password
                result = false;
            }

            rs.close();
            preState.close();
            conn.close();
        } catch (SQLException se) {
            se.printStackTrace();
        } catch (Exception e) {
            e.printStackTrace();
        } finally {
            try {
                if (preState != null) preState.close();
            } catch (SQLException se2) {
            }
            try {
                if (conn != null) conn.close();
            } catch (SQLException se) {
                se.printStackTrace();
            }
        }
        //System.out.println("Goodbye!");
        return result;
    }
%> --%>

<%!
    int getMirStudentsNum() {

        int studentsNum = 0;

        String JDBC_DRIVER = "com.mysql.cj.jdbc.Driver";
        String DB_URL = "jdbc:mysql://localhost:3306/students?useSSL=false&allowPublicKeyRetrieval=true&serverTimezone=UTC";

        String USER = "stu_login";
        String PASS = "123";

        Connection conn = null;
        Statement stmt = null;

        try {

            Class.forName(JDBC_DRIVER);

            conn = DriverManager.getConnection(DB_URL, USER, PASS);

            String sql = "SELECT COUNT(*) AS student_num FROM students";
            stmt = conn.createStatement();
            ResultSet rs = stmt.executeQuery(sql);

            if (rs.next()) {
                studentsNum = rs.getInt("student_num");
            }

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
        return studentsNum;
    }
%>

<%!
    String[] getMirStudentsName() {
        String[] students = new String[128];

        int studentsNum = getMirStudentsNum();

        String JDBC_DRIVER = "com.mysql.cj.jdbc.Driver";
        String DB_URL = "jdbc:mysql://localhost:3306/students?useSSL=false&allowPublicKeyRetrieval=true&serverTimezone=UTC";

        String USER = "stu_login";
        String PASS = "123";

        Connection conn = null;
        Statement stmt = null;

        try {

            Class.forName(JDBC_DRIVER);

            conn = DriverManager.getConnection(DB_URL, USER, PASS);

            String sql = "SELECT * FROM students";
            stmt = conn.createStatement();
            ResultSet rs = stmt.executeQuery(sql);

            if (rs.next()) {
                for (int i = 0; i < studentsNum; i++) {
                    students[i] = new String(rs.getString("name").getBytes("ISO-8859-1"), "gbk");
                    rs.next();
                }
            }

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
        return students;
    }
%>

<%!
    String PrintField(ResultSet rs, String field, int editable) {
        //PrintWriter out = response.getWriter();
        String result = new String();
        try {
            result += "<ol>\n";
            for (int i = 0; i < 5; i++) {
                if (editable == 0) {
                    if (rs.getString(field + Integer.toString(i)) != null) {
                        result += "<li>" + new String(rs.getString(field + Integer.toString(i)).getBytes("ISO-8859-1"), "gbk") + "\n";
                    }
                } else {
                    result += "<li><textarea name=\n";
                    result += field + Integer.toString(i) + "\n";
                    result += " cols=30 rows=2 wrap=virtual>\n";
                    result += new String(rs.getString(field + Integer.toString(i)).getBytes("ISO-8859-1"), "gbk") + "\n";
                    result += "</textarea></li>\n";
                }
            }
            result += "</ol>";
        } catch (SQLException se) {
            se.printStackTrace();
        } catch (Exception e) {
            e.printStackTrace();
        }
        return result;
    }
%>

<%!
    String PrintDateTask(ResultSet rs, String dateField, String taskField) {
        //PrintWriter out = response.getWriter();
        String result = new String();
        try {
            result += "<ol>\n";
            for (int i = 0; i < 5; i++) {
                if (rs.getString(taskField + Integer.toString(i)) != null) {
                    result += "<li>【<span style=\"color: red;\">" + new String(rs.getString(dateField + Integer.toString(i)).getBytes("ISO-8859-1"), "gbk") + "</span>】" + new String(rs.getString(taskField + Integer.toString(i)).getBytes("ISO-8859-1"), "gbk") + "\n";
                }
            }
            result += "</ol>\n";
        } catch (SQLException se) {
            se.printStackTrace();
        } catch (Exception e) {
            e.printStackTrace();
        }
        return result;
    }
%>

<%!
    String PrintSession(HttpSession session, String dateField, String taskField) {
        //PrintWriter out = response.getWriter();
        String result = new String();
        try {
            result += "<ol>\n";
            for (int i = 0; i < 5; i++) {
                if (session.getAttribute(taskField + Integer.toString(i)) != null) {
                    result += "<li>【<span style=\"color: red;\">" + session.getAttribute(dateField + Integer.toString(i)) + "</span>】" + session.getAttribute(taskField + Integer.toString(i)) + "\n";
                }
            }
        } catch (Exception e) {
            e.printStackTrace();
        }
        return result;
    }
%>