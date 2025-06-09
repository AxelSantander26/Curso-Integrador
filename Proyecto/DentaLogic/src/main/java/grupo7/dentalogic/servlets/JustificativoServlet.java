package grupo7.dentalogic.servlets;

import grupo7.dentalogic.dao.JustificativoDAO;
import grupo7.dentalogic.model.Justificativo;
import javax.servlet.*;
import javax.servlet.http.*;
import java.io.*;
import java.net.URLEncoder;
import java.sql.Date;
import java.util.UUID;

public class JustificativoServlet extends HttpServlet {
    private static final String UPLOAD_DIR = "uploads/justificaciones";

    protected void doPost(HttpServletRequest request, HttpServletResponse response) 
            throws ServletException, IOException {
        
        try {
            // Verificar que es una petición multipart
            if (!request.getContentType().startsWith("multipart/form-data")) {
                throw new ServletException("Content type no es multipart/form-data");
            }
            
            // Obtener parámetros
            int empId = Integer.parseInt(request.getParameter("empId"));
            Date desde = Date.valueOf(request.getParameter("desde"));
            Date hasta = Date.valueOf(request.getParameter("hasta"));
            String motivo = request.getParameter("motivo");
            
            // Procesar archivo
            Part filePart = request.getPart("archivo");
            if (filePart == null || filePart.getSize() == 0) {
                throw new ServletException("Debe seleccionar un archivo");
            }
            
            String fileName = generateUniqueFileName(filePart.getSubmittedFileName());
            String uploadPath = getServletContext().getRealPath("") + File.separator + UPLOAD_DIR;
            
            // Crear directorio si no existe
            File uploadDir = new File(uploadPath);
            if (!uploadDir.exists()) {
                uploadDir.mkdirs();
            }
            
            // Guardar archivo
            String filePath = uploadPath + File.separator + fileName;
            filePart.write(filePath);
            
            // Crear y guardar justificativo
            Justificativo justificativo = new Justificativo();
            justificativo.setEmpId(empId);
            justificativo.setDesde(desde);
            justificativo.setHasta(hasta);
            justificativo.setMotivo(motivo);
            justificativo.setArchivoUrl(UPLOAD_DIR + "/" + fileName);
            
            JustificativoDAO dao = new JustificativoDAO();
            if (dao.insertar(justificativo)) {
                response.sendRedirect(request.getContextPath() + "/asistencias?success=Justificativo guardado");
            } else {
                deleteUploadedFile(filePath); // Eliminar archivo si falla la BD
                response.sendRedirect(request.getContextPath() + "/asistencias?error=Error al guardar en BD");
            }
        } catch (Exception e) {
            e.printStackTrace();
            response.sendRedirect(request.getContextPath() + "/asistencias?error=" + 
                URLEncoder.encode(e.getMessage(), "UTF-8"));
        }
    }
    
    private String generateUniqueFileName(String originalName) {
        String extension = "";
        int i = originalName.lastIndexOf('.');
        if (i > 0) {
            extension = originalName.substring(i);
        }
        return UUID.randomUUID().toString() + extension;
    }
    
    private void deleteUploadedFile(String filePath) {
        try {
            File file = new File(filePath);
            if (file.exists()) {
                file.delete();
            }
        } catch (Exception e) {
            e.printStackTrace();
        }
    }
}