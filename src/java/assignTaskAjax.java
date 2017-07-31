
import com.mysql.jdbc.ResultSetMetaData;
import java.io.IOException;
import java.io.PrintWriter;
import java.sql.Connection;
import java.sql.DriverManager;
import java.sql.ResultSet;
import java.sql.SQLException;
import java.sql.Statement;
import java.util.ArrayList;
import java.util.logging.Level;
import java.util.logging.Logger;
import javax.servlet.ServletException;
import javax.servlet.annotation.WebServlet;
import javax.servlet.http.HttpServlet;
import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;
import javax.servlet.http.HttpSession;

@WebServlet(urlPatterns = {"/assignTaskAjax"})
public class assignTaskAjax extends HttpServlet {

    protected void processRequest(HttpServletRequest request, HttpServletResponse response)
            throws ServletException, IOException, ClassNotFoundException, SQLException {
        response.setContentType("text/html;charset=UTF-8");
        try (PrintWriter out = response.getWriter()) {
          
            
            String URL = "jdbc:mysql://localhost:3306/orgi";
            Class.forName("com.mysql.jdbc.Driver");
            HttpSession session = request.getSession();
            session.setMaxInactiveInterval(100000000);
            Connection con = DriverManager.getConnection(URL, "root", "root");
            Statement st = con.createStatement();
//                        String sql = "select * from account , acc_dep_sa where Dep_ID = " + session.getAttribute("depID") + " and Acc_ID = ID and type = 0";
            String sql = "select skill_ID from task_skill  where task_ID = " + session.getAttribute("TaskID");
//
            ResultSet rs = st.executeQuery(sql);
            ArrayList<Integer> SkillID = new ArrayList<Integer>();
            while (rs.next()) {

                SkillID.add(rs.getInt("skill_ID"));
            }
            con.close();
            con = DriverManager.getConnection(URL, "root", "root");
            st = con.createStatement();
            if(request.getParameter("param").equals("dep")){
//                        String sql = "select * from account , acc_dep_sa where Dep_ID = " + session.getAttribute("depID") + " and Acc_ID = ID and type = 0";
            sql = "select email,skill_ID,FName , skills.skill from acc_skill , account ,skills "
                    + " where acc_ID = account.ID and skills.ID = acc_skill.skill_ID and   account.ID in ( select account.ID from account , acc_dep_sa"
                    + " where Acc_ID = ID and Dep_ID = " + session.getAttribute("depID") + " and type = "
                    +request.getParameter("name2")+")";
            }else{
            sql = "select email,skill_ID,FName , skills.skill from acc_skill , account ,skills "
                                + " where acc_ID = account.ID and skills.ID = acc_skill.skill_ID and   account.ID in ( select account.ID from account , acc_dep_sa"
                                + " where Acc_ID = ID  and type = "+request.getParameter("name2")+" and SA_ID in(select SA_ID from campagin where ID=" + session.getAttribute("CampID") + "))";

            }
            rs = st.executeQuery(sql);
            ArrayList<String> NameMemebr = new ArrayList<String>();
            ArrayList<Integer> NumberOfSkills = new ArrayList<Integer>();
            ArrayList<String> mails = new ArrayList<String>();
            while (rs.next()) {
                String k = rs.getString("FName");
                String mail = rs.getString("email");
                int s = rs.getInt("skill_ID");
                if (NameMemebr.size() == 0) {
                    NameMemebr.add(k);
                    NumberOfSkills.add(0);
                    mails.add(mail);
                }
           
                for (int i = 0; i < NameMemebr.size(); i++) {

                    if (mails.get(i).equals(mail)) {
                        for (int j = 0; j < SkillID.size(); j++) {
                            if (SkillID.get(j).equals(s)) {
                                int count = NumberOfSkills.get(i);
                                count++;
                                out.print(count);
                                NumberOfSkills.add(i, count);

                            }
                        }
                    }
                }
                if (!mails.contains(mail)) {
                    NameMemebr.add(k);
                    mails.add(mail);
                    NumberOfSkills.add(0);
                    for (int i = 0; i < NameMemebr.size(); i++) {
                        for (int j = 0; j < SkillID.size(); j++) {
                            if (SkillID.get(j).equals(s)) {
                                int count = NumberOfSkills.get(i);
                                NumberOfSkills.set(i, ++count);

                            }
                        }
                    }
                }
            }
            con.close();
            for (int p = 0; p < NameMemebr.size() - 1; p++) {
                for (int d = p + 1; d < NumberOfSkills.size() - 1; d++) {
                    if (NumberOfSkills.get(p) < NumberOfSkills.get(d)) {
                        int skil = NumberOfSkills.get(d);
                        String memberName = NameMemebr.get(d);
                        String mail = mails.get(d);
                        NameMemebr.set(d, NameMemebr.get(p));
                        NumberOfSkills.set(d, NumberOfSkills.get(p));
                        mails.set(d, mails.get(p));
                        NameMemebr.set(p, memberName);
                        NumberOfSkills.set(p, skil);
                        mails.set(p, mail);

                    }
                }
            }
             String buffer = "";
            for (int i = 0; i < NameMemebr.size(); i++) {
                if (NumberOfSkills.get(i) > 0) { 
                  buffer+=" <option value = "+ mails.get(i) +">"+ NameMemebr.get(i) +"</option>" ;
                } else {
                   buffer+=" <option value = "+ mails.get(i) +">"+ NameMemebr.get(i) +"</option>" ;
                }
            }
         response.getWriter().println(buffer);    
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
            Logger.getLogger(assignTaskAjax.class.getName()).log(Level.SEVERE, null, ex);
        } catch (SQLException ex) {
            Logger.getLogger(assignTaskAjax.class.getName()).log(Level.SEVERE, null, ex);
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
            Logger.getLogger(assignTaskAjax.class.getName()).log(Level.SEVERE, null, ex);
        } catch (SQLException ex) {
            Logger.getLogger(assignTaskAjax.class.getName()).log(Level.SEVERE, null, ex);
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
