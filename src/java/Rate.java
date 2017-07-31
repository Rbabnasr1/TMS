
import java.io.IOException;
import java.io.PrintWriter;
import java.sql.Connection;
import java.sql.DriverManager;
import java.sql.ResultSet;
import java.sql.SQLException;
import java.sql.Statement;
import java.util.Locale;
import java.util.logging.Level;
import java.util.logging.Logger;
import javax.servlet.ServletException;
import javax.servlet.annotation.WebServlet;
import javax.servlet.http.HttpServlet;
import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;
import javax.servlet.http.HttpSession;
import model.Notification;
import model.taskModel;

@WebServlet(urlPatterns = {"/Rate"})
public class Rate extends HttpServlet {

    protected void processRequest(HttpServletRequest request, HttpServletResponse response)
            throws ServletException, IOException, ClassNotFoundException, SQLException {
        response.setContentType("text/html;charset=UTF-8");
        try (PrintWriter out = response.getWriter()) {
            String URL = "jdbc:mysql://localhost:3306/orgi";
            Class.forName("com.mysql.jdbc.Driver");
            HttpSession session = request.getSession();

            if (request.getParameter("param1").equals("depTask")) {
                int rate = 0;
                int TaskID = Integer.parseInt(String.valueOf(session.getAttribute("TaskID")));
                int AccountID = 0;
                int SumEvaluateStar = 0;
                int numberOfStarts = 0;
                String task_n = (String) session.getAttribute("Task_name");
                int evl = Integer.valueOf(request.getParameter("rating"));
                Connection con = DriverManager.getConnection(URL, "root", "root");
                Statement st = con.createStatement();
                String sql = "select * from acc_dep_task where Task_ID = " + TaskID + " and Acc_ID IS NOT Null";
                ResultSet rs = st.executeQuery(sql);
                while (rs.next()) {
                    rate = rs.getInt("rate");
                    AccountID = rs.getInt("Acc_ID");
                    numberOfStarts = rs.getInt("NumberOfStar");
                }
                con.close();
                con = DriverManager.getConnection(URL, "root", "root");

                st = con.createStatement();
                sql = "Update acc_dep_task set NumberOfStar = " + evl + " where Task_ID = " + TaskID;
                st.executeUpdate(sql);
                con.close();
                session.setAttribute("rated", "true");
                ////////////////////////////////////////////////////// Calculate el evaluation
                con = DriverManager.getConnection(URL, "root", "root");
                st = con.createStatement();
                sql = "select AVG(NumberOfStar) as Avg , AVG(rate) as Avgr "
                        + "  From acc_dep_task where Acc_ID ="
                        + AccountID + " and finished = 1 group by Acc_ID ";
                rs = st.executeQuery(sql);
                double avgStars = 0.0, avgRate = 0.0;
                while (rs.next()) {
                    avgStars = rs.getDouble("Avg");
                    avgRate = rs.getDouble("Avgr");
                }
                con.close();
                con = DriverManager.getConnection(URL, "root", "root");

                st = con.createStatement();
                sql = "select AVG(NumberOfStar) as Avg , AVG(rate) as Avgr , Acc_ID "
                        + " From acc_task_camp where Acc_ID =" + AccountID
                        + " and finished = 1 group by Acc_ID ";
                rs = st.executeQuery(sql);
                double avgStarsCamp = 0.0, avgRateCamp = 0.0;
                while (rs.next()) {
                    avgStarsCamp = rs.getDouble("Avg");
                    avgRateCamp = rs.getDouble("Avgr");
                }
                con.close();
                double evaluation = (avgRate + avgStars + avgRateCamp + avgStarsCamp) / 4;
                con = DriverManager.getConnection(URL, "root", "root");
                st = con.createStatement();
                sql = "Update account set evaluations = " + evaluation + " where ID = " + AccountID;
                st.executeUpdate(sql);
                con.close();
                // 3shan el chart of mem eval
                taskModel t = new taskModel();
                t.cummulativeEval(AccountID, TaskID, evaluation);
                // 3shan el amsa7 kol el notifications elly 5assa bel task dy 
                model.Notification n = new Notification();
                n.delete_all_task_noti(TaskID);

                session.setAttribute("rated", "true");

                response.sendRedirect("Task.jsp");
/////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////
            } else if (request.getParameter("param1").equals("campTask")) {
                int rate = 0;
                int TaskID = Integer.parseInt(String.valueOf(session.getAttribute("TaskID")));
                int AccountID = 0;
                int SumEvaluateStar = 0;
                int numberOfStarts = 0;
                String task_n = (String) session.getAttribute("Task_name");
                int evl = Integer.valueOf(request.getParameter("rating"));
                Connection con = DriverManager.getConnection(URL, "root", "root");
                Statement st = con.createStatement();
                String sql = "select * from acc_task_camp where Task_ID = " + TaskID + " and Acc_ID IS NOT Null";
                ResultSet rs = st.executeQuery(sql);
                while (rs.next()) {
                    rate = rs.getInt("rate");
                    AccountID = rs.getInt("Acc_ID");
                    numberOfStarts = rs.getInt("NumberOfStar");
                }
                con.close();
                con = DriverManager.getConnection(URL, "root", "root");
                st = con.createStatement();
                sql = "Update acc_task_camp set NumberOfStar = " + evl + " where Task_ID = " + TaskID;
                st.executeUpdate(sql);
                con.close();
                session.setAttribute("rated", "true");
                con = DriverManager.getConnection(URL, "root", "root");
                st = con.createStatement();
                sql = "select AVG(NumberOfStar) as Avg , AVG(rate) as Avgr "
                        + "  From acc_dep_task where Acc_ID ="
                        + AccountID + " and finished = 1 group by Acc_ID ";
                rs = st.executeQuery(sql);
                double avgStars = 0.0, avgRate = 0.0;
                while (rs.next()) {
                    avgStars = rs.getDouble("Avg");
                    avgRate = rs.getDouble("Avgr");
                }
                con.close();
                con = DriverManager.getConnection(URL, "root", "root");

                st = con.createStatement();
                sql = "select AVG(NumberOfStar) as Avg , AVG(rate) as Avgr , Acc_ID "
                        + " From acc_task_camp where Acc_ID =" + AccountID
                        + " and finished = 1 group by Acc_ID ";
                rs = st.executeQuery(sql);
                double avgStarsCamp = 0.0, avgRateCamp = 0.0;
                while (rs.next()) {
                    avgStarsCamp = rs.getDouble("Avg");
                    avgRateCamp = rs.getDouble("Avgr");
                }
                con.close();
                double evaluation = (avgRate + avgStars + avgRateCamp + avgStarsCamp) / 4;
                con = DriverManager.getConnection(URL, "root", "root");
                st = con.createStatement();
                sql = "Update account set evaluations = " + evaluation + " where ID = " + AccountID;
                st.executeUpdate(sql);
                con.close();
                taskModel t = new taskModel();
                t.cummulativeEval(AccountID, TaskID, evaluation);

                model.Notification n = new Notification();
                n.delete_all_task_noti(TaskID);

                session.setAttribute("rated", "true");
                response.sendRedirect("TaskC.jsp");
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
            Logger.getLogger(Rate.class.getName()).log(Level.SEVERE, null, ex);
        } catch (SQLException ex) {
            Logger.getLogger(Rate.class.getName()).log(Level.SEVERE, null, ex);
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
            Logger.getLogger(Rate.class.getName()).log(Level.SEVERE, null, ex);
        } catch (SQLException ex) {
            Logger.getLogger(Rate.class.getName()).log(Level.SEVERE, null, ex);
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
