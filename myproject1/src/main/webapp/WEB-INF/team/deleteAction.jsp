<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>
<%@ page import="java.sql.*"%>
<%@ page import="java.sql.DriverManager"%>
<html>
<head>
    <title>게시글 삭제 처리</title>
</head>
<body>
    <%
    String dbDriver = "com.mysql.jdbc.Driver";
    String jdbcUrl = "jdbc:mysql://192.168.50.52:3306/board";
    String jdbcUsername = "NULL";
    String jdbcPassword = "0000";

    Connection conn = null;
    PreparedStatement pstmt = null;

    try {
        Class.forName(dbDriver);
        conn = DriverManager.getConnection(jdbcUrl, jdbcUsername, jdbcPassword);

        // 게시글 번호를 파라미터로 전달받음
        int bno = Integer.parseInt(request.getParameter("bno"));

        // 삭제 확인 값 가져오기
        String confirmValue = request.getParameter("confirm");

        if (confirmValue != null && confirmValue.equals("yes")) {
            // 게시글 삭제 수행
            String deleteSql = "DELETE FROM board WHERE bno = ?";
            pstmt = conn.prepareStatement(deleteSql);
            pstmt.setInt(1, bno);
            pstmt.executeUpdate();
        }

        response.sendRedirect("index.jsp");
    } catch (Exception e) {
        e.printStackTrace();
    } finally {
        try {
            if (pstmt != null)
                pstmt.close();
            if (conn != null)
                conn.close();
        } catch (SQLException e) {
            e.printStackTrace();
        }
    }
    %>
</body>
</html>
