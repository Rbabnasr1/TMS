/*
 * To change this license header, choose License Headers in Project Properties.
 * To change this template file, choose Tools | Templates
 * and open the template in the editor.
 */

import java.io.IOException;
import java.io.PrintWriter;
import java.sql.Connection;
import java.sql.DriverManager;
import java.sql.ResultSet;
import java.sql.SQLException;
import java.sql.Statement;
import java.util.logging.Level;
import java.util.logging.Logger;
import javax.servlet.ServletException;
import javax.servlet.annotation.WebServlet;
import javax.servlet.http.HttpServlet;
import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;
import javax.servlet.http.HttpSession;
import model.Notification;

/**
 *
 * @author rabab
 */
@WebServlet(urlPatterns = {"/assignTask"})
public class assignTask extends HttpServlet {

    /**
     * Processes requests for both HTTP <code>GET</code> and <code>POST</code>
     * methods.
     *
     * @param request servlet request
     * @param response servlet response
     * @throws ServletException if a servlet-specific error occurs
     * @throws IOException if an I/O error occurs
     */
    protected void processRequest(HttpServletRequest request, HttpServletResponse response)
            throws ServletException, IOException, ClassNotFoundException, SQLException {
        response.setContentType("text/html;charset=UTF-8");
        try (PrintWriter out = response.getWriter()) {

            if (request.getParameter("param1").equals("assignD")) {
                if (!request.getParameter("name1").equals("8")) {
                    String URL = "jdbc:mysql://localhost:3306/orgi";
                    Class.forName("com.mysql.jdbc.Driver");
                    HttpSession session = request.getSession();
                    session.setMaxInactiveInterval(12000);
                    String member = request.getParameter("memberMail");

                    int Acc_ID = 0;
                    int task_ID = 0;
                    int dp_ID = 0;
                    Connection con = DriverManager.getConnection(URL, "root", "root");
                    Statement st = con.createStatement();
                    String sql = "select * from account where email = '" + member + "'";
                    ResultSet rs = st.executeQuery(sql);

                    while (rs.next()) {

                        Acc_ID = rs.getInt("ID");

                    }
                    con.close();
                     con = DriverManager.getConnection(URL, "root", "root");

                    String task_n = (String) session.getAttribute("Task_name");
                    st = con.createStatement();
                    sql = "select * from Task where name='" + task_n + "'";
                    rs = st.executeQuery(sql);

                    while (rs.next()) {

                        task_ID = rs.getInt("ID");

                    }
                    con.close();
                     con = DriverManager.getConnection(URL, "root", "root");

                    st = con.createStatement();
                    sql = "update acc_dep_task set Acc_ID = " + Acc_ID + " where Dep_ID = " + session.getAttribute("depID") + " and Task_ID = " + task_ID;

                    st.executeUpdate(sql);
                    con.close();
                    model.Notification notify = new Notification();
                    notify.notify(task_ID, Integer.parseInt(String.valueOf(session.getAttribute("uID"))), Acc_ID, "assign", "taskD");

                    response.sendRedirect("taskPlan.jsp");
                } else {
                    response.sendRedirect("Task.jsp");
                }
            } else {
                if (!request.getParameter("name1").equals("8")) {
                    String URL = "jdbc:mysql://localhost:3306/orgi";
                    Class.forName("com.mysql.jdbc.Driver");
                    HttpSession session = request.getSession();
                    session.setMaxInactiveInterval(12000);
                    String member = request.getParameter("memberMail");
                    int Acc_ID = 0;
                    int task_ID = 0;
                    int dp_ID = 0;
                    Connection con = DriverManager.getConnection(URL, "root", "root");
                    Statement st = con.createStatement();
                    String sql = "select * from account where email = '" + member + "'";
                    ResultSet rs = st.executeQuery(sql);

                    while (rs.next()) {

                        Acc_ID = rs.getInt("ID");

                    }
                    con.close();
                     con = DriverManager.getConnection(URL, "root", "root");

                    String task_n = (String) session.getAttribute("Task_name");
                    st = con.createStatement();
                    sql = "select * from Task where name='" + task_n + "'";
                    rs = st.executeQuery(sql);

                    while (rs.next()) {

                        task_ID = rs.getInt("ID");

                    }
                    con.close();
                     con = DriverManager.getConnection(URL, "root", "root");

                    st = con.createStatement();
                    sql = "update acc_task_camp set Acc_ID = " + Acc_ID + " where Camp_ID = " + session.getAttribute("CampID") + " and Task_ID = " + task_ID;

                    st.executeUpdate(sql);
con.close();
 con = DriverManager.getConnection(URL, "root", "root");
                    st = con.createStatement();
                    sql = "select * from campagin where ID = " + session.getAttribute("CampID");
                    rs = st.executeQuery(sql);
                    String CampName = "";
                    while (rs.next()) {

                        CampName = rs.getString("name");

                    }
                    con.close();
                    model.Notification notify = new Notification();
                    notify.notify(task_ID, Integer.parseInt(String.valueOf(session.getAttribute("uID"))), Acc_ID, "assign", "taskC");

                    response.sendRedirect("campaign.jsp?param1=" + CampName + "&param2=" + session.getAttribute("CampID"));

                } else {
                    response.sendRedirect("TaskC.jsp");
                }
            }

        }
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
            Logger.getLogger(assignTask.class.getName()).log(Level.SEVERE, null, ex);
        } catch (SQLException ex) {
            Logger.getLogger(assignTask.class.getName()).log(Level.SEVERE, null, ex);
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
            Logger.getLogger(assignTask.class.getName()).log(Level.SEVERE, null, ex);
        } catch (SQLException ex) {
            Logger.getLogger(assignTask.class.getName()).log(Level.SEVERE, null, ex);
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
