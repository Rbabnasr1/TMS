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

/**
 *
 * @author rabab
 */
public class Report {

    public ArrayList GetDepName(int ID) throws ClassNotFoundException, SQLException {

        String URL = "jdbc:mysql://localhost:3306/orgi";
        Class.forName("com.mysql.jdbc.Driver");

        Connection con = DriverManager.getConnection(URL, "root", "root");
        Statement st = con.createStatement();
        String sql = "select Distinct Dep_ID from acc_dep_sa where Sa_ID=" + ID+" and Dep_ID IS NOT NULL";
        ResultSet rs = st.executeQuery(sql);

        ArrayList<Integer> list = new ArrayList<Integer>();

        while (rs.next()) {

            list.add(rs.getInt("Dep_ID"));

        }
        con.close();
        return list;
    }

    public ArrayList getAllTaskTime(int ID) throws ClassNotFoundException, SQLException {

        String URL = "jdbc:mysql://localhost:3306/orgi";
        Class.forName("com.mysql.jdbc.Driver");

        Connection con = DriverManager.getConnection(URL, "root", "root");
        Statement st = con.createStatement();
        String TName = "";
        String StartDate = "";
        String EndDate = "";
        ArrayList<String> Times = new ArrayList<>();
        st = con.createStatement();
        String sql = "select Distinct name,ID,rate,completionDate, endDate from task,acc_dep_task,acc_dep_sa where acc_dep_task.Acc_ID=acc_dep_sa.Acc_ID and Task_ID=ID and SA_ID=" + ID + " and (rate IS NOT NULL or rate <> 50 ) and completionDate IS NOT NULL";
        ResultSet rs = st.executeQuery(sql);
        int counter = 0;
        String Cday = "";
        String Cmonth = "";
        String Cyear = "";
        String Eday = "";
        String Emonth = "";
        String Eyear = "";
        while (rs.next()) {
            if (counter == 0) {
                TName += rs.getString("name");
                StartDate += rs.getString("completionDate");
                String[] co = rs.getString("completionDate").split("-");
                Cyear += co[0];
                Cmonth += co[1];
                Cday += co[2];
                EndDate += rs.getString("endDate");
                String[] En = rs.getString("endDate").split("-");
                Eyear += En[0];
                Emonth += En[1];
                Eday += En[2];

            } else {
                TName += "," + rs.getString("name");
                StartDate += "," + rs.getString("completionDate");
                String[] co = rs.getString("completionDate").split("-");
                Cyear += "," + co[0];
                Cmonth += "," + co[1];
                Cday += "," + co[2];
                EndDate += "," + rs.getString("endDate");
                String[] En = rs.getString("endDate").split("-");
                Eyear += "," + En[0];
                Emonth += "," + En[1];
                Eday += "," + En[2];

            }
            counter++;
        }
        Times.add(Eyear);
        Times.add(Emonth);
        Times.add(Eday);

        Times.add(Cyear);
        Times.add(Cmonth);
        Times.add(Cday);
        Times.add(TName);
        con.close();
        return Times;

    }

    public ArrayList getDepTaskTime(int DepID) throws ClassNotFoundException, SQLException {

        String URL = "jdbc:mysql://localhost:3306/orgi";
        Class.forName("com.mysql.jdbc.Driver");

        Connection con = DriverManager.getConnection(URL, "root", "root");
        Statement st = con.createStatement();
        String TName = "";
        String StartDate = "";
        String EndDate = "";
        ArrayList<String> Times = new ArrayList<>();
        st = con.createStatement();
        String sql = "select Distinct name,ID,rate,completionDate, endDate from task,acc_dep_task where Task_ID=ID and Dep_ID=" + DepID + " and (rate IS NOT NULL or rate <> 50 ) and completionDate IS NOT NULL";
        ResultSet rs = st.executeQuery(sql);
        int counter = 0;
        String Cday = "";
        String Cmonth = "";
        String Cyear = "";
        String Eday = "";
        String Emonth = "";
        String Eyear = "";
        while (rs.next()) {
            if (counter == 0) {
                TName += rs.getString("name");
                StartDate += rs.getString("completionDate");
                String[] co = rs.getString("completionDate").split("-");
                Cyear += co[0];
                Cmonth += co[1];
                Cday += co[2];
                EndDate += rs.getString("endDate");
                String[] En = rs.getString("endDate").split("-");
                Eyear += En[0];
                Emonth += En[1];
                Eday += En[2];

            } else {
                TName += "," + rs.getString("name");
                StartDate += "," + rs.getString("completionDate");
                String[] co = rs.getString("completionDate").split("-");
                Cyear += "," + co[0];
                Cmonth += "," + co[1];
                Cday += "," + co[2];
                EndDate += "," + rs.getString("endDate");
                String[] En = rs.getString("endDate").split("-");
                Eyear += "," + En[0];
                Emonth += "," + En[1];
                Eday += "," + En[2];

            }
            counter++;
        }
        Times.add(Eyear);
        Times.add(Emonth);
        Times.add(Eday);

        Times.add(Cyear);
        Times.add(Cmonth);
        Times.add(Cday);
        Times.add(TName);
        
        con.close();
        return Times;

    }
    
     public ArrayList getTaskSA(int Said) throws ClassNotFoundException, SQLException {

        String URL = "jdbc:mysql://localhost:3306/orgi";
        Class.forName("com.mysql.jdbc.Driver");

        Connection con = DriverManager.getConnection(URL, "root", "root");
        Statement st = con.createStatement();
        String ID = "";
        String StartDate = "";
        String EndDate = "";
        ArrayList<String> Times = new ArrayList<>();
        st = con.createStatement();
        String sql = "select Distinct ID, endDate from task,acc_dep_task,acc_dep_sa where Task_ID=ID and acc_dep_sa.dep_ID=acc_dep_task.dep_ID and SA_ID="+Said ;
        ResultSet rs = st.executeQuery(sql);
        int counter = 0;
       
        String Eday = "";
        String Emonth = "";
        String Eyear = "";
        while (rs.next()) {
            if (counter == 0) {
                ID += String.valueOf(rs.getString("ID"));
                EndDate += rs.getString("endDate");
                String[] En = rs.getString("endDate").split("-");
                Eyear += En[0];
                Emonth += En[1];
                Eday += En[2];

            } else {
               ID +=","+ String.valueOf(rs.getString("ID"));
                EndDate += "," + rs.getString("endDate");
                String[] En = rs.getString("endDate").split("-");
                Eyear += "," + En[0];
                Emonth += "," + En[1];
                Eday += "," + En[2];

            }
            counter++;
        }
        Times.add(Eyear);
        Times.add(Emonth);
        Times.add(Eday);

        Times.add(ID);
        con.close();
        return Times;

    }


    public String Evaluation (int ID) throws ClassNotFoundException, SQLException {
        String URL = "jdbc:mysql://localhost:3306/orgi";
        Class.forName("com.mysql.jdbc.Driver");
        Connection con = DriverManager.getConnection(URL, "root", "root");
        Statement st = con.createStatement();
        String sql = "select * from membereval ,task where  Acc_ID=" + ID+" and task_ID=ID";
        ResultSet rs = st.executeQuery(sql);
        String Data="";
        int counter=0;
        while(rs.next()){
            if(counter==0){
                Data+=rs.getString("Name")+","+rs.getDouble("eval");
            }
            else{
                 Data+="-"+rs.getString("Name")+","+rs.getDouble("eval");
            }
            counter++;
        }
        con.close();
        if(Data.equals("")){
        Data="Empty";}
return Data;
    }
     public ArrayList GetTable (int ID) throws ClassNotFoundException, SQLException {
         ArrayList<String>Data=new ArrayList<>();
        String URL = "jdbc:mysql://localhost:3306/orgi";
        Class.forName("com.mysql.jdbc.Driver");
        Connection con = DriverManager.getConnection(URL, "root", "root");
        Statement st = con.createStatement();
        String sql = "select Distinct account.type,FName,Task.name,finished from task,acc_dep_task,account,acc_dep_sa where Task_ID=task.ID and acc_dep_sa.dep_ID=acc_dep_task.dep_ID and account.ID=acc_dep_task.Acc_ID and SA_ID="+ID;
       ResultSet rs = st.executeQuery(sql);
        String MemberName="";
           String TaskName="";
              String Finished="";
              String type="";
              int f;
              int t;
              
        int counter=0;
        while(rs.next()){
            if(counter==0){
                MemberName+=rs.getString("FName");
                
                TaskName+=rs.getString("Task.Name");
                if(rs.getInt("finished")==1){
                Finished+="true";}else{
                Finished+="false";}
                 if(rs.getInt("type")==0){
                 
                 type+="Member";
                 }else{
                 type+="Head";}
                
                
            }
            else{
                  MemberName+=","+rs.getString("FName");
                
                TaskName+=","+rs.getString("Task.Name");
                if(rs.getInt("Finished")==1){
                Finished+=","+"Yes";}else{
                Finished+=","+"No";}
                 if(rs.getInt("type")==0){
                 
                 type+=","+"Member";
                 }else{
                 type+=","+"Head";}
                
                
            }
            counter++;
        }
        Data.add(MemberName);
        
        Data.add(type);
        Data.add(TaskName);
        
        Data.add(Finished);
        con.close();
        
        
return Data;
    }
    
     public ArrayList GetAllCamp(int SAID) throws ClassNotFoundException, SQLException {
        ArrayList<campaginModel> DepList = new ArrayList<campaginModel>();

        String URL = "jdbc:mysql://localhost:3306/orgi";
        Class.forName("com.mysql.jdbc.Driver");
        Connection con = DriverManager.getConnection(URL, "root", "root");
     
        Statement st = con.createStatement();
        String sql = "select Distinct ID, Name from campagin,acc_task_camp where SA_ID = " + SAID + " and ID=Camp_ID";
        ResultSet rs = st.executeQuery(sql);

        while (rs.next()) {
               campaginModel dep = new campaginModel();
            dep.setName(rs.getString("Name"));
            dep.setCID(rs.getInt("ID"));
            DepList.add(dep);
        }
con.close();
        return DepList;

    }
    
    

}
