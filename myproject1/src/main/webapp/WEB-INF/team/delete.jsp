<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core"%>
<%@ page import="java.sql.*"%>
<%@ page import="java.sql.DriverManager"%>
<html>
<head>
    <title>게시글 삭제</title>
    <style>
        body {
            font-family: Arial, sans-serif;
            margin: 0;
            padding: 20px;
        }

        h2 {
            text-align: center;
        }

        p {
            margin-bottom: 10px;
        }

        form {
            display: flex;
            justify-content: center;
            margin-top: 20px;
        }

        button[type="submit"] {
            padding: 10px 20px;
            font-size: 16px;
            background-color: #ccc;
            color: #fff;
            border: none;
            border-radius: 4px;
            cursor: pointer;
            margin: 0 10px;
        }

        button[type="submit"]:hover {
            background-color: #999;
        }
    </style>
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

        // 게시글 정보를 가져옴
        String selectSql = "SELECT * FROM board WHERE bno = ?";
        pstmt = conn.prepareStatement(selectSql);
        pstmt.setInt(1, bno);
        ResultSet rs = pstmt.executeQuery();

        if (rs.next()) {
            String title = rs.getString("title");
            String writer = rs.getString("writer");
            String content = rs.getString("content");
    %>
            <h2>게시글 삭제 확인</h2>
            <p>게시글 제목: <%= title %></p>
            <p>작성자: <%= writer %></p>
            <p>내용: <%= content %></p>

            <form method="post" action="deleteAction.jsp">
                <input type="hidden" name="bno" value="<%= bno %>">
                <button type="submit" name="confirm" value="yes">예</button>
                <button type="submit" name="confirm" value="no">아니오</button>
            </form>
    <%
        } else {
            out.println("해당 게시글을 찾을 수 없습니다.");
        }
        rs.close();
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
