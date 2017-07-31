<%@page import="model.Notification"%>
<%@page import="java.util.Calendar"%>
<%@page import="java.util.Date"%>
<%@page import="java.util.ArrayList"%>
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
        <script type="text/javascript" src="js/Task.js"></script>
        <link rel="stylesheet" href="css/styleTask.css">
        <link rel="stylesheet" href="css/General.css">
        <!--<link rel="stylesheet" href="css/format.css">-->
        <link rel="stylesheet" href="css/Charts.css">

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



        </ul>
                <br>

    <div class="All-Information" style="position: absolute; top: 100px;">
          
    <h1 style="text-align: center;"> <%= request.getParameter("param1")%> </h1>

        </div>
            
        <%
            String campName = request.getParameter("param1");
            session.setAttribute("CampName", campName);
            int campID = Integer.parseInt(request.getParameter("param2"));
            session.setAttribute("CampID", campID);

            String URL = "jdbc:mysql://localhost:3306/orgi";
            Class.forName("com.mysql.jdbc.Driver");
            Connection con = DriverManager.getConnection(URL, "root", "root");
            Statement st = con.createStatement();
            String sql = "select * from campagin where ID = " + campID;
            ResultSet rs = st.executeQuery(sql);
            while (rs.next()) {
        %>

        <!--<div class="All-Information"style="position: static; margin: 100px 30px ">-->
        <div class="camp-Information"style="top: 200px;padding-bottom: 15px;line-height: 40px;">
<!--        <p class="Info">-->
<table>
    <tr><td style="font-weight: bold ; color:#aabcc6 ">  <%
                out.print("Description      " ); %> </td> <td><%
                out.print(rs.getString("Description")); %> </td><tr><td style="font-weight: bold ; color:#aabcc6"> <%
                out.print("Start Date ");%> </td> <td><%
                out.print(rs.getString("startDate")) ;%> </td><tr><td style="font-weight: bold ; color:#aabcc6"> <%
                out.print("End Date ");%> </td> <td><%
                out.print(rs.getString("endDate")); %></td><tr><td style="font-weight: bold ; color:#aabcc6"> <%
                out.print("Start Time ");%> </td> <td><%
                out.print(rs.getString("startTime"));  %></td><tr><td style="font-weight: bold ; color:#aabcc6"> <%
                out.print("End Time ");%> </td> <td><%
                out.print(rs.getString("endTime")); %></td><tr><td style="font-weight: bold ; color:#aabcc6"> <%
            //                      out.print("EndTime  " + session.getAttribute("CampID")); %>  <%

                }
            con.close();
            //        %>
            </table>
            <!--</p>-->
        </div>
        <!--</div>-->
        <%
             con = DriverManager.getConnection(URL, "root", "root");
            sql = "select Distinct endDate,startDate,Name,ID,percentage,Acc_ID,finished from task , acc_task_camp where ID = Task_ID and Camp_ID = " + session.getAttribute("CampID");
            st = con.createStatement();
            rs = st.executeQuery(sql);
            %><div class="camp-Information"style="top: 380px;padding-bottom: 15px;margin-top: 180px;"><h1 style="font-size: 30px; "><%
                out.print("Campaign Tasks");
        %></h1><% ArrayList<Integer> listDuration = new ArrayList<Integer>();
                ArrayList<Integer> listDurationCur = new ArrayList<Integer>();
                ArrayList<String> campTasksName = new ArrayList<String>();
                ArrayList<Integer> campTasksID = new ArrayList<Integer>();
                ArrayList<Integer> campTasksPercentge = new ArrayList<Integer>();
    //                               ArrayList<Integer> campTasksfinished = new ArrayList<Integer>();
                //                               ArrayList<Integer> campTasksAcc_ID = new ArrayList<Integer>();
                ArrayList<String> campTasksColor = new ArrayList<String>();
                ArrayList<Double> listDurationLate = new ArrayList<Double>();

                while (rs.next()) {
                    String k = rs.getString("Name");
                    campTasksName.add(k);
                    int j = rs.getInt("ID");
                    campTasksID.add(j);
                    int y = rs.getInt("percentage");
                    campTasksPercentge.add(y);
                    // out.print("samarrrrrr " + k);
                    int n = rs.getInt("Acc_ID");
                    int o = rs.getInt("finished");
                    if (n == 0) {
                        campTasksColor.add("Red");
                    } else if (o == 1) {
                        campTasksColor.add("Green");

                    } else {
                        campTasksColor.add("#DFD948");
                    }
                    int monthConsEnd;
                    int monthConsStrt;
                    int monthConsCur;

                    String str = rs.getString("startDate");
                    String str1[] = str.split("-");
                    String end = rs.getString("endDate");
                    String end1[] = end.split("-");

                    if (Integer.parseInt(end1[1]) <= 7) {
                        if (Integer.parseInt(end1[1]) == 2) {
                            monthConsEnd = 28;

                        } else if (Integer.parseInt(end1[1]) % 2 == 0) {
                            monthConsEnd = 30;
                        } else {
                            monthConsEnd = 31;
                        }

                    } else {
                        if (Integer.parseInt(end1[1]) % 2 == 0) {
                            monthConsEnd = 31;
                        } else {
                            monthConsEnd = 30;
                        }

                    }

    //            out.print("end : " + monthConsEnd + "<br>");
                    if (Integer.parseInt(str1[1]) <= 7) {
                        if (Integer.parseInt(str1[1]) == 2) {
                            monthConsStrt = 28;
                        } else if (Integer.parseInt(str1[1]) % 2 == 0) {
                            monthConsStrt = 30;
                        } else {
                            monthConsStrt = 31;
                        }

                    } else {
                        if (Integer.parseInt(str1[1]) % 2 == 0) {
                            monthConsStrt = 31;
                        } else {
                            monthConsStrt = 30;
                        }

                    }
    //            out.print(monthConsStrt);
                    int durYear = (Integer.parseInt(end1[0]) - Integer.parseInt(str1[0])) * 365;

                    int durMonth;
                    int durDay;
                    int durMonthCur;
                    int durDayCur;

                    Date date = new Date();
                    Calendar cal = Calendar.getInstance();
                    cal.setTime(date);
                    String year = String.valueOf(cal.get(Calendar.YEAR));
                    String month = String.valueOf(cal.get(Calendar.MONTH) + 1);
                    String day = String.valueOf(cal.get(Calendar.DAY_OF_MONTH));

                    if (Integer.parseInt(month) <= 7) {
                        if (Integer.parseInt(month) == 2) {
                            monthConsCur = 28;
                        } else if (Integer.parseInt(month) % 2 == 0) {
                            monthConsCur = 30;
                        } else {
                            monthConsCur = 31;
                        }

                    } else {
                        if (Integer.parseInt(month) % 2 == 0) {
                            monthConsCur = 31;
                        } else {
                            monthConsCur = 30;
                        }

                    }

                    int durYearCur = (Integer.parseInt(end1[0]) - Integer.parseInt(year)) * 365;

                    if (durYear == 0) {
                        if (monthConsEnd <= monthConsStrt) {
                            durDay = (Integer.parseInt(end1[2]) - Integer.parseInt(str1[2]));
                            durMonth = ((Integer.parseInt(end1[1]) - Integer.parseInt(str1[1]))) * monthConsStrt;
                        } else {

                            durDay = (Integer.parseInt(end1[2]) - Integer.parseInt(str1[2]));
                            durMonth = ((Integer.parseInt(end1[1]) - Integer.parseInt(str1[1]))) * monthConsEnd;

                        }
                    } else {
                        if (monthConsEnd <= monthConsStrt) {
                            durDay = ((Integer.parseInt(end1[2])) - Integer.parseInt(str1[2]));
                            durMonth = ((Integer.parseInt(end1[1] + 12) * -(Integer.parseInt(str1[1]))) * monthConsStrt);
                        } else {
                            durDay = ((Integer.parseInt(end1[2])) - Integer.parseInt(str1[2]));
                            durMonth = ((Integer.parseInt(end1[1] + 12) * -(Integer.parseInt(str1[1]))) * monthConsEnd);

                        }
                    }

                    if (durYearCur == 0) {
                        if (monthConsEnd <= monthConsCur) {
                            durDayCur = (Integer.parseInt(end1[2]) - Integer.parseInt(day));
                            durMonthCur = (Integer.parseInt(end1[1]) - Integer.parseInt(month)) * monthConsCur;
                        } else {
                            durDayCur = (Integer.parseInt(end1[2]) - Integer.parseInt(day));
                            durMonthCur = (Integer.parseInt(end1[1]) - Integer.parseInt(month)) * monthConsEnd;
                        }
                    } else {
                        if (monthConsEnd <= monthConsCur) {
                            durDayCur = ((Integer.parseInt(end1[2])) - Integer.parseInt(day));
                            durMonthCur = (Integer.parseInt(end1[1] + 12) - Integer.parseInt(month)) * monthConsCur;
                        } else {
                            durDayCur = (Integer.parseInt(end1[2]) - Integer.parseInt(day));
                            durMonthCur = (Integer.parseInt(end1[1] + 12) - Integer.parseInt(month)) * monthConsEnd;
                        }
                    }
                    listDuration.add(durYear + durMonth + durDay);
    //            out.print("<br>" + rs.getString("Name") + "<br>");
    //            out.println("   duration : " + (durYear + durMonth + durDay));
                    listDurationCur.add(durYearCur + durMonthCur + durDayCur);
                    listDurationLate.add((Double) ((durYear + durMonth + durDay) * .2));

    //       
                }
                con.close();
                for (int i = 0; i < campTasksName.size(); i++) {
                    if (campTasksName.size() > 0) {
                        String color;

                        if (campTasksPercentge.get(i) == 100) {
                            color = "mediumvioletred";
                        } else if (listDurationCur.get(i) <= Math.ceil(listDurationLate.get(i))) {
                            color = "red";

                        } else if ((listDuration.get(i) / 2) - 1 == listDurationCur.get(i) || (listDuration.get(i) / 2) == listDurationCur.get(i) || (listDuration.get(i) / 2) + 1 == listDurationCur.get(i)) {
                            color = "yellow";
                        } else {
                            color = "green";
                        }
        
                    %>    
               
            <!--</div>-->
  
        
        <a style="font-size: 27px;  color:#4E6B81"href="dep?param1=<%=campTasksName.get(i)%>&param2=<%=campTasksID.get(i)%>&param3=<%=campTasksPercentge.get(i)%>&param4=TaskCam&param6=<%=color%>" style="text-decoration: none; color: <%=campTasksColor.get(i)%>"><%=campTasksName.get(i)%></a><br>
   <%

            }
        }

    %>

    </div>
    <%        if (session.getAttribute("type").equals(1)) {
    %>
    <div class="all-post">
    <form action="campaginController">
        <input type="text" placeholder="what's on your mind" name="message" id="postcamp" />
        <button name="type" value="post"style="    position: absolute;
    margin: -84px 622px;">Post</button>
    </form></div>
    <%}
         con = DriverManager.getConnection(URL, "root", "root");
        st = con.createStatement();
        sql = "select * from post , account where account.ID = acc_ID and camp_ID = " + session.getAttribute("CampID")
                + " order by postDate desc , postTime desc";
        rs = st.executeQuery(sql);
        %>
        <div class="in-post">
        <%
        while (rs.next()) {%><div class="All-Information" id="postformat" ><br> <%
                String user_name = rs.getString("FName"); %><h style=" font-size: 25px;text-transform: capitalize"><%
                    out.print(user_name);%></h><br><%
            String mess = rs.getString("message"); %><br><%
            out.print("      " + mess);%><br><br><p12 style="color: #c5b4cb;"><%
                String date = rs.getString("postDate");
                out.print("  " + date);%><br><%

                String time = rs.getString("postTime");
                            out.print("      " + time);%></p12><%
            %>
        <div  style="position: relative;margin-left: 490px;margin-top: -50px ">            
            <form action="campaginController">
                <input type="hidden" name="postID" value="<%= rs.getInt("post.ID")%>"/>
                <button class="btnDel" name="type" value="delete_post">x</button>
            </form></div></div>
    <br><%                }
        con.close();
        if(session.getAttribute("type").equals(1)){
    %>
</div>

    <br>
    <div class="moveOpt">
        <div class="All-Information" id="SaOpt" style="padding-top: 15px;">
            <a id="SaOpt"href="createTask.jsp?param1=CampTask">Create Task  </a></div><br>
        <div class="All-Information" id="SaOpt" style=" padding-top: 15px;">
            <a id="SaOpt" href="UpdateCamp.jsp" >Update Campaign </a></div><br>
        <div class="All-Information" id="SaOpt" style=" padding-top: 15px;">
            <!--<a id="SaOpt"href="DeleteCamp.jsp">delete campaign </a></div>-->
            <a id="SaOpt"onclick="document.getElementById('id03').style.display = 'block'" >Delete Campaign </a>

  </div>

            <div id="id03" class="modal">

                <form class="modal-content animate" action="campaginController">


                    <div class="container">
                        <h1>Are you sure you want to delete ? </h1>

                        <%--<%= session.getAttribute("CampID") %>--%>

                        <button type="submit"  name="type" value="DeleteCamp">Delete  </button>
                    </div>

                    <div class="container" style="background-color:#f1f1f1">
                        <button type="button" onclick="document.getElementById('id03').style.display = 'none'" class="cancelbtn">Cancel</button>

                    </div></form>
            </div>

      
        <%
        }
            URL = "jdbc:mysql://localhost:3306/orgi";
            Class.forName("com.mysql.jdbc.Driver");
            con = DriverManager.getConnection(URL, "root", "root");
            st = con.createStatement();
            sql = "SELECT count(Task_ID) AS CountTask FROM acc_task_camp where Camp_ID = " + campID;
            int CountTasks = 0;
            int FinishedTask = 0;
            rs = st.executeQuery(sql);
            while (rs.next()) {
                CountTasks = rs.getInt("CountTask");

                if (CountTasks == 0) {
                    CountTasks = 1;
                }
            }con.close();
 con = DriverManager.getConnection(URL, "root", "root");
            st = con.createStatement();
            sql = "SELECT count(Task_ID) AS CountTask FROM acc_task_camp where Camp_ID=" + campID + " and finished = 1";
            rs = st.executeQuery(sql);
            while (rs.next()) {
                FinishedTask = rs.getInt("CountTask");
              
            }
            con.close();

            double per = (double) ((double) FinishedTask / (double) CountTasks) * 100;

        %>
        <br> <br>
        <div class="campBar">
    <h style="font-size: 30px;position: absolute;top:-130px;right: 150px;"><%="Tasks'Progress"%></h>
    <div class="progress-bar purple stripes" style="position: absolute;top:-140px; right: 40px">
            <a href="campProgress.jsp" style="text-decoration:none"> 
            <span  id="s" class="w" style="width :<%= per + "%"%> ; color: white ; text-align: center; text-shadow: .5 px" > <%=per + "%"%></span>
        </div>
        </a>
    </div>

    </body>





</html>
