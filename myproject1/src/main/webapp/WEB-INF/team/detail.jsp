<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core"%>
<%@ page import="java.sql.*, java.io.*"%>
<html>
<head>
<title>게시글 상세 내용</title>
<style>
body {
    font-family: Arial, sans-serif;
}

h1 {
    text-align: center;
}

table {
    width: 100%;
    border-collapse: collapse;
    margin-bottom: 20px;
}

th, td {
    padding: 10px;
    text-align: left;
}

th {
    background-color: #f2f2f2;
    font-weight: bold;
}

tr:nth-child(even) {
    background-color: #f9f9f9;
}

tr:hover {
    background-color: #e5e5e5;
}

.content {
    margin-bottom: 20px;
}

.action-buttons {
    text-align: center;
    margin-top: 10px;
}

.download-link {
    display: block;
    margin-top: 10px;
}
</style>
</head>
<body>
    <h1>게시글 상세 내용</h1>
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

        // 해당 게시글 조회수 증가
        String updateSql = "UPDATE board SET viewCnt = viewCnt + 1 WHERE bno = ?";
        pstmt = conn.prepareStatement(updateSql);
        pstmt.setInt(1, bno);
        pstmt.executeUpdate();

        // 해당 게시글 내용 조회
        String selectSql = "SELECT bno, title, writer, regDate, viewCnt, content, file_name, file_path FROM board WHERE bno = ?";
        pstmt = conn.prepareStatement(selectSql);
        pstmt.setInt(1, bno);
        rs = pstmt.executeQuery();

        if (rs.next()) {
            String title = rs.getString("title");
            String writer = rs.getString("writer");
            String regDate = rs.getString("regDate");
            int viewCnt = rs.getInt("viewCnt");
            String content = rs.getString("content");
            String fileName = rs.getString("file_name");
            String filePath = rs.getString("file_path");
    %>
    <table>
        <tr>
            <th>번호</th>
            <th>제목</th>
            <th>작성자</th>
            <th>작성일</th>
            <th>조회수</th>
        </tr>
        <tr>
            <td><%=bno%></td>
            <td><%=title%></td>
            <td><%=writer%></td>
            <td><%=regDate%></td>
            <td><%=viewCnt%></td>
        </tr>
    </table>
    <p>
        <br><h2>내용</h2>
        <br><%=content%>
    </p>
    <%
        if (fileName != null && !fileName.isEmpty() && filePath != null && !filePath.isEmpty()) {
    %>
    <div class="download-link">
        첨부 파일: <a href="download.jsp?filePath=<%=filePath%>&fileName=<%=fileName%>"><%=fileName%></a>
    </div>
    <%
        }
    %>
    <br>
    <br>
    <div style="display: flex; justify-content: center; gap: 10px;">
        <form method="post" action="delete.jsp">
            <input type="hidden" name="bno" value="<%=bno%>"> <input
                type="submit" value="삭제">
        </form>
        <form method="post" action="modify.jsp">
            <input type="hidden" name="bno" value="<%=bno%>"> <input
                type="submit" value="수정">
        </form>
        <form method="post" action="index.jsp">
            <input type="submit" value="목록">
        </form>
    </div>


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
</body>
</html>
