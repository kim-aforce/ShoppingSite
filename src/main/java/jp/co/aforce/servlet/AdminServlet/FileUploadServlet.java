package jp.co.aforce.servlet.AdminServlet;

import java.io.File;
import java.io.IOException;
import java.time.LocalDateTime;
import java.time.format.DateTimeFormatter;
import java.util.Arrays;
import java.util.List;

import jakarta.servlet.ServletException;
import jakarta.servlet.annotation.MultipartConfig;
import jakarta.servlet.annotation.WebServlet;
import jakarta.servlet.http.HttpServlet;
import jakarta.servlet.http.HttpServletRequest;
import jakarta.servlet.http.HttpServletResponse;
import jakarta.servlet.http.Part;

/**
 * 商品画像アップロード専用サーブレット
 * 管理者用ファイルアップロード機能を提供
 */
@WebServlet("/admin/upload-image")
@MultipartConfig(
    fileSizeThreshold = 1024 * 1024 * 2,
    maxFileSize = 1024 * 1024 * 10,
    maxRequestSize = 1024 * 1024 * 50
)
public class FileUploadServlet extends HttpServlet {

    private static final String UPLOAD_DIRECTORY = "views" + File.separator + "img" + File.separator + "product";

    private static final List<String> ALLOWED_EXTENSIONS =
        Arrays.asList(".jpg", ".jpeg", ".png", ".gif", ".webp", ".bmp");

    private static final long MAX_FILE_SIZE = 10 * 1024 * 1024;

    @Override
    protected void doPost(HttpServletRequest request, HttpServletResponse response)
            throws ServletException, IOException {

        response.setContentType("application/json");
        response.setCharacterEncoding("UTF-8");

        try {
            Part filePart = request.getPart("imageFile");
            String fileName = getSubmittedFileName(filePart);

            if (fileName == null || fileName.trim().isEmpty()) {
                writeErrorResponse(response, "ファイルが選択されていません");
                return;
            }

            if (!isValidImageFile(fileName)) {
                writeErrorResponse(response, "サポートされていない画像形式です。JPG, PNG, GIF, WebP形式を使用してください");
                return;
            }

            if (filePart.getSize() > MAX_FILE_SIZE) {
                writeErrorResponse(response, "ファイルサイズが大きすぎます。最大10MBまで対応しています");
                return;
            }

            String uploadPath = getServletContext().getRealPath("") + File.separator + UPLOAD_DIRECTORY;
            File uploadDir = new File(uploadPath);
            if (!uploadDir.exists()) {
                boolean created = uploadDir.mkdirs();
                if (!created) {
                    writeErrorResponse(response, "アップロードディレクトリの作成に失敗しました");
                    return;
                }
            }

            String uniqueFileName = generateUniqueFileName(fileName);
            String fullPath = uploadPath + File.separator + uniqueFileName;

            filePart.write(fullPath);

            String relativePath = "../img/product/" + uniqueFileName;

            String successResponse = String.format(
                "{\"status\":\"success\", \"filename\":\"%s\", \"path\":\"%s\", \"size\":%d, \"message\":\"アップロード完了\"}",
                uniqueFileName, relativePath, filePart.getSize()
            );
            response.getWriter().write(successResponse);

            System.out.println("[画像アップロード成功] ファイル: " + uniqueFileName + " サイズ: " + filePart.getSize() + " bytes");

        } catch (Exception e) {
            e.printStackTrace();
            writeErrorResponse(response, "サーバーエラーが発生しました: " + e.getMessage());
        }
    }

    private String getSubmittedFileName(Part part) {
        String contentDisposition = part.getHeader("content-disposition");
        if (contentDisposition == null) return null;

        String[] elements = contentDisposition.split(";");
        for (String element : elements) {
            if (element.trim().startsWith("filename")) {
                String filename = element.substring(element.indexOf('=') + 1).trim();
                return filename.replace("\"", "");
            }
        }
        return null;
    }

    private boolean isValidImageFile(String fileName) {
        if (fileName == null) return false;
        String lowerFileName = fileName.toLowerCase();
        return ALLOWED_EXTENSIONS.stream().anyMatch(lowerFileName::endsWith);
    }

    private String generateUniqueFileName(String originalFileName) {
        String extension = "";
        int dotIndex = originalFileName.lastIndexOf('.');
        if (dotIndex > 0) {
            extension = originalFileName.substring(dotIndex);
        }

        String timestamp = LocalDateTime.now().format(DateTimeFormatter.ofPattern("yyyyMMdd_HHmmss_SSS"));

        String baseName = originalFileName.substring(0, dotIndex > 0 ? dotIndex : originalFileName.length());
        String safeName = baseName.replaceAll("[^a-zA-Z0-9._-]", "_");

        return timestamp + "_" + safeName + extension;
    }

    private void writeErrorResponse(HttpServletResponse response, String message) throws IOException {
        response.setStatus(HttpServletResponse.SC_BAD_REQUEST);
        String errorResponse = String.format(
            "{\"status\":\"error\", \"message\":\"%s\"}",
            message.replace("\"", "\\\"")
        );
        response.getWriter().write(errorResponse);
    }
}
