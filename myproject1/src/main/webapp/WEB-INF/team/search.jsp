<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core"%>
<%@ page import="java.sql.*"%>
<%@ page import="java.sql.DriverManager"%>
<html>
<head>
<title>게시글 검색 결과</title>
</head>
<body>
	<h1>게시글 검색 결과</h1>
	<table>
		<tr>
			<th>번호</th>
			<th>제목</th>
			<th>작성자</th>
			<th>작성일</th>
			<th>조회수</th>
		</tr>
		<%
		String keyword = request.getParameter("keyword");

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

			String sql = "SELECT bno, title, writer, regDate, viewCnt FROM board WHERE title LIKE ?";
			pstmt = conn.prepareStatement(sql);
			pstmt.setString(1, "%" + keyword + "%");
			rs = pstmt.executeQuery();

			if (rs.next()) {
				rs.beforeFirst(); // Move the cursor back to the beginning
				while (rs.next()) {
					int bno = rs.getInt("bno");
					String title = rs.getString("title");
					String writer = rs.getString("writer");
					String regDate = rs.getString("regDate");
					int viewCnt = rs.getInt("viewCnt");
		%>
		<tr>
			<td><%=bno%></td>
			<td><a href="detail.jsp?bno=<%=bno%>"><%=title%></a></td>
			<td><%=writer%></td>
			<td><%=regDate%></td>
			<td><%=viewCnt%></td>
		</tr>
		<%
				}
			} else {
		%>
		<tr>
			<td colspan="5">검색한 게시글이 없습니다.</td>
		</tr>
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
	</table>
	<form method="post" action="index.jsp">
		<input type="submit" value="돌아가기">
	</form>
</body>
</html>