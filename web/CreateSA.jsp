<%-- 
    Document   : CreateSA
    Created on : 12-Feb-2017, 18:13:14
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


        <link rel="stylesheet" href="css/General.css">
        <link rel="stylesheet" href="css/Charts.css">
        <link rel="stylesheet" href="css/General_Creation.css">


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
                    colors: ["#7C083D", "#FF127E", "gold"],
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
                    colors: ["#0B2B6F", "#3574F9", "gold"],
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



        
                <h1 style="font-size: 50px; color:#0a426c "> Create Student Activity Form </h1>


        <div class="General_c">
            
            <div Class="createSA"></div>

            <div class="TableCreate">
            <form action="StudentActivityController" >
                <table>   
                    <tr><td> <h class="Information_Create">  Student Activity Name </h> </td> <td><input type="text" name="Sname" placeholder="Student activity name " style="width: 200%" required></td></tr>
              <tr><td>  <h class="Information_Create"> Student Activity Location </h> </td> <td><input type="text" name="address" placeholder="Student activity address " style="width: 200%" required></td></tr>
                </table>
                 <input class="btnnCreate" type="submit"  name="studentActivity" value="Create" >
              
            </form>
            </div>
            
        </div>



    </body>
</html>
