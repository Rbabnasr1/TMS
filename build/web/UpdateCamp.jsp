<%-- 
    Document   : UpdateCamp
    Created on : 21-Mar-2017, 12:11:50
    Author     : mena
--%>

<%@page import="model.Notification"%>
<%@page import="java.util.ArrayList"%>
<%@page import="java.sql.ResultSet"%>
<%@page import="java.sql.Statement"%>
<%@page import="java.sql.DriverManager"%>
<%@page import="java.sql.Connection"%>
<%@page contentType="text/html" pageEncoding="UTF-8"%>
<!DOCTYPE html>
<html>
    <head>
        <meta http-equiv="Content-Type" content="text/html; charset=UTF-8">
        <title>JSP Page</title>
        <link rel="stylesheet" href="css/Charts.css">
        <link rel="stylesheet" href="css/updateCamp.css">
        
    </head>
    <body>
        <ul class="header">
            <li class="log" style="float: right">

                <a  href="register.html" name="logout"value="logout" class="logout"  >logout</a> 

            </li>
            <li style="float: left"  >
                <a  href="#" class="logo" ></a> 

            </li>



            <li class="searchList"style="padding: 15px 40px ;">

                <div class="List">
                    <input type="search" class ="search" name="name" placeholder="search..." id="Listbtn" autocomplete="off" onkeyup="ShowData(this.value);">
                    <div class="List-content" id="mydiv" style="position: absolute;z-index: 1; ">
                    </div>
                </div> 
            </li>



            <li style="float: right">
                <div class="List" >
                    <button class="Listbtn" ></button>
                    <div class="List-Notification" style="margin: -10px 0 0 0" >

                        <%
                            model.Notification notify = new Notification();
                            ArrayList<String> notifi = new ArrayList<String>();
                            notifi = notify.AllNotify(Integer.parseInt(String.valueOf(session.getAttribute("uID"))), Integer.parseInt(String.valueOf(session.getAttribute("SAID"))), Integer.parseInt(String.valueOf(session.getAttribute("depID"))), Integer.parseInt(String.valueOf(session.getAttribute("type"))));
                            for (int i = 0; i < notifi.size(); i++) {
                                out.print(notifi.get(i));
                            }

                        %>

                    </div>
                    <span class="numberOfNotif"  ><% if (!notifi.get(0).equals("<a class=noti href=#>Don`t have Notifications </a>")) {
                            out.print(notifi.size());
                        }
                        %></span>

                </div>

            </li>
            <li style="float: right">
                <a class="element" title="profile"id="iconProfile" href="profile.jsp?param1=<%= session.getAttribute("uID")%>&param2=<%= session.getAttribute("profile")%>"></a>

            </li>
            <li style="float: right">
                <a class="element" title="Home" id="iconHome"  href="HomePage.jsp"></a>

            </li >



        </ul>
        <h1>Update Campaign</h1>
<div class="infoCamp">        
<form action ="campaginController">
        <%
        String campName = (String) session.getAttribute("CampName");
         int ID =Integer.parseInt(String.valueOf(session.getAttribute("CampID")));
//          out.print(session.getAttribute("CampName"));
         String URL = "jdbc:mysql://localhost:3306/orgi";
                Class.forName("com.mysql.jdbc.Driver");
                Connection con = DriverManager.getConnection(URL, "root", "root");
                Statement st = con.createStatement();
                String sql = "select * from campagin where ID ="+ID ;
                ResultSet rs = st.executeQuery(sql);
                while (rs.next())
                {
                    %>
                    <table class="table1">
                        <tr>  <td> Current Name:</td>
                            <td>
                            <%
                    out.print(rs.getString("Name"));
                    %></td>
                        </tr>    <tr>  <td> New Name: </td> <td>  <input type="text" name="campName" >  </td> </tr>
                   
                        <tr>  <td>Current Description:  </td>
                            <td>
                     <%
                    out.print(rs.getString("Description"));
                    %>
                    </td>
                        </tr>   <tr>  <td> New Description : </td>  <td> <input type="text" name="campDesc" ></td> </tr>
                        <tr>  <td> Current Start Date: </td>
                            <td>
                    <%
                    out.print(rs.getString("startDate"));
                    %>
                    </td>
                        </tr>  <tr>  <td>  New Start Date :  </td> <td> <input type="date" name="campSD" > </td> </tr>
                        <tr>   <td> Current End Date:  </td>
                            <td>
                    <%
                    out.print(rs.getString("endDate"));
                    %>
                            </td>
                            
                        </tr>  <tr> <td> New End Date :  </td> <td> <input type="date" name="campED" > </td></tr>
                        <tr>  <td> Current Start Time:  </td>
                            <td>
                    <%
                    out.print(rs.getString("startTime"));
                    %>
                            </td>
                        </tr>  <tr> <td>New Start Time : </td> <td>  <input type="time" name="campST" > </td> </tr>
                        <tr> <td> Current End Time:  </td>
                            <td>
                    <%
                    out.print(rs.getString("endTime"));
                    %>
                            </td>
                        </tr>  <tr> <td>New End Time :</td> <td>  <input type="time" name="campET" > </td> </tr>
                    <%
                }
                con.close();
               
        %>
                       </table>  <button class="butns"name="type" value="UpdateCamp">Save</button>  
        </form>
         </div>
    </body>
</html>
