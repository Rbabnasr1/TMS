
import java.io.IOException;
import java.io.PrintWriter;
import javax.servlet.ServletException;
import javax.servlet.annotation.WebServlet;
import javax.servlet.http.HttpServlet;
import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;
import javax.servlet.http.HttpSession;
import model.Department;
import model.Notification;
import model.campaginModel;

@WebServlet(urlPatterns = {"/campaginController"})
public class campaginController extends HttpServlet {

    protected void processRequest(HttpServletRequest request, HttpServletResponse response)
            throws ServletException, IOException {
        response.setContentType("text/html;charset=UTF-8");
        try (PrintWriter out = response.getWriter()) {
            HttpSession session = request.getSession();
            session.setMaxInactiveInterval(300000000);

            if (request.getParameter("type").equals("createCampagin")) {
                model.campaginModel camp = new campaginModel();
                camp.setName(request.getParameter("campName"));
                camp.setDescription(request.getParameter("campDesc"));
                camp.setStartDate(request.getParameter("campStDate"));
                camp.setEndDate(request.getParameter("campEnDate"));
                camp.setStartTime(request.getParameter("campSttime"));
                camp.setEndTime(request.getParameter("campEnTime"));

                int campID = camp.addCampagin(camp, Integer.parseInt((String) session.getAttribute("SAID")));
                response.sendRedirect("campaign.jsp?param1=" + request.getParameter("campName") + "&param2=" + campID);

            } else if (request.getParameter("type").equals("UpdateCamp")) {
                model.campaginModel camp1 = new campaginModel();
                model.campaginModel camp2 = new campaginModel();
                model.campaginModel camp3 = new campaginModel();
                camp1.setName(request.getParameter("campName"));
                camp1.setDescription(request.getParameter("campDesc"));
                camp1.setStartDate(request.getParameter("campSD"));
                camp1.setEndDate(request.getParameter("campED"));
                camp1.setStartTime(request.getParameter("campST"));
                camp1.setEndTime(request.getParameter("campET"));

                int hhh = Integer.parseInt(String.valueOf(session.getAttribute("CampID")));
                camp2 = camp3.UpdateCampagin(camp1, Integer.parseInt(String.valueOf(session.getAttribute("CampID"))));
                response.sendRedirect("campaign.jsp?param1=" + camp2.getName() + "&param2=" + session.getAttribute("CampID"));
            } else if (request.getParameter("type").equals("post")) {
                model.campaginModel camp1 = new campaginModel();
                int campID = Integer.parseInt(String.valueOf(session.getAttribute("CampID")));
                int uID = Integer.parseInt(String.valueOf(session.getAttribute("uID")));
                String mess = request.getParameter("message");
                camp1.postInCamp(mess, uID, campID);
                model.Notification notify = new Notification();
                notify.notify(campID, Integer.parseInt(String.valueOf(session.getAttribute("uID"))), Integer.parseInt(String.valueOf(session.getAttribute("uID"))), "post", "camp");

                response.sendRedirect("campaign.jsp?param1=" + session.getAttribute("CampName") + "&param2=" + session.getAttribute("CampID"));
            } else if (request.getParameter("type").equals("DeleteCamp")) {
                model.campaginModel camp1 = new campaginModel();
                camp1.DeleteCampagin(Integer.parseInt(String.valueOf(session.getAttribute("CampID"))));
                response.sendRedirect("SA.jsp?param1=" + session.getAttribute("SAName") + "&param2=" + session.getAttribute("SAID") + "&param3=" + session.getAttribute("CreatuinDate") + "&param4=" + session.getAttribute("cover"));
            } else if (request.getParameter("type").equals("delete_post")) {
                model.campaginModel camp1 = new campaginModel();
                camp1.deletePostInCamp(Integer.parseInt(request.getParameter("postID")));
                response.sendRedirect("campaign.jsp?param1=" + session.getAttribute("CampName") + "&param2=" + session.getAttribute("CampID"));
            }
        } catch (Exception e) {
            System.out.println("eror in task controller");
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
        processRequest(request, response);
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
        processRequest(request, response);
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
