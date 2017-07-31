<%-- 
    Document   : campProgress
    Created on : 21-Apr-2017, 19:56:01
    Author     : rabab
--%>

<%@page import="model.Notification"%>
<%@page import="java.util.Calendar"%>
<%@page import="java.util.Date"%>
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
             <link rel="stylesheet" href="css/styleTask.css">
              <link rel="stylesheet" href="css/styleTask.css">

        <link rel="stylesheet" href="css/General.css">

        <link rel="stylesheet" href="css/Charts.css">
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

        
        
        
                <h1 style="font-size: 50px;color: #0a426c">Late Tasks</h1>
        
        <%
        String URL = "jdbc:mysql://localhost:3306/orgi";
            Class.forName("com.mysql.jdbc.Driver");
            Connection con = DriverManager.getConnection(URL, "root", "root");
            Statement st = con.createStatement();
           String sql = "select * from task ,acc_task_camp where .task.ID=acc_task_camp.Task_ID and finished is NULL and  Camp_ID=" + session.getAttribute("CampID");
            ResultSet rs = st.executeQuery(sql);
            ArrayList<Integer> list = new ArrayList<Integer>();
            ArrayList<String> listName = new ArrayList<String>();
            ArrayList<Integer> listPercentage = new ArrayList<Integer>();
             ArrayList<Integer> listDuration = new ArrayList<Integer>();
        ArrayList<Integer> listDurationCur = new ArrayList<Integer>();
        ArrayList<String> FileTask = new ArrayList<String>();
          ArrayList<Integer> listAccID = new ArrayList<Integer>();
          ArrayList<Double> listDurationLate = new ArrayList<Double>();


            while (rs.next()) {
int monthConsEnd;
            int monthConsStrt;
            int monthConsCur;
            list.add(rs.getInt("ID"));
            listName.add(rs.getString("Name"));
            listPercentage.add(rs.getInt("percentage"));
            FileTask.add(rs.getString("task_File"));
            listAccID.add(rs.getInt("Acc_ID"));
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
          listDurationCur.add(durYearCur + durMonthCur + durDayCur);
          listDurationLate.add((Double)((durYear + durMonth + durDay)*.2));

          }
             con.close();
          
            %><table>
       <%
            for (int i = 0; i < list.size(); i++) {
                  
                if(listAccID.get(i)==0){
                 %>
           <tr><td> <br><a href="dep?param1=<%=listName.get(i)%>&param2=<%=list.get(i)%>&param3=<%=listPercentage.get(i)%>&param4=TaskCam&param5=<%=FileTask.get(i)%>&param6=mediumvioletred"><%=listName.get(i)%> </a></td>
                <td> <div class="progress-bar mediumvioletred stripes" >
                        <span  id="s" class="w" value="Not Assigned" style="width :0%; text-decoration-color: #721050; text-align: center; ">Not Assigned</span>
                    </div></td>
                </a></tr><%
                }
                
                
               else if (listPercentage.get(i) == 100) {
            %>
            <tr><td> <br><a href="dep?param1=<%=listName.get(i)%>&param2=<%=list.get(i)%>&param3=<%=listPercentage.get(i)%>&param4=TaskCam&param5=<%=FileTask.get(i)%>&param6=mediumvioletred"><%=listName.get(i)%> </a></td>
                <td> <div class="progress-bar mediumvioletred stripes" >
                        <span  id="s" class="w" style="width :<%=listPercentage.get(i) + "%"%> ; color: white ; text-align: center ; text-shadow: .5 px" > <%=listPercentage.get(i) + "%"%></span>
                    </div></td>
                </a></tr><%
            } else if (listDurationCur.get(i) <= Math.ceil(listDurationLate.get(i))) {%>
            <tr><td> <br><a href="dep?param1=<%=listName.get(i)%>&param2=<%=list.get(i)%>&param3=<%=listPercentage.get(i)%>&param4=TaskCam&param5=<%=FileTask.get(i)%>&param6=red"><%=listName.get(i)%> </a></td>
                <td> <div class="progress-bar red stripes" >
                        <span  id="s" class="w" style="width :<%=listPercentage.get(i) + "%"%> ; color: white ; text-align: center ; text-shadow: .5 px" > <%=listPercentage.get(i) + "%"%></span>
                    </div></td>
                </a></tr>
            <% } else if ((listDuration.get(i) / 2) >= listDurationCur.get(i)) {%> <tr><td> <br><a href="dep?param1=<%=listName.get(i)%>&param2=<%=list.get(i)%>&param3=<%=listPercentage.get(i)%>&param4=TaskCam&param5=<%=FileTask.get(i)%>&param6=yellow"><%=listName.get(i)%> </a></td>
                <td> <div class="progress-bar yellow stripes" >
                        <span  id="s" class="w" style="width :<%=listPercentage.get(i) + "%"%> ; color: white ; text-align: center ; text-shadow: .5 px" > <%=listPercentage.get(i) + "%"%></span>
                    </div></td>
                </a></tr>
                <%
                } else {%>
            <tr><td> <br><a href="dep?param1=<%=listName.get(i)%>&param2=<%=list.get(i)%>&param3=<%=listPercentage.get(i)%>&param4=TaskCam&param5=<%=FileTask.get(i)%>&param6=green"><%=listName.get(i)%> </a></td>
                <td> <div class="progress-bar green stripes" >
                        <span  id="s" class="w" style="width :<%=listPercentage.get(i) + "%"%> ; color: white ; text-align: center ; text-shadow: .5 px" > <%=listPercentage.get(i) + "%"%></span>
                    </div></td>
                </a></tr>
                <% }

                    }

                %>

        
    </table>
    </body>
</html>
