<%@page import="java.util.ArrayList"%>
<%@page import="model.Notification"%>
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
        <link rel="stylesheet" href="css/updateCamp.css">
        <link rel="stylesheet" href="css/Charts.css">
        <!--<link rel="stylesheet" href="css/General.css">-->

    </head>
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
                    <button class="Listbtn" style="background-position: 4px 11px;" ></button>
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
                        <span class="numberOfNotif"  style="    margin: -56px 0 0 30px;" ><% if (!notifi.get(0).equals("<a class=noti href=#>Don`t have Notifications </a>")) {
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




        <h1>Update Personal Information</h1>
        <div class="infoCamp">
            <form action ="AccountController">
                <%

                    String URL = "jdbc:mysql://localhost:3306/orgi";
                    Class.forName("com.mysql.jdbc.Driver");
                    Connection con = DriverManager.getConnection(URL, "root", "root");
                    Statement st = con.createStatement();
                    String sql = "select * from account where ID = " + session.getAttribute("uID");
                    ResultSet rs = st.executeQuery(sql);
                    while (rs.next()) {
                %>
                <table>
                    <tr> <td style="font-weight: bold">Current Name</td>
                        <td> <% out.print(rs.getString("FName"));%></td>

                    </tr> <tr>  <td style="font-weight: bold"> New Name </td><td><input type="text" name="Name" > </td></tr>

                    <tr><td style="font-weight: bold">  Current E-mail </td>  
                        <td> <% out.print(rs.getString("email"));
                            %></td>
                    </tr> <tr>  <td style="font-weight: bold">  New E-mail  </td>  <td>  <input type="text" name="email" >
                        </td> </tr>
                    <tr><td style="font-weight: bold">    Current Mobile </td> 
                        <td>     <%
                            out.print(rs.getString("mobile"));
                            %></td>
                    </tr> <tr>  <td style="font-weight: bold">     New Mobile  </td>  <td>  <input type="text" name="mobile" ></td> </tr>
                    <tr><td style="font-weight: bold">     Current Address   </td> 
                        <td>    <%
                            out.print(rs.getString("address"));
                            %></td>
                    </tr> <tr>  <td style="font-weight: bold"> New Address   </td>  <td> <input type="text" name="address"  /></td> </tr>
                    <tr><td style="font-weight: bold">      Current Password   </td> 
                        <td>     <%
                            out.print(rs.getString("password"));
                            %></td>
                    </tr> <tr>  <td style="font-weight: bold"> New Password </td>  <td> <input type="text" name="pass" ></td> </tr>


                <!--<div class="selB" style="font-weight: bold" >-->
                    <tr>  <td style="font-weight: bold">Birth Date  </td> <td> <select name="day" >
                        <option value="">Day</option>
                        <option value="1">1</option> 
                        <option value="2">2</option>
                        <option value="3">3</option>
                        <option value="4">4</option> 
                        <option value="5">5</option>
                        <option value="6">6</option>
                        <option value="7">7</option> 
                        <option value="8">8</option>
                        <option value="9">9</option>
                        <option value="10">10</option> 
                        <option value="11">11</option>
                        <option value="12">12</option>
                        <option value="13">13</option> 
                        <option value="14">14</option>
                        <option value="15">15</option>
                        <option value="16">16</option> 
                        <option value="17">17</option>
                        <option value="18">18</option>
                        <option value="19">19</option> 
                        <option value="20">20</option>
                        <option value="21">21</option>
                        <option value="22">22</option> 
                        <option value="23">23</option>
                        <option value="24">24</option>
                        <option value="25">25</option> 
                        <option value="26">26</option>
                        <option value="27">27</option>
                        <option value="28">28</option> 
                        <option value="29">29</option>
                        <option value="30">30</option>
                    </select>
                    <select name="month"  >
                        <option value="">Month</option>
                        <option value="01">January</option>
                        <option value="02">February</option>
                        <option value="03">March</option>
                        <option value="04">April</option>
                        <option value="05">May</option>
                        <option value="06">June</option>
                        <option value="07">July</option>
                        <option value="08">August</option>
                        <option value="09">September</option>
                        <option value="10">October</option>
                        <option value="11">November</option>
                        <option value="12">December</option>
                    </select>

                    <select  name="year">
                        <option value="">Year</option>
                        <option value="2012">2012</option>
                        <option value="2011">2011</option>
                        <option value="2010">2010</option>
                        <option value="2009">2009</option>
                        <option value="2008">2008</option>
                        <option value="2007">2007</option>
                        <option value="2006">2006</option>
                        <option value="2005">2005</option>
                        <option value="2004">2004</option>
                        <option value="2003">2003</option>
                        <option value="2002">2002</option>
                        <option value="2001">2001</option>
                        <option value="2000">2000</option>
                        <option value="1999">1999</option>
                        <option value="1998">1998</option>
                        <option value="1997">1997</option>
                        <option value="1996">1996</option>
                        <option value="1995">1995</option>
                        <option value="1994">1994</option>
                        <option value="1993">1993</option>
                        <option value="1992">1992</option>
                        <option value="1991">1991</option>
                        <option value="1990">1990</option>
                        <option value="1989">1989</option>
                        <option value="1988">1988</option>
                        <option value="1987">1987</option>
                        <option value="1986">1986</option>
                        <option value="1985">1985</option>
                        <option value="1984">1984</option>
                        <option value="1983">1983</option>
                        <option value="1982">1982</option>
                        <option value="1981">1981</option>
                        <option value="1980">1980</option>
                        <option value="1979">1979</option>
                        <option value="1978">1978</option>
                        <option value="1977">1977</option>
                        <option value="1976">1976</option>
                        <option value="1975">1975</option>
                        <option value="1974">1974</option>
                        <option value="1973">1973</option>
                        <option value="1972">1972</option>
                        <option value="1971">1971</option>
                        <option value="1970">1970</option>
                        <option value="1969">1969</option>
                        <option value="1968">1968</option>
                        <option value="1967">1967</option>
                        <option value="1966">1966</option>
                        <option value="1965">1965</option>
                        <option value="1964">1964</option>
                        <option value="1963">1963</option>
                        <option value="1962">1962</option>
                        <option value="1961">1961</option>
                        <option value="1960">1960</option>
                        <option value="1959">1959</option>
                        <option value="1958">1958</option>
                        <option value="1957">1957</option>
                        <option value="1956">1956</option>
                        <option value="1955">1955</option>
                        <option value="1954">1954</option>
                        <option value="1953">1953</option>
                        <option value="1952">1952</option>
                        <option value="1951">1951</option>
                        <option value="1950">1950</option>
                        <option value="1949">1949</option>
                        <option value="1948">1948</option>
                        <option value="1947">1947</option>
                        <option value="1946">1946</option>
                        <option value="1945">1945</option>
                        <option value="1944">1944</option>
                        <option value="1943">1943</option>
                        <option value="1942">1942</option>
                        <option value="1941">1941</option>
                        <option value="1940">1940</option>
                        <option value="1939">1939</option>
                        <option value="1938">1938</option>
                        <option value="1937">1937</option>
                        <option value="1936">1936</option>
                        <option value="1935">1935</option>
                        <option value="1934">1934</option>
                        <option value="1933">1933</option>
                        <option value="1932">1932</option>
                        <option value="1931">1931</option>
                        <option value="1930">1930</option>
                        <option value="1929">1929</option>
                        <option value="1928">1928</option>
                        <option value="1927">1927</option>
                        <option value="1926">1926</option>
                        <option value="1925">1925</option>
                        <option value="1924">1924</option>
                        <option value="1923">1923</option>
                        <option value="1922">1922</option>
                        <option value="1921">1921</option>
                        <option value="1920">1920</option>
                        <option value="1919">1919</option>
                        <option value="1918">1918</option>
                        <option value="1917">1917</option>
                        <option value="1916">1916</option>
                        <option value="1915">1915</option>
                        <option value="1914">1914</option>
                        <option value="1913">1913</option>
                        <option value="1912">1912</option>
                        <option value="1911">1911</option>
                        <option value="1910">1910</option>
                        <option value="1909">1909</option>
                        <option value="1908">1908</option>
                        <option value="1907">1907</option>
                        <option value="1906">1906</option>
                        <option value="1905">1905</option>
                        <option value="1904">1904</option>
                        <option value="1903">1903</option>
                        <option value="1903">1902</option>
                        <option value="1901">1901</option>
                        <option value="1900">1900</option>
                    </select>
                <!--</div>-->
</td></tr></table>




                <%
                    } 
                    con.close();

                %>
                <br><br>
                <button class="butns"name="change" value="update">Update</button>
            </form>

            <div id="id01" class="modal">

                <form class="modal-content animate" method="post" enctype="multipart/form-data" action="AccountController">


                    <div class="container" style="font-size: 20px;">
                        <label style="color: #022640;font-size: 30px;"><b >Skills</b></label>


                        <%              con = DriverManager.getConnection(URL, "root", "root");
                    st = con.createStatement();
               
               
                            sql = " select ID , skill from skills "
                                    + " where skill not in "
                                    + "( select skill from skills , acc_skill where acc_ID = " + session.getAttribute("uID")
                                    + " and skills.ID = acc_skill.skill_ID )";
                            rs = st.executeQuery(sql);
                            while (rs.next()) {
                                String SkillName = rs.getString("skill");
                                int SkillID = rs.getInt("ID");
                                %><br><input type="checkbox"  name="skill" value="<%=SkillID%>" > <%=SkillName%>
                        <%
                            }
                            con.close();
                        %>

                    </div>

                    <div class="container" style="background-color:#f1f1f1">
                        <button  class="blog" type="submit" name="change" value="updateSkill">Update </button>

                        <button  class="blog" type="button" onclick="document.getElementById('id01').style.display = 'none'" class="cancelbtnn">Cancel</button>

                    </div>
                </form>
            </div>

            <a  class="butns" onclick="document.getElementById('id01').style.display = 'block'" style="width:auto;"> Update Skills </a>


        </div>
    </body>
</html>
