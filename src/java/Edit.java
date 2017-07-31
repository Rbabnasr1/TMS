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
import java.sql.ResultSet;
import java.sql.SQLException;
import java.sql.Statement;
import java.text.ParseException;
import java.util.ArrayList;
import java.util.Calendar;
import java.util.Date;
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

/**
 *
 * @author rabab
 */
@WebServlet(urlPatterns = {"/Edit"})
@MultipartConfig
public class Edit extends HttpServlet {

    protected void processRequest(HttpServletRequest request, HttpServletResponse response)
            throws ServletException, IOException, ClassNotFoundException, SQLException, ParseException {
        response.setContentType("text/html;charset=UTF-8");
        try (PrintWriter out = response.getWriter()) {
            String URL = "jdbc:mysql://localhost:3306/orgi";
            Class.forName("com.mysql.jdbc.Driver");
            HttpSession session = request.getSession();
            if (request.getParameter("param1").equals("EditD")) {
                String task_n = (String) session.getAttribute("Task_name");

                Connection con = DriverManager.getConnection(URL, "root", "root");

                Statement st = con.createStatement();
                String sql = "";
                int task_ID = 0;
                sql = "select ID from Task where name='" + task_n + "'";
                ResultSet rs = st.executeQuery(sql);
                while (rs.next()) {

                    task_ID = rs.getInt("ID");

                }
                con.close();
                

                final String path = "C:\\Users\\rabab\\Documents\\NetBeansProjects\\GP V10\\GP\\web\\file";
                final Part filePart = request.getPart("workedFile");

                final String fileName = getFileName(filePart);

                OutputStream fileOut = null;
                InputStream filecontent = null;
                final PrintWriter writer = response.getWriter();

//                try {
                fileOut = new FileOutputStream(new File(path + File.separator
                        + fileName));
                filecontent = filePart.getInputStream();

                int read = 0;
                final byte[] bytes = new byte[1024];

                while ((read = filecontent.read(bytes)) != -1) {
                    fileOut.write(bytes, 0, read);
                } con = DriverManager.getConnection(URL, "root", "root");

                int Percentage = Integer.parseInt(request.getParameter("rate"));
                st = con.createStatement();
                sql = "Update task set percentage=" + Percentage + " where ID= " + task_ID;
                st.executeUpdate(sql);
                con.close();
                 con = DriverManager.getConnection(URL, "root", "root");
                
                
                st = con.createStatement();
                sql = "Update task set  worked_File ='" + fileName + "' where ID= " + task_ID;
                st.executeUpdate(sql);
                
                con.close();
                
                session.setAttribute("worked_File", fileName);
                session.setAttribute("percentage", Percentage);
                Date date = new Date();
                Calendar cal = Calendar.getInstance();
                cal.setTime(date);
                String year = String.valueOf(cal.get(Calendar.YEAR));
                String month = String.valueOf(cal.get(Calendar.MONTH) + 1);
                String day = String.valueOf(cal.get(Calendar.DAY_OF_MONTH));

                String hour = String.valueOf(cal.get(Calendar.HOUR_OF_DAY));
                String min = String.valueOf(cal.get(Calendar.MINUTE));
                String sec = String.valueOf(cal.get(Calendar.SECOND));

                String d = String.valueOf(year + "-" + month + "-" + day);
                String t = String.valueOf(hour + ":" + min + ":" + sec);

                if (Percentage == 100) {
                     con = DriverManager.getConnection(URL, "root", "root");
                    st = con.createStatement();
                    sql = "Update task set completionDate='" + d + "' where ID=" + task_ID;
                    st.executeUpdate(sql);
                    
                    con.close();
                     con = DriverManager.getConnection(URL, "root", "root");
                    
                    st = con.createStatement();
                    sql = "Update task set complationTime='" + t + "' where ID=" + task_ID;
                    st.executeUpdate(sql);
                    con.close();
                     con = DriverManager.getConnection(URL, "root", "root");
                    
                    ////////////////////////////////////////////////////////////////////////////
                    st = con.createStatement();
                    sql = "Update acc_dep_task set finished = 1 where Task_ID = " + task_ID;
                    session.setAttribute("assign", "finished");
                    st.executeUpdate(sql);
                    con.close();
                    //notification
                    model.UserModel user = new UserModel();
                    int Acc_ID=user.head_Presid(Integer.parseInt(String.valueOf(session.getAttribute("depID"))),Integer.parseInt(String.valueOf(session.getAttribute("SAID"))) , Integer.parseInt(String.valueOf(session.getAttribute("type"))));
                    
                     model.Notification notify = new Notification();
                    notify.notify(task_ID,Integer.parseInt(String.valueOf(session.getAttribute("uID"))),Acc_ID,"completion","taskD");

                    /////////////////////////////////////////
                    int rate1 = 0;
                    // model.Task task=(model.Task) session.getAttribute("task");
 con = DriverManager.getConnection(URL, "root", "root");
                    st = con.createStatement();
                    sql = "select * from task where name='" + task_n + "'";
                    rs = st.executeQuery(sql);
                    String end_date = "";
                    String completion_time = "", completion_date = "", end_time = "";
                    int taskID = 0;
                    while (rs.next()) {
                        taskID = rs.getInt("ID");
                        end_date = rs.getNString("endDate");
                        end_time = rs.getNString("endTime");
                        completion_time = rs.getNString("complationTime");
                        completion_date = rs.getNString("completionDate");
                    }
                    con.close();
                    int g = completion_date.compareTo(end_date);
                    // 2 = meet expectation  5=above  0=below expectations
                  if (completion_date.compareTo(end_date) > 1) //w7esh
                    {
                        rate1 = 0;
                    } else if (completion_date.compareTo(end_date) == 0) { // equal
                        if (completion_time.compareTo(end_time) <= 0) {
                            rate1 = 2;
                        } else {
                            rate1 = 0;
                        }
                    } else if (completion_date.compareTo(end_date) < 0) { // 7lw
                        rate1 = 5;
                    }
                   con = DriverManager.getConnection(URL, "root", "root");
                    String sql2 = "update Acc_Dep_Task set rate = " + rate1 + " where Task_ID=" + taskID;
                    st = con.createStatement();
                    st.executeUpdate(sql2);
                    con.close();
                   
                }
                
                response.sendRedirect("Task.jsp");

            } else {

                String task_n = (String) session.getAttribute("Task_name");

                Connection con = DriverManager.getConnection(URL, "root", "root");
                Statement st = con.createStatement();
                String sql = "";
                int task_ID = 0;
                sql = "select ID from Task where name='" + task_n + "'";
                ResultSet rs = st.executeQuery(sql);
                while (rs.next()) {

                    task_ID = rs.getInt("ID");

                }
                con.close();

                final String path = "C:\\Users\\rabab\\Documents\\NetBeansProjects\\GP V10\\GP\\web\\file";
                final Part filePart = request.getPart("workedFile");

                final String fileName = getFileName(filePart);

                OutputStream fileOut = null;
                InputStream filecontent = null;
                final PrintWriter writer = response.getWriter();

//                try {
                fileOut = new FileOutputStream(new File(path + File.separator
                        + fileName));
                filecontent = filePart.getInputStream();

                int read = 0;
                final byte[] bytes = new byte[1024];

                while ((read = filecontent.read(bytes)) != -1) {
                    fileOut.write(bytes, 0, read);
                }
                int Percentage = Integer.parseInt(request.getParameter("rate"));
 con = DriverManager.getConnection(URL, "root", "root");
                st = con.createStatement();
                sql = "Update task set percentage=" + Percentage + " where ID= " + task_ID;
                st.executeUpdate(sql);
                con.close();
                 con = DriverManager.getConnection(URL, "root", "root");
                
                st = con.createStatement();
                sql = "Update task set  worked_File ='" + fileName + "' where ID= " + task_ID;
                st.executeUpdate(sql);
                
                con.close();
                session.setAttribute("worked_File", fileName);
                session.setAttribute("percentage", Percentage);
                Date date = new Date();
                Calendar cal = Calendar.getInstance();
                cal.setTime(date);
                String year = String.valueOf(cal.get(Calendar.YEAR));
                String month = String.valueOf(cal.get(Calendar.MONTH) + 1);
                String day = String.valueOf(cal.get(Calendar.DAY_OF_MONTH));

                String hour = String.valueOf(cal.get(Calendar.HOUR_OF_DAY));
                String min = String.valueOf(cal.get(Calendar.MINUTE));
                String sec = String.valueOf(cal.get(Calendar.SECOND));

//            String d = String.valueOf(day + "-" + month + "-" + year);
//            String t = String.valueOf(hour + ":" + min + ":" + sec);
                String d = String.valueOf(year + "-" + month + "-" + day);
                String t = String.valueOf(hour + ":" + min + ":" + sec);

                if (Percentage == 100) {
                     con = DriverManager.getConnection(URL, "root", "root");
                  st = con.createStatement();
                    sql = "Update task set completionDate='" + d + "' where ID=" + task_ID;
                    st.executeUpdate(sql);
                    con.close();
                     con = DriverManager.getConnection(URL, "root", "root");
                    
                    st = con.createStatement();
                    sql = "Update task set complationTime='" + t + "' where ID=" + task_ID;
                    st.executeUpdate(sql);
                     con.close();
                     con = DriverManager.getConnection(URL, "root", "root");
                    st = con.createStatement();
                    sql = "Update acc_task_camp set finished = 1 where Task_ID = " + task_ID;
                    session.setAttribute("assign", "finished");
                    st.executeUpdate(sql);
                    con.close();
                     int rate1 = 0;
                    // model.Task task=(model.Task) session.getAttribute("task");
                   //notification
                    model.UserModel user = new UserModel();
                    int Acc_ID=user.head_Presid(Integer.parseInt(String.valueOf(session.getAttribute("depID"))),Integer.parseInt(String.valueOf(session.getAttribute("SAID"))) , Integer.parseInt(String.valueOf(session.getAttribute("type"))));
                    
                     model.Notification notify = new Notification();
                    notify.notify(task_ID,Integer.parseInt(String.valueOf(session.getAttribute("uID"))),Acc_ID,"completion","taskC");

                    /////////////////////////////////////////
                     
                     con = DriverManager.getConnection(URL, "root", "root");
                    st = con.createStatement();
                    sql = "select * from task where name='" + task_n + "'";
                    rs = st.executeQuery(sql);
                    String end_date = "";
                    String completion_time = "", completion_date = "", end_time = "";
                    int taskID = 0;
                    while (rs.next()) {
                        taskID = rs.getInt("ID");
                        end_date = rs.getNString("endDate");
                        end_time = rs.getNString("endTime");
                        completion_time = rs.getNString("complationTime");
                        completion_date = rs.getNString("completionDate");
                    }
                    con.close();
                    int g = completion_date.compareTo(end_date);
                    // 2 = meet expectation  5=above  0=below expectations
                    if (completion_date.compareTo(end_date) > 1) //w7esh
                    {
                        rate1 = 0;
                    } else if (completion_date.compareTo(end_date) == 0) { // equal
                        if (completion_time.compareTo(end_time) <= 0) {
                            rate1 = 2;
                        } else {
                            rate1 = 0;
                        }
                    } else if (completion_date.compareTo(end_date) < 0) { // 7lw
                        rate1 = 5;
                    }
                     con.close();
                     con = DriverManager.getConnection(URL, "root", "root");
                    String sql2 = "update acc_task_camp set rate = " + rate1 + " where Task_ID=" + taskID;
                    st = con.createStatement();
                    st.executeUpdate(sql2);
//                    session.setAttribute("rated", "true");

                }
                con.close();


                response.sendRedirect("TaskC.jsp");

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
        } catch (ClassNotFoundException ex) {
            Logger.getLogger(Edit.class.getName()).log(Level.SEVERE, null, ex);
        } catch (SQLException ex) {
            Logger.getLogger(Edit.class.getName()).log(Level.SEVERE, null, ex);
        } catch (ParseException ex) {
            Logger.getLogger(Edit.class.getName()).log(Level.SEVERE, null, ex);
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
        } catch (ClassNotFoundException ex) {
            Logger.getLogger(Edit.class.getName()).log(Level.SEVERE, null, ex);
        } catch (SQLException ex) {
            Logger.getLogger(Edit.class.getName()).log(Level.SEVERE, null, ex);
        } catch (ParseException ex) {
            Logger.getLogger(Edit.class.getName()).log(Level.SEVERE, null, ex);
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
