
import java.io.IOException;
import java.io.PrintWriter;
import java.util.ArrayList;
import javax.servlet.ServletException;
import javax.servlet.annotation.WebServlet;
import javax.servlet.http.HttpServlet;
import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;
import javax.servlet.http.HttpSession;
import model.UserModel;
import model.studentActivity;

@WebServlet(urlPatterns = {"/RegisterController"})
public class RegisterController extends HttpServlet {

    protected void processRequest(HttpServletRequest request, HttpServletResponse response)
            throws ServletException, IOException {
        response.setContentType("text/html;charset=UTF-8");
        try (PrintWriter out = response.getWriter()) {
            HttpSession session = request.getSession();
            session.setMaxInactiveInterval(100000000);
            model.UserModel user = new UserModel();
            user.setEmail(request.getParameter("email"));
            user.setPassword(request.getParameter("pass"));

            if (request.getParameter("register").equals("signup")) {
                session.setAttribute("type", -1);
                user.setFName(request.getParameter("name"));
                user.setMobile(request.getParameter("mobile"));
                user.setLName(request.getParameter("lName"));
                user.setAddress(request.getParameter("address"));
                user.setGender(request.getParameter("gender"));
                user.setDay(Integer.parseInt(request.getParameter("day")));
                user.setMonth(Integer.parseInt(request.getParameter("month")));
                user.setYear(Integer.parseInt(request.getParameter("year")));
                boolean ok = user.signUp(user);
                if (ok) {
                    session.setAttribute("uID", user.getID(request.getParameter("email")));
                    session.setAttribute("type", -1);
                    response.sendRedirect("skills.jsp");
                    session.setAttribute("type", user.GetType(user));
                    session.setAttribute("Fname", user.getName(request.getParameter("email")));
                    session.setAttribute("profile", user.getphotoP(request.getParameter("email")));
                    session.setAttribute("user", user.GetInformation(request.getParameter("email")));
//                    session.setAttribute(null, out);

                    session.setAttribute("SAID", 0);
                    session.setAttribute("depID", 0);

                } else {
                    response.sendRedirect("register.html");
                }
            } else if (request.getParameter("register").equals("login")) {
                boolean ok = user.login(user);
                if (ok) {
                    int iiii = user.getID(request.getParameter("email"));
                    session.setAttribute("uID", user.getID(request.getParameter("email")));
                    session.setAttribute("type", user.GetType(user));
                    if (Integer.parseInt(String.valueOf(session.getAttribute("type"))) == -1) {

                        session.setAttribute("SAID", 0);
                        session.setAttribute("depID", 0);
                        
                            session.setAttribute("CheckDep", 0);
                    } else {
                        studentActivity SA = new studentActivity();
                        ArrayList<Integer> SA_DEP = new ArrayList<>();
                        SA_DEP = SA.GetDepSA(Integer.parseInt(String.valueOf(session.getAttribute("uID"))));
//            = st.executeQuery(sql);
                        int depiD = 0;
                        int SAiD = 0;
                        if (!SA_DEP.isEmpty()) {
                            depiD = SA_DEP.get(1);
                            SAiD = SA_DEP.get(0);
                           
                        }
                         session.setAttribute("SAID", String.valueOf(SAiD));
                            session.setAttribute("depID", String.valueOf(depiD));
                            session.setAttribute("CheckDep", String.valueOf(depiD));

                    }
                    session.setAttribute("Fname", user.getName(request.getParameter("email")));
                    session.setAttribute("profile", user.getphotoP(request.getParameter("email")));
                    session.setAttribute("user", user.GetInformation(request.getParameter("email")));
 
                    response.sendRedirect("HomePage.jsp");
                } else {
                    response.sendRedirect("register.html");
                }
            } 
            else if (request.getParameter("register").equals("Next")) {
                String[] skill = request.getParameterValues("skill");
                ArrayList<Integer> skills = new ArrayList<>();

                for (int i = 0; i < skill.length; i++) {
                    if(!skill[i].equals(0)){
                    skills.add(Integer.parseInt(skill[i]));}
                }
                user.setSkills(skills);
                user.addSkills(Integer.parseInt(String.valueOf(session.getAttribute("uID"))));

                response.sendRedirect("HomePage.jsp");
            }

        } catch (Exception e) {
            System.out.println("error");
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
