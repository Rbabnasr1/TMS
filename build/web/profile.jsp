<%@page import="model.Report"%>
<%@page import="model.UserModel"%>
<%@page import="model.studentActivity"%>
<%@page import="model.Department"%>
<%@page import="java.util.Locale"%>
<%@page import="java.util.Calendar"%>
<%@page import="java.util.Date"%>
<%@page import="model.Notification"%>
<%@page import="java.util.ArrayList"%>
<%@page import="java.sql.DriverManager"%>
<%@page import="java.sql.ResultSet"%>
<%@page import="java.sql.Statement"%>
<%@page import="java.sql.Connection"%>  
<%@page contentType="text/html" pageEncoding="UTF-8"%>
<!DOCTYPE html>
<html>
    <head>
        <meta http-equiv="Content-Type" content="text/html; charset=UTF-8">
        <title>JSP Page</title>
        <script type="text/javascript" src="http://www.google.com/jsapi"></script>
        <script type="text/javascript" src="https://www.gstatic.com/charts/loader.js"></script>
        <script type="text/javascript" src="http://canvasjs.com//assets/script/canvasjs.min.js"></script>

        <script type="text/javascript">



            google.charts.load('current', {'packages': ['corechart']});

            google.charts.setOnLoadCallback(Evaluation2);
            function Evaluation2() {
                // Some raw data (not necessarily accurate)
                var data = new google.visualization.DataTable();
                data.addColumn('string', 'Task');
                data.addColumn('number', 'Evaluation');
                var label = document.getElementById('TaskNameE').value;
                var value = document.getElementById('EVE').value;
                var splitlabel = label.split(',');
                var splitvalue = value.split(',');
                for (var i = 0; i < splitlabel.length; i++) {
                    data.addRow([splitlabel[i], parseFloat(splitvalue[i])]);
                }
//              
                var options = {
                    title: 'Evaluation',
                    vAxis: {title: 'Tasks'},
                    hAxis: {title: 'Evaluation'},
                    seriesType: 'bars', is3D: true,
                    titleTextStyle: {
                        color: '#4E6B81'
                    },
                    bar: {groupWidth: "45%"},
//                    colors: ["#B6DCFE"],
                    colors: ["#4E6B81"],
                    height: 400,
                    width: 1200,
                    chartArea: {backgroundColor: '#fcfcfc'}

                };

                var chart = new google.visualization.ComboChart(document.getElementById('Eval2'));
                chart.draw(data, options);
            }

            function ShowData(value) {
                xmlHttp = GetXmlHttpObject();
                var url = "Search";
                url = url + "?name=" + value;
                xmlHttp.onreadystatechange = stateChanged
                xmlHttp.open("GET", url, true)
                xmlHttp.send(null)

            }
            function stateChanged() {
                if (xmlHttp.readyState == 4 || xmlHttp.readyState == "complete") {

                    var Showdata = xmlHttp.responseText;
                    document.getElementById("mydiv").innerHTML = Showdata;

                }
            }
            function GetXmlHttpObject() {

                var xmlHttp = null;
                try {
                    xmlHttp = new XMLHttpRequest();
                } catch (e) {
                    try {
                        xmlHttp = new ActiveXObject("Msxm12.XMLHTTP");
                    }
                    catch (e) {
                        xmlHttp = new ActiveXObject("Microsoft.XMLHTTP");

                    }
                }
                return xmlHttp;
            }

            /* When the user clicks on the button, 
             toggle between hiding and showing the dropdown content */
            function myFunction() {
                document.getElementById("myDropdown").classList.toggle("show");
            }

// Close the dropdown if the user clicks outside of it
            window.onclick = function (event) {
                if (!event.target.matches('.dropbtn')) {

                    var dropdowns = document.getElementsByClassName("dropdown-content");
                    var i;
                    for (i = 0; i < dropdowns.length; i++) {
                        var openDropdown = dropdowns[i];
                        if (openDropdown.classList.contains('show')) {
                            openDropdown.classList.remove('show');
                        }
                    }
                }
            }

// Get the modal
            var modal = document.getElementById('id01');

// When the user clicks anywhere outside of the modal, close it
            window.onclick = function (event) {
                if (event.target == modal) {
                    modal.style.display = "none";
                }
            }





        </script>
        <link rel="stylesheet" href="css/General.css">

        <link rel="stylesheet" href="css/Charts.css">

        <link rel="stylesheet" href="css/profile.css">

    </head>
    <body>



        <ul class="header">
            <li class="log" style="float: right">

                <a  href="register.html" name="logout" value="logout" class="logout"  >logout</a> 

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
            <% if (Integer.parseInt(request.getParameter("param1")) == Integer.parseInt(String.valueOf(session.getAttribute("uID")))) {%>
            <li style="float: right">

                <a class="element" id="iconUpdate" href="UpdateProfle.jsp" type="submit" ></a>
            </li>
            <%}%>
        </ul>

        <!--//////////////////////////////////////////////////////////////////////////////////////////////////////-->


        <%
            if (Integer.parseInt(request.getParameter("param1")) == Integer.parseInt(String.valueOf(session.getAttribute("uID")))) {%>
        <div class="BackGround">
            <div id="profile-container">
                <a  onclick="document.getElementById('id01').style.display = 'block'" style="width:auto;">

                    <img id="profileImage" src="<%="Image\\" + request.getParameter("param2")%>"   class="rotate360" title="<%=session.getAttribute("Fname")%>" /></a>
            </div>


            <!--////////////////////////////////////// Blog -->
            <div id="id01" class="modal">




                <form class="modal-content animate" method="post" enctype="multipart/form-data" action="AccountController">


                    <div class="Popcontainer">
                        <label><b>Photo</b></label><br>
                        <br><br>
                        <img id="profileImage" src="<%="Image\\" + request.getParameter("param2")%>"   class="rotate360" title="<%=session.getAttribute("Fname")%>" />
                        <br>
                        <input  type="file"  id = "mg" name="image" placeholder="Photo" required="" capture />
                        <input type="submit" value="uploadPhoto" name="change" onclick="this.display = 'none'" style="width:auto;" />

                    </div>

                    <div class="Popcontainer" style="background-color:#f1f1f1">
                        <button type="button" onclick="document.getElementById('id01').style.display = 'none'" class="cancelbtnn">Cancel</button>

                    </div>
                </form>

            </div>
            <%} else {%>
            <div class="BackGround">
                <div id="profile-container">
                    <img id="profileImage" src="<%="Image\\" + request.getParameter("param2")%>"   class="rotate360" title="profile" />
                    <br>
                </div>


                <%}%>

                <br>

                <%

                    int type = -1;
                    int ID = Integer.parseInt(String.valueOf(request.getParameter("param1")));
                    UserModel user_Acc = new UserModel();
                    user_Acc = user_Acc.GetInformationByID(Integer.parseInt(String.valueOf(request.getParameter("param1"))));
                %>
              
                
                <h1 class="UserName"><%= user_Acc.getFName() + " " + user_Acc.getLName()%></h1></div>
            <div class="Profile_Detail">
              
                
                <table>
                    
                    
                    <tr><td class="data_user" id="data_1" title="E-mail"></td><td><%=user_Acc.getEmail()%></td></tr>
                    <tr><td  class="data_user" id="data_2"title="Birth Date"></td><td><%=" " + user_Acc.getDay() + "/" + user_Acc.getMonth() + "/" + user_Acc.getYear()%></td></tr>
                    <tr><td  class="data_user" id="data_3"title="Mobile "></td><td><%=user_Acc.getMobile()%></td></tr>
                    <tr><td  class="data_user" id="data_4"title="Address"></td><td><%=user_Acc.getAddress()%></td></tr>
                    <tr><td   class="data_user" id="data_5"title="Gender"> </td><td><%=user_Acc.getGender()%></td></tr>
                    <tr><td  style="font-weight: bold;">Evaluation </td><td><%= user_Acc.getEvaluation()%></td></tr><%

                        type = user_Acc.getType();

                        model.UserModel m = new UserModel();
                        ArrayList<String> s = new ArrayList<String>();
                        s = m.skills(Integer.parseInt(String.valueOf(request.getParameter("param1"))));
                        if (!s.isEmpty()) {
                    %>
                    <tr><td style="font-weight: bold">Skills: </td><td> <%= s.get(0)%></td></tr>
                    <%
                        for (int j = 1; j < s.size(); j++) {
                    %>
                    <tr><td></td><td> <%= s.get(j)%></td></tr> <%

                            }
                        }
                    %>
                </table>
            </div>
            <br><div class="PositionMember">


                <%                if (type == 0) {
                        Department dep = new Department();
                        ArrayList<Department> Dep_Info = new ArrayList<Department>();

                        Dep_Info = dep.GetDep(dep.getDep_ID(Integer.parseInt(request.getParameter("param1"))));
                        if (dep.getDep_ID(Integer.parseInt(request.getParameter("param1"))) != 0) {
                %>

                <br><div class="position_dep"  style="    right: -435px;">Member in <a style="font-size: 20px;" class="Dep_name"href="dep.jsp?param1=<%= Dep_Info.get(0).getName()%>&param2=<%= dep.getDep_ID(Integer.parseInt(request.getParameter("param1")))%>"><%= Dep_Info.get(0).getName()%></a></div>
                    <%
                        }
                    } else if (type == 1) {

                        model.studentActivity SA = new studentActivity();
                        ArrayList<studentActivity> SA_Info = new ArrayList<studentActivity>();

                        SA_Info = SA.GetSA(SA.getSA_ID(Integer.parseInt(request.getParameter("param1"))));
                    %>
                <br><div class="position_dep" style="    right: -435px;"> President in <a style="font-size: 20px; " class="Dep_name" href="SA.jsp?param1=<%= SA_Info.get(0).getName()%>&param2=<%=SA.getSA_ID(Integer.parseInt(request.getParameter("param1")))%>&param3=<%= SA_Info.get(0).getCreationDate()%>&param4=<%= SA_Info.get(0).getCover()%>"><%=SA_Info.get(0).getName()%>
                    </a></div>

                <%

                } else if (type == 2) {

                    Department dep = new Department();
                    ArrayList<Department> Dep_Info = new ArrayList<Department>();

                    Dep_Info = dep.GetDep(dep.getDep_ID(Integer.parseInt(request.getParameter("param1"))));
                    if (dep.getDep_ID(Integer.parseInt(request.getParameter("param1"))) != 0) {
                %>

                <br><div class="position_dep" style="    right: -435px;">head in <a style="font-size: 20px;" class="Dep_name"href="dep.jsp?param1=<%= Dep_Info.get(0).getName()%>&param2=<%= dep.getDep_ID(Integer.parseInt(request.getParameter("param1")))%>"><%= Dep_Info.get(0).getName()%></a></div>
                <%
                    }
                } else {

                %><br><div class="position_dep" style="    right: -459px;"><% out.print("Currentely not enrolled in any student activity");%></div><%
                    }

                %>
            </div>

            <div class="Evaluation">
                <div id="Eval2" ></div></div>
                <% //  if (session.getAttribute("type").equals(0) || session.getAttribute("type").equals(2)) {
                    Report report = new Report();
                    String Eval = report.Evaluation(ID);
    //                    out.print("yes" + Eval);
                    if (!Eval.equals("Empty")) {
    //                out.print("yes" + Eval);

                        String[] Evalu = Eval.split("-");
                        String Task = "";
                        String Ev = "";
                        for (int i = 0; i < Evalu.length; i++) {
                            String[] Evalu2 = Evalu[i].split(",");
                            if (i == 0) {
                                Task += Evalu2[0];
                                Ev += Evalu2[1];
                            } else {
    //
                                Task += "," + Evalu2[0];
                                Ev += "," + Evalu2[1];
                            }
    //
                        }

                %>

            <input type="hidden" id="TaskNameE" value="<%= Task%>" hidden/>
            <input type="hidden" id="EVE" value="<%=Ev%>"hidden/>



            <%}
%>
    </body>
</html>
