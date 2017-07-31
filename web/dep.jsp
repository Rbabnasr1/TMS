<%-- 
    Document   : dep
    Created on : 24-Jan-2017, 16:54:54
    Author     : rabab
--%>

<%@page import="model.Department"%>
<%@page import="model.studentActivity"%>
<%@page import="model.Notification"%>
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
        <!--<link rel="stylesheet" href="css/format.css">-->
         <link rel="stylesheet" href="css/General.css">
       
        <link rel="stylesheet" href="css/Charts.css">
        <script type="text/javascript">
            function ShowData(value){
                xmlHttp=GetXmlHttpObject();
                var url="Search";
                url=url+"?name="+value;
                xmlHttp.onreadystatechange=stateChanged
                xmlHttp.open("GET",url,true)
                xmlHttp.send(null)
                
            }
            function stateChanged(){
                if(xmlHttp.readyState==4 || xmlHttp.readyState=="complete"){
                    
                    var Showdata=xmlHttp.responseText;
                    document.getElementById("mydiv").innerHTML=Showdata;
                    
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
   
   <!--<div class="All-Information" style="opacity: 0.2;color:white;background-color: #000; bottom: -300px; margin-left: px;margin-top: -290px;width: 200px"><p style=" color: white;font-weight:  bold">Department</p></div>-->
   
   
   <div class="All-Information" style="position: absolute; top: 100px;">
       <%  if(request.getParameter("param1")!=null){
       %><h1 style="text-align: center;"><% out.print(" "+request.getParameter("param1"));%></h1><%
               session.setAttribute("depName",request.getParameter("param1") );
               session.setAttribute("depID", request.getParameter("param2") );}
        else{
      %><h1 style="text-align: center;"><%out.print(" "+session.getAttribute("depName"));%></h1><%
              
        }
            %></div>
          
              <%
String URL = "jdbc:mysql://localhost:3306/orgi";
            Class.forName("com.mysql.jdbc.Driver");
            Connection con = DriverManager.getConnection(URL, "root", "root");
            Statement st = con.createStatement();
            String sql;
            ResultSet rs ;
  
                boolean Owner=false;
                int sa;
                boolean Head_Dep=false;
                
                boolean persidnt=false;
                studentActivity StudentA =new studentActivity();
                sa=StudentA.getSA_Dep_ID(Integer.parseInt(request.getParameter("param2")));
                
                Owner=StudentA.CheckSA_ID(Integer.parseInt(String.valueOf(session.getAttribute("uID"))),sa);
                  Department depart=new Department();
                  Head_Dep=depart.CheckDep_ID(Integer.parseInt(String.valueOf(session.getAttribute("uID"))),Integer.parseInt(String.valueOf(session.getAttribute("depID"))));
                  //out.print("hnaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaa: "+ Head_Dep);
                  persidnt=StudentA.GetPer(Integer.parseInt(String.valueOf(session.getAttribute("uID"))),sa);
            if (session.getAttribute("type").equals(1) || session.getAttribute("type").equals(2)) {
      
                
                if( Owner || Head_Dep ){
                
                
              
              %>
              <br><div class="movDeptPost"><form action="Departments">
            <input type="text" placeholder="what's on your mind" name="message" id='postcamp' />
            <button name="type" value="post" style="    position: absolute;
    margin: -70px 625px">Post</button>
        </form></div>
        <%}}
               
            
            
      %><br><%
                      if( Owner || Head_Dep ){ 
        st = con.createStatement();
         sql = "select * from post , account where account.ID = acc_ID and dep_ID = " +  session.getAttribute("depID")
                + " order by postDate desc , postTime desc";
             rs = st.executeQuery(sql);
             %><div class="in-post" style="  top: 400px;"><%
            while (rs.next()) {
             %>
            <div class="All-Information" id="postformat" style="left: 80px;">
        <%
            String user_name = rs.getString("FName"); %><h style=" font-size: 25px;"><%
            out.print(user_name);%></h><br><br><%
            String mess = rs.getString("message"); 
            out.print("      "+mess);%><br><br><%
             String date = rs.getString("postDate");%><p12 style="color: #c5b4cb;"><%
            out.print(date);
            String time = rs.getString("postTime");
            %><br><%out.print("      "+ time);%></p12><%
           %>
          <%if  (session.getAttribute("type").equals(1)||session.getAttribute("type").equals(2)){
          if(Head_Dep || session.getAttribute("type").equals(1)){
          %>
             <div id="movDel" style="position: relative;margin-left: 490px;margin-top: -50px "><form action="Departments">
                     <input type="hidden" name="postID" value="<%= rs.getInt("post.ID")%>"/>
                     <button name="type" value="delete_post"style="background-color: #F3F4F7;color: #4E6B81">x</button>
                 </form></div><%}}%>
            
            <br></div><br>
         <%   
            %><br>
           <% }
                      con.close();
                      
                      }
                      %>
                      </div>
                      <%
            if (session.getAttribute("type").equals(1) || session.getAttribute("type").equals(2)) {
                 con = DriverManager.getConnection(URL, "root", "root");
        //////////////////////////////////////////////////////////
           st = con.createStatement();
            sql = "select * from  acc_dep_sa where Dep_ID = "+session.getAttribute("depID")+" and Acc_ID =" + session.getAttribute("uID");
            rs = st.executeQuery(sql);
          while (rs.next()) {
         
           %>
           <form action="Departments">
               
               
               <%
              
       if( persidnt || Head_Dep ){
                
     
             ArrayList<Integer> list = new ArrayList<Integer>();
             ArrayList<String> listName = new ArrayList<String>();
                     con = DriverManager.getConnection(URL, "root", "root");
            sql = "select * from account , acc_dep_sa where Dep_ID IS NULL and SA_ID="+rs.getInt("SA_ID")+" and requested =1 and type=0 and ID=Acc_ID";
            rs = st.executeQuery(sql);
         
         while (rs.next()) {
         list.add(rs.getInt("ID"));
         listName.add(rs.getString("FName"));
         
          } con.close();
//         out.print(Head_Dep + " "+Owner+session.getAttribute("depID")+" "+request.getParameter("param2"));
          
         %>
               
         <div class="selProm" id="daOpt" style=" left: 1450px; top: 90px; ">
             <select name="addMember"  >
            <%
             for(int i =0;i<list.size();i++){%>
             <option value="<%=list.get(i)%>">
                 <%=listName.get(i) %>
             </option>
               <%}%>
             
         
         </select> 
             
                <input type="submit" name="type" value="AddMember" style="background-color:  #4E6B81;color: #F3F4F7;border-radius: 30px;width: 90px;height: 40px"/>
            </div>
            </form>
             
             
             
             
             
          
            <%
          }
          } con.close();
             
              }
            %>
               <div id="movedepOpt" class="heloo" style="">
       
                <%
                if  (session.getAttribute("type").equals(1)||session.getAttribute("type").equals(2)){
         
                if(session.getAttribute("type").equals(1)&& Owner){
        %>
         
                   <div class="All-Information" id="SaOpt" style="padding-top: 15px;">
            <a id="SaOpt" href="UpdateDep.jsp" >Update Department </a></div><br>
        <div class="All-Information" id="SaOpt" style="padding-top: 15px">
            <!--<a id="SaOpt" href="deletedep.jsp">delete Departemt </a></div><br>-->
            <a id="SaOpt" onclick="document.getElementById('id04').style.display = 'block'" style="width:auto;">Delete Department </a>

  
    
     <div id="id04" class="modal">

        <form class="modal-content animate" action="Departments">


            <div class="container">
               <h1>Are you sure you want to delete ? </h1>
        
        <%--<%= session.getAttribute("CampID") %>--%>
               
                <button type="submit"  name="type" value="delete">Delete  </button>
                </div>

                <div class="container" style="background-color:#f1f1f1">
                    <button type="button" onclick="document.getElementById('id04').style.display = 'none'" class="cancelbtn">Cancel</button>

            </div></form>
     </div>
    </div>

            <%  }if( persidnt ||Head_Dep ){%>
            <br> <div class="All-Information" id="SaOpt" style="padding-top: 15px;">     
          <a id="SaOpt"  href="createTask.jsp?param1=DepTask">Create Task Department </a>
             </div><br><% }} %>
        
        
       <!--<div class="All-Information" id="SaOpt" style="padding: 8px 0px ; position: absolute;left: 1050px;top:300px " >-->       
            
            
            
            <%
         if(Owner || Head_Dep){ %>
         <div class="All-Information" id="SaOpt" style="padding-top: 15px;">     
         <a id="SaOpt" href="taskPlan.jsp">View Department Tasks  </a></div><br>
  <%}
         %>   <div class="All-Information" id="depInf">  <table>  <tr><td style="font-weight: bold ; color:#aabcc6 ">   <%
          con = DriverManager.getConnection(URL, "root", "root");
    st = con.createStatement();
    sql="select * from departement where ID = "+ session.getAttribute("depID");
    ResultSet r = st.executeQuery(sql);
    while(r.next()){
        out.print("Target Plan "); %> 
                     </td><td>
    <%
         out.println(r.getString("targetPlan"));
    }con.close();
    %>
                     </td></tr><tr><td style="font-weight: bold ; color:#aabcc6 ">
             <%
     con = DriverManager.getConnection(URL, "root", "root");
    st = con.createStatement();
    sql="select * from account , departement where account.ID = Acc_ID and departement.ID = "+ session.getAttribute("depID");
    r = st.executeQuery(sql);
    while(r.next()){
        out.print("Headed By ");%> 
                     </td><td>
    <%  out.print(r.getString("FName"));
    }
    con.close();
    %>
        </td></tr>     </table></div>
  
  
  
  
  
   </div>
    </body>
</html>
