<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core"%>
<%@ page import="java.sql.*"%>
<%@ page import="java.sql.DriverManager"%>
<html>
<head>
    <title>게시글 수정</title>
    <style>
        body {
            font-family: Arial, sans-serif;
            margin: 0;
            padding: 20px;
        }

        h1 {
            text-align: center;
        }

        form {
            display: flex;
            flex-direction: column;
            align-items: center;
            margin-top: 20px;
        }

        label {
            margin-bottom: 10px;
        }

        input[type="text"],
        textarea {
            width: 100%;
            padding: 5px;
            border: 1px solid #ccc;
            border-radius: 4px;
        }

        textarea {
            resize: vertical;
        }

        input[type="submit"] {
            padding: 10px 20px;
            font-size: 16px;
            background-color: #ccc;
            color: #fff;
            border: none;
            border-radius: 4px;
            cursor: pointer;
            margin-top: 10px;
        }

        input[type="submit"]:hover {
            background-color: #999;
        }
    </style>
</head>
<body>
    <h1>게시글 수정</h1>
    <%
    String dbDriver = "com.mysql.jdbc.Driver";
    String jdbcUrl = "jdbc:mysql://192.168.50.52:3306/board";
    String jdbcUsername = "NULL";
    String jdbcPassword = "0000";

    Connection conn = null;
    PreparedStatement pstmt = null;
    ResultSet rs = null;

    try {
        Class.forName(dbDriver);
        conn = DriverManager.getConnection(jdbcUrl, jdbcUsername, jdbcPassword);

        // 게시글 번호를 파라미터로 전달받음
        int bno = Integer.parseInt(request.getParameter("bno"));

        // 해당 게시글 내용 조회
        String selectSql = "SELECT bno, title, writer, regDate, viewCnt, content FROM board WHERE bno = ?";
        pstmt = conn.prepareStatement(selectSql);
        pstmt.setInt(1, bno);
        rs = pstmt.executeQuery();

        if (rs.next()) {
            String title = rs.getString("title");
            String writer = rs.getString("writer");
            String regDate = rs.getString("regDate");
            int viewCnt = rs.getInt("viewCnt");
            String content = rs.getString("content");
    %>
    <form method="post" action="update.jsp">
        <div style="text-align: center;">
            <input type="hidden" name="bno" value="<%=bno%>">
            <label for="title">제목:</label>
            <input type="text" id="title" name="title" value="<%=title%>">
            <br>
            <label for="writer">작성자:</label>
            <input type="text" id="writer" name="writer" value="<%=writer%>">
            <br>
            <label for="content">내용:</label>
            <textarea id="content" name="content" rows="5" cols="50"><%=content%></textarea>
            <br>
            <input type="submit" value="수정">
        </div>
    </form>
    <%
        }
    } catch (Exception e) {
        e.printStackTrace();
    } finally {
        try {
            if (rs != null)
                rs.close();
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
