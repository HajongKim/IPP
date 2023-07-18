<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8" %>
<%@ page import="java.sql.*" %>
<%@ page import="java.io.*" %>
<%@ page import="com.servlet.multipart.DefaultFileRenamePolicy;" %>

<!DOCTYPE html>
<html>
<head>
    <meta charset="UTF-8">
    <title>작성 완료</title>
</head>
<body>

    <h1>게시물 작성 완료</h1>
    <p>게시물이 성공적으로 작성되었습니다.</p>
    <% request.setCharacterEncoding("UTF-8"); %>
    
    <% 
    	MultipartRequest multi = new MultipartRequest(request, "C:/Users/CEO/Downloads", 1024*1024*10, "utf-8",
    		   new DefaultFileRenamePolicy());
        String title = request.getParameter("title");
        String name = request.getParameter("name");
        String content = request.getParameter("content");
        Part filePart = request.getPart("file");
        
        String fileName = "";
        if (filePart != null) {
            fileName = getFileName(filePart);
            String filePath = "C:/Users/CEO/Downloads" + File.separator + fileName;
            saveFile(filePart, filePath); // 파일 저장
        }
    %>

	<%
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
    		String sql = "INSERT INTO board (title, name, content, fileName) VALUES (?, ?, ?, ?)";
    		PreparedStatement statement = conn.prepareStatement(sql);
    		statement.setCharacterStream(1, new StringReader(title), title.length());
    		statement.setCharacterStream(2, new StringReader(name), name.length());
    		statement.setCharacterStream(3, new StringReader(content), content.length());
    		statement.setString(4, fileName);
    		statement.executeUpdate();
    
    	// 리소스 해제
    	statement.close();
    	conn.close();
    
    	// 작성 완료 메시지 출력
		} catch (Exception e) {
    		e.printStackTrace();
		}
%>	

    <%-- 전달된 데이터 출력 --%>
    <p>제목: <%= title %></p>
    <p>이름: <%= name %></p>
    <p>내용: <%= content %></p>
    <% if (!fileName.isEmpty()) { %>
        <p>첨부 파일: <%= fileName %></p>
    <% } %>

    <a href="dbtest.jsp"><button>게시판 페이지</button></a>
</body>
</html>

<%-- 파일 이름 추출 함수 --%>
<%!
    private String getFileName(Part part) {
        String contentDisposition = part.getHeader("content-disposition");
        String[] elements = contentDisposition.split(";");
        for (String element : elements) {
            if (element.trim().startsWith("filename")) {
                return element.substring(element.indexOf("=") + 1).trim().replace("\"", "");
            }
        }
        return "";
    }
%>

<%-- 파일 저장 함수 --%>
<%!
    private void saveFile(Part part, String filePath) throws IOException {
        InputStream inputStream = null;
        OutputStream outputStream = null;
        try {
            inputStream = part.getInputStream();
            outputStream = new FileOutputStream(filePath);
            byte[] buffer = new byte[1024];
            int bytesRead;
            while ((bytesRead = inputStream.read(buffer)) != -1) {
                outputStream.write(buffer, 0, bytesRead);
            }
        } finally {
            if (inputStream != null) {
                inputStream.close();
            }
            if (outputStream != null) {
                outputStream.close();
            }
        }
    }
%>
