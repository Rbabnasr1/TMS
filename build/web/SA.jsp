<%-- 
    Document   : SA
    Created on : 12-Feb-2017, 15:46:12
    Author     : rabab
--%>

<%@page import="model.Department"%>
<%@page import="model.studentActivity"%>
<%@page import="model.Notification"%>
<%@page import="java.sql.ResultSet"%>
<%@page import="java.sql.DriverManager"%>
<%@page import="java.util.ArrayList"%>
<%@page import="java.sql.Statement"%>
<%@page import="java.sql.Connection"%>
<%@page contentType="text/html" pageEncoding="UTF-8"%>
<!DOCTYPE html>
<html>
    <head>
        <link rel="stylesheet" href="css/General.css">
        <!--<link rel="stylesheet" href="css/format.css">-->
        <link rel="stylesheet" href="css/Charts.css">
        <meta http-equiv="Content-Type" content="text/html; charset=UTF-8">
        <title>JSP Page</title>
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
        <style>
            a{
                color: black;
                font-size: 50px;
                text-align: center;
                text-decoration: none;
            }
            a:hover{
                color: #4ca916;
            }
            h.Welcome{
                color: darkcyan;
                font-size: 50px;
                text-align: center;
                text-decoration: none;
                padding: 28%;


            }
            input{

                width: 300px;
                height: 30px;

            }
            #cover-container{
                width: 100%;
                height: 300px;
                overflow: hidden;
                image-resolution: 200dpi snap;
                -webkit-transform: rotate(360deg);
                -moz-transform: rotate(360deg);
                -o-transform: rotate(360deg);
                -ms-transform: rotate(360deg);
                transform: rotate(360deg);
                -webkit-image-resolution: 200dpi snap;
                -moz-image-resolution: 200dpi snap;
                -ms-image-resolution: 200dpi snap;
                -o-image-resolution: 200dpi snap;
                border-bottom-style: solid;
                border-bottom-style: solid;
                border-bottom: 500px;
                box-shadow: 0 1px 3px #000 ;

            }

            #coverImage
            {min-height: 100%;
             min-width: 1024px;
             width: 100%;
             height: 80%;
             position: fixed;
             top: 0;
             /*left: auto;*/
            }
            @media screen and (max-width: 1024px) { /* Specific to this particular image */
                #coverImage {
                    left: 50%;
                    margin-left: -512px;   /* 50% */

                }
            }
        </style>
    </head>
    <body>
        <%
            if (!request.getParameter("param4").equals(null)) {
                session.setAttribute("cover", request.getParameter("param4"));
            }
        %>

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
        <%  boolean Owner = false;

            boolean Head_Dep = false;
            boolean persidnt = false;
            studentActivity StudentA = new studentActivity();
            Owner = StudentA.CheckSA_ID(Integer.parseInt(String.valueOf(session.getAttribute("uID"))), Integer.parseInt(request.getParameter("param2")));
            Department depart = new Department();
            Head_Dep = depart.CheckDep_ID(Integer.parseInt(String.valueOf(session.getAttribute("uID"))), Integer.parseInt(String.valueOf(session.getAttribute("depID"))));
       //                out.print(Head_Dep + " "+Owner);
            persidnt = StudentA.GetPer(Integer.parseInt(String.valueOf(session.getAttribute("uID"))), Integer.parseInt(request.getParameter("param2")));


        %><%  if (session.getAttribute("type").equals(1) && Owner) {%>
        <div id="cover-container">

            <a href="UpdateCover.jsp">
                <a  onclick="document.getElementById('id10').style.display = 'block'" style="width:auto;">
                    <img id="coverImage" src="<%="Image\\" + session.getAttribute("cover")%>"   class="rotate90" title="Cover" /></a></div>
                    <%} else {%>
        <div id="cover-container">


            <img id="coverImage" src="<%="Image\\" + session.getAttribute("cover")%>"   class="rotate90" title="Cover" />
        </div>  <%}%>

         <div id="id10" class="modal">

            <form class="modal-content animate" method="post" enctype="multipart/form-data" action="StudentActivityController">


                <div class="Popcontainer">
                    <label><b>Photo</b></label><br>
                    <br><br>
                    <img id="profileImage" src="<%="Image\\" + request.getParameter("param2")%>"   class="rotate360"  />
                    <br>
                    <input  type="file"  id = "mg" name="image" placeholder="Photo" required="" capture />
                    <input type="submit" value="uploadCover" name="studentActivity" onclick="this.display = 'none'" style="width:auto;" />

                </div>

                <div class="Popcontainer" style="background-color:#f1f1f1">
                    <button type="button" onclick="document.getElementById('id10').style.display = 'none'" class="cancelbtnn">Cancel</button>

                </div>
            </form>

        </div>



        
        
        
        
        <!--<h1>-->
            <%

                if (request.getParameter("param1") != null) {
            %>
            <!--<div class="All-Information" style="opacity: 0.2;color:white;background-color: #000; margin-left: 1250px;margin-top: -90px;width: 200px"><p style="z-index: 1; color: white;font-weight:  bold">Student Activity</p></div>-->

            <div class="All-Information" style="background-color: #F3F4F7; margin-top: 20px;" >
                <p style="font-size: large; color: #4E6B81;text-align: center;"> 
                    <%
                        out.print(" " + request.getParameter("param1"));
                    %><br><%out.print("Created on : " + request.getParameter("param3"));

                        session.setAttribute("SAName", request.getParameter("param1"));
                        session.setAttribute("SAID", request.getParameter("param2"));
                        session.setAttribute("CreatuinDate", request.getParameter("param3"));
                    %>
                </p></div>
                <%
                } else {
                %>
            <p>
                <%
                    out.print("Student Activity Name : " + session.getAttribute("SAName"));
                %>
            </p>

            <%
                }

                boolean found = false;
                String URL = "jdbc:mysql://localhost:3306/orgi";
                Class.forName("com.mysql.jdbc.Driver");
                ResultSet rs;
                Connection con = DriverManager.getConnection(URL, "root", "root");
                Statement st = con.createStatement();
                String sql = "";
                if (!session.getAttribute("type").equals(-1)) {

            %>
        <!--</h1>-->

        <%    if (session.getAttribute("type").equals(1) && Owner) {
        %>
        
        <div class="all-post" style="top: 530px;">
        <form action="StudentActivityController">
            <input type="text" placeholder="what's on your mind" name="message" id="postcamp" />
            <button name="studentActivity" value="post" style="size: 60px;position: absolute;    margin: -89px 642px">Post</button> 
        </form>
</div>



        <%}

//            out.print(Head_Dep + " " + Owner + session.getAttribute("depID") + " " + request.getParameter("param2"));
            if (Owner) {
                 con = DriverManager.getConnection(URL, "root", "root");
               
                st = con.createStatement();
                sql = "select * from post , account where account.ID = acc_ID and sa_ID = " + session.getAttribute("SAID")
                        + " order by postDate desc , postTime desc";
                rs = st.executeQuery(sql);
//            out.print("SA Posts :  ");%><br>
<div class="in-post" style="top: 700px">
<%
                while (rs.next()) {%><div class="All-Information" id="postformat" <br> <%
        String user_name = rs.getString("FName"); %><br><h style="; font-size: 25px;text-transform: capitalize"><%
                            out.print(user_name);%></h><br><%
                                    String mess = rs.getString("message"); %><br><%
                                    out.print("      " + mess);%><br><br><p12 style="color: #c5b4cb;"><%

                                String date = rs.getString("postDate");
                                                out.print("  " + date); %><br><%
                                                String time = rs.getString("postTime");
                                                            out.print("      " + time);%></p12><%

                %>
                <!--<a href="StudentActivityController?param1=<%=session.getAttribute("SAName")%>&param2=<%=session.getAttribute("SAID")%>&param3=<%=session.getAttribute("CreatuinDate")%>&param5=<%= rs.getInt("post.ID")%>" class= "delete_post"  name="studentActivity" value="delete_post" style="font-size: 20px">x</a>-->                     
            <%if (session.getAttribute("type").equals(1)) {%>
            <div id="movDel" style="position: relative;margin-left: 490px;margin-top: -50px "><form action="StudentActivityController?param1=<%=session.getAttribute("SAName")%>&param2=<%=session.getAttribute("SAID")%>&param3=<%=session.getAttribute("CreatuinDate")%>">   
                    <input type="hidden" name="postID"  value="<%= rs.getInt("post.ID")%>"/>
                    <button class="btnDel" name="studentActivity" value="delete_post">x</button>
                </form></div><%}%>
            <br></div><br><br>
            <%       }
                con.close();
                }

            %></div>

        <%//            if (session.getAttribute("type").equals(1) || session.getAttribute("type").equals(2)) {
            if (session.getAttribute("type").equals(1) && Owner) {
        %>

        <br>
        <div class="moveOpt">
            <div class="All-Information" id="SaOpt" style=" padding-top: 10px">
                <a id="SaOpt" href="showRequests.jsp" />Show Requests</a>
            </div>

            <%
                //        }
            %>  <br>

            <div class="All-Information" id="SaOpt" style=" padding-top: 10px">
                <a  id="SaOpt" href="Promotion.jsp"style=" " />Promotion</a>
            </div><br>

            <div class="All-Information" id="SaOpt" style=" padding-top: 10px">
                <a id="SaOpt" href="Dismiss.jsp" style=""/>Dismiss</a>

            </div><br>

            <div class="All-Information" id="SaOpt" style=" padding-bottom: 10px;">
                <br><a id="SaOpt" href="CreateNewDep.jsp"> Create New Department</a></div><br>
            <div class="All-Information" id="SaOpt" style=" padding-bottom: 10px;">
                <br><a id="SaOpt" href="updateSA.jsp"> Update Student Activity</a></div><br>

            <div class="All-Information" id="SaOpt" style=" padding-top:  15px;">
                <!--<br><a id="SaOpt" href="deleteSA.jsp"> Delete Student Activity</a>-->
                <a id="SaOpt"onclick="document.getElementById('id04').style.display = 'block'" style="width:auto; cursor:pointer;">delete Student Activity </a>

                
                 <div id="id04" class="modal">

                    <form class="modal-content animate" action="StudentActivityController">


                        <div class="container">
                            <h1>Are you sure you want to delete <%=session.getAttribute("SAName")%>   ? </h1>

                            <%--<%= session.getAttribute("CampID") %>--%>

                            <button type="submit" name="studentActivity" value="Delete">Delete </button>
                        </div>

                        <div class="container" style="background-color:#f1f1f1">
                            <button type="button" onclick="document.getElementById('id04').style.display = 'none'" class="cancelbtn">Cancel</button>

                        </div></form>
                </div>

            </div><br>





            <div class="All-Information" id="SaOpt" style="padding-bottom: 10px;">
                <br><a id="SaOpt" href="createCampagin.jsp"> Create New Campaign</a>           </div><br>
        </div>
        <%}
   
            con = DriverManager.getConnection(URL, "root", "root");
               
            st = con.createStatement();
            sql = "select Distinct Dep_ID from acc_dep_sa where  Dep_ID IS NOT null and SA_ID= " + session.getAttribute("SAID");
            rs = st.executeQuery(sql);

            ArrayList<Integer> list = new ArrayList<Integer>();

            ArrayList<String> listName = new ArrayList<String>();
            while (rs.next()) {
                int k = rs.getInt("Dep_ID");
                list.add(k);
            }
            con.close();
        %><div class="StudentAcitivity " id="tempMove" >
            <h style=" ">
                <%
                    out.print("Departments ");
                %>
            </h>
            <%
                for (int i = 0; i < list.size(); i++) {
                    con = DriverManager.getConnection(URL, "root", "root");
               
                    st = con.createStatement();
                    sql = "select Name from Departement where ID = " + list.get(i);
                    rs = st.executeQuery(sql);
                    while (rs.next()) {
                        listName.add(rs.getString("Name"));
                    }
con.close();
                    if (list.size() > 0) {
                        //                 %>
            <a href="dep.jsp?param1=<%=listName.get(i)%>&param2=<%=list.get(i)%>" style="font-size: large;color:#4E6B81 "><%=listName.get(i)%></a>

            <br>
            <%
                    }

                }
                con = DriverManager.getConnection(URL, "root", "root");
               
                st = con.createStatement();
                sql = "select * from campagin where SA_ID= " + session.getAttribute("SAID");
                rs = st.executeQuery(sql);
                ArrayList<String> campName = new ArrayList<String>();
                ArrayList<Integer> campID = new ArrayList<Integer>();
            %><br>
            <!--<div class="All-Information" id="tempMove"style="background-color: #e9daf8">-->
            <h style="">
                <%
                    out.print("Campaigns ");
                %>
            </h>
            <%
                while (rs.next()) {
                    String j = (String) rs.getString("Name");
                    campName.add(j);
                    int l = rs.getInt("ID");
                    campID.add(l);
                } con.close();
                for (int i = 0; i < campName.size(); i++) {
                    if (campName.size() > 0) {
                        //                 %>
            <a href="campaign.jsp?param1=<%=campName.get(i)%>&param2=<%=campID.get(i)%>" style="font-size: large;color:#4E6B81"><%=campName.get(i)%></a>
            <br><%
                    }
                }
            } else {con = DriverManager.getConnection(URL, "root", "root");
               
                st = con.createStatement();
                sql = "select * from acc_dep_sa where Acc_ID= " + session.getAttribute("uID");
                rs = st.executeQuery(sql);

                ArrayList<Integer> list = new ArrayList<Integer>();

                ArrayList<String> listName = new ArrayList<String>();
                while (rs.next()) {

                    found = true;
                }
                con.close();
                if (found == false) {
            %>  
        </div>
        <form action="StudentActivityController?param1=<%=session.getAttribute("SAName")%>&param2=<%=session.getAttribute("SAID")%>&param3=<%=session.getAttribute("CreatuinDate")%>">   
            <button name="studentActivity" value="request">Request Add</button>
        </form>

        <%
                }
            }
        %>

    </body>
</html>
