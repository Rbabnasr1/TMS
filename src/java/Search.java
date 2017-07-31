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
import java.util.ArrayList;
import java.util.Calendar;
import java.util.Date;
import java.util.logging.Level;
import java.util.logging.Logger;
import javax.servlet.ServletException;
import javax.servlet.annotation.WebServlet;
import javax.servlet.http.HttpServlet;
import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;
import javax.servlet.http.HttpSession;
import model.UserModel;

/**
 *
 * @author rabab
 */
@WebServlet(urlPatterns = {"/Search"})
public class Search extends HttpServlet {

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

            String name = request.getParameter("name").toString();
            String buffer = "";
            ResultSet rs;
            String sql;
            try {
                HttpSession session = request.getSession();
                String URL = "jdbc:mysql://localhost:3306/orgi";
                Class.forName("com.mysql.jdbc.Driver");
                Connection con = DriverManager.getConnection(URL, "root", "root");
                Statement st;
                ///////////////////////////////////////////////////////////////// account
                if (!name.equals("")) {
                    st = con.createStatement();
                    sql = "select * from account  where FName like '" + name + "%'";
                    rs = st.executeQuery(sql);
                    UserModel user = new UserModel();
                    while (rs.next()) {
                        user.setID(rs.getInt("ID"));

                        user.setFName(rs.getString("FName"));
                        user.setLName(rs.getString("LName"));
                        user.setEmail(rs.getString("email"));
                        user.setDay(rs.getInt("day"));
                        user.setMonth(rs.getInt("month"));
                        user.setYear(rs.getInt("year"));
                        user.setMobile(rs.getString("mobile"));
                        user.setPassword(rs.getString("password"));
                        user.setAddress(rs.getString("address"));
                        user.setType(rs.getInt("type"));
                        user.setGender(rs.getString("gender"));
                        user.setEvaluation(rs.getInt("evaluations"));
                        user.setPhoto(rs.getString("photo"));
//                        String b = "<a href=profile.jsp?param1=" + rs.getInt("ID") + "&param3="+ user+">" + rs.getString("FName") + "</a><br>";

                        String b = "<a class=searchContent href=profile.jsp?param1=" + rs.getInt("ID") + "&param2=" + rs.getString("photo") + ">" + rs.getString("FName") + "</a>";
                        buffer = buffer + b;

                    }
con.close();
                }
                ////////////////////////////////////////////////// SA
                if (!name.equals("")) {
 con = DriverManager.getConnection(URL, "root", "root");
                    st = con.createStatement();
                    sql = "select * from studentactivity  where Name like '" + name + "%' ";
                    rs = st.executeQuery(sql);
                    while (rs.next()) {

                        String b = "<a class=searchContent href=SA.jsp?param1=" + rs.getString("Name").replace(" ", "+") + "&param2=" + rs.getInt("ID") + "&param3=" + rs.getString("creationDate") + "&param4=" + rs.getString("cover") + ">" + rs.getString("Name") + "</a>";

                        buffer = buffer + b;
                    }
                    con.close();
                }
                /////////////////////////////////////////////// Dep
                if (!name.equals("")) {
                     con = DriverManager.getConnection(URL, "root", "root");
                    st = con.createStatement();
                    sql = "select * from departement  where Name like '" + name + "%'";
                    rs = st.executeQuery(sql);
                    while (rs.next()) {
                        String name2 = rs.getString("Name").replace(" ", "+");

//            String b="<a href=dep.jsp?param1="+rs.getString("Name")+"&param2="+rs.getInt("ID")+">"+rs.getString("Name")+rs.getInt("ID")+"</a><br>";
                        String b = "<a class=searchContent href=dep.jsp?param1=" + name2 + "&param2=" + rs.getInt("ID") + ">" + rs.getString("Name")+"</a>";

                        buffer = buffer + b;
                    }
                    con.close();
                }
                /////////////////////////////////////////////////// Camp
                if (!name.equals("")) { con = DriverManager.getConnection(URL, "root", "root");
                    st = con.createStatement();
                    sql = "select * from campagin where Name like '" + name + "%'";
                    rs = st.executeQuery(sql);
                    while (rs.next()) {
                        String b = "<a class=searchContent href=campaign.jsp?param1=" + rs.getString("Name").replace(" ", "+") + "&param2=" + rs.getInt("ID") + ">" + rs.getString("Name") + "</a>";
                        buffer = buffer + b;
                    }
                    con.close();
                }

                ///////////////////////////////////////////////////////////////////////////////// tasks
                if (!name.equals("")) {
                     con = DriverManager.getConnection(URL, "root", "root");
                    st = con.createStatement();
                    sql = "select * from task , acc_dep_task where Name like '" + name + "%' and ID=Task_ID";
                    rs = st.executeQuery(sql);
                    while (rs.next()) {
                        int monthConsEnd;
                        int monthConsStrt;
                        int monthConsCur;
                        String str = rs.getString("startDate");
                        String str1[] = str.split("-");
                        String end = rs.getString("endDate");
                        String end1[] = end.split("-");

                        if (Integer.parseInt(end1[1]) <= 7) {
                            if (Integer.parseInt(end1[1]) == 2) {
                                monthConsEnd = 28;

                            } else if (Integer.parseInt(end1[1]) % 2 == 0) {
                                monthConsEnd = 30;
                            } else {
                                monthConsEnd = 31;
                            }

                        } else {
                            if (Integer.parseInt(end1[1]) % 2 == 0) {
                                monthConsEnd = 31;
                            } else {
                                monthConsEnd = 30;
                            }

                        }

//            out.print("end : " + monthConsEnd + "<br>");
                        if (Integer.parseInt(str1[1]) <= 7) {
                            if (Integer.parseInt(str1[1]) == 2) {
                                monthConsStrt = 28;
                            } else if (Integer.parseInt(str1[1]) % 2 == 0) {
                                monthConsStrt = 30;
                            } else {
                                monthConsStrt = 31;
                            }

                        } else {
                            if (Integer.parseInt(str1[1]) % 2 == 0) {
                                monthConsStrt = 31;
                            } else {
                                monthConsStrt = 30;
                            }

                        }
//            out.print(monthConsStrt);
                        int durYear = (Integer.parseInt(end1[0]) - Integer.parseInt(str1[0])) * 365;

                        int durMonth;
                        int durDay;
                        int durMonthCur;
                        int durDayCur;

                        Date date = new Date();
                        Calendar cal = Calendar.getInstance();
                        cal.setTime(date);
                        String year = String.valueOf(cal.get(Calendar.YEAR));
                        String month = String.valueOf(cal.get(Calendar.MONTH) + 1);
                        String day = String.valueOf(cal.get(Calendar.DAY_OF_MONTH));

                        if (Integer.parseInt(month) <= 7) {
                            if (Integer.parseInt(month) == 2) {
                                monthConsCur = 28;
                            } else if (Integer.parseInt(month) % 2 == 0) {
                                monthConsCur = 30;
                            } else {
                                monthConsCur = 31;
                            }

                        } else {
                            if (Integer.parseInt(month) % 2 == 0) {
                                monthConsCur = 31;
                            } else {
                                monthConsCur = 30;
                            }

                        }

                        int durYearCur = (Integer.parseInt(end1[0]) - Integer.parseInt(year)) * 365;

                        if (durYear == 0) {
                            if (monthConsEnd <= monthConsStrt) {
                                durDay = (Integer.parseInt(end1[2]) - Integer.parseInt(str1[2]));
                                durMonth = ((Integer.parseInt(end1[1]) - Integer.parseInt(str1[1]))) * monthConsStrt;
                            } else {

                                durDay = (Integer.parseInt(end1[2]) - Integer.parseInt(str1[2]));
                                durMonth = ((Integer.parseInt(end1[1]) - Integer.parseInt(str1[1]))) * monthConsEnd;

                            }
                        } else {
                            if (monthConsEnd <= monthConsStrt) {
                                durDay = ((Integer.parseInt(end1[2])) - Integer.parseInt(str1[2]));
                                durMonth = ((Integer.parseInt(end1[1] + 12) * -(Integer.parseInt(str1[1]))) * monthConsStrt);
                            } else {
                                durDay = ((Integer.parseInt(end1[2])) - Integer.parseInt(str1[2]));
                                durMonth = ((Integer.parseInt(end1[1] + 12) * -(Integer.parseInt(str1[1]))) * monthConsEnd);

                            }
                        }

                        if (durYearCur == 0) {
                            if (monthConsEnd <= monthConsCur) {
                                durDayCur = (Integer.parseInt(end1[2]) - Integer.parseInt(day));
                                durMonthCur = (Integer.parseInt(end1[1]) - Integer.parseInt(month)) * monthConsCur;
                            } else {
                                durDayCur = (Integer.parseInt(end1[2]) - Integer.parseInt(day));
                                durMonthCur = (Integer.parseInt(end1[1]) - Integer.parseInt(month)) * monthConsEnd;
                            }
                        } else {
                            if (monthConsEnd <= monthConsCur) {
                                durDayCur = ((Integer.parseInt(end1[2])) - Integer.parseInt(day));
                                durMonthCur = (Integer.parseInt(end1[1] + 12) - Integer.parseInt(month)) * monthConsCur;
                            } else {
                                durDayCur = (Integer.parseInt(end1[2]) - Integer.parseInt(day));
                                durMonthCur = (Integer.parseInt(end1[1] + 12) - Integer.parseInt(month)) * monthConsEnd;
                            }
                        }

                        int Duration = durDay + durMonth + durYear;
                        int DurationCur = durMonthCur + durYearCur + durDayCur;
                        String color = "green";

                        if (rs.getInt("percentage") == 100) {
                            color = "mediumvioletred";
                        } else if (DurationCur <= 1) {
                            color = "red";

                        } else if ((Duration / 2) - 1 == DurationCur || (Duration / 2) == DurationCur || (Duration / 2) + 1 == DurationCur) {
                            color = "yellow";
                        } else {
                            color = "green";
                        }

                        String b = "<a class=searchContent href=dep?param1=" + rs.getString("Name").replace(" ", "+") + "&param2=" + rs.getInt("ID") + "&param4=search" + "&param6=" + color + ">" + rs.getString("Name") + "</a>";
                        buffer = buffer + b;
                    }
                    con.close();
                }

//           if(!name.equals("")){
//          st = con.createStatement();
//        sql = "select * from account where Name like '"+name+"%'";
//         rs = st.executeQuery(sql);
//        while(rs.next()){
//             String b="<a href=profile.jsp?param1="+rs.getInt("ID")+">"+rs.getString("Name")+"</a><br>";
//              buffer=buffer+b;
//        }}
                response.getWriter().println(buffer);

            } catch (Exception e) {
                System.out.println(e);
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
            Logger.getLogger(Search.class.getName()).log(Level.SEVERE, null, ex);
        } catch (SQLException ex) {
            Logger.getLogger(Search.class.getName()).log(Level.SEVERE, null, ex);
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
            Logger.getLogger(Search.class.getName()).log(Level.SEVERE, null, ex);
        } catch (SQLException ex) {
            Logger.getLogger(Search.class.getName()).log(Level.SEVERE, null, ex);
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
