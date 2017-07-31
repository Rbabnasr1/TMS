<%-- 
    Document   : skills
    Created on : 07-Mar-2017, 16:24:00
    Author     : rabab
--%>

<%@page import="java.sql.ResultSet"%>
<%@page import="java.sql.DriverManager"%>
<%@page import="java.sql.Statement"%>
<%@page import="java.sql.Connection"%>
<%@page contentType="text/html" pageEncoding="UTF-8"%>
<!DOCTYPE html>
<html>
    <head>
        <meta http-equiv="Content-Type" content="text/html; charset=UTF-8">
        <title>JSP Page</title>
         <link rel="stylesheet" href="css/TaskCreate.css">

    </head>
    <body>

 <h1 style="font-size: 50px; color:#0a426c ;text-align: center"> Skills  </h1>


                    <form  action="RegisterController" method="post" >
                        <div class="SkillsPage"style="text-transform: capitalize" >
         <%
                     
                        String URL = "jdbc:mysql://localhost:3306/orgi";
                        Class.forName("com.mysql.jdbc.Driver");
                        Connection con = DriverManager.getConnection(URL, "root", "root");
                        Statement st = con.createStatement();
                        String sql = "select * from skills";
                        ResultSet rs = st.executeQuery(sql);
                                    int found=0;
                        while (rs.next()) {
                            String SkillName = rs.getString("skill");
                            int SkillID = rs.getInt("ID");
                            found=1;
                            %><br><input type="checkbox" name="skill" value="<%=SkillID%>" > <%=SkillName%>
                            <%
                            
                        }
                        con.close();
                        if(found==1){%>
                          </div>
                   <br> <input class="next" type="submit" name="register" value="Next"/>
                 
                    </form>
            <%}else{
                            response.sendRedirect("HomePage.jsp");
                            
                        }%>
    
    </body>
</html>
