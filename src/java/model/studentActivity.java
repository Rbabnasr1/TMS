/*
 * To change this license header, choose License Headers in Project Properties.
 * To change this template file, choose Tools | Templates
 * and open the template in the editor.
 */
package model;

import java.io.IOException;
import java.io.PrintWriter;
import java.sql.Connection;
import java.sql.Date;
import java.sql.DriverManager;
import java.sql.ResultSet;
import java.sql.SQLException;
import java.sql.Statement;
import java.util.ArrayList;
import java.util.Calendar;
import javax.servlet.ServletException;

/**
 *
 * @author aya nasef
 */
public class studentActivity {

    private String Name;
    private String address;
    private String creationDate;

    private String _cover;

    /**
     * @return the Name
     */
    public void Add(String n, String a, String c, int uID) throws SQLException {//Fun AddStudentActivity 
        try {
            String URL = "jdbc:mysql://localhost:3306/orgi";
            Class.forName("com.mysql.jdbc.Driver");
            Connection con = DriverManager.getConnection(URL, "root", "root");
            Statement st = con.createStatement();
            String sql = "insert into studentactivity (Name,address,creationDate) values('" + n + "','" + a + "','" + c + "')";
            st.executeUpdate(sql);
            int ID = getID(n);
            con.close();
            con = DriverManager.getConnection(URL, "root", "root");
            st = con.createStatement();
            sql = "insert into acc_dep_sa (SA_ID,Acc_ID,requested) values(" + ID + "," + uID + ",1)";
            st.executeUpdate(sql);
            con.close();
            con = DriverManager.getConnection(URL, "root", "root");
            st = con.createStatement();
            sql = "update account set type = " + 1 + " where ID=" + uID;
            st.executeUpdate(sql);
            con.close();
        } catch (Exception e) {
            System.out.println("error");
        }
    }

    public void request(int acc_ID, int sa_ID) throws SQLException {
        try {
            String URL = "jdbc:mysql://localhost:3306/orgi";
            Class.forName("com.mysql.jdbc.Driver");
            Connection con = DriverManager.getConnection(URL, "root", "root");
            Statement st = con.createStatement();
            String sql = "insert into acc_dep_sa (SA_ID , Acc_ID , requested) values(" + sa_ID + "," + acc_ID + ",0 )";
            st.executeUpdate(sql);
            con.close();
        } catch (Exception e) {
            System.out.println("error");
        }
    }

    public void Delete(int id, int Acc_ID) throws SQLException {//Fun DeleteStudentActivity 
        try {
            String URL = "jdbc:mysql://localhost:3306/orgi";
            Class.forName("com.mysql.jdbc.Driver");
            Connection con = DriverManager.getConnection(URL, "root", "root");
            Statement st = con.createStatement();
            String Sql = " delete from acc_dep_sa where SA_ID = " + id;
            st.executeUpdate(Sql);
            con.close();

            ArrayList<Integer> IDS = new ArrayList<Integer>();
            con = DriverManager.getConnection(URL, "root", "root");

            st = con.createStatement();
            Sql = "SELECT ID FROM orgi.account,acc_dep_sa where ID=Acc_ID and SA_ID=" + id;
            ResultSet rs = st.executeQuery(Sql);
            while (rs.next()) {

                IDS.add(rs.getInt("ID"));
            }
            con.close();

            
            
            con = DriverManager.getConnection(URL, "root", "root");
            for (int i = 0; i < IDS.size(); i++) {
                st = con.createStatement();
                Sql = "update account set type = -1 where ID = " + IDS.get(i);
                st.executeUpdate(Sql);
            }

            con.close();

            con = DriverManager.getConnection(URL, "root", "root");
            st = con.createStatement();
            Sql = " delete from notification where pageType = 'SA' and PageID = " + id;
            st.executeUpdate(Sql);
            con.close();
            con = DriverManager.getConnection(URL, "root", "root");
            st = con.createStatement();
            Sql = " update account set type = -1 where ID = " + Acc_ID;
            st.executeUpdate(Sql);
            con.close();
            con = DriverManager.getConnection(URL, "root", "root");
            st = con.createStatement();
            Sql = " delete from post where sa_ID = " + id;
            st.executeUpdate(Sql);
            con.close();
            con = DriverManager.getConnection(URL, "root", "root");
            st = con.createStatement();
            Sql = " delete from studentactivity where ID =" + id;
            st.executeUpdate(Sql);
            con.close();
        } catch (Exception e) {
            System.out.println("error");
        }
    }

    public void Update(int i, String n, String a) throws SQLException {//Fun UpdateStudentActivity 
        try {
            String name = "";
            String location = "";
            String URL = "jdbc:mysql://localhost:3306/orgi";
            Class.forName("com.mysql.jdbc.Driver");
            Connection con = DriverManager.getConnection(URL, "root", "root");
            Statement st = con.createStatement();
            String sql = " select *  from studentactivity where ID=" + i;
            ResultSet rs = st.executeQuery(sql);
            while (rs.next()) {
                name = rs.getString("Name");
                location = rs.getString("address");

            }
            con.close();

            if (!n.equals("")) {
                name = n;
            }
            if (!a.equals("")) {
                location = a;
            }
 con = DriverManager.getConnection(URL, "root", "root");
            st = con.createStatement();

            sql = " update studentactivity set Name ='" + name + "' , address ='" + location + "' where ID=" + i;
            st.executeUpdate(sql);
            con.close();
        } catch (Exception e) {
            System.out.println("error");
        }
    }
//    public void AcceptRequest(int i, String n, String a) throws SQLException { 
//        try {
//            
//        } catch (Exception e) {
//            System.out.println("error");
//        }
//    }

    public String getName() {
        return Name;
    }

    /**
     * @param Name the Name to set
     */
    public void setName(String Name) {
        this.Name = Name;
    }

    /**
     * @return the address
     */
    public String getAddress() {
        return address;
    }

    /**
     * @param address the address to set
     */
    public void setAddress(String address) {
        this.address = address;
    }

    /**
     * @return the creationDate
     */
    public String getCreationDate() {
        return creationDate;
    }

    /**
     * @param creationDate the creationDate to set
     */
    public void setCreationDate(String creationDate) {
        this.creationDate = creationDate;
    }

    public void StudentActivity(String parameter, String parameter0, String Cdate) {
        Name = parameter;
        address = parameter0;
        creationDate = Cdate;
    }

    public void Update(String id, String parameter, String parameter0) {
        throw new UnsupportedOperationException("Not supported yet."); //To change body of generated methods, choose Tools | Templates.
    }

    public int getID(String name) throws ClassNotFoundException, SQLException {
        
        String URL = "jdbc:mysql://localhost:3306/orgi";
        Class.forName("com.mysql.jdbc.Driver");
        Connection con = DriverManager.getConnection(URL, "root", "root");
        Statement st = con.createStatement();

        String sql = "select ID from studentactivity where Name = '" + name + "'";
        ResultSet rs = st.executeQuery(sql);
        int ID = 0;
        while (rs.next()) {
            ID = rs.getInt("ID");
        }
con.close();
        return ID;
    }

    public void postInSA(String message, int accID, int pageID) throws SQLException, ClassNotFoundException {
        java.util.Date date = new java.util.Date();
        Calendar cal = Calendar.getInstance();
        cal.setTime(date);
        String year = String.valueOf(cal.get(Calendar.YEAR));
        String month = String.valueOf(cal.get(Calendar.MONTH) + 1);
        String day = String.valueOf(cal.get(Calendar.DAY_OF_MONTH));

        String hour = String.valueOf(cal.get(Calendar.HOUR_OF_DAY));
        String min = String.valueOf(cal.get(Calendar.MINUTE));
        String sec = String.valueOf(cal.get(Calendar.SECOND));

        String d = String.valueOf(year + "-" + month + "-" + day);
        String t = String.valueOf(hour + ":" + min + ":" + sec);
        String query = "insert into post (message , sa_ID , acc_ID , postTime , postDate) values ('" + message + "', " + pageID + " , " + accID + " , '" + t + "','" + d + "')";
        String URL = "jdbc:mysql://localhost:3306/orgi";
        Class.forName("com.mysql.jdbc.Driver");
        Connection con = DriverManager.getConnection(URL, "root", "root");
        Statement st = con.createStatement();
        st.executeUpdate(query);
        con.close();
    }

    public void deletePostInSA(int post_ID) throws ClassNotFoundException, SQLException {
        String query = "Delete from post where ID =" + post_ID;
        String URL = "jdbc:mysql://localhost:3306/orgi";
        Class.forName("com.mysql.jdbc.Driver");
        Connection con = DriverManager.getConnection(URL, "root", "root");
        Statement st = con.createStatement();
        st.executeUpdate(query);
        con.close();
    }

    public void accept(int SAID, int AccID) throws ClassNotFoundException, SQLException {
        String URL = "jdbc:mysql://localhost:3306/orgi";
        Class.forName("com.mysql.jdbc.Driver");
        Connection con = DriverManager.getConnection(URL, "root", "root");

        String query = "update acc_dep_sa set requested= 1 where Acc_ID=" + AccID + " and SA_ID=" + SAID;
        Statement st = con.createStatement();
        st.executeUpdate(query);
        con.close();
         con = DriverManager.getConnection(URL, "root", "root");

        query = "update account set type=0 where ID=" + AccID;
        st = con.createStatement();
        st.executeUpdate(query);
        con.close();

    }

    public void ignore(int SAID, int AccID) throws ClassNotFoundException, SQLException {

        String query = "delete from acc_dep_sa where Acc_ID=" + AccID + " and SA_ID=" + SAID;
        String URL = "jdbc:mysql://localhost:3306/orgi";
        Class.forName("com.mysql.jdbc.Driver");
        Connection con = DriverManager.getConnection(URL, "root", "root");
        Statement st = con.createStatement();
        st.executeUpdate(query);

    }

    public int getSA_ID(int Acc_ID) throws ClassNotFoundException, SQLException {
        String URL = "jdbc:mysql://localhost:3306/orgi";
        Class.forName("com.mysql.jdbc.Driver");
        Connection con = DriverManager.getConnection(URL, "root", "root");
        Statement st = con.createStatement();

        String sql = "select SA_ID from acc_dep_sa where Acc_ID=" + Acc_ID + " and requested= 1";
        ResultSet rs = st.executeQuery(sql);
        int ID = 0;
        while (rs.next()) {
            ID = rs.getInt("SA_ID");
        }
con.close();
        return ID;
    }

    public ArrayList<studentActivity> GetSA(int ID) throws ClassNotFoundException, SQLException {
        ArrayList<studentActivity> SAList = new ArrayList<>();

        String URL = "jdbc:mysql://localhost:3306/orgi";
        Class.forName("com.mysql.jdbc.Driver");
        Connection con = DriverManager.getConnection(URL, "root", "root");
        studentActivity SA = new studentActivity();
        Statement st = con.createStatement();
        String sql = "select * from studentactivity where ID = " + ID;
        ResultSet rs = st.executeQuery(sql);

        while (rs.next()) {
            SA.setName(rs.getString("Name"));
            SA.setAddress(rs.getString("address"));
            SA.setCreationDate(rs.getString("creationDate"));
            SA.setCover(rs.getString("cover"));
            SAList.add(SA);
        }
con.close();
        return SAList;
    }

    /**
     * @return the _cover
     */
    public String getCover() {
        return _cover;
    }

    /**
     * @param _cover the _cover to set
     */
    public void setCover(String _cover) {
        this._cover = _cover;
    }

    public ArrayList<Integer> GetDepSA(int userID) throws ClassNotFoundException, SQLException {
        ArrayList<Integer> SAdep = new ArrayList<>();

        String URL = "jdbc:mysql://localhost:3306/orgi";
        Class.forName("com.mysql.jdbc.Driver");
        Connection con = DriverManager.getConnection(URL, "root", "root");
        studentActivity SA = new studentActivity();
        Statement st = con.createStatement();
        String sql = "select * from acc_dep_sa where Acc_ID = " + userID + " and requested = 1 ";
        ResultSet rs = st.executeQuery(sql);
        int depiD = 0, SAiD = 0;
        ArrayList<String> listName = new ArrayList<String>();
        while (rs.next()) {
            depiD = rs.getInt("Dep_ID");
            SAiD = rs.getInt("SA_ID");

        }
        con.close();
        SAdep.add(SAiD);
        SAdep.add(depiD);

        return SAdep;
    }

    public boolean CheckSA_ID(int Acc_ID, int said) throws ClassNotFoundException, SQLException {
        String URL = "jdbc:mysql://localhost:3306/orgi";
        Class.forName("com.mysql.jdbc.Driver");
        Connection con = DriverManager.getConnection(URL, "root", "root");
        Statement st = con.createStatement();

        String sql = "select distinct SA_ID from acc_dep_sa where Acc_ID=" + Acc_ID + " and requested= 1";
        ResultSet rs = st.executeQuery(sql);
        int ID = 0;
        while (rs.next()) {
            ID = rs.getInt("SA_ID");
        }
        if (ID == said) {

            return true;
        }
        con.close();

        return false;
    }

    public boolean GetPer(int Acc_ID, int said) throws ClassNotFoundException, SQLException {
        String URL = "jdbc:mysql://localhost:3306/orgi";
        Class.forName("com.mysql.jdbc.Driver");
        Connection con = DriverManager.getConnection(URL, "root", "root");
        Statement st = con.createStatement();

        String sql = "select distinct Acc_ID from account,acc_dep_sa where SA_ID=" + said + " and type=1 and ID=Acc_ID and requested=1";
        ResultSet rs = st.executeQuery(sql);
        int ID = 0;
        while (rs.next()) {
            ID = rs.getInt("Acc_ID");
        }
        if (ID == Acc_ID) {

            return true;
        }
con.close();
        return false;
    }

    public int getSA_Dep_ID(int dep) throws ClassNotFoundException, SQLException {
        String URL = "jdbc:mysql://localhost:3306/orgi";
        Class.forName("com.mysql.jdbc.Driver");
        Connection con = DriverManager.getConnection(URL, "root", "root");
        Statement st = con.createStatement();

        String sql = "select distinct SA_ID from acc_dep_sa where Dep_ID=" + dep + " and requested= 1";
        ResultSet rs = st.executeQuery(sql);
        int ID = 0;
        while (rs.next()) {
            ID = rs.getInt("SA_ID");
        }
        con.close();
        return ID;

    }

    public String getSA_PName(int said) throws ClassNotFoundException, SQLException {
        String URL = "jdbc:mysql://localhost:3306/orgi";
        Class.forName("com.mysql.jdbc.Driver");
        Connection con = DriverManager.getConnection(URL, "root", "root");
        Statement st = con.createStatement();

        String sql = "select distinct FName from acc_dep_sa,account where SA_ID=" + said + " and  Acc_ID=ID and type=1 and requested= 1";
        ResultSet rs = st.executeQuery(sql);
        String Name = "";
        while (rs.next()) {
            Name = rs.getString("FName");
        }
        con.close();
        return Name;

    }

}
