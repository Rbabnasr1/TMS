/*
 * To change this license header, choose License Headers in Project Properties.
 * To change this template file, choose Tools | Templates
 * and open the template in the editor.
 */

import java.io.IOException;
import java.io.PrintWriter;
import java.sql.SQLException;
import java.util.Calendar;
import java.util.Date;
import java.util.logging.Level;
import java.util.logging.Logger;
import javax.servlet.ServletException;
import javax.servlet.annotation.WebServlet;
import javax.servlet.http.HttpServlet;
import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;

/**
 *
 * @author rabab
 */
@WebServlet(urlPatterns = {"/taskDependency"})
public class taskDependency extends HttpServlet {

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
            throws ServletException, IOException, SQLException, ClassNotFoundException {
        response.setContentType("text/html;charset=UTF-8");
        try (PrintWriter out = response.getWriter()) {
                      model.taskModel t = new model.taskModel();
            if(request.getParameter("taskDep").equals("yes")){
            int id = Integer.parseInt(request.getParameter("name1"));
            String buffer ="";
            
            if(id!=0){
            buffer =t.taskDep(id);
            }else{
               Date date = new Date();
                            Calendar cal = Calendar.getInstance();
                            cal.setTime(date);
                            String year = String.valueOf(cal.get(Calendar.YEAR));
                            String month = String.valueOf(cal.get(Calendar.MONTH) + 1);
                            String day = String.valueOf(cal.get(Calendar.DAY_OF_MONTH));
                            if (month.length() == 1) {

                                month = "0" + month;
                            }
                            if (day.length() == 1) {

                                day = "0" + day;
                            }
                            String hour = String.valueOf(cal.get(Calendar.HOUR_OF_DAY));
                            String min = String.valueOf(cal.get(Calendar.MINUTE));
                            String sec = String.valueOf(cal.get(Calendar.SECOND));
                            if (hour.length() == 1) {

                                hour = "0" + hour;
                            }
                            if (min.length() == 1) {

                                min = "0" + min;
                            }
                            if (sec.length() == 1) {

                                sec = "0" + sec;
                            }

                            String _date = String.valueOf(year + "-" + month + "-" + day);
                            String _time = String.valueOf(hour + ":" + min + ":" + sec);
                            
                            buffer=_date;

            }
          response.getWriter().println(buffer);
              
            }else{
            
            
            String end = request.getParameter("name2");
            String buffer =end;
            
           
          response.getWriter().println(buffer);
            
            
            
            
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
        } catch (SQLException ex) {
            Logger.getLogger(taskDependency.class.getName()).log(Level.SEVERE, null, ex);
        } catch (ClassNotFoundException ex) {
            Logger.getLogger(taskDependency.class.getName()).log(Level.SEVERE, null, ex);
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
            Logger.getLogger(taskDependency.class.getName()).log(Level.SEVERE, null, ex);
        } catch (ClassNotFoundException ex) {
            Logger.getLogger(taskDependency.class.getName()).log(Level.SEVERE, null, ex);
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
