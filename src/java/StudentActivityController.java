
import static com.sun.xml.ws.spi.db.BindingContextFactory.LOGGER;
import java.io.File;
import java.io.FileOutputStream;
import java.io.IOException;
import java.io.InputStream;
import java.io.OutputStream;
import java.io.PrintWriter;
import java.sql.Connection;
import java.sql.DriverManager;
import java.sql.SQLException;
import java.sql.Statement;
import java.util.Calendar;
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
import model.studentActivity;

@WebServlet(urlPatterns = {"/StudentActivityController"})
@MultipartConfig
public class StudentActivityController extends HttpServlet {

    protected void processRequest(HttpServletRequest request, HttpServletResponse response)
            throws ServletException, IOException, SQLException, ClassNotFoundException {
        response.setContentType("text/html;charset=UTF-8");
        try (PrintWriter out = response.getWriter()) {
            HttpSession session = request.getSession();
            if (request.getParameter("studentActivity").equals("Create")) {
                model.studentActivity s = new studentActivity();
                java.util.Date date = new java.util.Date();
                Calendar cal = Calendar.getInstance();
                cal.setTime(date);
                String year = String.valueOf(cal.get(Calendar.YEAR));
                String month = String.valueOf(cal.get(Calendar.MONTH) + 1);
                String day = String.valueOf(cal.get(Calendar.DAY_OF_MONTH));
                String Cdate = String.valueOf(year + "-" + month + "-" + day);
                int userID = Integer.parseInt(String.valueOf(session.getAttribute("uID")));
                s.Add(request.getParameter("Sname"), request.getParameter("address"), Cdate, userID);
                session.setAttribute("type", 1);
                int SAID = s.getID(request.getParameter("Sname"));
                session.setAttribute("SA", SAID);
                session.setAttribute("SAName", String.valueOf(request.getParameter("Sname")));
                session.setAttribute("SAID", SAID);
                session.setAttribute("CreatuinDate", Cdate);
                response.sendRedirect("SA.jsp?param1=" + session.getAttribute("SAName") + "&param2=" + session.getAttribute("SAID") + "&param3=" + session.getAttribute("CreatuinDate") + "&param4=" + session.getAttribute("cover"));

            } else if (request.getParameter("studentActivity").equals("Update")) {
                model.studentActivity s = new studentActivity();
//                int id = Integer.parseInt(request.getParameter("lid"));
                int id = Integer.parseInt(String.valueOf(session.getAttribute("SAID")));

                s.Update(id, request.getParameter("sname"), request.getParameter("saddress"));
                if (!String.valueOf(session.getAttribute("SAName")).equals(String.valueOf(request.getParameter("sname"))) && !String.valueOf(request.getParameter("sname")).equals("")) {
                    session.setAttribute("SAName", String.valueOf(request.getParameter("sname")));
                }
                out.print("Update is done successful");
                response.sendRedirect("SA.jsp?param1=" + session.getAttribute("SAName") + "&param2=" + session.getAttribute("SAID") + "&param3=" + session.getAttribute("CreatuinDate") + "&param4=" + session.getAttribute("cover"));

            } else if (request.getParameter("studentActivity").equals("Delete")) {

                model.studentActivity s = new studentActivity();
                s.Delete(Integer.parseInt(String.valueOf(session.getAttribute("SAID"))),Integer.parseInt(String.valueOf(session.getAttribute("uID"))));
                session.setAttribute("SAID",0);
                session.setAttribute("type",-1);
                response.sendRedirect("HomePage.jsp");
            } else if (request.getParameter("studentActivity").equals("post")) {
                model.studentActivity s = new studentActivity();
                int SAID = Integer.parseInt(String.valueOf(session.getAttribute("SAID")));
                int uID = Integer.parseInt(String.valueOf(session.getAttribute("uID")));
                String mess = request.getParameter("message");
                s.postInSA(mess, uID, SAID);

                model.Notification notify = new Notification();
                notify.notify(SAID, Integer.parseInt(String.valueOf(session.getAttribute("uID"))), Integer.parseInt(String.valueOf(session.getAttribute("uID"))), "post", "SA");

//                
                response.sendRedirect("SA.jsp?param1=" + session.getAttribute("SAName") + "&param2=" + session.getAttribute("SAID")
                        + "&param3=" + session.getAttribute("CreatuinDate") + "&param4=" + session.getAttribute("cover"));
            } else if (request.getParameter("studentActivity").equals("request")) {
                model.studentActivity s = new studentActivity();
                int SAID = Integer.parseInt(String.valueOf(session.getAttribute("SAID")));
                int uID = Integer.parseInt(String.valueOf(session.getAttribute("uID")));
                s.request(uID, SAID);

                response.sendRedirect("SA.jsp?param1=" + session.getAttribute("SAName") + "&param2=" + session.getAttribute("SAID") + "&param3=" + session.getAttribute("CreatuinDate") + "&param4=" + session.getAttribute("cover"));

            } else if (request.getParameter("studentActivity").equals("delete_post")) {
                model.studentActivity s = new studentActivity();
                s.deletePostInSA(Integer.parseInt(request.getParameter("postID")));
                response.sendRedirect("SA.jsp?param1=" + session.getAttribute("SAName") + "&param2=" + session.getAttribute("SAID") + "&param3=" + session.getAttribute("CreatuinDate") + "&param4=" + session.getAttribute("cover"));

            } else if (request.getParameter("studentActivity").equals("uploadCover")) {

                final String path = "C:\\Users\\rabab\\Documents\\NetBeansProjects\\GP V10\\GP\\web\\Image";
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
                String sql = "update studentactivity set cover = '" + fileName + "' where ID = " + session.getAttribute("SAID");
                session.setAttribute("cover", fileName);
                st.executeUpdate(sql);
con.close();
                response.sendRedirect("SA.jsp?param1=" + session.getAttribute("SAName") + "&param2=" + session.getAttribute("SAID") + "&param3=" + session.getAttribute("CreatuinDate") + "&param4=" + session.getAttribute("cover"));

            } else {
                String s = request.getParameter("studentActivity");
                String splitRequest[] = s.split("_");
                if (splitRequest[0].equals("accept")) {
                    model.studentActivity t = new studentActivity();
                    int SAID = Integer.parseInt(String.valueOf(session.getAttribute("SAID")));

                    t.accept(SAID, Integer.parseInt(splitRequest[1]));
//                      response.sendRedirect("SA.jsp?param1=" + session.getAttribute("SAName") + "&param2=" + session.getAttribute("SAID") + "&param3=" + session.getAttribute("CreatuinDate")+"&param4="+session.getAttribute("cover"));
//                 
                    response.sendRedirect("showRequests.jsp");
//                      response.sendRedirect("showRequest.jsp");

                } else {
                    model.studentActivity t = new studentActivity();
                    int SAID = Integer.parseInt(String.valueOf(session.getAttribute("SAID")));
                    t.ignore(SAID, Integer.parseInt(splitRequest[1]));
//                    response.sendRedirect("SA.jsp?param1=" + session.getAttribute("SAName") + "&param2=" + session.getAttribute("SAID") + "&param3=" + session.getAttribute("CreatuinDate")+"&param4="+session.getAttribute("cover"));
                    response.sendRedirect("showRequest.jsp");
                }
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
            Logger.getLogger(StudentActivityController.class.getName()).log(Level.SEVERE, null, ex);
        } catch (ClassNotFoundException ex) {
            Logger.getLogger(StudentActivityController.class.getName()).log(Level.SEVERE, null, ex);
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
            Logger.getLogger(StudentActivityController.class.getName()).log(Level.SEVERE, null, ex);
        } catch (ClassNotFoundException ex) {
            Logger.getLogger(StudentActivityController.class.getName()).log(Level.SEVERE, null, ex);
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
