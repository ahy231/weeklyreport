package com.nhzhong.servlet;

import java.io.*;
import javax.servlet.*;
import javax.servlet.http.*;
import java.sql.*;
import java.text.SimpleDateFormat;

/**
 * @author ahy231
 * @Date created in 10:41 2020/8/19
 * @since 1.4
 */
public class Stu_info extends HttpServlet {

    String JDBC_DRIVER = "com.mysql.cj.jdbc.Driver";
    String DB_URL = "jdbc:mysql://localhost:3306/students?useSSL=false&allowPublicKeyRetrieval=true&serverTimezone=UTC";

    String USER = "stu_login";
    String PASS = "123";

    String name = null;
    String[] prevTask = new String[5];
    String[] prevDate = new String[5];
    String[] thisTask = new String[5];
    String[] thisDate = new String[5];
    String[] finished = new String[5];
    String summary = null;

    Connection conn = null;
    Statement stmt = null;

    public void init() throws ServletException {
        //TODO
    }

    public void doGet(HttpServletRequest request, HttpServletResponse response) throws ServletException, IOException {
        response.setContentType("text/html");

        HttpSession session = request.getSession();
        name = (String) session.getAttribute("name");

        try {
            //注册JDBC驱动
            Class.forName(JDBC_DRIVER);

            //打开链接
            conn = DriverManager.getConnection(DB_URL, USER, PASS);

            //执行查询
            String sql = "SELECT * FROM " + name + " ORDER BY weekid DESC";
            stmt = conn.createStatement();
            ResultSet rs = stmt.executeQuery(sql);

            if (rs.next()) {
                java.util.Date dNow = new java.util.Date();
                SimpleDateFormat ftw = new SimpleDateFormat("w");
                SimpleDateFormat fty = new SimpleDateFormat("yyyy");
                int thisWeek = Integer.parseInt(ftw.format(dNow)) + 100 * Integer.parseInt(fty.format(dNow)); //当前年份加周数
                if (thisWeek == rs.getInt("weekid")) { //若和目前时间在同一周，则显示旧资料
                    for (int i = 0; i < 5; i++) {
                        finished[i] = rs.getString("finished" + Integer.toString(i));
                        thisTask[i] = rs.getString("thisTask" + Integer.toString(i));
                        thisDate[i] = rs.getString("thisDate" + Integer.toString(i));
                        summary = rs.getString("summary");
                    }
                    if (rs.next()) { //找到第二笔资料，应该是上星期的资料
                        for (int i = 0; i < 5; i++) {
                            prevTask[i] = rs.getString("thisTask" + Integer.toString(i));
                            prevDate[i] = rs.getString("thisDate" + Integer.toString(i));
                        }
                    }
                } else { //若和目前时间不在同一个星期...
                    for (int i = 0; i < 5; i++) {
                        prevTask[i] = rs.getString("thisTask" + Integer.toString(i));
                        prevDate[i] = rs.getString("thisDate" + Integer.toString(i));
                    }
                }
            }
            rs.close();
            stmt.close();
            conn.close();
        } catch (SQLException se) {
            //处理JDBC错误
            se.printStackTrace();
        } catch (Exception e) {
            //处理Class.forName错误
            e.printStackTrace();
        } finally {
            //关闭资源
            try {
                if (stmt != null) stmt.close();
            } catch (SQLException ignored) {
            }
            try {
                if (conn!=null) conn.close();
            } catch (SQLException se) {
                se.printStackTrace();
            }
        }

        for (int i = 0; i < 5; i++) {
            session.setAttribute("prevTask" + i, (prevTask[i]!=null)?prevTask[i]:"");
            session.setAttribute("prevDate" + i, (prevDate[i]!=null)?prevDate[i]:"");
            session.setAttribute("finished" + i, (finished[i]!=null)?finished[i]:"");
            session.setAttribute("thisTask" + i, (thisTask[i]!=null)?thisTask[i]:"");
            session.setAttribute("thisDate" + i, (thisDate[i]!=null)?thisDate[i]:"");
        }
        session.setAttribute("summary", (summary!=null)?summary:"");

        response.setStatus(response.SC_MOVED_TEMPORARILY);
        response.setHeader("Location", "http://localhost:8080/weeklyreport/stu_form.jsp");
    }

    public void destroy() {
        //TODO
    }
}
