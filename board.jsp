<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8" %>
<!DOCTYPE html>
<html>
<head>
    <meta charset="UTF-8">
    <title>게시판 페이지</title>
</head>
<body>
    
    <%-- 게시물 작성 양식 --%>
    <h2>게시판 작성</h2>
	<form action="write.jsp" method="post" accept-charset="UTF-8" >
    	<label for="title">제목:</label>
    	<input type="text" id="title" name="title"><br>
    	<label for="name">이름:</label>
    	<input type="text" id="name" name="name"><br>
    	<label for="content">내용:</label><br>
    	<textarea id="content" name="content" rows="6" cols="50"></textarea><br>
    	<input type="file" name="file">
    	<input type="submit" value="작성">
	</form>

    <a href="dbtest.jsp"><button>돌아가기</button></a>
</body>
</html>
