<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8" %>
<%@ page import="java.sql.*" %>

<!DOCTYPE html>
<html>
<head>
    <title>게시물 수정 완료</title>
</head>
<body>
	<% request.setCharacterEncoding("UTF-8"); %>
    <%-- 게시물 ID와 수정된 데이터를 파라미터로 받아옴 --%>
    <% String idParam = request.getParameter("id");
       String title = request.getParameter("title");
       String name = request.getParameter("name");
       String content = request.getParameter("content");

       if (idParam != null && !idParam.isEmpty()) {
           int id = Integer.parseInt(idParam);
           
           // 데이터베이스 연결
           String driver = "org.mariadb.jdbc.Driver";
           String url = "jdbc:mariadb://localhost:3306/test";
           String DB_username = "khj";
           String DB_password = "1234";
    
           Connection conn = null;
           PreparedStatement pstmt = null;
    
           try {
               Class.forName(driver);
               conn = DriverManager.getConnection(url, DB_username, DB_password);
    
               // SQL 쿼리 실행하여 해당 ID의 게시물 업데이트
               String sql = "UPDATE board SET title = ?, name = ?, content = ? WHERE id = ?";
               pstmt = conn.prepareStatement(sql);
               pstmt.setString(1, title);
               pstmt.setString(2, name);
               pstmt.setString(3, content);
               pstmt.setInt(4, id);
               int rowsUpdated = pstmt.executeUpdate();
    
               if (rowsUpdated > 0) {
                   out.println("<h1>게시물 수정 완료</h1>");
                   out.println("<p>게시물이 성공적으로 수정되었습니다.</p>");
               } else {
                   out.println("<h1>게시물 수정 실패</h1>");
                   out.println("<p>게시물 수정 중 오류가 발생하였습니다.</p>");
               }
           } catch (SQLException e) {
               e.printStackTrace();
           } catch (ClassNotFoundException e) {
               e.printStackTrace();
           } finally {
               try {
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
           out.println("<h1>게시물 수정 실패</h1>");
           out.println("<p>게시물 ID를 제공하지 않았습니다.</p>");
       }
    %>
    
    <br>
    <a href="dbtest.jsp"><button>목록으로 돌아가기</button></a>
</body>
</html>
