<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8" %>
<%@ page import="java.sql.*" %>
<%@ page import="java.io.*" %>
<%@ page import="com.oreilly.servlet.*" %>
<%@ page import="com.oreilly.servlet.multipart.DefaultFileRenamePolicy" %>

<!DOCTYPE html>
<html>
<head>
    <meta charset="UTF-8">
    <title>작성 완료</title>
</head>
<body>

    <h1>게시물 작성 완료</h1>
    <p>게시물이 성공적으로 작성되었습니다.</p>
    <% request.setCharacterEncoding("UTF-8"); 
    String uploadPath = "C:/Users/CEO/Desktop/ipp실습/업로드"; // 파일을 저장할 경로를 지정해야 합니다.
	MultipartRequest multi = new MultipartRequest(request,uploadPath,5*1024*1024,"UTF-8",new DefaultFileRenamePolicy());
    %>
    
    <% 
        String title = multi.getParameter("title");
        String name = multi.getParameter("name");
        String content = multi.getParameter("content");
        String fileName = null;
    %>

	<%
	if (request.getMethod().equalsIgnoreCase("post")) {
		
		File uploadedFile = multi.getFile("file"); // "file" is the name of the file input field in the HTML form
        fileName = uploadedFile.getName();
        String filePath = uploadedFile.getAbsolutePath();
		
		try {
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
            
    			// SQL 쿼리 실행
    			String sql = "INSERT INTO board (title, name, content, fileName, filePath) VALUES (?, ?, ?, ?, ?)";
    			PreparedStatement statement = conn.prepareStatement(sql);
            	statement.setString(1, title);
            	statement.setString(2, name);
            	statement.setString(3, content);
            	statement.setString(4, fileName);
            	statement.setString(5, uploadPath);
            	statement.executeUpdate();
    
    			// 리소스 해제
    			statement.close();
    			conn.close();
    
    			// 작성 완료 메시지 출력
				} catch (Exception e) {
    			e.printStackTrace();
				}

			out.println("<p>파일 업로드가 완료되었습니다.</p>");
		} catch (Exception ex) {
			out.println("<p>파일 업로드 중 오류가 발생하였습니다.</p>");
			ex.printStackTrace();
		}
	}
	
		
		
%>	

    <%-- 전달된 데이터 출력 --%>
    <p>제목: <%= title %></p>
    <p>이름: <%= name %></p>
    <p>내용: <%= content %></p>
    <p>파일: <%= fileName %></p>

    <a href="dbtest.jsp"><button>게시판 페이지</button></a>
</body>
</html>
