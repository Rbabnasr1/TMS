
import static com.sun.xml.ws.spi.db.BindingContextFactory.LOGGER;
import java.io.File;
import java.io.FileNotFoundException;
import java.io.FileOutputStream;
import model.taskModel;
import java.io.IOException;
import java.io.InputStream;
import java.io.OutputStream;
import java.io.PrintWriter;
import java.nio.file.Paths;
import java.sql.SQLException;
import java.util.ArrayList;
import java.util.logging.Level;
import java.util.logging.Logger;
import javax.servlet.ServletException;
import javax.servlet.annotation.MultipartConfig;
import javax.servlet.annotation.WebServlet;
import javax.servlet.http.HttpServlet;
import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;
import javax.servlet.http.HttpSession;
import javax.servlet.http.Part;

@WebServlet(urlPatterns = {"/taskController"})
@MultipartConfig
public class taskController extends HttpServlet {

    protected void processRequest(HttpServletRequest request, HttpServletResponse response)
            throws ServletException, IOException, SQLException, ClassNotFoundException {
        response.setContentType("text/html;charset=UTF-8");
        try (PrintWriter out = response.getWriter()) {
            HttpSession session = request.getSession();
            session.setMaxInactiveInterval(30000000);

            if (request.getParameter("type").equals("create Task")) {

                model.taskModel task = new taskModel();
                task.setName(request.getParameter("taskName"));
                task.setDescription(request.getParameter("taskDesc"));
                task.setPiriority(Integer.parseInt(request.getParameter("taskProir")));
                task.setStartDate(request.getParameter("taskStDate"));
                task.setEndDate(request.getParameter("taskEnDate"));
                task.setStartTime(request.getParameter("taskSttime"));
                task.setEndTime(request.getParameter("taskEnTime"));
                int task_depen =Integer.parseInt(request.getParameter("taskDepen"));
                
                final String path = "C:\\Users\\rabab\\Documents\\NetBeansProjects\\GP V10\\GP\\web\\file";
                       final Part filePart = request.getPart("task_file");

                final String fileName = getFileName(filePart);
                task.setTaskFile(fileName);

                OutputStream fileOut = null;
                InputStream filecontent = null;
                final PrintWriter writer = response.getWriter();

                try {
                    fileOut = new FileOutputStream(new File(path + File.separator
                            + fileName));
                    filecontent = filePart.getInputStream();

                    int read = 0;
                    final byte[] bytes = new byte[1024];

                    while ((read = filecontent.read(bytes)) != -1) {
                        fileOut.write(bytes, 0, read);
                    }
                    
                    task.addTask(task, Integer.parseInt(String.valueOf(session.getAttribute("uID"))), Integer.parseInt(String.valueOf(session.getAttribute("depID"))),task_depen);
                String[] skill = request.getParameterValues("skill");
                ArrayList<Integer> skills = new ArrayList<>();
                for (int i = 0; i < skill.length; i++) {
                    skills.add(Integer.parseInt(skill[i]));
                }
                task.setSkills(skills);
                task.addSkills(task.getID(task));

                response.sendRedirect("taskPlan.jsp");
                } catch (FileNotFoundException fne) {
                    writer.println("You either did not specify a file to upload or are "
                            + "trying to upload a file to a protected or nonexistent "
                            + "location.");
                } 
            } else if (request.getParameter("type").equals("Create camp task")) {
                model.taskModel task = new taskModel();
                task.setName(request.getParameter("taskName"));
                task.setDescription(request.getParameter("taskDesc"));
                task.setPiriority(Integer.parseInt(request.getParameter("taskProir")));
                task.setStartDate(request.getParameter("taskStDate"));
                task.setEndDate(request.getParameter("taskEnDate"));
                task.setStartTime(request.getParameter("taskSttime"));
                task.setEndTime(request.getParameter("taskEnTime"));
                    final String path = "C:\\Users\\rabab\\Documents\\NetBeansProjects\\GP V10\\GP\\web\\file";
                final Part filePart = request.getPart("task_file");

                final String fileName = getFileName(filePart);
                task.setTaskFile(fileName);

                OutputStream fileOut = null;
                InputStream filecontent = null;
                final PrintWriter writer = response.getWriter();

                
                    fileOut = new FileOutputStream(new File(path + File.separator
                            + fileName));
                    filecontent = filePart.getInputStream();

                    int read = 0;
                    final byte[] bytes = new byte[1024];

                    while ((read = filecontent.read(bytes)) != -1) {
                        fileOut.write(bytes, 0, read);
                    }

                boolean k = task.addTaskToCamp(task, Integer.parseInt(String.valueOf(session.getAttribute("uID"))), Integer.parseInt(String.valueOf(session.getAttribute("CampID"))));
                if (k) {
                    String[] skill = request.getParameterValues("skill");
                    ArrayList<Integer> skills = new ArrayList<>();
                    for (int i = 0; i < skill.length; i++) {
                        skills.add(Integer.parseInt(skill[i]));
                    }
                    task.setSkills(skills);

                    task.addSkills(task.getID(task));

                    response.sendRedirect("campaign.jsp?param1=" + session.getAttribute("CampName") + "&param2=" + session.getAttribute("CampID"));


                } else {
                    response.sendRedirect("SA.jsp");
                }
            }

        } catch (Exception e) {
            e.printStackTrace();
          
        }
    }
    
    private String getFileName(final Part part) {
        final String partHeader = part.getHeader("content-disposition");
        LOGGER.log(Level.INFO, "Part Header = {0}", partHeader);
        for (String content : part.getHeader("content-disposition").split(";")) {
            if (content.trim().startsWith("filename")) {
                return content.substring(
                        content.indexOf('=') + 1).trim().replace("\"", "");
            }
        }
        return null;
    }

    // <editor-fold defaultstate="collapsed" desc="HttpServlet methods. Click on the + sign on the left to edit the code.">
    /**
     * Handles the HTTP <code>GET</code> method.
     *
     * @param request servlet request
     * @param response servlet response
     * @throws ServletException if a servlet-specific error occurs
     * @throws IOException if an I/O error occurs
     */
    @Override
    protected void doGet(HttpServletRequest request, HttpServletResponse response)
            throws ServletException, IOException {
        try {
            processRequest(request, response);
        } catch (SQLException ex) {
            Logger.getLogger(taskController.class.getName()).log(Level.SEVERE, null, ex);
        } catch (ClassNotFoundException ex) {
            Logger.getLogger(taskController.class.getName()).log(Level.SEVERE, null, ex);
        }
    }

    /**
     * Handles the HTTP <code>POST</code> method.
     *
     * @param request servlet request
     * @param response servlet response
     * @throws ServletException if a servlet-specific error occurs
     * @throws IOException if an I/O error occurs
     */
    @Override
    protected void doPost(HttpServletRequest request, HttpServletResponse response)
            throws ServletException, IOException {
        try {
            processRequest(request, response);
        } catch (SQLException ex) {
            Logger.getLogger(taskController.class.getName()).log(Level.SEVERE, null, ex);
        } catch (ClassNotFoundException ex) {
            Logger.getLogger(taskController.class.getName()).log(Level.SEVERE, null, ex);
        }
    }

    /**
     * Returns a short description of the servlet.
     *
     * @return a String containing servlet description
     */
    @Override
    public String getServletInfo() {
        return "Short description";
    }// </editor-fold>

}
