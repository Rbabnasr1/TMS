<%@page import="model.Notification"%>
<%@page import="model.taskModel"%>
<%@page import="java.util.ArrayList"%>
<%@page import="java.util.Calendar"%>
<%@page import="java.util.Date"%>
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
        <link rel="stylesheet" href="css/General.css">
        <script>
            // Get the modal
            function ShowData2(value) {
                xmlHttp = GetXmlHttpObject();
                var url = "taskDependency";
                url = url + "?name1=" + value + "&taskDep=yes";
                xmlHttp.onreadystatechange = stateChanged1
                xmlHttp.open("GET", url, true)
                xmlHttp.send(null)

            }
            function ShowData(value) {
                xmlHttp = GetXmlHttpObject();
                var url = "Search";
                url = url + "?name=" + value;
                xmlHttp.onreadystatechange = stateChanged
                xmlHttp.open("GET", url, true)
                xmlHttp.send(null)

            }
            function ShowData3(value) {
                xmlHttp = GetXmlHttpObject();
                var url = "taskDependency";
                url = url + "?name2=" + value + "&taskDep=no";
                xmlHttp.onreadystatechange = stateChanged3
                xmlHttp.open("GET", url, true)
                xmlHttp.send(null)

            }


            function stateChanged3() {
                if (xmlHttp.readyState == 4 || xmlHttp.readyState == "complete") {

                    var Showdata = xmlHttp.responseText;
//                    document.getElementById("rabab").innerHTML = Showdata;
                    var date = Showdata.split("-");
                    var _date;
                    if (date[2].includes("01")) {
                        _date = date[0] + "-" + date[1] + "-01";
                    }
                    else if (date[2].includes("02")) {
                        _date = date[0] + "-" + date[1] + "-02";
                    }
                    else if (date[2].includes("03")) {
                        _date = date[0] + "-" + date[1] + "-03";
                    }
                    else if (date[2].includes("04")) {
                        _date = date[0] + "-" + date[1] + "-04";
                    }
                    else if (date[2].includes("05")) {
                        _date = date[0] + "-" + date[1] + "-05";
                    }
                    else if (date[2].includes("06")) {
                        _date = date[0] + "-" + date[1] + "-06";
                    }
                    else if (date[2].includes("07")) {
                        _date = date[0] + "-" + date[1] + "-07";
                    }
                    else if (date[2].includes("08")) {
                        _date = date[0] + "-" + date[1] + "-08";
                    }
                    else if (date[2].includes("09")) {
                        _date = date[0] + "-" + date[1] + "-09";
                    }
                    else if (date[2].includes("10")) {
                        _date = date[0] + "-" + date[1] + "-10";
                    }
                    else if (date[2].includes("11")) {
                        _date = date[0] + "-" + date[1] + "-11";
                    }
                    else if (date[2].includes("12")) {
                        _date = date[0] + "-" + date[1] + "-12";
                    }
                    else if (date[2].includes("13")) {
                        _date = date[0] + "-" + date[1] + "-13";
                    }
                    else if (date[2].includes("14")) {
                        _date = date[0] + "-" + date[1] + "-14";
                    }
                    else if (date[2].includes("15")) {
                        _date = date[0] + "-" + date[1] + "-15";
                    }
                    else if (date[2].includes("16")) {
                        _date = date[0] + "-" + date[1] + "-16";
                    }
                    else if (date[2].includes("17")) {
                        _date = date[0] + "-" + date[1] + "-17";
                    }
                    else if (date[2].includes("18")) {
                        _date = date[0] + "-" + date[1] + "-18";
                    }
                    else if (date[2].includes("19")) {
                        _date = date[0] + "-" + date[1] + "-19";
                    }
                    else if (date[2].includes("20")) {
                        _date = date[0] + "-" + date[1] + "-20";
                    }
                    else if (date[2].includes("21")) {
                        _date = date[0] + "-" + date[1] + "-21";
                    }
                    else if (date[2].includes("22")) {
                        _date = date[0] + "-" + date[1] + "-22";
                    }
                    else if (date[2].includes("23")) {
                        _date = date[0] + "-" + date[1] + "-23";
                    }
                    else if (date[2].includes("24")) {
                        _date = date[0] + "-" + date[1] + "-24";
                    }
                    else if (date[2].includes("25")) {
                        _date = date[0] + "-" + date[1] + "-25";
                    }
                    else if (date[2].includes("26")) {
                        _date = date[0] + "-" + date[1] + "-26";
                    }
                    else if (date[2].includes("27")) {
                        _date = date[0] + "-" + date[1] + "-27";
                    }
                    else if (date[2].includes("28")) {
                        _date = date[0] + "-" + date[1] + "-28";
                    }
                    else if (date[2].includes("29")) {
                        _date = date[0] + "-" + date[1] + "-29";
                    }
                    else if (date[2].includes("30")) {
                        _date = date[0] + "-" + date[1] + "-30";
                    }
                    else if (date[2].includes("31")) {
                        _date = date[0] + "-" + date[1] + "-31";
                    }


                    document.getElementById("etr").min = _date;

                    document.getElementById("etr").value = _date;



                }
            }


            function stateChanged1() {
                if (xmlHttp.readyState == 4 || xmlHttp.readyState == "complete") {

                    var Showdata2 = xmlHttp.responseText;
                    var date = Showdata2.split("-");
                    var _date;
                    if (date[2].includes("01")) {
                        _date = date[0] + "-" + date[1] + "-01";
                    }
                    else if (date[2].includes("02")) {
                        _date = date[0] + "-" + date[1] + "-02";
                    }
                    else if (date[2].includes("03")) {
                        _date = date[0] + "-" + date[1] + "-03";
                    }
                    else if (date[2].includes("04")) {
                        _date = date[0] + "-" + date[1] + "-04";
                    }
                    else if (date[2].includes("05")) {
                        _date = date[0] + "-" + date[1] + "-05";
                    }
                    else if (date[2].includes("06")) {
                        _date = date[0] + "-" + date[1] + "-06";
                    }
                    else if (date[2].includes("07")) {
                        _date = date[0] + "-" + date[1] + "-07";
                    }
                    else if (date[2].includes("08")) {
                        _date = date[0] + "-" + date[1] + "-08";
                    }
                    else if (date[2].includes("09")) {
                        _date = date[0] + "-" + date[1] + "-09";
                    }
                    else if (date[2].includes("10")) {
                        _date = date[0] + "-" + date[1] + "-10";
                    }
                    else if (date[2].includes("11")) {
                        _date = date[0] + "-" + date[1] + "-11";
                    }
                    else if (date[2].includes("12")) {
                        _date = date[0] + "-" + date[1] + "-12";
                    }
                    else if (date[2].includes("13")) {
                        _date = date[0] + "-" + date[1] + "-13";
                    }
                    else if (date[2].includes("14")) {
                        _date = date[0] + "-" + date[1] + "-14";
                    }
                    else if (date[2].includes("15")) {
                        _date = date[0] + "-" + date[1] + "-15";
                    }
                    else if (date[2].includes("16")) {
                        _date = date[0] + "-" + date[1] + "-16";
                    }
                    else if (date[2].includes("17")) {
                        _date = date[0] + "-" + date[1] + "-17";
                    }
                    else if (date[2].includes("18")) {
                        _date = date[0] + "-" + date[1] + "-18";
                    }
                    else if (date[2].includes("19")) {
                        _date = date[0] + "-" + date[1] + "-19";
                    }
                    else if (date[2].includes("20")) {
                        _date = date[0] + "-" + date[1] + "-20";
                    }
                    else if (date[2].includes("21")) {
                        _date = date[0] + "-" + date[1] + "-21";
                    }
                    else if (date[2].includes("22")) {
                        _date = date[0] + "-" + date[1] + "-22";
                    }
                    else if (date[2].includes("23")) {
                        _date = date[0] + "-" + date[1] + "-23";
                    }
                    else if (date[2].includes("24")) {
                        _date = date[0] + "-" + date[1] + "-24";
                    }
                    else if (date[2].includes("25")) {
                        _date = date[0] + "-" + date[1] + "-25";
                    }
                    else if (date[2].includes("26")) {
                        _date = date[0] + "-" + date[1] + "-26";
                    }
                    else if (date[2].includes("27")) {
                        _date = date[0] + "-" + date[1] + "-27";
                    }
                    else if (date[2].includes("28")) {
                        _date = date[0] + "-" + date[1] + "-28";
                    }
                    else if (date[2].includes("29")) {
                        _date = date[0] + "-" + date[1] + "-29";
                    }
                    else if (date[2].includes("30")) {
                        _date = date[0] + "-" + date[1] + "-30";
                    }
                    else if (date[2].includes("31")) {
                        _date = date[0] + "-" + date[1] + "-31";
                    }



                    document.getElementById("str").min = _date;
                    document.getElementById("etr").min = _date;

                    document.getElementById("str").value = _date;
                    document.getElementById("etr").value = _date;
                }
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

            var modal = document.getElementById("id01");

            // When the user clicks anywhere outside of the modal, close it
            window.onclick = function (event) {
                if (event.target == modal) {
                    modal.style.display = "none";
                }
            }
        </script>
    </head>
    <link rel="stylesheet" href="css/Charts.css">
    <link rel="stylesheet" href="css/TaskCreate.css">

    <link rel="stylesheet" href="css/General.css">
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









        <h1 style="font-size: 50px; color:#0a426c ;"> New Task Form  </h1>


        <div class="TaskCreation">
            <table>


                <form action="taskController" method="post" enctype="multipart/form-data" >
<!--                    <div id="rabab"></div>-->
                    <!--                <tr><td><h1>New Task Form  </h1></td></tr>-->
                    <tr><td><h class = "Table_d">Name:</h> </td><td> <input type="text"style=" height: 42px;width: 154px" name="taskName" required /> </td></tr> 
                    <tr><td><h class = "Table_d">Description:</h> </td><td>  <input type="text"style="height: 42px;width: 154px" name="taskDesc" required /></td></tr>
                    <tr><td><h class = "Table_d"> Priority: </h> </td><td>  <input type="text"style="height: 42px;width: 154px" name="taskProir" required /></td></tr>
                        <%
                           Date date = new Date();
                                                         Calendar cal = Calendar.getInstance();
                                                        cal.setTime(date);
                                                        String year = String.valueOf(cal.get(Calendar.YEAR));
                                                         String month = String.valueOf(cal.get(Calendar.MONTH)+1);
                                                        String day = String.valueOf(cal.get(Calendar.DAY_OF_MONTH));
                                           
                            if (month.length() == 1) {

                                month = "0" + month;
                            }
                            if (day.length() == 1) {

                                day = "0" + day;
                            }
                            String hour = String.valueOf(cal.get(Calendar.HOUR_OF_DAY));
                            String min = String.valueOf(cal.get(Calendar.MINUTE));
                            String sec = String.valueOf(cal.get(Calendar.SECOND));
                            if (hour.length() == 1) {

                                hour = "0" + hour;
                            }
                            if (min.length() == 1) {

                                min = "0" + min;
                            }
                            if (sec.length() == 1) {

                                sec = "0" + sec;
                            }
         
                            String _date = String.valueOf(year + "-" + month + "-" + day);
                            String _time = String.valueOf(hour + ":" + min + ":" + sec);
                            if (request.getParameter("param1").equals("DepTask")) {

                        %>
            
                    <tr><td><h class = "Table_d"> Determinant task (optional)</h></td><td><select style="height: 42px;width: 157px"name="taskDepen" onchange="ShowData2(this.value);" name="name1" id="name1"><option value="0"  style=" color: #4E6B81">Task Dependancy</option>
                        <%              model.taskModel t = new model.taskModel();
                            ArrayList<taskModel> t1 = new ArrayList<taskModel>();
                            t1 = t.tasksinDep(Integer.parseInt(String.valueOf(session.getAttribute("depID"))));

                            for (int i = 0; i < t1.size(); i++) {
                        %>
                            <option value=<%= t1.get(i).getID()%>> <%= t1.get(i).getName()%>  </option>
                            <%}%>

                        </select>
                
                    </td></tr>
                    <%}%>
                    <!--<div id="td" >hhh </div>-->
                    <tr><td><h class = "Table_d"> Start date: </h> </td><td>  <input type="date" name="taskStDate" style="height: 42px;width: 154px"id="str" min="<%=_date%>" value="<%=_date%>" onchange="ShowData3(this.value);" required/></td></tr>
                    <tr><td> <h class = "Table_d">End date: </h> </td><td>  <input type="date" name="taskEnDate" id="etr" style="height: 42px;width: 154px" min="<%=_date%>" value="<%=_date%>" required/></td></tr>
                    <tr><td><h class = "Table_d"> start time: </h>  </td><td> <input type="time" name="taskSttime" style="height: 42px;width: 154px" min="<%=_time%>" value="<%=_time%>" required/></td></tr>
                    <tr><td><h class = "Table_d"> End time:  </h></td><td>  <input type="time" name="taskEnTime" style="height: 42px;width: 154px" value="<%=_time%>"  required/></td></tr>
                    <tr><td> <input type="file" class="_file"  name="task_file" required style="background-color: #F3F4F7"/></td></tr>
                    <tr><td><h class = "Table_d">Skills</h></td></tr>



            </table>
            <br> 
            <%
                String URL = "jdbc:mysql://localhost:3306/orgi";
                Class.forName("com.mysql.jdbc.Driver");
                Connection con = DriverManager.getConnection(URL, "root", "root");
                Statement st = con.createStatement();
                String sql = "select * from skills";
                ResultSet rs = st.executeQuery(sql);
            %><div class="Skills_name" style="width: 680px;font-size: 20px;text-transform: capitalize "><%
                while (rs.next()) {
                    String SkillName = rs.getString("skill");
                    int SkillID = rs.getInt("ID");
                %>
                <!--<tr><td><br><input type="checkbox" name="skill" value="<%=SkillID%>" > <%=SkillName%></td></tr>-->
                <input type="checkbox" name="skill" value="<%=SkillID%>"  style="text-transform: capitalize" > <%=SkillName%><br>
                <%

                    }
                con.close();
                %>
            </div>

            <% if (request.getParameter("param1").equals("CampTask")) {%>
            <button name="type" class="CreateTask" style="background-color: #0a426c" value="Create camp task">Create Task</button>
            <%} else if (request.getParameter("param1").equals("DepTask")) {%>
            <input class="CreateTask" type="submit" name="type" style="background-color: #0a426c"value="create Task"/>
            <%}%>

        </form>
        <button onclick="document.getElementById('id01').style.display = 'block'" style="width:auto; background-color: #0a426c;
                color: white;font-weight: bold; text-transform: capitalize;position: absolute;right: 560px">Add new Skill</button>
    </div>
    <div id="id01" class="modal">

        <form class="modal-content animate" action="CreateSkill">


            <div class="container">
                <label><b>Skill name</b></label>
                <input type="text" placeholder="skill name" name="Sname" required>
                <button type="submit" style="">Add Skill</button>

                <div class="container" style="background-color:#f1f1f1">
                    <button type="button"  onclick="document.getElementById('id01').style.display = 'none'" class="cancelbtn">Cancel</button>

                </div>
            </div>


            </body>
            </html>
