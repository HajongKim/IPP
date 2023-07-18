<%@ page language="java" contentType="text/html; charset=UTF-8"
	pageEncoding="UTF-8"%>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core"%>
<%@ page import="java.sql.*"%>
<%@ page import="java.sql.DriverManager"%>
<html>
<head>
    <title>게시글 수정 처리</title>
    <style>
        body {
            display: flex;
            flex-direction: column;
            align-items: center;
            justify-content: center;
            height: 100vh;
            margin: 0;
            font-family: Arial, sans-serif;
        }

        .message {
            font-size: 24px;
            text-align: center;
            margin-bottom: 20px;
        }
    </style>
</head>
<body>
    <h1>게시글 수정 처리</h1>
    <%
    request.setCharacterEncoding("UTF-8");
    %>
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

        // 게시글 번호와 수정할 내용을 파라미터로 전달받음
        int bno = Integer.parseInt(request.getParameter("bno"));
        String title = request.getParameter("title");
        String writer = request.getParameter("writer");
        String content = request.getParameter("content");

        // 해당 게시글 업데이트
        String updateSql = "UPDATE board SET title = ?, writer = ?, content = ? WHERE bno = ?";
        pstmt = conn.prepareStatement(updateSql);
        pstmt.setString(1, title);
        pstmt.setString(2, writer);
        pstmt.setString(3, content);
        pstmt.setInt(4, bno);
        pstmt.executeUpdate();

        %>
        <div class="message">
            게시글이 성공적으로 수정되었습니다.
        </div>
        <%
    } catch (Exception e) {
        e.printStackTrace();
        %>
        <div class="message">
            게시글 수정에 실패했습니다.
        </div>
        <%
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

    <form method="post" action="index.jsp">
        <input type="submit" value="돌아가기">
    </form>
</body>
</html>
