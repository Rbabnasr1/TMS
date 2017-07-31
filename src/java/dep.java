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
import model.taskModel;

/**
 *
 * @author rabab
 */
@WebServlet(urlPatterns = {"/dep"})
public class dep extends HttpServlet {

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
            String r = request.getParameter("param4");
            if (request.getParameter("param4").equals("TaskDep")) {

                String URL = "jdbc:mysql://localhost:3306/orgi";
                Class.forName("com.mysql.jdbc.Driver");
                HttpSession session = request.getSession();
                session.setMaxInactiveInterval(30000000);
                String task = request.getParameter("param1");
                int IDT = Integer.parseInt(request.getParameter("param2"));
                session.setAttribute("color", request.getParameter("param6"));

                Connection con = DriverManager.getConnection(URL, "root", "root");
                Statement st = con.createStatement();
                String sql = "select * from task where Name ='" + task + "' and ID = " + IDT;
                ResultSet rs = st.executeQuery(sql);
                int ID = 0;

                while (rs.next()) {
                    ID = rs.getInt("ID");
                    session.setAttribute("Task_name", rs.getString("Name"));
                    session.setAttribute("Task_des", rs.getString("description"));
                    session.setAttribute("percentage", rs.getString("percentage"));
                    session.setAttribute("Task_Sd", rs.getString("startDate"));
                    session.setAttribute("Task_Ed", rs.getString("endDate"));
                    session.setAttribute("TaskID", rs.getInt("ID"));
                    session.setAttribute("Task_File", rs.getString("task_File"));

                    session.setAttribute("Worked_File", rs.getString("worked_File"));
                }

                con.close();
                con = DriverManager.getConnection(URL, "root", "root");
                st = con.createStatement();
                sql = "select * from acc_dep_task where Task_ID = " + ID + " and Acc_ID IS NOT Null";
                rs = st.executeQuery(sql);

                int f = 1, b = 0;
                while (rs.next()) {
                    session.setAttribute("ID", rs.getInt("Acc_ID"));
                    session.setAttribute("depID", rs.getInt("dep_ID"));

                    f = 0;
                    int rate = rs.getInt("NumberOfStar");
                    if (rs.getInt("finished") == 1) {
                        session.setAttribute("assign", "finished");

                        if (rate == 50) {
                            session.setAttribute("rated", "false");
                        } else {
                            session.setAttribute("rated", "true");
                        }

                    } else {
                        session.setAttribute("assign", "true");
                    }
                    response.sendRedirect("Task.jsp");
                }
                con.close();
                if (f == 1) {
                    session.setAttribute("assign", "false");
                    response.sendRedirect("Task.jsp");
                }
            } else if (request.getParameter("param4").equals("TaskCam")) {

                String URL = "jdbc:mysql://localhost:3306/orgi";
                Class.forName("com.mysql.jdbc.Driver");
//             con = DriverManager.getConnection(URL, "root", "root");
                HttpSession session = request.getSession();
                session.setMaxInactiveInterval(30000000);
                session.setAttribute("color", request.getParameter("param6"));
//             

                String task = request.getParameter("param1");
                int IDT = Integer.parseInt(request.getParameter("param2"));
                Connection con = DriverManager.getConnection(URL, "root", "root");
                Statement st = con.createStatement();
                String sql = "select * from task where Name ='" + task + "' and ID = " + IDT;
                ResultSet rs = st.executeQuery(sql);
                int ID = 0;

                while (rs.next()) {
                    ID = rs.getInt("ID");
                    session.setAttribute("Task_name", rs.getString("Name"));
                    session.setAttribute("Task_des", rs.getString("description"));
                    session.setAttribute("percentage", rs.getString("percentage"));
                    session.setAttribute("Task_Sd", rs.getString("startDate"));
                    session.setAttribute("Task_Ed", rs.getString("endDate"));
                    session.setAttribute("TaskID", rs.getInt("ID"));
                    session.setAttribute("Task_File", rs.getString("task_File"));

                    session.setAttribute("Worked_File", rs.getString("worked_File"));

                }
                con.close();
                con = DriverManager.getConnection(URL, "root", "root");

                st = con.createStatement();
                sql = "select * from acc_task_camp where Task_ID = " + ID + " and Acc_ID IS NOT Null";
                rs = st.executeQuery(sql);

                int f = 1, b = 0;
                while (rs.next()) {
                    session.setAttribute("ID", rs.getInt("Acc_ID"));
                    f = 0;
                    int rate = rs.getInt("NumberOfStar");
                    if (rs.getInt("finished") == 1) {
                        session.setAttribute("assign", "finished");

                        if (rate == 50) {
                            session.setAttribute("rated", "false");
                        } else {
                            session.setAttribute("rated", "true");
                        }

                    } else {
                        session.setAttribute("assign", "true");
                    }
                    response.sendRedirect("TaskC.jsp");
                }
                con.close();
                if (f == 1) {
                    session.setAttribute("assign", "false");
                    response.sendRedirect("TaskC.jsp");
                }

            } else {

                String URL = "jdbc:mysql://localhost:3306/orgi";
                Class.forName("com.mysql.jdbc.Driver");
                HttpSession session = request.getSession();
                session.setMaxInactiveInterval(30000000);
                String task = request.getParameter("param1");
                int IDT = Integer.parseInt(request.getParameter("param2"));
//              session.setAttribute("rated", "false");
                session.setAttribute("color", request.getParameter("param6"));
                Connection con = DriverManager.getConnection(URL, "root", "root");
                Statement st = con.createStatement();
                String sql = "select * from task where Name ='" + task + "' and ID = " + IDT;
                ResultSet rs = st.executeQuery(sql);
                int ID = 0;

                while (rs.next()) {
                    ID = rs.getInt("ID");
                    session.setAttribute("Task_name", rs.getString("Name"));
                    session.setAttribute("Task_des", rs.getString("description"));
                    session.setAttribute("percentage", rs.getString("percentage"));
                    session.setAttribute("Task_Sd", rs.getString("startDate"));
                    session.setAttribute("Task_Ed", rs.getString("endDate"));
                    session.setAttribute("TaskID", rs.getInt("ID"));
                    session.setAttribute("Task_File", rs.getString("task_File"));

                    session.setAttribute("Worked_File", rs.getString("worked_File"));

                }
                con.close();
                con = DriverManager.getConnection(URL, "root", "root");

                st = con.createStatement();
                sql = "select * from acc_dep_task where Task_ID = " + ID + " and Acc_ID IS NOT Null";
                rs = st.executeQuery(sql);
                taskModel taskA = new taskModel();
                session.setAttribute("depID", taskA.getDepforTask(Integer.parseInt(String.valueOf(session.getAttribute("TaskID")))));

                int f = 1, b = 0;
                while (rs.next()) {
                    session.setAttribute("ID", rs.getInt("Acc_ID"));
                    f = 0;
                    int rate = rs.getInt("NumberOfStar");
                    if (rs.getInt("finished") == 1) {
                        session.setAttribute("assign", "finished");

                        if (rate == 50) {
                            session.setAttribute("rated", "false");
                        } else {
                            session.setAttribute("rated", "true");
                        }

                    } else {
                        session.setAttribute("assign", "true");
                    }
                    response.sendRedirect("Task.jsp");
                }
                con.close();
                if (f == 1) {
                    session.setAttribute("assign", "false");
                    response.sendRedirect("Task.jsp");
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
            Logger.getLogger(dep.class.getName()).log(Level.SEVERE, null, ex);
        } catch (SQLException ex) {
            Logger.getLogger(dep.class.getName()).log(Level.SEVERE, null, ex);
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
            Logger.getLogger(dep.class.getName()).log(Level.SEVERE, null, ex);
        } catch (SQLException ex) {
            Logger.getLogger(dep.class.getName()).log(Level.SEVERE, null, ex);
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
