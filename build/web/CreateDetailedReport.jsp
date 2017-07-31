<%@page import="model.Notification"%>
<%@page import="model.UserModel"%>
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
         <link rel="stylesheet" href="css/General_Creation.css">

                <script>


// Get the modal
            var modal = document.getElementById('id01');

// When the user clicks anywhere outside of the modal, close it
            window.onclick = function (event) {
                if (event.target == modal) {
                    modal.style.display = "none";
                }
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
         <link rel="stylesheet" href="css/General.css">
          <link rel="stylesheet" href="css/Charts.css">
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


        
        <%
        String managerName = "";
        String Profile = "";
        int manager_ID = 0 ;
           if(session.getAttribute("type").equals(0)){     
               ArrayList<UserModel>manger=new ArrayList<UserModel>();
                 UserModel user = new UserModel();
                 manger=user.getDepManger( Integer.parseInt(String.valueOf(session.getAttribute("depID"))));
                 
                 if(!manger.isEmpty()){
                     for(int i=0;i<manger.size();i++){
                managerName = manger.get(i).getFName();
                   manager_ID = manger.get(i).getID();
                   Profile=manger.get(i).getPhoto();
                 
                 }}
            
           }
           else if(session.getAttribute("type").equals(2)){

               
               ArrayList<UserModel>manger=new ArrayList<UserModel>();
                 UserModel user = new UserModel();
                 manger=user.getDepPersident(Integer.parseInt(String.valueOf(session.getAttribute("depID"))),Integer.parseInt(String.valueOf(session.getAttribute("SAID"))));
                if(!manger.isEmpty()){
                     for(int i=0;i<manger.size();i++){
                managerName = manger.get(i).getFName();
                   manager_ID = manger.get(i).getID();
                      Profile=manger.get(i).getPhoto();
                 
                 }}
          }
        %>
        
        
        
                <h1 style="font-size: 50px; color:#0a426c ">Report problem </h1>

        <div class="General_M">
       <form action ="DetailedReportController?param1=<%=manager_ID%>">
               <div class="img_problem">  <img id="profileImage" src="<%= "Image\\"+Profile%>"  class="rotate360" style="width: 200px;height: 200px; " title="<%=managerName%>" /></a>
               <table class="tableProblem">
                <tr> <td>   To: <%=managerName%> </td> </tr>
                <tr> <td>   Subject: <input type="text" name="subject" placeholder="Subject" style="color: #0a426c;font-size: 15px;"></td> </tr>
                
                <!--<tr> <td>   <input type="text" name="message"  style="width:500px;line-height: 10px;" ></td> </tr>-->
                <tr> <td>   <textarea  name="message"  style="width:500px;color:#0a426c;font-size: 15px;overflow: hidden;line-height: 30px;height:200px" placeholder="Write your Message !" ></textarea></td> </tr>
                
                <tr> <td>  <input class="btnnCreate_M" type="submit" name="DetReport" value="Send" ></td> </tr>
                <input type="hidden" name="no" value="<%=manager_ID%>" />
            </table>
               
               </div>       
            
        </form>
            
        
            </div>
    </body>
</html>
