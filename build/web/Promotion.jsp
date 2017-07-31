<%-- 
    Document   : Promotion
    Created on : 21-Apr-2017, 13:48:11
    Author     : rabab
--%>

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
        <link rel="stylesheet" href="css/Charts.css">
        <link rel="stylesheet" href="css/ShowReq.css">
    </head>
    <script type="text/javascript">
        
        
           function ShowData1(value) {
                xmlHttp = GetXmlHttpObject();
                var url = "Search";
                url = url + "?name=" + value;
                xmlHttp.onreadystatechange = stateChanged1
                xmlHttp.open("GET", url, true)
                xmlHttp.send(null)

            }
            function stateChanged1() {
                if (xmlHttp.readyState == 4 || xmlHttp.readyState == "complete") {

                    var Showdata = xmlHttp.responseText;
                    document.getElementById("mydiv").innerHTML = Showdata;

                }


            }
       
            function ShowData(value){
                xmlHttp=GetXmlHttpObject();
                var url="InformationMember";
                url=url+"?name="+value;
//                alert(url);
                xmlHttp.onreadystatechange=stateChanged
                xmlHttp.open("GET",url,true)
                xmlHttp.send(null)
                
            }
            function stateChanged(){
                if(xmlHttp.readyState==4 || xmlHttp.readyState=="complete"){
                    
                    var Showdata=xmlHttp.responseText;
                    document.getElementById("Info").innerHTML=Showdata;
//                    alert(Showdata);
                     document.getElementById("Info").style.display='block';
                    
                }
                
                
            }
            function GetXmlHttpObject(){
                
                var xmlHttp=null;
                try{
                    xmlHttp=new XMLHttpRequest();}
                    
                
                catch(e){
                    try{
                        xmlHttp=new ActiveXObject("Msxm12.XMLHTTP");
                    }
                    catch(e){
                         xmlHttp=new ActiveXObject("Microsoft.XMLHTTP");
                        
                    }
                }
                return xmlHttp;
            }
            
              
            
            
            
        </script>
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
                    <input type="search" class ="search" name="name" placeholder="search..." id="Listbtn" autocomplete="off" onkeyup="ShowData1(this.value);">
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

        <h1>Promotion form</h1>

<div class="containProm">
        
        <form action="AccountController">
            <br>
            <div class="selProm">
           <select name="Promotion" onchange="ShowData(this.value);" name="name" id="name" >
         <%
                  
                    String URL = "jdbc:mysql://localhost:3306/orgi";
                    Class.forName("com.mysql.jdbc.Driver");
                    Connection con = DriverManager.getConnection(URL, "root", "root");
                    Statement st = con.createStatement();
                    String sql = "select * from acc_dep_sa,account where SA_ID="+session.getAttribute("SAID")+" and ID=Acc_ID and type=0";
                    ResultSet rs = st.executeQuery(sql);%>
                  <option  value="-1">  </option>
                    <%while (rs.next()) {
                        String MemberName = rs.getString("FName");
                        int MemberID = rs.getInt("ID");
                %>
<!--<tr><td><br><input type="checkbox" name="skill" value="<%=MemberID%>" > <%=MemberName%></td></tr>-->
                        
                <option value="<%=MemberID%>" ><%=MemberName%></option>
                
                <%
                          
                            }
                    
                    con.close();
                    con = DriverManager.getConnection(URL, "root", "root");
                    
                        %>
                        <!--<input type="submit" name="promote" value promote>-->
           </select>
        
         <%
                  
                    
                     st = con.createStatement();
                     sql = "select Distinct name,  ID from acc_dep_sa,Departement where SA_ID="+session.getAttribute("SAID")+" and ID=Dep_ID and Departement.Acc_ID="+session.getAttribute("uID") +" or Departement.Acc_ID IS NULL";
                    rs = st.executeQuery(sql);
                %>
                <select name="Dpromote">
            <%
                    while (rs.next()) {
                        String DepName = rs.getString("name");
                        int DepID = rs.getInt("ID");
                        
                        %>
                        <option value="<%=DepID%>"><%= DepName%></option>
                            
                            <%
                    }
                      con.close();
//                    con = DriverManager.getConnection(URL, "root", "root");
                  
                %>
        
                        </select></div>
                <br>
                        <input type="submit"  name="change" value="promote"/>
            </div>             
                <div  id="Info"></div>  
       
        </form>
       
        
    </body>
</html>
