<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8" %>
<%@ page import="java.sql.*" %>

<!DOCTYPE html>
<html>
<head>
    <title>게시물 내용</title>
    <style>
        body {
            font-family: Arial, sans-serif;
            margin: 20px;
        }

        table {
        	width: 50%;
            border-collapse: collapse;
        }
        
        tr {
        	border: 1px solid #ddd;
        }

        th, td {
            padding: 10px;
            text-align: left;
            vertical-align: top;
            border-bottom: 1px solid #ddd;
        }

        th {
            background-color: #f5f5f5;
        }

        .button-container {
            margin-top: 20px;
        }

        .button-container button {
            display: inline-block;
            padding: 10px 20px;
            margin-right: 10px;
            background-color: #4caf50;
            color: white;
            border: none;
            border-radius: 4px;
            cursor: pointer;
        }

        .button-container button:hover {
            background-color: #45a049;
        }

        .error-message {
            color: red;
            font-weight: bold;
        }
    </style>
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
               
               // 조회수 증가를 위한 SQL 쿼리 실행
               String updateSql = "UPDATE board SET count = count + 1 WHERE id = ?";
               pstmt = conn.prepareStatement(updateSql);
               pstmt.setInt(1, id);
               pstmt.executeUpdate();
               pstmt.close(); 
               
               // 게시물 내용 조회
               String selectSql = "SELECT * FROM board WHERE id = ?";
               pstmt = conn.prepareStatement(selectSql);
               pstmt.setInt(1, id);
               rs = pstmt.executeQuery();
    
               if (rs.next()) {
                   String title = rs.getString("title");
                   String name = rs.getString("name");
                   String content = rs.getString("content");
                   String date = rs.getString("date");
                   int count = rs.getInt("count");
    %>
    <table>
    	<tr>
        	<th>제목 </th>
        	<td><%= title %></td>
        	<td>작성자: <%= name %></td>
        	<td>작성일: <%= date %></td>
        	<td>조회수: <%= count %></td>
    	</tr>
    	<tr>
        	<th>내용</th>
        	<td><%= content %></td>
    	</tr>
	</table>

	

    
    <br>
    <a href="dbtest.jsp"><button style="display: inline-block; margin-right: 120px;">목록으로 돌아가기</button></a>
    
    <a href="edit.jsp?id=<%= id %>"><button>수정하기</button></a>
    
    <a href="delete.jsp?id=<%= id %>"><button>삭제하기</button></a>
    
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
