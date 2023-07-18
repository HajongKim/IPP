<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8" %>
<%@ page import="java.sql.*" %>
<%@ page import="java.io.*" %>
<%@ page import="com.oreilly.servlet.*" %>
<%@ page import="com.oreilly.servlet.multipart.DefaultFileRenamePolicy" %>

<!DOCTYPE html>
<html>
<head>
    <title>게시물 수정 완료</title>
</head>
<body>
	<% request.setCharacterEncoding("UTF-8"); 
		String uploadPath = "C:/Users/CEO/Desktop/ipp실습/업로드"; // 파일을 저장할 경로를 지정해야 합니다.
		MultipartRequest multi=new MultipartRequest(request,uploadPath,5*1024*1024,"UTF-8",new DefaultFileRenamePolicy());
	%>
    <%-- 게시물 ID와 수정된 데이터를 파라미터로 받아옴 --%>
    <% String idParam = multi.getParameter("id");
       String title = multi.getParameter("title");
       String name = multi.getParameter("name");
       String content = multi.getParameter("content");
       String fileName = null;
       
       if (idParam != null && !idParam.isEmpty()) {
           int id = Integer.parseInt(idParam);

           try {
               // 파일 업로드 처리
               File uploadedFile = multi.getFile("file"); // "file" is the name of the file input field in the HTML form
               fileName = uploadedFile.getName();
               String filePath = uploadedFile.getAbsolutePath();
               
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
                String sql = "UPDATE board SET title = ?, name = ?, content = ?, fileName = ?, filePath = ? WHERE id = ?";
                pstmt = conn.prepareStatement(sql);
                pstmt.setString(1, title);
                pstmt.setString(2, name);
                pstmt.setString(3, content);
                pstmt.setString(4, fileName);
                pstmt.setString(5, uploadPath);
                pstmt.setInt(6, id);
                int rowsUpdated = pstmt.executeUpdate();
     
                if (rowsUpdated > 0) {
                    out.println("<h1>게시물 수정 완료</h1>");
                    out.println("<p>게시물이 성공적으로 수정되었습니다.</p>");
                } else {
                    out.println("<h1>게시물 수정 실패</h1>");
                    out.println("<p>게시물 수정 중 오류가 발생하였습니다.</p>");
                }
       
       			// 리소스 해제
       			pstmt.close();
       			conn.close();
       
       			// 작성 완료 메시지 출력
   				} catch (Exception e) {
       			e.printStackTrace();
   				}
               
           	} catch (Exception ex) {
    			out.println("<p>파일 업로드 중 오류가 발생하였습니다.</p>");
    			ex.printStackTrace();
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
