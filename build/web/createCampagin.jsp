<%-- 
    Document   : createCampagin
    Created on : 13-Feb-2017, 14:15:16
    Author     : rabab
--%>

<%@page import="java.util.ArrayList"%>
<%@page import="model.Notification"%>
<%@page import="java.util.Calendar"%>
<%@page import="java.util.Date"%>
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

            function ShowData3(value) {
                xmlHttp = GetXmlHttpObject();
                var url = "taskDependency";
                url = url + "?name2=" + value + "&taskDep=no";
//                      alert(url);
                xmlHttp.onreadystatechange = stateChanged3
                xmlHttp.open("GET", url, true)
                xmlHttp.send(null)

            }


            function stateChanged3() {
                if (xmlHttp.readyState == 4 || xmlHttp.readyState == "complete") {

                    var Showdata = xmlHttp.responseText;
                    alert(ShowData());
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
                    alert(_date);



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




        <%
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
        %>



        <h1 style="font-size: 50px; color:#0a426c "> Create Campaign Form</h1>


        <div class="General_Camp">

            <!--<div Class="createSA"></div>-->

            <table>
                <form action="campaginController">

                    <tr><td><h class="Information_Create_Camp">Name: </h></td><td> <input type="text" name="campName" placeholder="Campaign name" required/> </td></tr>
                    <tr><td><h class="Information_Create_Camp">Description:</h> </td><td>  <input type="text" placeholder="Campaign description" name="campDesc" required /></td></tr>
                    <tr><td><h class="Information_Create_Camp"> Start date:  </h></td><td>  <input type="date" min="<%=_date%>" value="<%=_date%>" name="campStDate"  onchange="ShowData3(this.value);" required/></td></tr>
                    <tr><td><h class="Information_Create_Camp"> End date:  </h></td><td>  <input type="date" min="<%=_date%>" value="<%=_date%>"name="campEnDate" required/></td></tr>
                    <tr><td><h class="Information_Create_Camp"> Start time: </h>  </td><td> <input type="time"  min="<%=_time%>" value="<%=_time%>"name="campSttime" required /></td></tr>
                    <tr><td><h class="Information_Create_Camp"> End time: </h> </td><td>  <input type="time" value="<%=_time%>"name="campEnTime" required/></td></tr>
                    <tr><td> <button class="btnnCreateD" name="type" value="createCampagin" style="right: 50px;top:420px ">Create Campaign</button></td></tr>
                </form>
            </table>

        </div></div>
</body>
</html>
