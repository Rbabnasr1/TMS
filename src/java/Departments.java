/*
 * To change this license header, choose License Headers in Project Properties.
 * To change this template file, choose Tools | Templates
 * and open the template in the editor.
 */

import java.io.IOException;
import java.io.PrintWriter;
import java.sql.SQLException;
import java.util.logging.Level;
import java.util.logging.Logger;
import javax.servlet.ServletException;
import javax.servlet.annotation.WebServlet;
import javax.servlet.http.HttpServlet;
import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;
import javax.servlet.http.HttpSession;
import model.Department;
import model.Notification;
import model.studentActivity;

/**
 *
 * @author rabab
 */
@WebServlet(urlPatterns = {"/Departments"})
public class Departments extends HttpServlet {

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
            HttpSession session = request.getSession(true);
            session.setMaxInactiveInterval(3000000);

            if (request.getParameter("type").equals("update")) {
                String dep = request.getParameter("name");
                if(!dep.equals("")){
                    session.setAttribute("depName",dep);
                }
                String targ = request.getParameter("targ");
               // session.setAttribute("depName", dep);
                Department department = new Department();
                boolean flag = department.Update(dep,targ, Integer.parseInt(String.valueOf(session.getAttribute("depID"))));
                if (flag == true) {
                    response.sendRedirect("dep.jsp?param1=" + session.getAttribute("depName") + "&param2=" + session.getAttribute("depID"));
                } else {
                    response.sendRedirect("UpdateDep.jsp");
                }

            } else if (request.getParameter("type").equals("post")) {
                model.Department dep = new Department();
                int depID = Integer.parseInt(String.valueOf(session.getAttribute("depID")));
                int uID = Integer.parseInt(String.valueOf(session.getAttribute("uID")));
                String mess = request.getParameter("message");
                dep.postInDep(mess, uID, depID);

                model.Notification notify = new Notification();
                notify.notify(depID, Integer.parseInt(String.valueOf(session.getAttribute("uID"))), Integer.parseInt(String.valueOf(session.getAttribute("uID"))), "post", "dep");

                response.sendRedirect("dep.jsp?param1=" + session.getAttribute("depName") + "&param2=" + session.getAttribute("depID"));
            } else if (request.getParameter("type").equals("create")) {

                String dep = request.getParameter("depname");
                String target = request.getParameter("target");
                int acc_ID = Integer.parseInt(String.valueOf(session.getAttribute("uID")));
                session.setAttribute("depName", dep);
                session.setAttribute("Department", new Department(dep, target, acc_ID));
                Department department = new Department(dep, target, acc_ID);
                int id = department.CreateDep(dep, target, acc_ID, Integer.parseInt(String.valueOf(session.getAttribute("SAID"))));
                session.setAttribute("depID", id);
                response.sendRedirect("dep.jsp?param1=" + session.getAttribute("depName") + "&param2=" + session.getAttribute("depID"));

            } else if (request.getParameter("type").equals("delete")) {
                Department department = new Department();
                boolean flag = department.remove(Integer.parseInt(String.valueOf(session.getAttribute("depID"))));
                if (flag == true) {
                    response.sendRedirect("SA.jsp?param1=" + session.getAttribute("SAName") + "&param2=" + session.getAttribute("SAID") + "&param3=" + session.getAttribute("CreatuinDate") + "&param4=" + session.getAttribute("cover"));
                } else {
                    response.sendRedirect("dep.jsp?param1=" + session.getAttribute("depName") + "&param2=" + session.getAttribute("depID"));
                }

            } else if (request.getParameter("type").equals("AddMember")) {

                int IDMember = Integer.parseInt(request.getParameter("addMember"));
                Department department = new Department();
                department.addMember(IDMember, Integer.parseInt(String.valueOf(session.getAttribute("depID"))));
//               
                
                response.sendRedirect("dep.jsp?param1=" + session.getAttribute("depName") + "&param2=" + session.getAttribute("depID"));
               } else if (request.getParameter("type").equals("delete_post")) {
                Department department = new Department();
                department.deletePostInDep(Integer.parseInt(request.getParameter("postID")));
                response.sendRedirect("dep.jsp?param1=" + session.getAttribute("depName") + "&param2=" + session.getAttribute("depID"));

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
            Logger.getLogger(Departments.class.getName()).log(Level.SEVERE, null, ex);
        } catch (SQLException ex) {
            Logger.getLogger(Departments.class.getName()).log(Level.SEVERE, null, ex);
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
            Logger.getLogger(Departments.class.getName()).log(Level.SEVERE, null, ex);
        } catch (SQLException ex) {
            Logger.getLogger(Departments.class.getName()).log(Level.SEVERE, null, ex);
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
