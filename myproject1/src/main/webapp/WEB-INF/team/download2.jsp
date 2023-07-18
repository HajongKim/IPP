<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8" %>
<%@ page import="java.io.*, java.net.URLEncoder, java.util.zip.ZipEntry, java.util.zip.ZipOutputStream" %>
<%@ page import="javax.servlet.http.*" %>
<%@ page import="java.sql.DriverManager"%>

<%
// 폴더 경로
String folderPath = "C:/eGovFrameDev-4.1.0-64bit/workspace/ipp/upload/";

File folder = new File(folderPath);
if (folder.exists() && folder.isDirectory()) {
    // 폴더 내의 파일 목록 조회
    File[] files = folder.listFiles();
    if (files != null && files.length > 0) {
        // 압축 파일명
        String zipFileName = "files.zip";

        // MIME 타입 설정
        String mimeType = getServletContext().getMimeType(zipFileName);
        if (mimeType == null) {
            mimeType = "application/octet-stream";
        }

        // 다운로드를 위한 헤더 설정
        response.setContentType(mimeType);
        response.setHeader("Content-Disposition", "attachment; filename=\"" + URLEncoder.encode(zipFileName, "UTF-8") + "\"");

        // 압축 파일 생성
        try (ZipOutputStream zipOutputStream = new ZipOutputStream(response.getOutputStream())) {
            byte[] buffer = new byte[4096];

            // 폴더 내의 파일들을 압축 파일에 추가
            for (File file : files) {
                if (file.isFile()) {
                    String fileName = file.getName();

                    // 압축 파일 내의 엔트리 생성
                    zipOutputStream.putNextEntry(new ZipEntry(fileName));

                    // 파일을 읽고 압축 파일에 쓰기
                    try (InputStream inputStream = new FileInputStream(file)) {
                        int bytesRead;
                        while ((bytesRead = inputStream.read(buffer)) != -1) {
                            zipOutputStream.write(buffer, 0, bytesRead);
                        }
                    }
                }
            }
            // 압축 파일 닫기
            zipOutputStream.closeEntry();
        } catch (IOException e) {
            e.printStackTrace();
        }
    } else {
        // 폴더 내에 파일이 없는 경우에 대한 처리
        response.getWriter().println("다운로드할 파일이 없습니다.");
    }
} else {
    // 폴더가 존재하지 않는 경우에 대한 처리
    response.getWriter().println("폴더를 찾을 수 없습니다.");
}
%>
