<%-- 
    Document   : taskPlan
    Created on : 17-Feb-2017, 22:33:51
    Author     : rabab
--%>

<%@page import="model.taskModel"%>
<%@page import="model.Notification"%>
<%@page import="java.util.Calendar"%>
<%@page import="java.util.Date"%>
<%@page import="java.sql.DriverManager"%>
<%@page import="java.util.ArrayList"%>
<%@page import="java.sql.ResultSet"%>
<%@page import="java.sql.Statement"%>
<%@page import="java.sql.Connection"%>
<%@page contentType="text/html" pageEncoding="UTF-8"%>
<!DOCTYPE html>
<html>
    <head>
        <meta http-equiv="Content-Type" content="text/html; charset=UTF-8">
        <title>JSP Page</title>
        <link rel="stylesheet" href="css/styleTask.css">

        <link rel="stylesheet" href="css/General.css">

        <link rel="stylesheet" href="css/Charts.css">
        <style>

            /*            a{
                            color: #C1196E;
                            font-size: 30px;
                            text-align: center;
                            text-decoration: none;
                        }
                        a:hover{
            
                            color: #721050;
                        } h{
            
                            color: #721050;
                            font-size: 50px;
                            text-align: center;
                            margin: 600px;
                            text-decoration: none;
            
                        }*/

        </style>
        <script>
            function ShowData2(value) {
                xmlHttp = GetXmlHttpObject();

                var url = "Search";
                url = url + "?name=" + value;
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

            function sort(value) {
//                      alert("rabab")
                if (value.includes('Recent')) {
                    document.getElementById('Rec').style.display = 'block';
                    document.getElementById('Per').style.display = 'none';

                    document.getElementById('Unassign').style.display = 'none';
                    document.getElementById('finish').style.display = 'none';

                } else if (value.includes('priority')) {

                    document.getElementById('Per').style.display = 'block';
                    document.getElementById('Rec').style.display = 'none';
                    document.getElementById('Unassign').style.display = 'none';
                    document.getElementById('finish').style.display = 'none';

                }
                else if (value.includes('Unassa')) {

                    document.getElementById('Per').style.display = 'none';
                    document.getElementById('Rec').style.display = 'none';
                    document.getElementById('Unassign').style.display = 'block';

                    document.getElementById('finish').style.display = 'none';


                } else if (value.includes('finished')) {

                    document.getElementById('Per').style.display = 'none';
                    document.getElementById('Rec').style.display = 'none';
                    document.getElementById('Unassign').style.display = 'none';

                    document.getElementById('finish').style.display = '';

                }

            }

        </script>

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


          <h1 style="font-size: 50px;color: #0a426c">Tasks progress</h1>

        <select id="sort" onchange="sort(this.value);"><option value="Recent">
                Sort By Recent
            </option> 
            <option value="priority">
                Sort By priority
            </option><option value="Unassa">UnAssign Tasks </option><option value="finished">Finished Task</option>
        </select>
        <div id="Rec" style="display:block">
            <% String URL = "jdbc:mysql://localhost:3306/orgi";
                Class.forName("com.mysql.jdbc.Driver");
                Connection con = DriverManager.getConnection(URL, "root", "root");
                Statement st = con.createStatement();
                String sql = "select endDate,startDate,task.Name,Acc_ID ,task_File,task.ID,task.percentage "
                        + "from task , acc_dep_task where .task.ID=.acc_dep_task.Task_ID "
                        + "and Dep_ID=" + session.getAttribute("depID") + " order by task.ID desc ";
                ResultSet rs = st.executeQuery(sql);
                ArrayList<Integer> list = new ArrayList<Integer>();
                ArrayList<String> listName = new ArrayList<String>();
                ArrayList<Integer> listAccID = new ArrayList<Integer>();
                ArrayList<Integer> listPercentage = new ArrayList<Integer>();
                ArrayList<Integer> listDuration = new ArrayList<Integer>();
                ArrayList<Integer> listDurationCur = new ArrayList<Integer>();
                ArrayList<Double> listDurationLate = new ArrayList<Double>();
                ArrayList<String> FileTask = new ArrayList<String>();

                while (rs.next()) {
                                list.add(rs.getInt("ID"));
                    listName.add(rs.getString("Name"));
                    listPercentage.add(rs.getInt("percentage"));
                    FileTask.add(rs.getString("task_File"));
                    listAccID.add(rs.getInt("Acc_ID"));
                    String str = rs.getString("startDate");
                    String end = rs.getString("endDate");
                    int durMonth;
                    int durDay;
                    int durMonthCur;
                    int durDayCur;

                    model.taskModel task = new taskModel();
                    ArrayList<Integer> TaskDuration = new ArrayList<Integer>();
                    TaskDuration = task.GetDays(str, end);

                    listDuration.add((TaskDuration.get(0) + TaskDuration.get(1) + TaskDuration.get(2)));
                    listDurationCur.add((TaskDuration.get(3) + TaskDuration.get(4) + TaskDuration.get(5)));
                    listDurationLate.add((Double) (((TaskDuration.get(0) + TaskDuration.get(1) + TaskDuration.get(2))) * .2));

                }
                con.close();


            %>

            <div class="Tasks" style="text-transform: capitalize">
                <table>
                    <%            for (int i = 0; i < list.size(); i++) { %>
                    <%
                        if (listAccID.get(i) == 0) {
                    %>
                    <tr><td> <br><a style="text-transform: capitalize" href="dep?param1=<%=listName.get(i)%>&param2=<%=list.get(i)%>&param3=<%=listPercentage.get(i)%>&param4=TaskDep&param5=<%=FileTask.get(i)%>&param6=mediumvioletred"><%=listName.get(i)%> </a></td>
                        <td> <div class="progress-bar mediumvioletred stripes" >
                                <span  id="s" class="w" value="Not Assigned" style="width :0%; text-decoration-color: #721050; text-align: center; ">Not Assigned</span>
                            </div></td>
                        </a></tr><%
                        } else if (listPercentage.get(i) == 100) {
                        %>
                    <tr><td> <br><a  style="text-transform: capitalize" href="dep?param1=<%=listName.get(i)%>&param2=<%=list.get(i)%>&param3=<%=listPercentage.get(i)%>&param4=TaskDep&param5=<%=FileTask.get(i)%>&param6=mediumvioletred"><%=listName.get(i)%> </a></td>
                        <td> <div class="progress-bar mediumvioletred stripes" >
                                <span  id="s" class="w" style="width :<%=listPercentage.get(i) + "%"%> ; color: white ; text-align: center ; text-shadow: .5 px" > <%=listPercentage.get(i) + "%"%></span>
                            </div></td>
                        </a></tr><%
                        } else if (listDurationCur.get(i) <= Math.ceil(listDurationLate.get(i))) {%>
                    <tr><td> <br><a style="text-transform: capitalize" href="dep?param1=<%=listName.get(i)%>&param2=<%=list.get(i)%>&param3=<%=listPercentage.get(i)%>&param4=TaskDep&param5=<%=FileTask.get(i)%>&param6=red"><%=listName.get(i)%> </a></td>
                        <td> <div class="progress-bar red stripes" >
                                <span  id="s" class="w" style="width :<%=listPercentage.get(i) + "%"%> ; color: white ; text-align: center ; text-shadow: .5 px" > <%=listPercentage.get(i) + "%"%></span>
                            </div></td>
                        </a></tr>
                    <% } else if ((listDuration.get(i) / 2) >= listDurationCur.get(i)) {%> <tr><td> <br><a style="text-transform: capitalize" href="dep?param1=<%=listName.get(i)%>&param2=<%=list.get(i)%>&param3=<%=listPercentage.get(i)%>&param4=TaskDep&param5=<%=FileTask.get(i)%>&param6=yellow"><%=listName.get(i)%> </a></td>
                        <td> <div class="progress-bar yellow stripes" >
                                <span  id="s" class="w" style="width :<%=listPercentage.get(i) + "%"%> ; color: white ; text-align: center ; text-shadow: .5 px" > <%=listPercentage.get(i) + "%"%></span>
                            </div></td>
                        </a></tr>
                        <%
                        } else {%>
                    <tr><td> <br><a style="text-transform: capitalize" href="dep?param1=<%=listName.get(i)%>&param2=<%=list.get(i)%>&param3=<%=listPercentage.get(i)%>&param4=TaskDep&param5=<%=FileTask.get(i)%>&param6=green"><%=listName.get(i)%> </a></td>
                        <td> <div class="progress-bar green stripes" >
                                <span  id="s" class="w" style="width :<%=listPercentage.get(i) + "%"%> ; color: white ; text-align: center ; text-shadow: .5 px" > <%=listPercentage.get(i) + "%"%></span>
                            </div></td>
                        </a></tr>
                        <% }

                            }

                        %>
                </table></div>
        </div>
        <div id="Per" style="display:none">
            <%
                     con = DriverManager.getConnection(URL, "root", "root");
                st = con.createStatement();
                sql = "select endDate,startDate,piriority,task.Name,Acc_ID ,task_File,task.ID,task.percentage "
                        + "from task , acc_dep_task where .task.ID=.acc_dep_task.Task_ID "
                        + "and Dep_ID=" + session.getAttribute("depID") + " order by piriority asc,task.ID desc";
                rs = st.executeQuery(sql);
                list = new ArrayList<Integer>();
                listName = new ArrayList<String>();
                listAccID = new ArrayList<Integer>();
                listPercentage = new ArrayList<Integer>();
                listDuration = new ArrayList<Integer>();
                listDurationCur = new ArrayList<Integer>();
                listDurationLate = new ArrayList<Double>();
                FileTask = new ArrayList<String>();

                while (rs.next()) {
                    list.add(rs.getInt("ID"));
                    listName.add(rs.getString("Name"));
                    listPercentage.add(rs.getInt("percentage"));
                    FileTask.add(rs.getString("task_File"));
                    listAccID.add(rs.getInt("Acc_ID"));
                    String str = rs.getString("startDate");
                    String end = rs.getString("endDate");
                    int durMonth;
                    int durDay;
                    int durMonthCur;
                    int durDayCur;

                    model.taskModel task = new taskModel();
                    ArrayList<Integer> TaskDuration = new ArrayList<Integer>();
                    TaskDuration = task.GetDays(str, end);

                    listDuration.add((TaskDuration.get(0) + TaskDuration.get(1) + TaskDuration.get(2)));
                    listDurationCur.add((TaskDuration.get(3) + TaskDuration.get(4) + TaskDuration.get(5)));
                    listDurationLate.add((Double) (((TaskDuration.get(0) + TaskDuration.get(1) + TaskDuration.get(2))) * .2));

                }
                con.close();


            %>

            <div class="Tasks">
                <table>
                    <%            for (int i = 0; i < list.size(); i++) { 
                    
                        if (listAccID.get(i) == 0) {
                    %>
                    <tr><td> <br><a style="text-transform: capitalize" href="dep?param1=<%=listName.get(i)%>&param2=<%=list.get(i)%>&param3=<%=listPercentage.get(i)%>&param4=TaskDep&param5=<%=FileTask.get(i)%>&param6=mediumvioletred"><%=listName.get(i)%> </a></td>
                        <td> <div class="progress-bar mediumvioletred stripes" >
                                <span  id="s" class="w" value="Not Assigned" style="width :0%; text-decoration-color: #721050; text-align: center; ">Not Assigned</span>
                            </div></td>
                        </a></tr><%
                        } else if (listPercentage.get(i) == 100) {
                        %>
                    <tr><td> <br><a style="text-transform: capitalize" href="dep?param1=<%=listName.get(i)%>&param2=<%=list.get(i)%>&param3=<%=listPercentage.get(i)%>&param4=TaskDep&param5=<%=FileTask.get(i)%>&param6=mediumvioletred"><%=listName.get(i)%> </a></td>
                        <td> <div class="progress-bar mediumvioletred stripes" >
                                <span  id="s" class="w" style="width :<%=listPercentage.get(i) + "%"%> ; color: white ; text-align: center ; text-shadow: .5 px" > <%=listPercentage.get(i) + "%"%></span>
                            </div></td>
                        </a></tr><%
                        } else if (listDurationCur.get(i) <= Math.ceil(listDurationLate.get(i))) {%>
                    <tr><td> <br><a style="text-transform: capitalize" href="dep?param1=<%=listName.get(i)%>&param2=<%=list.get(i)%>&param3=<%=listPercentage.get(i)%>&param4=TaskDep&param5=<%=FileTask.get(i)%>&param6=red"><%=listName.get(i)%> </a></td>
                        <td> <div class="progress-bar red stripes" >
                                <span  id="s" class="w" style="width :<%=listPercentage.get(i) + "%"%> ; color: white ; text-align: center ; text-shadow: .5 px" > <%=listPercentage.get(i) + "%"%></span>
                            </div></td>
                        </a></tr>
                    <% } else if ((listDuration.get(i) / 2) >= listDurationCur.get(i)) {%> <tr><td> <br><a style="text-transform: capitalize" href="dep?param1=<%=listName.get(i)%>&param2=<%=list.get(i)%>&param3=<%=listPercentage.get(i)%>&param4=TaskDep&param5=<%=FileTask.get(i)%>&param6=yellow"><%=listName.get(i)%> </a></td>
                        <td> <div class="progress-bar yellow stripes" >
                                <span  id="s" class="w" style="width :<%=listPercentage.get(i) + "%"%> ; color: white ; text-align: center ; text-shadow: .5 px" > <%=listPercentage.get(i) + "%"%></span>
                            </div></td>
                        </a></tr>
                        <%
                        } else {%>
                    <tr><td> <br><a style="text-transform: capitalize" href="dep?param1=<%=listName.get(i)%>&param2=<%=list.get(i)%>&param3=<%=listPercentage.get(i)%>&param4=TaskDep&param5=<%=FileTask.get(i)%>&param6=green"><%=listName.get(i)%> </a></td>
                        <td> <div class="progress-bar green stripes" >
                                <span  id="s" class="w" style="width :<%=listPercentage.get(i) + "%"%> ; color: white ; text-align: center ; text-shadow: .5 px" > <%=listPercentage.get(i) + "%"%></span>
                            </div></td>
                        </a></tr>
                        <% }

                            }

                        %>
                </table></div>
        </div>


<!--/////////////////////////////////////////////////////////////////////////// un assign tasks-->
        <div id="Unassign" style="display:none">
            <%
                     con = DriverManager.getConnection(URL, "root", "root");
                st = con.createStatement();
                sql = "select endDate,startDate,piriority,task.Name,Acc_ID ,task_File,task.ID,task.percentage "
                        + "from task , acc_dep_task where .task.ID=.acc_dep_task.Task_ID "
                        + "and Dep_ID=" + session.getAttribute("depID") + " and Acc_ID is null " + " order by piriority asc,task.ID desc";
                rs = st.executeQuery(sql);
                list = new ArrayList<Integer>();
                listName = new ArrayList<String>();
                listAccID = new ArrayList<Integer>();
                listPercentage = new ArrayList<Integer>();
                listDuration = new ArrayList<Integer>();
                listDurationCur = new ArrayList<Integer>();
                listDurationLate = new ArrayList<Double>();
                FileTask = new ArrayList<String>();

                while (rs.next()) {
                    list.add(rs.getInt("ID"));
                    listName.add(rs.getString("Name"));
                    listPercentage.add(rs.getInt("percentage"));
                    FileTask.add(rs.getString("task_File"));
                    listAccID.add(rs.getInt("Acc_ID"));
                    String str = rs.getString("startDate");
                    String end = rs.getString("endDate");
                    int durMonth;
                    int durDay;
                    int durMonthCur;
                    int durDayCur;

                    model.taskModel task = new taskModel();
                    ArrayList<Integer> TaskDuration = new ArrayList<Integer>();
                    TaskDuration = task.GetDays(str, end);

                    listDuration.add((TaskDuration.get(0) + TaskDuration.get(1) + TaskDuration.get(2)));
                    listDurationCur.add((TaskDuration.get(3) + TaskDuration.get(4) + TaskDuration.get(5)));
                    listDurationLate.add((Double) (((TaskDuration.get(0) + TaskDuration.get(1) + TaskDuration.get(2))) * .2));

                }

con.close();
            %>

            <div class="Tasks">
                <table>
                    <%            for (int i = 0; i < list.size(); i++) { %>
                    <%
                        if (listAccID.get(i) == 0) {
                    %>
                    <tr><td> <br><a style="text-transform: capitalize" href="dep?param1=<%=listName.get(i)%>&param2=<%=list.get(i)%>&param3=<%=listPercentage.get(i)%>&param4=TaskDep&param5=<%=FileTask.get(i)%>&param6=mediumvioletred"><%=listName.get(i)%> </a></td>
                        <td> <div class="progress-bar mediumvioletred stripes" >
                                <span  id="s" class="w" value="Not Assigned" style="width :0%; text-decoration-color: #721050; text-align: center; ">Not Assigned</span>
                            </div></td>
                        </a></tr><%
                                }
                            }

                        %>
                </table></div>
        </div>
<!--///////////////////////////////////////////////////////////////////////  finished task-->
        <div id="finish" style="display:none">
            
            <%
                     con = DriverManager.getConnection(URL, "root", "root");
                    st = con.createStatement();
                sql = "select endDate,startDate,piriority,finished,task.Name,Acc_ID ,task_File,task.ID,task.percentage "
                        + "from task , acc_dep_task where .task.ID=.acc_dep_task.Task_ID "
                        + "and Dep_ID=" + session.getAttribute("depID") + " and finished=1 " + " order by task.ID desc";
                rs = st.executeQuery(sql);
                list = new ArrayList<Integer>();
                listName = new ArrayList<String>();
                listAccID = new ArrayList<Integer>();
                listPercentage = new ArrayList<Integer>();
                listDuration = new ArrayList<Integer>();
                listDurationCur = new ArrayList<Integer>();
                listDurationLate = new ArrayList<Double>();
                FileTask = new ArrayList<String>();

                while (rs.next()) {
                    list.add(rs.getInt("ID"));
                    listName.add(rs.getString("Name"));
                    listPercentage.add(rs.getInt("percentage"));
                    FileTask.add(rs.getString("task_File"));
                    listAccID.add(rs.getInt("Acc_ID"));
                    String str = rs.getString("startDate");
                    String end = rs.getString("endDate");
                    int durMonth;
                    int durDay;
                    int durMonthCur;
                    int durDayCur;

                    model.taskModel task = new taskModel();
                    ArrayList<Integer> TaskDuration = new ArrayList<Integer>();
                    TaskDuration = task.GetDays(str, end);

                    listDuration.add((TaskDuration.get(0) + TaskDuration.get(1) + TaskDuration.get(2)));
                    listDurationCur.add((TaskDuration.get(3) + TaskDuration.get(4) + TaskDuration.get(5)));
                    listDurationLate.add((Double) (((TaskDuration.get(0) + TaskDuration.get(1) + TaskDuration.get(2))) * .2));

                }
con.close();

            %>

            <div class="Tasks">
                <table>
                    <%            for (int i = 0; i < list.size(); i++) {

                            if (listPercentage.get(i) == 100) {
                    %>
                    <tr><td> <br><a style="text-transform: capitalize" href="dep?param1=<%=listName.get(i)%>&param2=<%=list.get(i)%>&param3=<%=listPercentage.get(i)%>&param4=TaskDep&param5=<%=FileTask.get(i)%>&param6=mediumvioletred"><%=listName.get(i)%> </a></td>
                        <td> <div class="progress-bar mediumvioletred stripes" >
                                <span  id="s" class="w" style="width :<%=listPercentage.get(i) + "%"%> ; color: white ; text-align: center ; text-shadow: .5 px" > <%=listPercentage.get(i) + "%"%></span>
                            </div></td>
                        </a></tr><%
                                }
                            }
                        %>
                </table></div>
        </div>
    </body>
</html>
