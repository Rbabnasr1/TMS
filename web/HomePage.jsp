<%@page import="java.util.Locale"%>
<%@page import="model.PostModel"%>
<%@page import="model.Report"%>
<%@page import="model.campaginModel"%>
<%@page import="model.Department"%>
<%@page import="model.studentActivity"%>
<%@page import="model.taskModel"%>
<%@page import="model.Notification"%>
<%@page import="java.util.Calendar"%>
<%@page import="java.util.Date"%>
<%@page import="java.util.ArrayList"%>
<%@page import="java.sql.ResultSet"%>
<%@page import="java.sql.DriverManager"%>
<%@page import="java.sql.Statement"%>
<%@page import="java.sql.Connection"%>
<%@page contentType="text/html" pageEncoding="UTF-8"%>
<html>
    <head>
        <meta http-equiv="Content-Type" content="text/html; charset=UTF-8">
        <title>JSP Page</title>
        <link rel="stylesheet" href="css/General.css">
        <link rel="stylesheet" href="css/Charts.css">
        <link rel="stylesheet" href="css/CalenderH.css">

        <link rel="stylesheet" href="css/Homepage.css">
        <script type="text/javascript" src="http://www.google.com/jsapi"></script>
        <script type="text/javascript" src="https://www.gstatic.com/charts/loader.js"></script>
        <script type="text/javascript" src="http://canvasjs.com//assets/script/canvasjs.min.js"></script>

        <script type="text/javascript">
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


            google.charts.load('current', {'packages': ['corechart']});

            google.charts.setOnLoadCallback(columeChart);
            function columeChart() {
                // Some raw data (not necessarily accurate)
                var data = new google.visualization.DataTable();
                data.addColumn('string', 'Department');
                data.addColumn('number', 'Tasks');
                data.addColumn('number', 'Finished Tasks');
                data.addColumn('number', 'UnFinished Tasks');
                var label = document.getElementById('label').value;
                var value = document.getElementById('value').value;
                var valueFinish = document.getElementById('finish').value;
                var splitlabel = label.split(',');
                var splitvalue = value.split(',');
                var splitFinishvalue = valueFinish.split(',');
                for (var i = 0; i < splitlabel.length; i++) {
                    data.addRow([splitlabel[i], parseFloat(splitvalue[i]), parseFloat(splitFinishvalue[i]), (parseFloat(splitvalue[i]) - parseFloat(splitFinishvalue[i]))]);
                }
//              
                var options = {
                    title: 'Tasks',
                    vAxis: {title: 'Number of Tasks '},
                    hAxis: {title: 'Departments'},
                    seriesType: 'bars', is3D: true,
                    colors: ["#0B2B6F", "green", "gold"],
                    bar: {groupWidth: "95%"},
                    width: 820,
                    height: 500,
                    chartArea: {backgroundColor: '#fcfcfc'}

                };
//                alert("hello")
                var chart = new google.visualization.ComboChart(document.getElementById('Colum'));

                chart.draw(data, options);

            }



            google.charts.setOnLoadCallback(columeChart2);
            function columeChart2() {
                // Some raw data (not necessarily accurate)
                var data = new google.visualization.DataTable();
                data.addColumn('string', 'Department');
                data.addColumn('number', 'Tasks');
                data.addColumn('number', 'Finished Tasks');
                data.addColumn('number', 'UnFinished Tasks');
                var label = document.getElementById('campName').value;
                var value = document.getElementById('Cmpvalue').value;
                var valueFinish = document.getElementById('Campfinish').value;
                var splitlabel = label.split(',');
                var splitvalue = value.split(',');
                var splitFinishvalue = valueFinish.split(',');
                for (var i = 0; i < splitlabel.length; i++) {
                    data.addRow([splitlabel[i], parseFloat(splitvalue[i]), parseFloat(splitFinishvalue[i]), (parseFloat(splitvalue[i]) - parseFloat(splitFinishvalue[i]))]);
                }
//              
                var options = {
                    title: 'Tasks',
                    vAxis: {title: 'Number of Tasks '},
                    hAxis: {title: 'Campaign'},
                    seriesType: 'bars', is3D: true,
                    colors: ["#0B2B6F", "green", "gold"],
                    bar: {groupWidth: "95%"},
                    width: 820,
                    height: 500,
                    chartArea: {backgroundColor: '#fcfcfc'}

                };
//                alert("hello")
                var chart = new google.visualization.ComboChart(document.getElementById('ColumC'));

                chart.draw(data, options);

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

                <div class="List" >
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


        <%--<%=session.getAttribute("type")%>--%>

        <%
            if (Integer.parseInt(String.valueOf(session.getAttribute("type"))) >= 0) {

                if (Integer.parseInt(String.valueOf(session.getAttribute("type"))) == 1) {%>

        <ul class="smallHeder" >
            <li>
                <a class="liSmall" href="Report.jsp" style="" >DashBoard</a>


            </li>
            <li>

                <div class="DReport">
                    <a class="liSmall" class="ReportB"onclick="myFunction()">Issues</a>
                    <div id="a-content" class="Report-content">
                        <a onclick="document.getElementById('id03').style.display = 'block'" style="color: #4E6B81;font-size: 17px;" style="width:auto;"> view received Reports </a>

                    </div>
                </div>
            </li>

            <li >
                <a class="liSmall" href="OverallReport.jsp"  name="DetailedRep" style="float: right" >Detailed Report</a> 


            </li>
        </ul >
        <%} else {%>

        <ul class="smallHeder"  style="width: 332px;">
            <li  style="float: right">
                <a class="liSmall"  href="Report.jsp"  >DashBoard</a>


            </li>
            <li >
                <!--<a  href="DetailedReport.jsp"  name="DetailedRep" >Issues</a>--> 

                <div class="DReport">
                    <a class="liSmall"class="ReportB" >Issues</a>
                    <div class="Report-content">
                        <a href="CreateDetailedReport.jsp" style="color: #4E6B81;font-size: 17px;" >Create Report</a>
                        <%if (Integer.parseInt(String.valueOf(session.getAttribute("type"))) == 2){%>
                        <a onclick="document.getElementById('id03').style.display = 'block'" style="color: #4E6B81;font-size: 17px;" style="width:auto;"> view received Reports </a>
                        <%}%>
                    </div>
                </div>
            </li>

        </ul><%}
            }%>




        <%        ////////////////////////////////////////// lw el session Expired 

            if (session.getAttribute ( 
                "uID") == null) {
                response.sendRedirect("register.html");

            }

            int depiD = 0;
            int SAiD = 0;

            studentActivity SA = new studentActivity();
            ArrayList<Integer> SA_DEP = new ArrayList<Integer>();
            SA_DEP  = SA.GetDepSA(Integer.parseInt(String.valueOf(session.getAttribute("uID"))));

            if (!SA_DEP.isEmpty () 
                ) {
                depiD = SA_DEP.get(1);
                SAiD = SA_DEP.get(0);

            }

            session.setAttribute (

            "SAID", String.valueOf(SAiD));
            session.setAttribute (
            "depID", String.valueOf(depiD));

            SAiD  = Integer.parseInt(String.valueOf(session.getAttribute("SAID")));
            depiD  = Integer.parseInt(String.valueOf(session.getAttribute("depID")));
            //            out.print(depiD);
            String SAname = "", DEPname = "", cover = "";
            String Creation = "";
            ////////////////////////////////////// bngeb asm el Dep Ali member feha 
            Department Department = new Department();
            ArrayList<Department> Dep_Info = new ArrayList<Department>();
            Dep_Info  = Department.GetDep(depiD);

            if (!Dep_Info.isEmpty () 
                ) {

                DEPname = Dep_Info.get(0).getName();
            }
            ////////////////////////////////////// bngeb asm el SA Ali member feha 

            ArrayList<studentActivity> SA_Info = new ArrayList<studentActivity>();

            if (SAiD

            
                != 0) {
                SA_Info = SA.GetSA(SAiD);
                SAname = SA_Info.get(0).getName();
                Creation = SA_Info.get(0).getCreationDate();
                cover = SA_Info.get(0).getCover();
                session.setAttribute("cover", cover);
                session.setAttribute("SAName", SAname);
                session.setAttribute("CreatuinDate", Creation);

        %> 


        <div class="StudentAcitivity">
            <h >Student Activity</h><br>

            <a  href="SA.jsp?param1=<%=SAname%>&param2=<%=SAiD%>&param3=<%=Creation%>&param4=<%=cover%>"><%=SAname%>  </a><br>



            <%if (depiD != 0) {
                    if (!session.getAttribute("type").equals(1)) {

            %>


            <h>Department </h>
            <br><a href="dep.jsp?param1=<%=DEPname%>&param2=<%=depiD%>"><%=DEPname%></a><br>
            <!--/<div class="List" style="float:right;right: -105px;top:-150px;"></div>-->



            <%}
                }
                ArrayList<campaginModel> camp = new ArrayList<campaginModel>();
                campaginModel campaign = new campaginModel();
                camp = campaign.viewCamo(SAiD);
                if (!camp.isEmpty()) {

            %>
            <br> <h >Campaign</h>
                <%        for (int i = 0; i < camp.size(); i++) {
                %>

            <br>    <a href="campaign.jsp?param1= <%= camp.get(i).getName().replace(" ", "+")%>&param2=<%= camp.get(i).getCID()%> " ><%=camp.get(i).getName()%></a><br>


            <%
                    }
                }%>    </div>
            <%

                }  
            else {

                session.setAttribute("SAID", 0);
                    session.setAttribute("depID", 0);
            %>


        <div Class="createSA" ><a  href="CreateSA.jsp">Create Student Activity</a></div>

        <%}
            taskModel tA = new taskModel();

            ArrayList<Integer> list = new ArrayList<Integer>();
            ArrayList<String> listNameTask = new ArrayList<String>();
            ArrayList<Integer> listPercentage = new ArrayList<Integer>();
            ArrayList<Integer> listDuration = new ArrayList<Integer>();
            ArrayList<Integer> listDurationCur = new ArrayList<Integer>();
            ArrayList<Double> listDurationLate = new ArrayList<Double>();
            ArrayList<String> FileTask = new ArrayList<String>();
            int found = 0;
            int foundCamp = 0;

            /////////////////////////////////////////////////////////////////////// bngeb el task ali fe el Dep ali hwa mt2ssign beha
            ArrayList<taskModel> Task_inf = new ArrayList<taskModel>();
            Task_inf  = tA.GetTaskSA(Integer.parseInt(String.valueOf(session.getAttribute("uID"))));

            if (!Task_inf.isEmpty () 
                ) {

                for (int i = 0; i < Task_inf.size(); i++) {
                    list.add(Task_inf.get(i).getID());
                    listNameTask.add(Task_inf.get(i).getName());
                    listPercentage.add(Task_inf.get(i).getPercentage());
                    found = 1;
                    
                    String str = Task_inf.get(i).getStartDate();
                    String end = Task_inf.get(i).getEndDate();
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
                if (found == 1) {
        %>

        <div class="Tasks_Dep"> <h> On Going Department Tasks</h>



            <%
                for (int i = 0; i < list.size(); i++) {
                    String color;

                    if (listPercentage.get(i) == 100) {
                        color = "mediumvioletred";
                    } else if (listDurationCur.get(i) <= Math.ceil(listDurationLate.get(i))) {

                        notify.notifyLateTask(list.get(i), Integer.parseInt(String.valueOf(session.getAttribute("uID"))), "taskD");

                        color = "red";

                    } else if ((listDuration.get(i) / 2) - 1 == listDurationCur.get(i) || (listDuration.get(i) / 2) == listDurationCur.get(i) || (listDuration.get(i) / 2) + 1 == listDurationCur.get(i)) {
                        color = "yellow";
                    } else {
                        color = "green";
                    }
            %> 





            <a href="dep?param1=<%=listNameTask.get(i)%>&param2=<%=list.get(i)%>&param3=<%=listPercentage.get(i)%>&param4=TaskDep&param6=<%=color%>"><%=listNameTask.get(i)%> </a><br>





            <%    }%> 
            <%         }
                }
                ////////////////////////////////////////////////////bngeb el task ali hwa mt assign beha fe el Camp
                Task_inf  = new ArrayList<taskModel>();
                Task_inf  = tA.GetTaskCamp(Integer.parseInt(String.valueOf(session.getAttribute("uID"))));

                //            out.print(Task_inf);

                if (!Task_inf.isEmpty () 
                    ) {

                    list = new ArrayList<Integer>();
                    listNameTask = new ArrayList<String>();
                    listPercentage = new ArrayList<Integer>();
                    ArrayList<Integer> listDurationC = new ArrayList<Integer>();
                    ArrayList<Integer> listDurationCurC = new ArrayList<Integer>();
                    ArrayList<Double> listDurationLateC = new ArrayList<Double>();

                    
                    for (int i = 0; i < Task_inf.size(); i++) {
                        list.add(Task_inf.get(i).getID());
                        listNameTask.add(Task_inf.get(i).getName());
                        listPercentage.add(Task_inf.get(i).getPercentage());
                        foundCamp = 1;
                        String str = Task_inf.get(i).getStartDate();
                        String end = Task_inf.get(i).getEndDate();

                        int durMonth;
                        int durDay;
                        int durMonthCur;
                        int durDayCur;

                        model.taskModel task = new taskModel();
                        ArrayList<Integer> TaskDuration = new ArrayList<Integer>();
                        TaskDuration = task.GetDays(str, end);

                        listDurationC.add((TaskDuration.get(0) + TaskDuration.get(1) + TaskDuration.get(2)));
                        listDurationCurC.add((TaskDuration.get(3) + TaskDuration.get(4) + TaskDuration.get(5)));
                        listDurationLateC.add((Double) (((TaskDuration.get(0) + TaskDuration.get(1) + TaskDuration.get(2))) * .2));
                    }

                    if (foundCamp == 1) {
                        if(found==0){  %><div class="Tasks_Dep"><% }
            %>
            <!--<div class="All-Information" style="position: relative;top: -450px"><br><br><b>  <h>-->
            <h>  On Going Campaign tasks </h>
            <!--        </b></h>-->
            <%
                for (int i = 0; i < list.size(); i++) {

                    String color = "";

                    if (listPercentage.get(i) == 100) {
                        color = "mediumvioletred";
                    } else if (listDurationCurC.get(i) <= Math.ceil(listDurationLateC.get(i))) {
                        color = "red";
                        notify.notifyLateTask(list.get(i), Integer.parseInt(String.valueOf(session.getAttribute("uID"))), "taskC");

                    } else if ((listDurationC.get(i) / 2) >= listDurationCurC.get(i)) {
                        color = "yellow";
                    } else {
                        color = "green";
                    }

            %> 
            <a  href="dep?param1=<%=listNameTask.get(i)%>&param2=<%=list.get(i)%>&param3=<%=listPercentage.get(i)%>&param4=TaskCam&param6=<%=color%>"><%=listNameTask.get(i)%></a><br>

            <%

                        }

                    }
                }  %></div><%

                    if (session.getAttribute ( "type").equals(1)) {
            %>

        <div class="Colum">Department Tasks` progress <div class="ColumChart" id="Colum"></div><div >
                
                <div class="ColumCam">  Campaign Tasks` progress <div class="ColumChartCamp" id="ColumC"></div><div >
                      
                        <%
                            String URL = "jdbc:mysql://localhost:3306/orgi";
                            Class.forName("com.mysql.jdbc.Driver");
                            int SAID = Integer.parseInt(String.valueOf(session.getAttribute("SAID")));

                            Connection con = DriverManager.getConnection(URL, "root", "root");
                            Statement st = con.createStatement();
                            String sql;
                            ResultSet rs;
                            ArrayList<Integer> list_R = new ArrayList<Integer>();
                            Report report = new Report();
                            list_R = report.GetDepName(SAID);
                            if (!list_R.isEmpty()) {

                                String reading = "[";
                                String DepName = "";
                                String TaskCount = "";
                                String Finish = "";
                                String NFinish = "";

                                for (int i = 0; i < list_R.size(); i++) {

                                    st = con.createStatement();
                                    sql = "select name, ID,Count(Dep_ID) from acc_dep_task,Departement where Dep_ID=ID and acc_dep_task.Dep_ID=" + list_R.get(i);
                                    rs = st.executeQuery(sql);
                                    while (rs.next()) {
                                        if (i == 0) {
                                            DepName += rs.getString("name");
                                            TaskCount += rs.getInt("Count(Dep_ID)");

                                        } else if (i == list_R.size()) {
                                            DepName += rs.getString("name");
                                            TaskCount += rs.getInt("Count(Dep_ID)");

                                        } else {
                                            DepName += "," + rs.getString("name");
                                            TaskCount += "," + rs.getInt("Count(Dep_ID)");
                                        }
                                    }
                                }
                                for (int i = 0; i < list_R.size(); i++) {
                                    st = con.createStatement();
                                    sql = "select Count(Dep_ID) from acc_dep_task,Departement where Dep_ID=ID and finished =1 and acc_dep_task.Dep_ID=" + list_R.get(i);
                                    rs = st.executeQuery(sql);
                                    while (rs.next()) {
                                        if (i == 0) {
                                            Finish += rs.getInt("Count(Dep_ID)");
                                        } else {
                                            Finish += "," + rs.getInt("Count(Dep_ID)");
                                        }
                                    }
                                }
                        %>



                        <input type="hidden" id="label"  value="<%=DepName%>" hidden/>
                        <input type="hidden" id="value"  value="<%=TaskCount%>" hidden />
                        <input type="hidden" id="finish"  value="<%=Finish%>" hidden />
                        <input type="" id="title"  value="Departments" hidden/>


                        <%  }
                            st = con.createStatement();

                            ArrayList<campaginModel> list_C = new ArrayList<campaginModel>();
                            list_C = report.GetAllCamp(SAID);
                            if (!list_C.isEmpty()) {
                                //    out.print(list_C.size());
                                String reading = "[";
                                String DepName = "";
                                String TaskCount = "";
                                String Finish = "";
                                String NFinish = "";

                                for (int i = 0; i < list_C.size(); i++) {

                                    st = con.createStatement();
                                    sql = "select campagin.name , campagin.ID , Count(Camp_ID) from  campagin , acc_task_camp where Camp_ID = ID and Camp_ID= " + list_C.get(i).getCID();
                                    rs = st.executeQuery(sql);
                                    while (rs.next()) {
                                        if (i == 0) {
                                            DepName += rs.getString("name");
                                            TaskCount += rs.getInt("Count(Camp_ID)");

                                        } else if (i == list_C.size()) {
                                            DepName += rs.getString("name");
                                            TaskCount += rs.getInt("Count(Camp_ID)");
                                        } else {
                                            DepName += "," + rs.getString("name");
                                            TaskCount += "," + rs.getInt("Count(Camp_ID)");
                                        }
                                    }
                                }
                                for (int i = 0; i < list_C.size(); i++) {
                                    st = con.createStatement();
                                    sql = "select Count(Camp_ID) from campagin,acc_task_camp where Camp_ID=ID and finished =1 and Camp_ID=" + list_C.get(i).getCID();
                                    rs = st.executeQuery(sql);
                                    while (rs.next()) {
                                        if (i == 0) {
                                            Finish += rs.getInt("Count(Camp_ID)");
                                        } else {
                                            Finish += "," + rs.getInt("Count(Camp_ID)");
                                        }
                                    }
                                }

                        %>

                        <input type="hidden" id="campName"  value="<%=DepName%>" hidden/>
                        <input type="hidden" id="Cmpvalue"  value="<%=TaskCount%>" hidden />
                        <input type="hidden" id="Campfinish"  value="<%=Finish%>" hidden />
                        <%
                                }
                            }

                            
                                else {

                            ArrayList<PostModel> post = new ArrayList<PostModel>();
                                studentActivity _SA = new studentActivity();
                                Department _dep = new Department();
                                PostModel _post = new PostModel();
                                String pName = "";
                                post = _post.get_Post(Integer.parseInt(String.valueOf(session.getAttribute("type"))), SAiD, depiD);
                                if (!post.isEmpty()) {
                        %> <div class="BigPost"> Posts<%
                            for (int i = 0; i < post.size(); i++) {
                            %>
                            <%
                                if (Integer.parseInt(String.valueOf(session.getAttribute("type"))) == 2) {
                                    pName = SA.getSA_PName(SAiD);
                            %>
                            <div class="postName"><%= pName%> posted in <%= SAname%>
                                <br><span Class="MsgPost"> <%=post.get(i).getMessage()%><span> <span class="DatePost" ><%=post.get(i).getPostDate() + " "%><%=post.get(i).getPostTime()%> </span></div><br>
                                        <%
                                        } else if (Integer.parseInt(String.valueOf(session.getAttribute("type"))) == 0) {
                                            pName = _dep.getDEp_HName(depiD);
                                        %>
                                        <%--<%= pName%>--%> 

                                        <div class="postName"><%= pName%> posted in <%= DEPname%>


                                            <br><span Class="MsgPost"> <%=post.get(i).getMessage()%><span> <span class="DatePost" ><%=post.get(i).getPostDate() + " "%><%=post.get(i).getPostTime()%> </span></div><br>



                                                    <%      }
                                                    %>
                                                    <!--</div>-->
                                                    <%}%>
                                                    </div><%
                                                        }

                                                        if (session.getAttribute("type").equals(0) || session.getAttribute("type").equals(2)) {


                                                    %><div id="infcal" ><%       
                                                            Date date = new Date();
                                                        Calendar cal = Calendar.getInstance();
                                                        cal.setTime(date);
                                                        String year = String.valueOf(cal.get(Calendar.YEAR));
                                                        String month = String.valueOf(cal.get(Calendar.MONTH) + 1);
                                                        String day = String.valueOf(cal.get(Calendar.DAY_OF_MONTH));
                                                        if (month.length() == 1) {
                                                            month = "0" + month;
                                                        }
                                                        if (day.length() == 1) {
                                                            day = "0" + day;
                                                        }

                                                        String _date = String.valueOf(year + "-" + month + "-" + day);

                                                        String DayOfWeek = "";
                                                        int day_of_week = cal.get(Calendar.DAY_OF_WEEK);
                                                        if (day_of_week == 1) {
                                                            DayOfWeek = "Sunday";
                                                        } else if (day_of_week == 2) {
                                                            DayOfWeek = "Sunday";
                                                        } else if (day_of_week == 3) {
                                                            DayOfWeek = "Monday";
                                                        } else if (day_of_week == 4) {
                                                            DayOfWeek = "Tuesday";
                                                        } else if (day_of_week == 5) {
                                                            DayOfWeek = "Wednesday";
                                                        } else if (day_of_week == 6) {
                                                            DayOfWeek = "Friday";
                                                        } else {
                                                            DayOfWeek = "Saturday";
                                                        }
                                                        String NameOfMonth = cal.getDisplayName(Calendar.MONTH, Calendar.LONG, Locale.getDefault());
                                                        %>


                                                        <time datetime="<%=_date%>" class="icon">
                                                            <em><%= NameOfMonth%></em>
                                                            <strong><%=DayOfWeek%></strong>
                                                            <span><%=day%></span>
                                                            <a class="tasks-a" href="#" onclick="document.getElementById('id02').style.display = 'block'" > Current Tasks</a>
                                                        </time>

                                                    </div>
                                                    <div id="id02" class="modalTask">

                                                        <form class="modal-content-task animate" method="post" enctype="multipart/form-data" action="AccountController">


                                                            <div class="Popcontainer-task">
                                                                <div ><h>Current Tasks</h>
                                                                        <%
                                                                            ArrayList<taskModel> tasks = new ArrayList<taskModel>();
                                                                            taskModel taskm = new taskModel();
                                                                            tasks = taskm.getTaskByDate(Integer.parseInt(String.valueOf(session.getAttribute("uID"))));
                                                                            if (!tasks.isEmpty()) {
                                                                                for (int i = 0; i < tasks.size(); i++) {
                                                                        %>
                                                                    <br>  <a style="text-transform: capitalize"class="CurrentTask"href=dep?param1=<%=tasks.get(i).getName()%>&param2=<%=tasks.get(i).getID()%>&param3=<%=tasks.get(i).getPercentage()%>&param4=TaskDep&param6=<%=tasks.get(i).getColor()%>"><%= tasks.get(i).getName().replace("+", " ") %></a><br>
                                                                    <%  }
                                                                    } else {%>
                                                                    <br> <a class="CurrentTask"href="#">You Do not have any Tasks Today</a><br>
                                                                    <%
                                                                        }      %>
                                                                </div>   </div>
                                                            <div class="Popcontainer-task" style="background-color:#f1f1f1">
                                                                <button type="button" onclick="document.getElementById('id02').style.display = 'none'" class="cancelTask" style="background-color: #0a426c;color: white">Cancel</button>

                                                            </div>
                                                        </form>

                                                    </div>
                                                    <%}
                                                        }%>

                                                    <div id="id03" class="modal">

                                                        <form class="modal-content animate" method="post" enctype="multipart/form-data" action="AccountController">


                                                            <div class="container">
                                                                <label style="color: #0a426c;font-size: 25px;border-bottom: 1px solid #0591f8;"><b >Problems</b></label><br><br>

                                                                <table>
                                                                    <%
                                                                        String URL = "jdbc:mysql://localhost:3306/orgi";

                                                                        Class.forName (
                                                                        "com.mysql.jdbc.Driver");
                                                                        Connection con = DriverManager.getConnection(URL, "root", "root");
                                                                        Statement st = con.createStatement();
                                                                        String sql = "select detailedreport.ID, Name , Sent_date ,sent_time , Rep_subject , message , FName "
                                                                                + "from detailedreport , account , departement where to_id = " + session.getAttribute("uID")
                                                                                + " and from_id = account.ID and depart_id = departement.ID order by Sent_date desc ,sent_time desc";
                                                                        ResultSet rs = st.executeQuery(sql);

                                                                        while (rs.next () 
                                                                            ) {

                                                                    %>   
                                                                    <tr><td> <% out.print("From: ");%> </td> <td> <% out.print(rs.getString("FName"));  %> </td> </tr> 
                                                                    <tr><td> <% out.print("Subject: ");%> </td> <td> <% out.print(rs.getString("Rep_subject"));  %> </td> </tr> 
                                                                    <tr><td> <% out.print("Message: ");%> </td> <td> <% out.print(rs.getString("message"));  %> </td> </tr> 
                                                                    <tr><td> <% out.print("Date: ");%> </td> <td> <% out.print(rs.getString("Sent_date"));  %> </td> </tr> 
                                                                    <tr><td> <% out.print("Time: ");%> </td> <td> <% out.print(rs.getString("sent_time"));  %> </td> </tr> 
                                                                    <tr><td> <% out.print("Departement: ");%> </td> <td> <% out.print(rs.getString("Name"));  %> </td> </tr> 
                                                                    <tr><td style="color: #28A0C3"> <% out.print("______________________");%> </td> <td style="color: #28A0C3"> <% out.print("____________________________");%> </td> </tr>
                                                                    <input type="hidden" name="messageID" value="<%= rs.getInt("detailedreport.ID")%>"/>


                                                                    <%
                                                                        }%>
                                                                </table>


                                                            </div>

                                                            <div class="container" style="background-color:#f1f1f1">
                                                                <button type="button" onclick="document.getElementById('id03').style.display = 'none'" class="cancelbtnn">Cancel</button>

                                                            </div>
                                                        </form>
                                                    </div>


                                                    </body>
                                                    </html>
