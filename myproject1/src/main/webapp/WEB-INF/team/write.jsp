<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core"%>
<%@ page import="java.sql.*"%>
<%@ page import="java.sql.DriverManager"%>
<html>
<head>
<title>글 작성</title>
<style>
    body {
        font-family: Arial, sans-serif;
        margin: 0;
        padding: 20px;
    }

    h1 {
        text-align: center;
    }

    form {
        width: 400px;
        margin: 0 auto;
    }

    label {
        display: block;
        font-weight: bold;
        margin-bottom: 5px;
    }

    input[type="text"],
    textarea {
        width: 100%;
        padding: 5px;
        font-size: 14px;
        border: 1px solid #ccc;
        border-radius: 4px;
        margin-bottom: 10px;
    }

    textarea {
        resize: vertical;
        height: 150px;
    }

    input[type="submit"] {
        padding: 10px 20px;
        font-size: 16px;
        background-color: #ccc;
        color: #fff;
        border: none;
        border-radius: 4px;
        cursor: pointer;
    }

    input[type="submit"]:hover {
        background-color: #999;
    }

    .back-btn {
    
        text-align: center;
        margin-top: 20px;
    }

    .back-btn input[type="submit"] {
        padding: 10px 20px;
        font-size: 16px;
        background-color: #ccc;
        color: #fff;
        border: none;
        border-radius: 4px;
        cursor: pointer;
    }

    .back-btn input[type="submit"]:hover {
        background-color: #999;
    }
</style>
</head>
<body>
    <h1>글 작성</h1>
    <form action="save.jsp" method="post" enctype="multipart/form-data">
        <label for="title">제목:</label>
        <input type="text" name="title" id="title" />

        <label for="writer">작성자:</label>
        <input type="text" name="writer" id="writer" />

        <label for="content">내용:</label>
        <textarea name="content" id="content" rows="5" cols="50"></textarea>

        <label for="file">파일 선택:</label>
        <input type="file" name="file" id="file" />

        <input type="submit" value="저장" />
    </form>

    <div class="back-btn">
        <form method="post" action="index.jsp">
            <input type="submit" value="돌아가기">
        </form>
    </div>
</body>
</html>
