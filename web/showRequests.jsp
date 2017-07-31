<%-- 
    Document   : showRequests
    Created on : 20-Apr-2017, 17:09:51
    Author     : mena
--%>

<%@page import="java.util.ArrayList"%>
<%@page import="model.Notification"%>
<%@page import="java.sql.ResultSet"%>
<%@page import="java.sql.Statement"%>
<%@page import="java.sql.DriverManager"%>
<%@page import="java.sql.Connection"%>
<%@page contentType="text/html" pageEncoding="UTF-8"%>
<!DOCTYPE html>
<html>
    <head>
        <link rel="stylesheet" href="css/General.css">
        <link rel="stylesheet" href="css/Charts.css">
        <link rel="stylesheet" href="css/ShowReq.css">
        <meta http-equiv="Content-Type" content="text/html; charset=UTF-8">
        <title>JSP Page</title>
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

                <div class="List" style="position: absolute;z-index: 2; ">
                    <input type="search" class ="search" name="name" placeholder="search..." id="Listbtn" autocomplete="off" onkeyup="ShowData(this.value);">
                    <div class="List-content" id="mydiv" style="position: absolute;z-index: 2; ">
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

        
        
               
        
        
<!--        <form action="register.html">
            <input type="submit" name="logout"value="logout" style="margin-left: 1350px ;"><br>
        </form>-->
        <%
         String URL = "jdbc:mysql://localhost:3306/orgi";
                Class.forName("com.mysql.jdbc.Driver");
                Connection con = DriverManager.getConnection(URL, "root", "root");
                Statement st = con.createStatement();
               String sql = "select email , ID from acc_dep_sa , account where SA_ID ="+ session.getAttribute("SAID") +" and requested = 0 and Acc_ID = ID ";
               ResultSet rs = st.executeQuery(sql);
               while(rs.next())
               {%> <br><div class="containReq" > 
                   <p><%
                   String email = rs.getString("email");
                   out.print(email);
                   %></p>
                   
                           <form action="StudentActivityController">
                               <button name="studentActivity" value="accept_<%=rs.getInt("ID")%>">Accept</button>
                               <button name="studentActivity" value="Ignore_<%=rs.getInt("ID")%>">Ignore</button>
                           </form>
               </div><br>
        <%    
               }con.close();
       %>
    </body>
</html>
