<%-- 
    Document   : UpdateDep
    Created on : 24-Jan-2017, 15:33:33
    Author     : rabab
--%>

<%@page import="java.util.ArrayList"%>
<%@page import="model.Notification"%>
<%@page contentType="text/html" pageEncoding="UTF-8"%>
<!DOCTYPE html>
<html>
    <head>
        <meta http-equiv="Content-Type" content="text/html; charset=UTF-8">
        <title>JSP Page</title>
        <link rel="stylesheet" href="css/Charts.css">
        <link rel="stylesheet" href="css/Update.css">

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
                </form>
        -->

        <form action="Departments" method="post">
            
                <h1>Update Department <%= session.getAttribute("depName")%></h1>
                <div class="infor" ><table><tr><td> New Name </td><td><input type="text" name="name" placeholder="Enter New Name"/><br>
                        </td></tr><tr><td>New Target Plan</td><td> <input type="text" name="targ" placeholder="Enter New Target Plan"/>
                        </td></tr><br><button class="btnU"name="type" value="update">Update</button>
                        <%--<%= session.getAttribute("depID") %>--%>
            </table>
        </form>
    </div>
</body>
</html>
