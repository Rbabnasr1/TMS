/*
 * To change this license header, choose License Headers in Project Properties.
 * To change this template file, choose Tools | Templates
 * and open the template in the editor.
 */

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
import java.sql.Connection;
import java.sql.DriverManager;
import java.sql.SQLException;
import java.sql.Statement;
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
import model.Notification;
import model.UserModel;

@WebServlet(urlPatterns = {"/AccountController"})
@MultipartConfig
public class AccountController extends HttpServlet {

    protected void processRequest(HttpServletRequest request, HttpServletResponse response)
            throws ServletException, IOException, SQLException, ClassNotFoundException {
        response.setContentType("text/html;charset=UTF-8");
        try (PrintWriter out = response.getWriter()) {
            HttpSession session = request.getSession();
            /* TODO output your page here. You may use following sample code. */
            if (request.getParameter("change").equals("promote")) {
                int MID = Integer.parseInt(request.getParameter("Promotion"));
                int DID = Integer.parseInt(request.getParameter("Dpromote"));

                model.Notification notify = new Notification();
                notify.notify(DID, Integer.parseInt(String.valueOf(session.getAttribute("uID"))), MID, "promotion", "dep");

                UserModel user = new UserModel();
                if (MID != -1) {
                    user.promote(MID, DID);

                }
                response.sendRedirect("Promotion.jsp");

            } else if (request.getParameter("change").equals("Dismiss")) {
                int MID = Integer.parseInt(request.getParameter("dismiss"));
                UserModel user = new UserModel();
                int SAID = Integer.parseInt(String.valueOf(session.getAttribute("SAID")));
                if (MID != -1) {
                    model.Notification notify = new Notification();
                    notify.notify(0, Integer.parseInt(String.valueOf(session.getAttribute("uID"))), MID, "dismiss", null);

                    user.dismiss(MID, SAID);

                    response.sendRedirect("Dismiss.jsp");
                } else {

                    response.sendRedirect("Dismiss.jsp");

                }
            } else if (request.getParameter("change").equals("update")) {
                model.UserModel user1 = new UserModel();
                model.UserModel user2 = new UserModel();
                model.UserModel user3 = new UserModel();
               
                user1.setFName(request.getParameter("Name"));
                String name = request.getParameter("Name");
                user1.setAddress(request.getParameter("address"));
                String he = request.getParameter("address");
                user1.setEmail(request.getParameter("email"));
                user1.setPassword(request.getParameter("pass"));
                user1.setMobile(request.getParameter("mobile"));
                String n = request.getParameter("day");
                if (!request.getParameter("day").equals("")) {
                    user1.setDay(Integer.parseInt(String.valueOf(request.getParameter("day"))));
                }
                if (!request.getParameter("month").equals("")) {
                    user1.setMonth(Integer.parseInt(String.valueOf(request.getParameter("month"))));
                }
                if (!request.getParameter("year").equals("")) {
                    user1.setYear(Integer.parseInt(String.valueOf(request.getParameter("year"))));
                }
                user3.update(user1, Integer.parseInt(String.valueOf(session.getAttribute("uID"))));
                response.sendRedirect("profile.jsp?param1=" + session.getAttribute("uID") + "&param2=" + session.getAttribute("profile") + "&param3=" + session.getAttribute("user"));

            }else if (request.getParameter("change").equals("updateSkill")){
                model.UserModel user3 = new UserModel();
                String[] skill = request.getParameterValues("skill");
                   ArrayList<Integer> skills = new ArrayList<>();
                    for (int i = 0; i < skill.length; i++) {
                        skills.add(Integer.parseInt(skill[i]));
                    }
                   user3.updateSkill(skills, Integer.parseInt(String.valueOf(session.getAttribute("uID"))));
                   response.sendRedirect("UpdateProfle.jsp");
            } 
            else if (request.getParameter("change").equals("uploadPhoto")) {
                final String path = "C:\\Users\\rabab\\Documents\\NetBeansProjects\\GP V10\\GP\\web\\Image";
                out.println(" " + request.getPart("image"));
                final Part filePart = request.getPart("image");
                final String fileName = getFileName(filePart);

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
                writer.println("New file " + fileName + " created at " + path);
                LOGGER.log(Level.INFO, "File{0}being uploaded to {1}",
                        new Object[]{fileName, path});

                String URL = "jdbc:mysql://localhost:3306/orgi";
                Class.forName("com.mysql.jdbc.Driver");
                Connection con = DriverManager.getConnection(URL, "root", "root");
                Statement st = con.createStatement();
                String sql = "update account set photo = '" + fileName + "' where ID = " + session.getAttribute("uID");
                session.setAttribute("profile", fileName);
                st.executeUpdate(sql);
con.close();
                response.sendRedirect("profile.jsp?param1=" + session.getAttribute("uID") + "&param2=" + session.getAttribute("profile") + "&param3=" + session.getAttribute("user"));
            }

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
            Logger.getLogger(AccountController.class.getName()).log(Level.SEVERE, null, ex);
        } catch (ClassNotFoundException ex) {
            Logger.getLogger(AccountController.class.getName()).log(Level.SEVERE, null, ex);
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
            Logger.getLogger(AccountController.class.getName()).log(Level.SEVERE, null, ex);
        } catch (ClassNotFoundException ex) {
            Logger.getLogger(AccountController.class.getName()).log(Level.SEVERE, null, ex);
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
