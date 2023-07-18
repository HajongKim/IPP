<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8" %>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core" %>
<%@ page import="java.sql.*" %>

<!DOCTYPE html>
<html>
<head>
    <title>Table Example</title>
    <style>
        table {
            width: 100%;
            border-collapse: collapse;
        }

        th, td {
            padding: 10px;
            text-align: left;
            border-bottom: 1px solid #ddd;
        }

        th {
            background-color: #f2f2f2;
        }

        tr:hover {
            background-color: #f5f5f5;
        }
    </style>
</head>
<body>
    <h1><a href="dbtest.jsp">게시판 페이지</a></h1>
    
    <%-- 검색어를 입력 받는 폼 --%>
    <form action="dbtest.jsp" method="get">
        <input type="text" name="search" placeholder="검색어를 입력하세요">
        <button type="submit">검색</button>
    </form>
    
    <table>
        <tr>
            <th>No</th>
            <th>제목</th>
            <th>작성자</th>
            <th>작성일</th>
            <th>조회수</th>
        </tr>

        <%-- 데이터베이스 연결 및 쿼리 실행 --%>
        <%
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

                String searchKeyword = request.getParameter("search");
                String sql = "SELECT * FROM board";
                
                // 검색어가 입력된 경우 검색 쿼리로 변경
                if (searchKeyword != null && !searchKeyword.isEmpty()) {
                    sql = "SELECT * FROM board WHERE title LIKE ? OR name LIKE ?";
                    pstmt = conn.prepareStatement(sql);
                    pstmt.setString(1, "%" + searchKeyword + "%");
                    pstmt.setString(2, "%" + searchKeyword + "%");
                } else {
                    pstmt = conn.prepareStatement(sql);
                }
                
                rs = pstmt.executeQuery();

                while (rs.next()) {
                    int id = rs.getInt("id");
                    String title = rs.getString("title");
                    String name = rs.getString("name");
                    String date = rs.getString("date");
                    int count = rs.getInt("count");
                    
        %>
        <tr>
            <td><%= id %></td>
            <td><a href="boardcontent.jsp?id=<%= id %>"> <%= title %></a></td>
            <td><%= name %></td>
            <td><%= date %></td>
            <td><%= count %></td>
        </tr>
        <% 
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
        %>
    </table>
    <br><a href="board.jsp"><button>글쓰기</button></a>
</body>
</html>
