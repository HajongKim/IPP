<%@ page language="java" contentType="application/octet-stream" pageEncoding="UTF-8" %>
<%@ page import="java.sql.*, java.io.*" %>
<%@ page import="java.net.URLEncoder" %>

<%
// 파일 경로와 파일 이름을 파라미터로부터 가져옴
String filePath = request.getParameter("filePath");
String fileName = request.getParameter("fileName");

if (filePath != null && fileName != null) {
    File file = new File(filePath, fileName);
    if (file.exists()) {
        // 파일 다운로드를 위한 설정
        response.setHeader("Content-Disposition", "attachment; filename=\"" + URLEncoder.encode(fileName, "UTF-8") + "\"");
        response.setContentType("application/octet-stream");
        response.setContentLength((int) file.length());

        // 파일을 읽어오고 다운로드
        try (FileInputStream fis = new FileInputStream(file);
             OutputStream os = response.getOutputStream()) {

            byte[] buffer = new byte[4096];
            int bytesRead;
            while ((bytesRead = fis.read(buffer)) != -1) {
                os.write(buffer, 0, bytesRead);
            }
        } catch (Exception e) {
            e.printStackTrace();
        }
    } else {
        out.println("<p>파일을 찾을 수 없습니다.</p>");
    }
} else {
    out.println("<p>잘못된 파일 정보입니다.</p>");
}
%>
