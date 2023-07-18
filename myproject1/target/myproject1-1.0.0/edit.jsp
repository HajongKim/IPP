<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8" %>
<%@ page import="java.sql.*" %>

<!DOCTYPE html>
<html>
<head>
    <title>게시물 수정</title>
</head>
<body>
    <%-- 게시물 ID를 파라미터로 받아옴 --%>
    <% String idParam = request.getParameter("id"); %>
    <% if (idParam != null && !idParam.isEmpty()) {
           int id = Integer.parseInt(idParam);
           
           // 데이터베이스 연결
           String driver = "org.mariadb.jdbc.Driver";
           String url = "jdbc:mariadb://localhost:3306/test";
           String DB_username = "khj";
           String DB_password = "1234";
    
           Connection conn = null;
           PreparedStatement pstmt = null;
           ResultSet rs = null;
    
           try {
               Class.forName(driver);
               conn = DriverManager.getConnection(url, DB_username, DB_password);
    
               // SQL 쿼리 실행하여 해당 ID의 게시물 정보 가져오기
               String sql = "SELECT * FROM board WHERE id = ?";
               pstmt = conn.prepareStatement(sql);
               pstmt.setInt(1, id);
               rs = pstmt.executeQuery();
    
               if (rs.next()) {
                   String title = rs.getString("title");
                   String name = rs.getString("name");
                   String content = rs.getString("content");
    %>
    <h1>게시물 수정</h1>
    <form action="update.jsp" method="post">
        <input type="hidden" name="id" value="<%= id %>">
        <label for="title">제목:</label>
        <input type="text" id="title" name="title" value="<%= title %>"><br>
        <label for="name">작성자:</label>
        <input type="text" id="name" name="name" value="<%= name %>"><br>
        <label for="content">내용:</label><br>
        <textarea id="content" name="content" rows="6" cols="50"><%= content %></textarea><br>
        <input type="submit" value="수정">
    </form>
    <% } else {
           // 해당 ID에 대한 게시물이 없는 경우 처리
           out.println("<p>해당 게시물을 찾을 수 없습니다.</p>");
       }
    } catch (SQLException e) {
           e.printStackTrace();
       } catch (ClassNotFoundException e) {
           e.printStackTrace();
       } finally {
           try {
               if (rs != null) {
                   rs.close();
               }
               if (pstmt != null) {
                   pstmt.close();
               }
               if (conn != null && !conn.isClosed()) {
                   conn.close();
               }
           } catch (SQLException e) {
               e.printStackTrace();
           }
       }
    } else {
       // ID 파라미터가 없는 경우 처리
       out.println("<p>게시물 ID를 제공하지 않았습니다.</p>");
    }
    %>
</body>
</html>
