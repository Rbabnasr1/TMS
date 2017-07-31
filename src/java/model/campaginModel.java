package model;

import java.sql.Connection;
import java.sql.DriverManager;
import java.sql.ResultSet;
import java.sql.SQLException;
import java.sql.Statement;
import java.util.ArrayList;
import java.util.Calendar;
import java.util.Date;

public class campaginModel {
    
private Connection con;
private String Name ;
private String description ;
private String startDate ;
private String endDate ;
private String startTime ;
private String endTime ;
private int SA_ID ;
private int CID;

    public campaginModel() throws SQLException, ClassNotFoundException{
     con = model.connection.getConnection();
}
    
    public void postInCamp( String message , int accID , int pageID) throws SQLException {
        Date date = new Date();
            Calendar cal = Calendar.getInstance();
            cal.setTime(date);
            String year = String.valueOf(cal.get(Calendar.YEAR));
            String month = String.valueOf(cal.get(Calendar.MONTH) + 1);
            String day = String.valueOf(cal.get(Calendar.DAY_OF_MONTH));

            String hour = String.valueOf(cal.get(Calendar.HOUR_OF_DAY));
            String min = String.valueOf(cal.get(Calendar.MINUTE));
            String sec = String.valueOf(cal.get(Calendar.SECOND));

            String d = String.valueOf(year+ "-" + month + "-" + day);
            String t = String.valueOf(hour + ":" + min + ":" + sec);
        String query="insert into post (message , camp_ID , acc_ID , postTime , postDate) values ('"+message+"', "+pageID +" , "+accID+" , '"+t+"','"+d+"')"; 
        Statement st = con.createStatement();
        st.executeUpdate(query);
    }
     public void deletePostInCamp(int post_ID) throws ClassNotFoundException, SQLException{
     String query="Delete from post where ID ="+post_ID ; 
         String URL = "jdbc:mysql://localhost:3306/orgi";
        Class.forName("com.mysql.jdbc.Driver");
        Connection con = DriverManager.getConnection(URL, "root", "root");
        Statement st = con.createStatement();
        st.executeUpdate(query);
}
public int addCampagin( campaginModel camp , int SA_Id) { 
    int campID =0;
try {
            
         String query="insert into Campagin (Name,Description,startDate,endDate,startTime,endTime,SA_ID) values ('"+
                 camp.getName()+ "','"+camp.getDescription()+"','"+camp.getStartDate()+"','"+
                 camp.getEndDate()+"','"+camp.getStartTime()+"','"+camp.getEndTime()+"',"+ SA_Id+" )";
                 
         Statement st = con.createStatement();
         st.executeUpdate(query);
         
         query = "select ID from Campagin where Name = '" +camp.getName()+"' and startDate = '"+camp.getStartDate()+"' and Description = '"+ camp.getDescription()+"'";
         st = con.createStatement();
         ResultSet rs = st.executeQuery(query);
         
         while(rs.next())
         {
             campID = rs.getInt("ID");
         }
         
         return campID;
        } catch (Exception e) {
            System.out.println("error in taskmodel");
        }
    return campID;
}
public campaginModel UpdateCampagin( campaginModel camp , int campID) throws SQLException, ClassNotFoundException 
{
   String Sql = " select * from campagin where ID = "+ campID;
    Statement st = con.createStatement();
   ResultSet rs = st.executeQuery(Sql);
    campaginModel OldCamp = new campaginModel();
    while (rs.next())
    {
        OldCamp.setName(rs.getString("Name"));
        OldCamp.setDescription(rs.getString("Description"));
        OldCamp.setEndDate(rs.getString("endDate"));
        OldCamp.setStartDate(rs.getString("startDate"));
        OldCamp.setEndTime(rs.getString("endTime"));
        OldCamp.setStartTime(rs.getString("startTime")); 
    }
    
    if(camp.getName().equals(""))
    {
        camp.setName(OldCamp.getName());
    }
    if(camp.getDescription().equals(""))
    {
        camp.setDescription(OldCamp.getDescription());
    }
    if(camp.getStartDate().equals(""))
    {
        camp.setStartDate(OldCamp.getStartDate());
    }
    if(camp.getEndDate().equals(""))
    {
        camp.setEndDate(OldCamp.getEndDate());
    }
    if(camp.getEndTime().equals(""))
    {
        camp.setEndTime(OldCamp.getEndTime());
    }
    if(camp.getStartTime().equals(""))
    {
        camp.setStartTime(OldCamp.getStartTime());
    }
    
    
    Sql=" update campagin set Name = '"+camp.getName()+"', Description = '"+camp.getDescription()+"', startDate = '"+
            camp.getStartDate() + "', endDate = '"+camp.getEndDate()+"', startTime = '"+camp.getStartTime()+"', endTime = '"+ camp.getEndTime() 
            +"' where ID = " + campID ;
    st = con.createStatement();
    st.executeUpdate(Sql);
    
    return camp;
}
public  void DeleteCampagin(int campID) throws SQLException, ClassNotFoundException 
{
    
    
    
    
    Statement st = con.createStatement();
    String Sql = " delete from acc_task_camp where Camp_ID = "+ campID;
    st.executeUpdate(Sql);
    
    
  st = con.createStatement();
    Sql = " delete from notification where pageType = 'camp' and PageID = "+campID;
    st.executeUpdate(Sql);
    
    
    
 st = con.createStatement();
    Sql = " delete from post where camp_ID = "+ campID;
    st.executeUpdate(Sql);

    
     st = con.createStatement();
    Sql = " delete from campagin where ID = "+ campID;
    st.executeUpdate(Sql);

    






}
    public String getName() {
        return Name;
    }
    public void setName(String Name) {
        this.Name = Name;
    }
    public String getDescription() {
        return description;
    }
    public void setDescription(String description) {
        this.description = description;
    }
    public String getStartDate() {
        return startDate;
    }
    public void setStartDate(String startDate) {
        this.startDate = startDate;
    }
    public String getEndDate() {
        return endDate;
    }
    public void setEndDate(String endDate) {
        this.endDate = endDate;
    }
    public String getStartTime() {
        return startTime;
    }
    public void setStartTime(String startTime) {
        this.startTime = startTime;
    }
    public String getEndTime() {
        return endTime;
    }
    public void setEndTime(String endTime) {
        this.endTime = endTime;
    }
    public int getSA_ID() {
        return SA_ID;
    }
    public void setSA_ID(int SA_ID) {
        this.SA_ID = SA_ID;
    }

    /**
     * @return the CID
     */
    public int getCID() {
        return CID;
    }

    /**
     * @param CID the CID to set
     */
    public void setCID(int CID) {
        this.CID = CID;
    }


public ArrayList viewCamo(int SA) throws SQLException, ClassNotFoundException 
{
    ArrayList <campaginModel> camp= new ArrayList<>();
   String Sql = " select * from campagin where SA_ID = "+SA;
    Statement st = con.createStatement();
   ResultSet rs = st.executeQuery(Sql);
 
    while (rs.next())
    {   campaginModel OldCamp = new campaginModel();
        OldCamp.setName(rs.getString("Name"));
        OldCamp.setDescription(rs.getString("Description"));
        OldCamp.setEndDate(rs.getString("endDate"));
        OldCamp.setStartDate(rs.getString("startDate"));
        OldCamp.setEndTime(rs.getString("endTime"));
        OldCamp.setStartTime(rs.getString("startTime"));
        
        OldCamp.setCID(rs.getInt("ID"));
        camp.add(OldCamp);    }

return camp;

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

        return DepList;

    }
   















}
