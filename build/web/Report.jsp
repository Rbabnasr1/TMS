<%-- 
    Document   : Report
    Created on : 02-May-2017, 20:18:39
    Author     : rabab
--%>

<%@page import="model.UserModel"%>
<%@page import="model.Department"%>
<%@page import="java.lang.String"%>
<%@page import="model.Report"%>
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
        <!--<script type="text/javascript" src="v5\GP\canvasjs.min.js"></script>-->

        <script type="text/javascript">
            google.charts.load('current', {'packages': ['corechart']});
            google.charts.setOnLoadCallback(drawChartPie);
            ///////////////////////////////////////pie Chart
            function drawChartPie() {
                var data = new google.visualization.DataTable();
                data.addColumn('string', 'Department');
                data.addColumn('number', 'Count');
                var label = document.getElementById('label').value;
                var value = document.getElementById('value').value;
                var splitlabel = label.split(',');
                var splitvalue = value.split(',');
                for (var i = 0; i < splitlabel.length; i++) {
                    data.addRow([splitlabel[i], parseFloat(splitvalue[i])]);
                }

                var options = {'title': 'Departments Tasks',
                    'width': 700,
                    'height': 600, is3D: true
                };
                // Instantiate and draw our chart, passing in some options.
                var chart = new google.visualization.PieChart(document.getElementById('chart_div'));
                chart.draw(data, options);
            }
            google.charts.setOnLoadCallback(barChart);
            function barChart() {
                // Create and populate the data table.
                var data = new google.visualization.DataTable();
                data.addColumn('string', 'Member Name');
                data.addColumn('number', 'Evaluation');
                var label = document.getElementById('MemberName').value;
                var value = document.getElementById('Eva').value;
                var splitlabel = label.split(',');
                var splitvalue = value.split(',');
                data.addRows(splitlabel.length);
                for (var i = 0; i < splitlabel.length; i++) {

                    data.setValue(i, 0, splitlabel[i]);
                    data.setValue(i, 1, parseFloat(splitvalue[i]));

                }
                var options = {
                    title: "Members Evaluation",
                    width: 600,
                    height: 400,
                    hxis: {title: 'Member', TextStyle: {color: '#0DBBEE'}},
                    vxis: {title: 'Evaluation'},
                    chartArea: {backgroundColor: '#fcfcfc'},
                    legend: {position: "none"}, is3D: true,
//        
                    series: [{color: "green", visibleInLegend: false}, {color: 'Gold', visibleInLegend: false}], bar: {groupWidth: "95%"},
                };
//                   alert("rabab");
                var view = new google.visualization.DataView(data);
                view.setColumns([0, 1,
                    {calc: "stringify",
                        sourceColumn: 1,
                        type: "string",
                        role: "annotation"}
                ]);
//                 alert("rabab");
                var chart = new google.visualization.BarChart(document.getElementById('visualization'));
                chart.draw(view, options);
            }

            google.charts.setOnLoadCallback(barHead);
            function barHead() {
                // Create and populate the data table.
                var data = new google.visualization.DataTable();
                data.addColumn('string', 'Head Name');
                data.addColumn('number', 'Evaluation');
                var label = document.getElementById('HName').value;
                var value = document.getElementById('HEva').value;
                var splitlabel = label.split(',');
                var splitvalue = value.split(',');
                data.addRows(splitlabel.length);

                for (var i = 0; i < splitlabel.length; i++) {

                    data.setValue(i, 0, splitlabel[i]);
                    data.setValue(i, 1, parseFloat(splitvalue[i]));

                }

                var options = {
                    title: "Heads Evaluation",
                    width: 600,
                    height: 400,
                    chartArea: {backgroundColor: '#fcfcfc'},
                    hxis: {title: 'Heads', TextStyle: {color: '#0DBBEE'}},
                    vxis: {title: 'Evaluation'},
                    legend: {position: "none"}, is3D: true,
                    series: [{color: "#5EA2C3", visibleInLegend: false}, {color: '#1791B4', visibleInLegend: false}], bar: {groupWidth: "95%"},
                };

                var view = new google.visualization.DataView(data);
                view.setColumns([0, 1,
                    {calc: "stringify",
                        sourceColumn: 1,
                        type: "string",
                        role: "annotation"}
                ]);
//                 alert("rabab");
                var chart = new google.visualization.BarChart(document.getElementById('HeadBar'));
                chart.draw(view, options);
            }


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
                    height: 400,
                    chartArea: {backgroundColor: '#fcfcfc'}

                };
                var chart = new google.visualization.ComboChart(document.getElementById('chart_div2'));
                chart.draw(data, options);
            }

            google.charts.setOnLoadCallback(Evaluation);
            function Evaluation() {
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
                    bar: {groupWidth: "95%"},
                    colors: ["#990066"],
                    height: 400,
                    chartArea: {backgroundColor: '#fcfcfc'}

                };

                var chart = new google.visualization.ComboChart(document.getElementById('Eval'));
                chart.draw(data, options);
            }



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
                    bar: {groupWidth: "95%"},
                    colors: ["#8c1b9a"],
                    height: 400,
                    chartArea: {backgroundColor: '#fcfcfc'}

                };

                var chart = new google.visualization.ComboChart(document.getElementById('Eval2'));
                chart.draw(data, options);
            }

            google.charts.setOnLoadCallback(scatter);
            function scatter() {
                var data = new google.visualization.DataTable();
                data.addColumn('string', 'Task');
                data.addColumn('number', 'Star');
                data.addColumn({'type': 'string', 'role': 'style'});
                var Task = document.getElementById('taskN').value;
                var Star = document.getElementById('Star').value;
//               
                var splitTask = Task.split(',');
                var splitStar = Star.split(',');
                for (var i = 0; i < splitTask.length; i++) {
                    data.addRow([splitTask[i], parseFloat(Star[i]), 'point {size: 13; shape-type:circle; fill-color: #C119' + i + 'E;}']);
                }


                var options = {
                    title: 'Rating Task',
                    hAxis: {textStyle: {color: '#5a0f41'}, title: 'Task', minValue: 0, maxValue: 15},
                    vAxis: {textStyle: {color: '#5a0f41'}, title: 'Rate', minValue: 0, maxValue: 5},
                    legend: 'none',
                    height: 400,
                    chartArea: {backgroundColor: '#fcfcfc'}

                };
                var chart = new google.visualization.ScatterChart(document.getElementById('scatter'));
                chart.draw(data, options);
            }


            google.charts.setOnLoadCallback(drawChartPieCamp);
            ///////////////////////////////////////pie Chart
            function drawChartPieCamp() {
                var data = new google.visualization.DataTable();
                data.addColumn('string', 'Campaign');
                data.addColumn('number', 'Number of task');
                var label = document.getElementById('CamLabel').value;
                var value = document.getElementById('CamValue').value;
                var splitlabel = label.split(',');
                var splitvalue = value.split(',');
                for (var i = 0; i < splitlabel.length; i++) {
                    data.addRow([splitlabel[i], parseFloat(splitvalue[i])]);
                }

                var options = {'title': 'Campaign Tasks',
                    'width': 700,
                    'height': 600, is3D: true
                };
                // Instantiate and draw our chart, passing in some options.
                var chart = new google.visualization.PieChart(document.getElementById('CampPie'));
                chart.draw(data, options);
            }
//
            google.charts.setOnLoadCallback(DiffChart);
            function DiffChart() {
                var data = new google.visualization.DataTable();
                data.addColumn('string', 'Task');
                data.addColumn('date', 'End Date');
                data.addColumn('date', 'Completion Date');

                var Tname = document.getElementById('TName').value;
                var Eyear = document.getElementById('Eyear').value;
                var Emonth = document.getElementById('Emonth').value;
                var Eday = document.getElementById('Eday').value;
                var Cyear = document.getElementById('Cyear').value;
                var Cmonth = document.getElementById('Cmonth').value;
                var Cday = document.getElementById('Cday').value;
                var splitTaskName = Tname.split(',');
                var EY = Eyear.split(',');
                var EM = Emonth.split(',');
                var ED = Eday.split(',');
                var CY = Cyear.split(',');
                var CM = Cmonth.split(',');
                var CD = Cday.split(',');

                for (var i = 0; i < splitTaskName.length; i++) {
                    data.addRow([splitTaskName[i], new Date(EY[i], EM[i], ED[i]), new Date(CY[i], CM[i], CD[i])]);

                }

                var options = {
                    title: 'Progress review',
                    vAxis: {title: 'Date'},
                    hAxis: {title: 'Task'},
                    seriesType: 'bars',
                    series: {5: {type: 'line'}},
                    height: 400,
                };
                var chart = new google.visualization.ComboChart(document.getElementById('diff'));
                chart.draw(data, options);
                //////////////////////////////////////////////////////////////////////



            }

            google.charts.setOnLoadCallback(DiffChartDep);
            function DiffChartDep() {
                var data = new google.visualization.DataTable();
                data.addColumn('string', 'Task');
                data.addColumn('date', ' Planned');
                data.addColumn('date', 'Actual ');

                var Tname = document.getElementById('DTName').value;
                var Eyear = document.getElementById('DEyear').value;
                var Emonth = document.getElementById('DEmonth').value;
                var Eday = document.getElementById('DEday').value;
                var Cyear = document.getElementById('DCyear').value;
                var Cmonth = document.getElementById('DCmonth').value;
                var Cday = document.getElementById('DCday').value;
                var splitTaskName = Tname.split(',');
                var EY = Eyear.split(',');
                var EM = Emonth.split(',');
                var ED = Eday.split(',');
                var CY = Cyear.split(',');
                var CM = Cmonth.split(',');
                var CD = Cday.split(',');

                for (var i = 0; i < splitTaskName.length; i++) {
                    data.addRow([splitTaskName[i], new Date(EY[i], EM[i], ED[i]), new Date(CY[i], CM[i], CD[i])]);

                }

                var options = {
                    title: 'Progress review',
                    vAxis: {title: 'Date'},
                    hAxis: {title: 'Task'},
                    seriesType: 'bars',
                    series: {5: {type: 'line'}},
                    height: 400,
                };
                var chart = new google.visualization.ComboChart(document.getElementById('DepDiff'));
                chart.draw(data, options);
                //////////////////////////////////////////////////////////////////////



            }
            google.charts.load("current", {packages: ["calendar"]});
            google.charts.setOnLoadCallback(Calender);

            function Calender() {
//                alert("hello");
                var dataTable = new google.visualization.DataTable();
//                alert("hello");
                dataTable.addColumn({type: 'date', id: 'Date'});
                dataTable.addColumn({type: 'number', id: 'Task'});

//                alert("hello");
                var Eyear = document.getElementById('taskyear').value;
                var Emonth = document.getElementById('taskmonth').value;
                var Eday = document.getElementById('taskday').value;
                var ID = document.getElementById('taskID').value;

                var Y = Eyear.split(',');
                var M = Emonth.split(',');
                var D = Eday.split(',');
                var I = ID.split(',');
                for (var i = 0; i < Y.length; i++) {
                    dataTable.addRow([new Date(Y[i], M[i], D[i]), parseInt((I[i]))]);


                }

                var chart = new google.visualization.Calendar(document.getElementById('calendar_basic'));

                var options = {
                    title: "Task Calendar",
                    height: 350,
                    calendar: {cellSize: 15},
                    calendar: {
                        cellColor: {
//                            color: '#990066',
//                            stroke: '#990066',
                            strokeOpacity: 0.5,
                            strokeWidth: 1,
                        },
                        focusedCellColor: {
                            stroke: '#990066',
                            strokeOpacity: 1,
                            strokeWidth: 1,
                        },
                        monthOutlineColor: {
                            stroke: '#990066',
                            strokeOpacity: 0.8,
                            strokeWidth: 2
                        }

                    },
//                        background-color:'#990066'
                    color: '#990066',
                };

                chart.draw(dataTable, options);
            }
            function ShowData(value) {
                xmlHttp = GetXmlHttpObject();
//                alert(value);
                var url = "Search";
                url = url + "?name=" + value;
//                alert(url);
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




        </script> 


        <style>h1{

                color: #721050;
                /*                color:indianred*/

                font-size: 50px;
                text-align: center;
                text-decoration: none;

            }</style>
        <script type="text/javascript" src="/assets/script/canvasjs.min.js"></script>
        <link rel="stylesheet" href="css/Charts.css">
        <!--<link rel="stylesheet" href="css/format.css">-->


    </head>

    <body>


        <!--<header class="block">-->


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
                    <button class="Listbtn"style="background-position: 6px 7px;" ></button>
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
                    <span class="numberOfNotif"  style="    margin: -57px 0px 0 34px;"><% if (!notifi.get(0).equals("<a class=noti href=#>Don`t have Notifications </a>")) {
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

        <h1 style="color: #16417E; text-shadow:  1px 1px  #000 ;">TMS Dashboard</h1>
        <table   border=1 frame=hsides bordercolor="#ccc" style="border-bottom:  .5px solid #ccc;box-shadow: 5px; width: 1310px;margin: auto "cellspacing="0" cellpadding="0">

            <% if (session.getAttribute("type").equals(1)) {%>
            <tr class="header_tab"><td>Department tasks` distribution</td>
                <td>campaign tasks` distribution</td> </tr>
            <tr><td name="pieDepartment"> <div id="chart_div"></div></td>

                <td name="pieCamp"> <div id="CampPie" ></div></td></tr>


            <tr>
            <tr class="header_tab"><td  align="center" colspan="3">Tasks` progress </td></tr>




            <td align="center" colspan="3"> <div id="chart_div2" ></div></td>

        </tr>

        <tr class="header_tab"><td>Members` evaluation </td><td>Heads` evaluation</td></tr>

        <tr> 
            <td name="MemberEv">  
                <div id="visualization" ></div>
            </td>
            <td name="HeadEV"><div id="HeadBar"></div></td>
        </tr>
        <tr class="header_tab"><td  align="center" colspan="3">Actual versus planned </td></tr>

        <tr>
            <td name="progressDiff" align="center" colspan="3">  
                <div name="diff" id="diff"></div>

            </td>
        </tr>
        <tr class="header_tab"><td  align="center" colspan="3">Task Calender</td></tr>


        <tr><td align="center" colspan="3"><div id="calendar_basic"></div>



            </td></tr>

        <%} else if (session.getAttribute("type").equals(2)) {%>
        <tr class="header_tab"><td  align="center" colspan="3">Rating</td></tr>

        <tr> <td name="Rating" align="center" colspan="3"> <div id="scatter" ></div></td>
        </tr> 
        <tr class="header_tab"><td  align="center" colspan="3">Actual</td></tr>

        <tr><td align="center" colspan="3"><div id="DepDiff"></div></td></tr>
        <tr class="header_tab"><td  align="center" colspan="3">Members` evaluation</td></tr>

        <tr> 
            <td name="MemberEv" align="center"  colspan="3">  
                <div  id="visualization" ></div>
            </td></tr>
        <tr class="header_tab"><td  align="center" colspan="3"> evaluation</td></tr>

        <tr> <td name="Ev" align="center" colspan="3"> <div id="Eval2" ></div></td>

        </tr>


        <%} else {%>
        <tr class="header_tab"><td  align="center" colspan="3">Rating</td></tr>

        <tr> <td name="Rating" align="center" colspan="3"> <div id="scatter" ></div></td>
        </tr>
        <tr class="header_tab"><td  align="center" colspan="3">evaluation</td></tr>

        <tr> <td name="Ev" align="center" colspan="3"> <div id="Eval" ></div></td>


        </tr>
        <% }%>
    </table>
    <div id="table_div"></div>

    <%

        String URL = "jdbc:mysql://localhost:3306/orgi";
        Class.forName("com.mysql.jdbc.Driver");

        Connection con = DriverManager.getConnection(URL, "root", "root");
        Statement st = con.createStatement();
        String sql = "select Distinct Dep_ID from acc_dep_sa where Sa_ID=" + session.getAttribute("SAID");
        ResultSet rs = st.executeQuery(sql);

        int SAID = Integer.parseInt(String.valueOf(session.getAttribute("SAID")));
        ArrayList<Integer> list = new ArrayList<Integer>();
        Report report = new Report();
        list = report.GetDepName(SAID);

        String reading = "[";
        String DepName = "";
        String TaskCount = "";
        String Finish = "";
        String NFinish = "";
        con.close();
        for (int i = 0; i < list.size(); i++) {

            con = DriverManager.getConnection(URL, "root", "root");

            st = con.createStatement();
            sql = "select name, ID,Count(Dep_ID) from acc_dep_task,Departement where Dep_ID=ID and acc_dep_task.Dep_ID=" + list.get(i);
            rs = st.executeQuery(sql);
            while (rs.next()) {
                if (i == 0) {
                    DepName += rs.getString("name");
                    TaskCount += rs.getInt("Count(Dep_ID)");

                } else if (i == list.size()) {
                    DepName += rs.getString("name");
                    TaskCount += rs.getInt("Count(Dep_ID)");

                } else {
                    DepName += "," + rs.getString("name");
                    TaskCount += "," + rs.getInt("Count(Dep_ID)");
                }

            }
              con.close();

        }
//         con.close();
        for (int i = 0; i < list.size(); i++) {
            con = DriverManager.getConnection(URL, "root", "root");

            st = con.createStatement();
            sql = "select Count(Dep_ID) from acc_dep_task,Departement where Dep_ID=ID and finished =1 and acc_dep_task.Dep_ID=" + list.get(i);
            rs = st.executeQuery(sql);
            while (rs.next()) {
                if (i == 0) {
                    Finish += rs.getInt("Count(Dep_ID)");
                } else {
                    Finish += "," + rs.getInt("Count(Dep_ID)");
                }

            }
              con.close();

        }

//   
    %>

    <Br>
    <input type="text" id="label"  value="<%=DepName%>" hidden/>
    <Br><input type="text" id="value"  value="<%=TaskCount%>" hidden /><br
        <Br><input type="text" id="finish"  value="<%=Finish%>" hidden /><Br>

    <input type="" id="title"  value="Departments" hidden/>

    <%
        ArrayList<String> CampName = new ArrayList<String>();
        ArrayList<Integer> CampID = new ArrayList<Integer>();
        String CamName = "";
        String TaskCam = "";
         con = DriverManager.getConnection(URL, "root", "root");

        st = con.createStatement();
        sql = "select ID,name from campagin where Sa_ID=" + session.getAttribute("SAID");
        rs = st.executeQuery(sql);
        while (rs.next()) {
            CampName.add(rs.getString("name"));

            CampID.add(rs.getInt("ID"));
        }
        int counter = 0;
con.close();
        for (int i = 0; i < CampName.size(); i++) {
             con = DriverManager.getConnection(URL, "root", "root");

            st = con.createStatement();
            sql = "select Count(Camp_ID) from acc_task_camp where Camp_ID=" + CampID.get(i);
            rs = st.executeQuery(sql);

            while (rs.next()) {

                if (counter == 0) {
                    CamName += CampName.get(i);
                    TaskCam += rs.getInt("Count(Camp_ID)");

                } else {
                    CamName += "," + CampName.get(i);
                    TaskCam += "," + rs.getInt("Count(Camp_ID)");
                }
                counter++;
            }
            con.close();
        }
    %>

    <input type="text" id="CamLabel"  value="<%=CamName%>" hidden/>
    <Br><input type="text" id="CamValue"  value="<%=TaskCam%>" hidden />


    <%

        ArrayList<String> list2 = new ArrayList<String>();
        list2 = report.getAllTaskTime(SAID);
        String Cday = String.valueOf(list2.get(5));;
        String Cmonth = String.valueOf(list2.get(4));
        String Cyear = String.valueOf(list2.get(3));;
        String Eday = String.valueOf(list2.get(2));;
        String Emonth = String.valueOf(list2.get(1));;
        String Eyear = String.valueOf(list2.get(0));;
        String StartDate = String.valueOf(list2.get(0));
        String EndDate = String.valueOf(list2.get(1));
        String TName = String.valueOf(list2.get(6));


    %>
    <input type="text" id="Eday"  value="<%=Eday%>" hidden/>
    <input type="text" id="Eyear"  value="<%=Eyear%>" hidden/>
    <input type="text" id="Emonth"  value="<%=Emonth%>" hidden/>
    <input type="text" id="Cday"  value="<%=Cday%>" hidden/>
    <input type="text" id="Cmonth"  value="<%=Cmonth%>" hidden/>
    <input type="text" id="Cyear"  value="<%=Cyear%>" hidden/>
    <input type="text" id="TName"  value="<%=TName%>" hidden/>




    <%

        String TsName = "";
        String TaskRate = "";
        String Star = "";
         con = DriverManager.getConnection(URL, "root", "root");

        st = con.createStatement();
        sql = "select Distinct name,NumberOfStar,rate from task,acc_dep_task,acc_dep_sa where Task_ID=ID and SA_ID=" + session.getAttribute("SAID") + " and (rate IS NOT NULL or rate <> 50 ) and acc_dep_task.Acc_ID=" + session.getAttribute("uID");
        rs = st.executeQuery(sql);
        counter = 0;
        while (rs.next()) {
            if (counter == 0) {
                TsName += rs.getString("name");
                TaskRate += rs.getInt("rate");
                Star += rs.getInt("NumberOfStar");

            } else {
                TsName += "," + rs.getString("name");
                TaskRate += "," + rs.getInt("rate");
                Star += "," + rs.getInt("NumberOfStar");

            }
            counter++;
        }
        con.close();


    %>


    <Br><input type="text" id="taskN"  value="<%=TsName%>" hidden />

    <Br><input type="text" id="RateT"  value="<%=TaskRate%>" hidden />

    <Br><input type="text" id="Star"  value="<%=Star%>" hidden />
    <Br><input type="text" id="dep"   hidden />


    <%

        UserModel user = new UserModel();
        ArrayList<UserModel> _user = new ArrayList<UserModel>();
        _user = user.getEv(SAID, 0);
        String Eva = "", MemberName = "";
        for (int i = 0; i < _user.size(); i++) {
            if (i == 0) {

                Eva += _user.get(i).getEvaluation();
                MemberName += _user.get(i).getFName();

            } else {

                Eva += "," + _user.get(i).getEvaluation();
                MemberName += "," + _user.get(i).getFName();

            }

        }


    %>

    <input type="hidden"  id="Eva" value="<%=Eva%>"/>
    <input type="hidden"  id="MemberName" value="<%=MemberName%>"/>
    <%

        UserModel user1 = new UserModel();
        ArrayList<UserModel> _user1 = new ArrayList<UserModel>();
        _user1 = user.getEv(SAID, 2);
        String Eva2 = "", MemberName2 = "";
        for (int i = 0; i < _user1.size(); i++) {
            if (i == 0) {

                Eva2 += _user1.get(i).getEvaluation();
                MemberName2 += _user1.get(i).getFName();

            } else {

                Eva2 += "," + _user1.get(i).getEvaluation();
                MemberName2 += "," + _user1.get(i).getFName();

            }

        }


    %>

    <input type="hidden"  id="HEva" value="<%=Eva2%>"/>
    <input type="hidden"  id="HName" value="<%=MemberName2%>"/>
    <%

        ArrayList<String> list3 = new ArrayList<String>();
        list3 = report.getAllTaskTime(SAID);
        String DEday = String.valueOf(list3.get(5));
        String DEmonth = String.valueOf(list3.get(4));
        String DEyear = String.valueOf(list3.get(3));
        String DCday = String.valueOf(list3.get(2));
        String DCmonth = String.valueOf(list3.get(1));
        String DCyear = String.valueOf(list3.get(0));
        String DCStartDate = String.valueOf(list3.get(0));
        String DCEndDate = String.valueOf(list3.get(1));
        String DTName = String.valueOf(list3.get(6));

//            out.print("1 yes");

    %>
    <input type="text" id="DEday"  value="<%=DEday%>" hidden/>
    <input type="text" id="DEyear"  value="<%=DEyear%>" hidden/>
    <input type="text" id="DEmonth"  value="<%=DEmonth%>" hidden/>
    <input type="text" id="DCday"  value="<%=DCday%>" hidden/>
    <input type="text" id="DCmonth"  value="<%=DCmonth%>" hidden/>
    <input type="text" id="DCyear"  value="<%=DCyear%>" hidden/>
    <input type="text" id="DTName"  value="<%=DTName%>" hidden/>

    <%
//            out.print(" 2 yes");
        String Eval = report.Evaluation(Integer.parseInt(String.valueOf(session.getAttribute("uID"))));
        //        out.print("yes" + Eval);
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

                    Task += "," + Evalu2[0];
                    Ev += "," + Evalu2[1];
                }

            }

    %>

    <input type="text" id="TaskNameE" value="<%=Task%>" hidden/>

    <br>  <input type="text" id="EVE" value="<%=Ev%>"hidden/>


    <%}
        ArrayList<String> list4 = new ArrayList<String>();
        list4 = report.getTaskSA(SAID);
        String day = String.valueOf(list4.get(2));
        String month = String.valueOf(list4.get(1));
        String year = String.valueOf(list4.get(0));
        String TID = String.valueOf(list4.get(3));


    %>
    <input type="text" id="taskday"  value="<%=day%>" hidden/>
    <input type="text" id="taskyear"  value="<%=year%>" hidden/>
    <input type="text" id="taskmonth"  value="<%=month%>" hidden/>
    <input type="text" id="taskID"  value="<%=TID%>" hidden/>


</body>
</html>
