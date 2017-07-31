package model;

import com.mysql.jdbc.PreparedStatement;
import java.io.InputStream;
import java.sql.Connection;
import java.sql.DriverManager;
import java.sql.ResultSet;
import java.sql.SQLException;
import java.sql.Statement;
import java.util.ArrayList;
import java.util.Calendar;
import java.util.Date;
import javax.servlet.http.Part;

public class taskModel {

    private Connection con;
    private String Name;
    private String description;
    private int piriority;
    private int percentage;
    private String startDate;
    private String endDate;
    private String completionDate;
    private String startTime;
    private String endTime;
    private int type;
    private String taskFile;
    private String workedFile;
    private ArrayList<Integer> skills;
    private int ID;
    private String color;
    
    
    
    public taskModel() throws SQLException, ClassNotFoundException {
        con = model.connection.getConnection();
    }

     public void cummulativeEval(int account_ID , int task_ID ,double eval) throws SQLException {
          Statement st =con.createStatement();
           String sql= "insert into memberEval (acc_ID,task_ID,eval) values ("+account_ID+","+task_ID+","+eval+")";
        st.executeUpdate(sql);
     }
    
     
    public void insertAtaskDep(int id , int id2) throws SQLException, ClassNotFoundException {
        String query = " insert into taskdep ( dependant , determinant ) values ("+id+","+id2+")";
        Statement statement = con.createStatement();
        statement.executeUpdate(query);
           }
    public boolean addSkills(int id) throws SQLException {
         
        Statement st ;
        for(int i=0 ;i<getSkills().size() ;i++)
        {
        st = con.createStatement();
        String sql= "insert into task_skill (task_ID,skill_ID) values ("+id+","+getSkills().get(i)+")";
        st.executeUpdate(sql);
        }
        return false;
     
     }
       public String taskDep(int id) throws SQLException, ClassNotFoundException {
        String query = "select endDate from task where ID = " + id;
        String d = "";
        Statement statement = con.createStatement();
        ResultSet rs = statement.executeQuery(query);
        while (rs.next()) {
            d = rs.getString("endDate");

        }

        return d;
    }
       public ArrayList<taskModel> tasksinDep(int depID) throws SQLException, ClassNotFoundException {
        String query = "select * from task , acc_dep_task where Task_ID = ID and Dep_ID = " + depID;
        ArrayList<taskModel> t = new ArrayList<taskModel>();

        Statement statement = con.createStatement();
        ResultSet rs = statement.executeQuery(query);
        while (rs.next()) {
            model.taskModel t1 = new taskModel();
            t1.setID(rs.getInt("ID"));
            t1.setName(rs.getString("Name"));
            t.add(t1);
        }
        return t;
    }

    public boolean addTask(taskModel task, int uID, int DepID,int depend) {
       try {
            Statement statement = con.createStatement();
            String query = "insert into task (Name,description,piriority,percentage,startDate,endDate,startTime,endTime,type,task_File) values('"
                    + task.getName() + "','" + task.getDescription() + "'," + task.getPiriority() + ",0,'" + task.getStartDate() + "','"
                    + task.getEndDate() + "','" + task.getStartTime() + "','" + task.getEndTime() + "',0,'" + task.getTaskFile() + "') ";
            statement.executeUpdate(query);

            addTaskInto(task, uID, DepID);
            
             statement = con.createStatement();
             query = "select ID from task where Name="+task.getName()+" and endDate"+ task.getEndDate()+" and startTime"+task.getStartTime();
            
            ResultSet rs=statement.executeQuery(query);
            int TaskID = 0;
            while(rs.next()){
            
            TaskID=rs.getInt("ID");
            }

            if(depend!=0){
            insertAtaskDep(depend,TaskID);
            }
        } catch (Exception e) {
            return false;
        }
        return false;
    }
     public void addTaskInto(taskModel task, int uID, int DepID) throws ClassNotFoundException, SQLException {
     
     int ID = getID(task);

             Statement st= con.createStatement();
           String query = "insert into acc_dep_task (Task_ID,Dep_ID,NumberOfStar) values (" + ID + "," + DepID + ",50)";

            st.executeUpdate(query);

      
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

    public int getPiriority() {
        return piriority;
    }

    public void setPiriority(int piriority) {
        this.piriority = piriority;
    }

    public int getPercentage() {
        return percentage;
    }

    public void setPercentage(int percentage) {
        this.percentage = percentage;
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

    public String getCompletionDate() {
        return completionDate;
    }

    public void setCompletionDate(String completionDate) {
        this.completionDate = completionDate;
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

    public int getType() {
        return type;
    }

    public void setType(int type) {
        this.type = type;
    }

    
      public boolean addTaskToCamp(taskModel task, int uID, int campID ) {
        try {
            String query = "insert into task (Name,description,piriority,percentage,startDate,endDate,startTime,endTime,type,task_File) values('"
                    + task.getName() + "','" + task.getDescription() + "'," + task.getPiriority() + ",0,'" + task.getStartDate() + "','"
                    + task.getEndDate() + "','" + task.getStartTime() + "','" + task.getEndTime() + "', 1  ,'"+task.getTaskFile()+"') ";
            Statement statement=con.createStatement();
            statement.executeUpdate(query);
            addTaskIntoCamp(task, uID, campID);
            return true;
        } catch (Exception e) {
          return false;
        }
    }
      public void addTaskIntoCamp(taskModel task, int uID, int campID) throws ClassNotFoundException, SQLException {
     
     int ID = getID(task);

             Statement st= con.createStatement();
           String query = "insert into acc_task_camp (Task_ID,Camp_ID,NumberOfStar) values ("+ ID + "," + campID + ",50)";
            st.executeUpdate(query);
     }
   
    public int getID(taskModel task) throws ClassNotFoundException, SQLException {
        String URL = "jdbc:mysql://localhost:3306/orgi";
        Class.forName("com.mysql.jdbc.Driver");
        Connection con = DriverManager.getConnection(URL, "root", "root");
        Statement st = con.createStatement();

        String sql = "select ID from task where Name='" + task.getName() + "' and description='" + task.getDescription() + "' and piriority=" + task.getPiriority();
        ResultSet rs = st.executeQuery(sql);
        int ID = 0;
        while (rs.next()) {
            ID = rs.getInt("ID");
        }

        return ID;
    }



    /**
     * @return the skills
     */
    public ArrayList<Integer> getSkills() {
        return skills;
    }

    /**
     * @param skills the skills to set
     */
    public void setSkills(ArrayList<Integer> skills) {
        this.skills = skills;
    }

    /**
     * @return the taskFile
     */
    public String getTaskFile() {
        return taskFile;
    }

    /**
     * @param taskFile the taskFile to set
     */
    public void setTaskFile(String taskFile) {
        this.taskFile = taskFile;
    }

    /**
     * @return the workedFile
     */
    public String getWorkedFile() {
        return workedFile;
    }

    /**
     * @param workedFile the workedFile to set
     */
    public void setWorkedFile(String workedFile) {
        this.workedFile = workedFile;
    }
    public ArrayList GetDays(String StartDate, String EndDate) {
        ArrayList<Integer> _Date=new ArrayList();
        int monthConsEnd;
        int monthConsStrt;
        int monthConsCur;

        String str = StartDate;
        String str1[] = str.split("-");
        String end = EndDate;
        String end1[] = end.split("-");

        if (Integer.parseInt(end1[1]) <= 7) {
            if (Integer.parseInt(end1[1]) == 2) {
                monthConsEnd = 28;

            } else if (Integer.parseInt(end1[1]) % 2 == 0) {
                monthConsEnd = 30;
            } else {
                monthConsEnd = 31;
            }

        } else {
            if (Integer.parseInt(end1[1]) % 2 == 0) {
                monthConsEnd = 31;
            } else {
                monthConsEnd = 30;
            }

        }

        if (Integer.parseInt(str1[1]) <= 7) {
            if (Integer.parseInt(str1[1]) == 2) {
                monthConsStrt = 28;
            } else if (Integer.parseInt(str1[1]) % 2 == 0) {
                monthConsStrt = 30;
            } else {
                monthConsStrt = 31;
            }

        } else {
            if (Integer.parseInt(str1[1]) % 2 == 0) {
                monthConsStrt = 31;
            } else {
                monthConsStrt = 30;
            }

        }
        int durYear = (Integer.parseInt(end1[0]) - Integer.parseInt(str1[0])) * 365;

        int durMonth;
        int durDay;
        int durMonthCur;
        int durDayCur;

        Date date = new Date();
        Calendar cal = Calendar.getInstance();
        cal.setTime(date);
        String year = String.valueOf(cal.get(Calendar.YEAR));
        String month = String.valueOf(cal.get(Calendar.MONTH) + 1);
        String day = String.valueOf(cal.get(Calendar.DAY_OF_MONTH));

        if (Integer.parseInt(month) <= 7) {
            if (Integer.parseInt(month) == 2) {
                monthConsCur = 28;
            } else if (Integer.parseInt(month) % 2 == 0) {
                monthConsCur = 30;
            } else {
                monthConsCur = 31;
            }

        } else {
            if (Integer.parseInt(month) % 2 == 0) {
                monthConsCur = 31;
            } else {
                monthConsCur = 30;
            }

        }

        int durYearCur = (Integer.parseInt(end1[0]) - Integer.parseInt(year)) * 365;

        if (durYear == 0) {
            if (monthConsEnd <= monthConsStrt) {
                durDay = (Integer.parseInt(end1[2]) - Integer.parseInt(str1[2]));
                durMonth = ((Integer.parseInt(end1[1]) - Integer.parseInt(str1[1]))) * monthConsStrt;
            } else {

                durDay = (Integer.parseInt(end1[2]) - Integer.parseInt(str1[2]));
                durMonth = ((Integer.parseInt(end1[1]) - Integer.parseInt(str1[1]))) * monthConsEnd;

            }
        } else {
            if (monthConsEnd <= monthConsStrt) {
                durDay = ((Integer.parseInt(end1[2])) - Integer.parseInt(str1[2]));
                durMonth = ((Integer.parseInt(end1[1] + 12) * -(Integer.parseInt(str1[1]))) * monthConsStrt);
            } else {
                durDay = ((Integer.parseInt(end1[2])) - Integer.parseInt(str1[2]));
                durMonth = ((Integer.parseInt(end1[1] + 12) * -(Integer.parseInt(str1[1]))) * monthConsEnd);

            }
        }

        if (durYearCur == 0) {
            if (monthConsEnd <= monthConsCur) {
                durDayCur = (Integer.parseInt(end1[2]) - Integer.parseInt(day));
                durMonthCur = (Integer.parseInt(end1[1]) - Integer.parseInt(month)) * monthConsCur;
            } else {
                durDayCur = (Integer.parseInt(end1[2]) - Integer.parseInt(day));
                durMonthCur = (Integer.parseInt(end1[1]) - Integer.parseInt(month)) * monthConsEnd;
            }
        } else {
            if (monthConsEnd <= monthConsCur) {
                durDayCur = ((Integer.parseInt(end1[2])) - Integer.parseInt(day));
                durMonthCur = (Integer.parseInt(end1[1] + 12) - Integer.parseInt(month)) * monthConsCur;
            } else {
                durDayCur = (Integer.parseInt(end1[2]) - Integer.parseInt(day));
                durMonthCur = (Integer.parseInt(end1[1] + 12) - Integer.parseInt(month)) * monthConsEnd;
            }
        }
      
        _Date.add( durYear);
        _Date.add(durMonth);
        _Date.add(durDay);
         _Date.add( durYearCur);
        _Date.add(durMonthCur);
        _Date.add(durDayCur);
        return _Date;
    }

public ArrayList GetAllTask(int Dep) throws ClassNotFoundException, SQLException {
        ArrayList<String> Tasks = new ArrayList<>();

        String URL = "jdbc:mysql://localhost:3306/orgi";
        Class.forName("com.mysql.jdbc.Driver");
        Connection con = DriverManager.getConnection(URL, "root", "root");
     
        Statement st = con.createStatement();
        String sql = "select Distinct  Name from Task,acc_dep_task where Dep_ID = " + Dep + " and ID=Dep_ID";
        ResultSet rs = st.executeQuery(sql);

        while (rs.next()) {
          
            
            Tasks.add(rs.getString("Name"));
        }

        return Tasks;

    }

    /**
     * @return the ID
     */
    public int getID() {
        return ID;
    }

    /**
     * @param ID the ID to set
     */
    public void setID(int ID) {
        this.ID = ID;
    }
    public ArrayList GetTaskCamp(int userID) throws ClassNotFoundException, SQLException {
        ArrayList<taskModel> Task_inf = new ArrayList<taskModel>();

        String URL = "jdbc:mysql://localhost:3306/orgi";
        Class.forName("com.mysql.jdbc.Driver");
        Connection con = DriverManager.getConnection(URL, "root", "root");
     
        Statement st = con.createStatement();
       String sql = "select task.Name,startDate,endDate ,task.ID,task.percentage from task , acc_task_camp where task.ID = acc_task_camp.Task_ID and Acc_ID = " + userID + " and task.percentage <100  ";
                ResultSet rs = st.executeQuery(sql);
            
            while (rs.next()) {
                   taskModel tA=new taskModel();
                   tA.setEndDate(rs.getString("endDate"));
                   tA.setStartDate(rs.getString("startDate"));
                   tA.setName(rs.getString("Name"));
                     tA.setPercentage(rs.getInt("percentage"));
                   tA.setID(rs.getInt("ID"));
                   
            Task_inf.add(tA);
        }
                
            
          
            return Task_inf;
}
     public ArrayList GetTaskSA(int userID) throws ClassNotFoundException, SQLException {
        ArrayList<taskModel> Task_inf = new ArrayList<taskModel>();

        String URL = "jdbc:mysql://localhost:3306/orgi";
        Class.forName("com.mysql.jdbc.Driver");
        Connection con = DriverManager.getConnection(URL, "root", "root");
     
        Statement st = con.createStatement();
       String  sql = "select task.Name ,startDate,endDate,task.ID,task.percentage from task , acc_dep_task where task.ID = acc_dep_task.Task_ID and Acc_ID =" + userID+" and task.percentage <100  ";
         ResultSet rs = st.executeQuery(sql);
            
            while (rs.next()) {
                   taskModel tA=new taskModel();
                   tA.setEndDate(rs.getString("endDate"));
                   tA.setStartDate(rs.getString("startDate"));
                   tA.setName(rs.getString("Name"));
                     tA.setPercentage(rs.getInt("percentage"));
                   tA.setID(rs.getInt("ID"));
                   
            Task_inf.add(tA);
        }
                
            
          
            return Task_inf;
}
      public boolean CheckTtask_ID(int Task_ID,int Depid) throws ClassNotFoundException, SQLException {
        String URL = "jdbc:mysql://localhost:3306/orgi";
        Class.forName("com.mysql.jdbc.Driver");
        Connection con = DriverManager.getConnection(URL, "root", "root");
        Statement st = con.createStatement();

        String sql = "select distinct Dep_ID from acc_dep_task where Task_ID=" + Task_ID ;
        ResultSet rs = st.executeQuery(sql);
        int ID = 0;
        while (rs.next()) {
            ID = rs.getInt("Dep_ID");
        }
        if(ID==Depid){
        
        return true;
        }

        return false; 
    }
                public boolean CheckTtaskSA_ID(int Task_ID,int said) throws ClassNotFoundException, SQLException {
        String URL = "jdbc:mysql://localhost:3306/orgi";
        Class.forName("com.mysql.jdbc.Driver");
        Connection con = DriverManager.getConnection(URL, "root", "root");
        Statement st = con.createStatement();

        String sql ="select distinct acc_dep_sa.SA_ID from acc_dep_task,acc_dep_sa where Task_ID="+Task_ID+" and requested= 1 and acc_dep_sa.Dep_ID=acc_dep_task.Dep_ID";
        ResultSet rs = st.executeQuery(sql);
        int ID = 0;
        while (rs.next()) {
            ID = rs.getInt("acc_dep_sa.SA_ID");
        }
        if(ID==said){
        
        return true;
        }

        return false; 
    }
            
    public int getDepforTask(int Task_ID) throws ClassNotFoundException, SQLException {
        String URL = "jdbc:mysql://localhost:3306/orgi";
        Class.forName("com.mysql.jdbc.Driver");
        Connection con = DriverManager.getConnection(URL, "root", "root");
        Statement st = con.createStatement();

        String sql = "select distinct Dep_ID from acc_dep_task where Task_ID=" + Task_ID ;
        ResultSet rs = st.executeQuery(sql);
        int ID = 0;
        while (rs.next()) {
            ID = rs.getInt("Dep_ID");
        }
        

        return ID; 
    }
   public ArrayList getTaskByDate(int ID) throws ClassNotFoundException, SQLException{
   ArrayList<taskModel> _task= new ArrayList<>();
    String URL = "jdbc:mysql://localhost:3306/orgi";
        Class.forName("com.mysql.jdbc.Driver");
        Connection con = DriverManager.getConnection(URL, "root", "root");
         Date date = new Date();
        Calendar cal = Calendar.getInstance();
        cal.setTime(date);
        String year = String.valueOf(cal.get(Calendar.YEAR));
        String month = String.valueOf(cal.get(Calendar.MONTH) + 1);
        String day = String.valueOf(cal.get(Calendar.DAY_OF_MONTH));
         if (month.length() == 1) {

                    month = "0" + month;
                }
                if (day.length() == 1) {

                    day = "0" + day;
                }
           String Date=year+"-"+month+"-"+day;

        Statement st = con.createStatement();

        String sql = " select * from task ,acc_dep_task where ID=Task_ID and endDate='"+Date+"' and Acc_ID="+ID+" and finished is null";
        ResultSet rs = st.executeQuery(sql);
        
        
        while (rs.next()) {
            
           
              int monthConsEnd;
                        int monthConsStrt;
                        int monthConsCur;
                        String str = rs.getString("startDate");
                        String str1[] = str.split("-");
                        String end = rs.getString("endDate");
                        String end1[] = end.split("-");

                        if (Integer.parseInt(end1[1]) <= 7) {
                            if (Integer.parseInt(end1[1]) == 2) {
                                monthConsEnd = 28;

                            } else if (Integer.parseInt(end1[1]) % 2 == 0) {
                                monthConsEnd = 30;
                            } else {
                                monthConsEnd = 31;
                            }

                        } else {
                            if (Integer.parseInt(end1[1]) % 2 == 0) {
                                monthConsEnd = 31;
                            } else {
                                monthConsEnd = 30;
                            }

                        }

//            out.print("end : " + monthConsEnd + "<br>");
                        if (Integer.parseInt(str1[1]) <= 7) {
                            if (Integer.parseInt(str1[1]) == 2) {
                                monthConsStrt = 28;
                            } else if (Integer.parseInt(str1[1]) % 2 == 0) {
                                monthConsStrt = 30;
                            } else {
                                monthConsStrt = 31;
                            }

                        } else {
                            if (Integer.parseInt(str1[1]) % 2 == 0) {
                                monthConsStrt = 31;
                            } else {
                                monthConsStrt = 30;
                            }

                        }
//            out.print(monthConsStrt);
                        int durYear = (Integer.parseInt(end1[0]) - Integer.parseInt(str1[0])) * 365;

                        int durMonth;
                        int durDay;
                        int durMonthCur;
                        int durDayCur;

                       
                        if (Integer.parseInt(month) <= 7) {
                            if (Integer.parseInt(month) == 2) {
                                monthConsCur = 28;
                            } else if (Integer.parseInt(month) % 2 == 0) {
                                monthConsCur = 30;
                            } else {
                                monthConsCur = 31;
                            }

                        } else {
                            if (Integer.parseInt(month) % 2 == 0) {
                                monthConsCur = 31;
                            } else {
                                monthConsCur = 30;
                            }

                        }

                        int durYearCur = (Integer.parseInt(end1[0]) - Integer.parseInt(year)) * 365;

                        if (durYear == 0) {
                            if (monthConsEnd <= monthConsStrt) {
                                durDay = (Integer.parseInt(end1[2]) - Integer.parseInt(str1[2]));
                                durMonth = ((Integer.parseInt(end1[1]) - Integer.parseInt(str1[1]))) * monthConsStrt;
                            } else {

                                durDay = (Integer.parseInt(end1[2]) - Integer.parseInt(str1[2]));
                                durMonth = ((Integer.parseInt(end1[1]) - Integer.parseInt(str1[1]))) * monthConsEnd;

                            }
                        } else {
                            if (monthConsEnd <= monthConsStrt) {
                                durDay = ((Integer.parseInt(end1[2])) - Integer.parseInt(str1[2]));
                                durMonth = ((Integer.parseInt(end1[1] + 12) * -(Integer.parseInt(str1[1]))) * monthConsStrt);
                            } else {
                                durDay = ((Integer.parseInt(end1[2])) - Integer.parseInt(str1[2]));
                                durMonth = ((Integer.parseInt(end1[1] + 12) * -(Integer.parseInt(str1[1]))) * monthConsEnd);

                            }
                        }

                        if (durYearCur == 0) {
                            if (monthConsEnd <= monthConsCur) {
                                durDayCur = (Integer.parseInt(end1[2]) - Integer.parseInt(day));
                                durMonthCur = (Integer.parseInt(end1[1]) - Integer.parseInt(month)) * monthConsCur;
                            } else {
                                durDayCur = (Integer.parseInt(end1[2]) - Integer.parseInt(day));
                                durMonthCur = (Integer.parseInt(end1[1]) - Integer.parseInt(month)) * monthConsEnd;
                            }
                        } else {
                            if (monthConsEnd <= monthConsCur) {
                                durDayCur = ((Integer.parseInt(end1[2])) - Integer.parseInt(day));
                                durMonthCur = (Integer.parseInt(end1[1] + 12) - Integer.parseInt(month)) * monthConsCur;
                            } else {
                                durDayCur = (Integer.parseInt(end1[2]) - Integer.parseInt(day));
                                durMonthCur = (Integer.parseInt(end1[1] + 12) - Integer.parseInt(month)) * monthConsEnd;
                            }
                        }

                        int Duration = durDay + durMonth + durYear;
                        int DurationCur = durMonthCur + durYearCur + durDayCur;
                        String color = "green";

                        if (rs.getInt("percentage") == 100) {
                            color = "mediumvioletred";
                        } else if (DurationCur <= 1) {
                            color = "red";

                        } else if ((Duration / 2) - 1 == DurationCur || (Duration / 2) == DurationCur || (Duration / 2) + 1 == DurationCur) {
                            color = "yellow";
                        } else {
                            color = "green";
                        }
                          taskModel ty=new taskModel();
             ty.setName(rs.getString("Name").replace(" ", "+"));
             ty.setID(   rs.getInt("ID"));
             ty.setColor(color);
             ty.setPercentage(rs.getInt("percentage"));
       
//              String b = "<a  href=dep?param1=" + rs.getString("Name").replace(" ", "+") + "&param2=" + rs.getInt("ID") + "&param4=search" + "&param6=" + color + ">" + rs.getString("Name") + "</a><br>";
                    _task.add(ty);
        }
//        if(_task.isEmpty()){
//        
//        _task.add("You Don not have Tasks Today");
//        }
        return _task;
   
   
  
   }

    /**
     * @return the color
     */
    public String getColor() {
        return color;
    }

    /**
     * @param color the color to set
     */
    public void setColor(String color) {
        this.color = color;
    }
    
    

}
