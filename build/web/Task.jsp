<%-- 
    Document   : Task
    Created on : 17-Dec-2016, 12:28:12
    Author     : rabab
--%>

<%@page import="model.Department"%>
<%@page import="model.studentActivity"%>
<%@page import="model.taskModel"%>
<%@page import="model.Notification"%>
<%@page import="java.util.ArrayList"%>
<%@page import="java.sql.ResultSet"%>
<%@page import="java.sql.Statement"%>
<%@page import="java.sql.DriverManager"%>
<%@page import="java.sql.Connection"%>
<%@page import="java.io.PrintWriter"%>
<%@page contentType="text/html" pageEncoding="UTF-8"%>
<!DOCTYPE html>
<html> 
    <head>

        <meta http-equiv="Content-Type" content="text/html; charset=UTF-8">
        <title>JSP Page</title>
        <script type="text/javascript" src="js/Task.js"></script>
        <link rel="stylesheet" href="css/styleTask.css">
        <link rel="stylesheet" href="css/Rating.css">

        <script>


            function ShowData2(value) {
                xmlHttp = GetXmlHttpObject();
//                alert(value);
                var url = "Search";
                url = url + "?name=" + value;
//                alert(url);
                xmlHttp.onreadystatechange = stateChanged2
                xmlHttp.open("GET", url, true)
                xmlHttp.send(null)

            }
            function stateChanged2() {
                if (xmlHttp.readyState == 4 || xmlHttp.readyState == "complete") {

                    var Showdata = xmlHttp.responseText;
                    document.getElementById("mydiv").innerHTML = Showdata;
                }


            }
            function GetXmlHttpObject() {

                var xmlHttp = null;
                try {
                    xmlHttp = new XMLHttpRequest();
                }


                catch (e) {
                    try {
                        xmlHttp = new ActiveXObject("Msxm12.XMLHTTP");
                    }
                    catch (e) {
                        xmlHttp = new ActiveXObject("Microsoft.XMLHTTP");
                    }
                }
                return xmlHttp;
            }



            function ShowData(value) {
                xmlHttp = GetXmlHttpObject();
                var url = "assignTaskAjax";
                url = url + "?name2=" + value + "&param=dep";

//        alert(url);
                xmlHttp.onreadystatechange = stateChanged
                xmlHttp.open("GET", url, true)
                xmlHttp.send(null)

            }
            function stateChanged() {
                if (xmlHttp.readyState == 4 || xmlHttp.readyState == "complete") {

                    var Showdata = xmlHttp.responseText;
                    document.getElementById("memberMail").style.display = '';
                    document.getElementById("memberMail").innerHTML = Showdata;

//            alert(ShowData());
                    if (document.getElementById('position').value.includes('8')) {
                        document.getElementById("memberMail").style.display = 'none';
                    }

                }


            }
            function GetXmlHttpObject() {

                var xmlHttp = null;
                try {
                    xmlHttp = new XMLHttpRequest();
                }


                catch (e) {
                    try {
                        xmlHttp = new ActiveXObject("Msxm12.XMLHTTP");
                    }
                    catch (e) {
                        xmlHttp = new ActiveXObject("Microsoft.XMLHTTP");

                    }
                }
                return xmlHttp;
            }





        </script>

        <link rel="stylesheet" href="css/Charts.css">

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
                    <input type="search" class ="search" name="name" placeholder="search..." id="Listbtn" autocomplete="off" onkeyup="ShowData2(this.value);">
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

        <%int depiD = 0;
            int SAiD = 0;

            studentActivity SA = new studentActivity();
            ArrayList<Integer> SA_DEP = new ArrayList<Integer>();
            SA_DEP = SA.GetDepSA(Integer.parseInt(String.valueOf(session.getAttribute("uID"))));

            if (!SA_DEP.isEmpty()) {
                depiD = SA_DEP.get(1);
                SAiD = SA_DEP.get(0);

            }

            boolean Owner = false;
            boolean persidnt = false;

            boolean Head_Dep = false;
            taskModel taskA = new taskModel();
            Owner = taskA.CheckTtaskSA_ID(Integer.parseInt(String.valueOf(session.getAttribute("TaskID"))), SAiD);
            persidnt = SA.GetPer(Integer.parseInt(String.valueOf(session.getAttribute("uID"))), SAiD);
            Head_Dep = taskA.CheckTtask_ID(Integer.parseInt(String.valueOf(session.getAttribute("TaskID"))), depiD);
        %>

        <h1 style="font-size: 40px; color:#0a426c ;text-align: center;text-transform: capitalize"> 
            <%
                out.print(session.getAttribute("Task_name"));

            %></h1><br><br>
        <div class="Task_Details">

            <table>
                <% String URL = "jdbc:mysql://localhost:3306/orgi";
                    Class.forName("com.mysql.jdbc.Driver");
                    String color = "green";
                    Connection con = DriverManager.getConnection(URL, "root", "root");
                    Statement st = con.createStatement();
                    String sql = "SELECT FName,ID FROM orgi.acc_dep_task , account where ID=Acc_ID and Task_ID=" + session.getAttribute("TaskID");
                    ResultSet rs = st.executeQuery(sql);
                    while (rs.next()) {

                %>
                <tr><td>Worked on by :</td><td style="text-transform: capitalize" ><%=rs.getString("FName")%></td></tr>

                <%        }con.close();

                %>
                <tr><td>Task Description  :</td><td><%= session.getAttribute("Task_des")%></td></tr>
                <tr><td>Task Start Date :</td><td><%=session.getAttribute("Task_Sd")%></td></tr>
                <tr><td>Task End Date  :</td><td><%=session.getAttribute("Task_Ed")%></td></tr>

                <%   if (persidnt || Head_Dep) {%>
                <tr><td>Task Assignment File:  </td>  <td><a download href="<%="file\\" + session.getAttribute("Task_File")%>" class="FileTask" title="<%=session.getAttribute("Task_File")%>"></td></a></tr>

                <tr> <% if (session.getAttribute("Worked_File") != null) {%><td>Task Completion File:</td><td> <a download href="<%="file\\" + session.getAttribute("worked_File")%>"class="FileTask" title="<%=session.getAttribute("Task_File")%>"><%}%></td></a></tr>
                <%
                    }%>

            </table>
        </div>
        <h1><%  if (request.getParameter("param1") != null) {
                session.setAttribute("TaskName", request.getParameter("param1"));
                session.setAttribute("TaskID", Integer.parseInt(request.getParameter("param2")));
                session.setAttribute("percentage", request.getParameter("param3"));
                session.setAttribute("Task_File", request.getParameter("param5"));
                color = request.getParameter("param6");

            }

            %>


            <%if (session.getAttribute("assign").equals("true")) {%>
            <div class="progressBarSt">
                <h style="color: #062d4a; font-size: 30px;"><%="Task Progress"%></h>
                <div class="progress-bar <%= session.getAttribute("color")%> stripes" >
                    <span  id="s" class="w" style="width :<%= session.getAttribute("percentage") + "%"%>"></span>
                </div>
                <% } %>
                <%
                    if (session.getAttribute("type").equals(1) || (session.getAttribute("type").equals(2))) {
                        if (persidnt || Head_Dep) {

                            if (session.getAttribute("assign").equals("false")) {%>
                <div class="progressBarSt">
                    <form action="assignTask?param1=assignD" method="post">

                        <select name="name1" id="position" onchange="ShowData(this.value);">
                            <option value="8">Choose a position</option>
                            <%if (session.getAttribute("type").equals(1)) {%>        <option value="2"  >Head</option><%}%>
                            <option value="0">Member</option>    
                            <br></select>
                        <select name="memberMail" id="memberMail" style="display: none">

                        </select>
                        <input type="submit" class="rateTask" style="right: 0;font-size: 15px" name="assign" value="Assign">
                    </form>
                </div>
                <% }
                        }
                    }
                    if (session.getAttribute("type").equals(0) || session.getAttribute("type").equals(2)) {

                        if (session.getAttribute("assign").equals("true")) {

                            if (session.getAttribute("ID").equals(session.getAttribute("uID"))) {%>
                <form action="Edit?param1=EditD" method="post" enctype="multipart/form-data">
                    <input type="radio" class="rate" name="rate" value="25"  onclick="return change25();" required/>25%
                    <br> <input type="radio" name="rate" value="50" onclick="return change50();" required/>50%
                    <br> <input type="radio" name="rate" value="75"  onclick="return change75();"required/>75%
                    <br><input type="radio" name="rate" value="100"  onclick="return change100();"required/>100%
                    <br><input type="file"  name="workedFile"  required/>

                    <br><input type="submit" class="rateTask" value="Save" >

                </form> </div>
                <% }
                        }
                    }

                %>

            <% if (session.getAttribute("type").equals(1) || session.getAttribute("type").equals(2)) {
                    if (persidnt || Head_Dep) {

                        if (session.getAttribute("percentage").equals("100")) {
                            if (session.getAttribute("rated").equals("false")) {

            %>


            <form action="Rate?param1=depTask"  method="post" class="progressBarSt">
                <fieldset>
                    <span class="star-cb-group">
                        <input type="radio" id="rating-5" name="rating" value="5" />
                        <label for="rating-5">5</label>
                        <input type="radio" id="rating-4" name="rating" value="4" checked="checked" />
                        <label for="rating-4">4</label>
                        <input type="radio" id="rating-3" name="rating" value="3" />
                        <label for="rating-3">3</label>
                        <input type="radio" id="rating-2" name="rating" value="2" />
                        <label for="rating-2">2</label>
                        <input type="radio" id="rating-1" name="rating" value="1"/>
                        <label for="rating-1">1</label>
                        <input type="radio" id="rating-0" name="rating" value="0" class="star-cb-clear" />
                        <label for="rating-0">0</label>
                    </span>
                </fieldset>


                <input type="submit" id="ate" class="rateTask" style="right: -400px" name = "ate" value="Evaluate" />
            </form>
            <%}
                        }
                    }
                }%>




    </body>
</html>
