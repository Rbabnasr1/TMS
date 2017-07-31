/*
 * To change this license header, choose License Headers in Project Properties.
 * To change this template file, choose Tools | Templates
 * and open the template in the editor.
 */
package model;

import java.sql.Connection;
import java.sql.DriverManager;
import java.sql.ResultSet;
import java.sql.SQLException;
import java.sql.Statement;
import java.util.ArrayList;
import java.util.Calendar;
import java.util.Date;
import javax.servlet.http.HttpSession;

/**
 *
 * @author rabab
 */
public class Department {

    private String name;
    private String target;
    private int acc_ID;
    private int Dep_ID;

    public Department(String name, String target, int Acc_ID) {
        this.name = name;
        this.target = target;
        this.acc_ID = Acc_ID;
    }

    public Department() {
        this.name = "";
        this.target = "";
        this.acc_ID = 0;
    }

    public String getName() {
        return name;
    }

    public void setName(String name) {
        this.name = name;
    }

    public String getTarget() {
        return target;
    }

    public void setTarget(String target) {
        this.target = target;
    }

    public int getAcc_ID() {
        return acc_ID;
    }

    public void setAcc_ID(int acc_ID) {
        this.acc_ID = acc_ID;
    }

    public int CreateDep(String name, String target, int Acc_ID, int SAID) throws ClassNotFoundException, SQLException {

        String URL = "jdbc:mysql://localhost:3306/orgi";
        Class.forName("com.mysql.jdbc.Driver");
        Connection con = DriverManager.getConnection(URL, "root", "root");
        Statement st = con.createStatement();
        String sql = "insert into Departement (Name,targetPlan) values('" + name + "','" + target + "')";
        st.executeUpdate(sql);
        int id = getID(name, target, Acc_ID);

        con.close();
        con = DriverManager.getConnection(URL, "root", "root");

        st = con.createStatement();

        sql = "select * from acc_dep_sa where SA_ID =" + SAID + " and Acc_ID =" + Acc_ID;
        ResultSet rs = st.executeQuery(sql);
        int ID = 0;
        while (rs.next()) {
            ID = rs.getInt("Dep_ID");
        }
        String check = String.valueOf(ID);
        con.close();
        con = DriverManager.getConnection(URL, "root", "root");
        st = con.createStatement();
        sql = "delete from acc_dep_sa where Dep_ID IS NULL and SA_ID = " + SAID;
        st.executeUpdate(sql);
        con.close();
        con = DriverManager.getConnection(URL, "root", "root");
        st = con.createStatement();
        sql = "insert into acc_dep_sa (SA_ID,Dep_ID,Acc_ID,requested) values(" + SAID + "," + id + "," + Acc_ID + ",1)";
        st.executeUpdate(sql);
        con.close();
        return id;

    }

    public boolean Update(String name, String targetPlan, int id) throws ClassNotFoundException, SQLException {
        try {
            String URL = "jdbc:mysql://localhost:3306/orgi";
            Class.forName("com.mysql.jdbc.Driver");
            Connection con = DriverManager.getConnection(URL, "root", "root");
            Statement st = con.createStatement();
            String sql = "";
            if (!targetPlan.equals("") && !name.equals("")) {
                sql = "update Departement set Name = '" + name + "' , targetPlan = '" + targetPlan + "' where ID =" + id;
            } else if (targetPlan.equals("") && !name.equals("")) {
                sql = "update Departement set Name = '" + name + "' where ID =" + id;
            } else if (!targetPlan.equals("") && name.equals("")) {
                sql = "update Departement set targetPlan = '" + targetPlan + "' where ID = " + id;
            }
            st.executeUpdate(sql);
            con.close();
            return true;
        } catch (Exception e) {
            return false;
        }
    }

    public boolean remove(int id) throws ClassNotFoundException, SQLException {
        try {
            String URL = "jdbc:mysql://localhost:3306/orgi";
            Class.forName("com.mysql.jdbc.Driver");
            Connection con = DriverManager.getConnection(URL, "root", "root");
            Statement st = con.createStatement();
            String sql = "delete from acc_dep_task where Dep_ID=" + id;
            st.executeUpdate(sql);
            con.close();
            
            
            
            con = DriverManager.getConnection(URL, "root", "root");
            st = con.createStatement();
            sql = "delete from acc_dep_sa where Dep_ID=" + id;
            st.executeUpdate(sql);
            con.close();
            
            
            
            con = DriverManager.getConnection(URL, "root", "root");
            st = con.createStatement();
            sql = " delete from notification where pageType = 'dep' and PageID = " + id;
            st.executeUpdate(sql);
            con.close();
            
            
            
            con = DriverManager.getConnection(URL, "root", "root");
            st = con.createStatement();
            sql = " delete from post where dep_ID = " + id;
            st.executeUpdate(sql);
            con.close();
            
            
            con = DriverManager.getConnection(URL, "root", "root");
            st = con.createStatement();
            sql = "delete from Departement where ID=" + id;
            st.executeUpdate(sql);
            con.close();
            
            
            return true;
        } catch (Exception e) {
            return false;
        }
    }

    public ArrayList<String> view() throws ClassNotFoundException, SQLException {
        ArrayList<String> DepList = new ArrayList<>();

        String URL = "jdbc:mysql://localhost:3306/orgi";
        Class.forName("com.mysql.jdbc.Driver");
        Connection con = DriverManager.getConnection(URL, "root", "root");
        Statement st = con.createStatement();
        String sql = "select * from Departement";
        ResultSet rs = st.executeQuery(sql);
  
        while (rs.next()) {
            String k = rs.getString("Name");
            DepList.add(k);
        }
con.close();
        return DepList;
    }

    public ArrayList<Department> GetDep(int ID) throws ClassNotFoundException, SQLException {
        ArrayList<Department> DepList = new ArrayList<>();

        String URL = "jdbc:mysql://localhost:3306/orgi";
        Class.forName("com.mysql.jdbc.Driver");
        Connection con = DriverManager.getConnection(URL, "root", "root");
        Department dep = new Department();
        Statement st = con.createStatement();
        String sql = "select * from Departement where ID = " + ID;
        ResultSet rs = st.executeQuery(sql);

        while (rs.next()) {
            dep.setName(rs.getString("Name"));
            dep.setAcc_ID(rs.getInt("Acc_ID"));
            dep.setTarget(rs.getString("targetPlan"));
            dep.setDep_ID(rs.getInt("ID"));
            DepList.add(dep);
        }
        con.close();

        return DepList;
    }

    public int getID(String name, String target, int Acc_ID) throws ClassNotFoundException, SQLException {
        String URL = "jdbc:mysql://localhost:3306/orgi";
        Class.forName("com.mysql.jdbc.Driver");
        Connection con = DriverManager.getConnection(URL, "root", "root");
        Statement st = con.createStatement();

        String sql = "select ID from Departement where Name='" + name + "' and targetPlan='" + target + "'";
        ResultSet rs = st.executeQuery(sql);
        int ID = 0;
        while (rs.next()) {
            ID = rs.getInt("ID");
        }
con.close();
        return ID;
    }

    public int getDep_ID(int Acc_ID) throws ClassNotFoundException, SQLException {
        String URL = "jdbc:mysql://localhost:3306/orgi";
        Class.forName("com.mysql.jdbc.Driver");
        Connection con = DriverManager.getConnection(URL, "root", "root");
        Statement st = con.createStatement();

        String sql = "select Dep_ID from acc_dep_sa where Acc_ID=" + Acc_ID + " and requested= 1";
        ResultSet rs = st.executeQuery(sql);
        int ID = 0;
        while (rs.next()) {
            ID = rs.getInt("Dep_ID");
        }

        con.close();
        return ID;
    }

    public void postInDep(String message, int accID, int pageID) throws ClassNotFoundException, SQLException {
        String URL = "jdbc:mysql://localhost:3306/orgi";
        Class.forName("com.mysql.jdbc.Driver");

        Connection con = DriverManager.getConnection(URL, "root", "root");
        Date date = new Date();
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
        String query = "insert into post (message , dep_ID , acc_ID , postTime , postDate) values ('" + message + "', " + pageID + " , " + accID + " , '" + t + "','" + d + "')";
        Statement st = con.createStatement();
        st.executeUpdate(query);
 con.close();
    }

    public void deletePostInDep(int post_ID) throws ClassNotFoundException, SQLException {
        String query = "Delete from post where ID =" + post_ID;
        String URL = "jdbc:mysql://localhost:3306/orgi";
        Class.forName("com.mysql.jdbc.Driver");
        Connection con = DriverManager.getConnection(URL, "root", "root");
        Statement st = con.createStatement();
        st.executeUpdate(query);
        con.close();
    }

    public void addMember(int IDMember, int Depid) throws ClassNotFoundException, SQLException {
        String URL = "jdbc:mysql://localhost:3306/orgi";
        Class.forName("com.mysql.jdbc.Driver");

        Connection con = DriverManager.getConnection(URL, "root", "root");
        String query = "Update acc_dep_sa set Dep_ID=" + Depid + " where Acc_ID=" + IDMember;
        Statement st = con.createStatement();
        st.executeUpdate(query);
         con.close();
//                 con = DriverManager.getConnection(URL, "root", "root");

    }

    public ArrayList GetAllDep(int SAID) throws ClassNotFoundException, SQLException {
        ArrayList<Department> DepList = new ArrayList<>();

        String URL = "jdbc:mysql://localhost:3306/orgi";
        Class.forName("com.mysql.jdbc.Driver");
        Connection con = DriverManager.getConnection(URL, "root", "root");

        Statement st = con.createStatement();
        String sql = "select Distinct ID, Name from Departement,acc_dep_sa where SA_ID = " + SAID + " and ID=Dep_ID";
        ResultSet rs = st.executeQuery(sql);

        while (rs.next()) {
            Department dep = new Department();
            dep.setName(rs.getString("Name"));
            dep.setDep_ID(rs.getInt("ID"));
            DepList.add(dep);
        }
        con.close();

        return DepList;

    }

    public boolean CheckDep_ID(int Acc_ID, int Depid) throws ClassNotFoundException, SQLException {
        String URL = "jdbc:mysql://localhost:3306/orgi";
        Class.forName("com.mysql.jdbc.Driver");
        Connection con = DriverManager.getConnection(URL, "root", "root");
       
        Statement st = con.createStatement();

        String sql = "select distinct Dep_ID from account,acc_dep_sa where Acc_ID=" + Acc_ID + " and requested= 1 and ID=Acc_ID and type=2";
        ResultSet rs = st.executeQuery(sql);
        int ID = 0;
        while (rs.next()) {
            ID = rs.getInt("Dep_ID");
        }
        
        if (ID == Depid) {

            return true;
        }
con.close();
        return false;
    }

    /**
     * @return the Dep_ID
     */
    public int getDep_ID() {
        return Dep_ID;
    }

    /**
     * @param Dep_ID the Dep_ID to set
     */
    public void setDep_ID(int Dep_ID) {
        this.Dep_ID = Dep_ID;
    }

    public String getDEp_HName(int depID) throws ClassNotFoundException, SQLException {
        String URL = "jdbc:mysql://localhost:3306/orgi";
        Class.forName("com.mysql.jdbc.Driver");
        Connection con = DriverManager.getConnection(URL, "root", "root");
        Statement st = con.createStatement();

        String sql = "select distinct FName from acc_dep_sa,account where Dep_ID=" + depID + " and  Acc_ID=ID and type=2 and requested= 1";
        ResultSet rs = st.executeQuery(sql);
        String Name = "";
        while (rs.next()) {
            Name = rs.getString("FName");
        }
        con.close();
        return Name;

    }
}
