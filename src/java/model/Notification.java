package model;

import static com.sun.corba.se.spi.presentation.rmi.StubAdapter.request;
import java.sql.Connection;
import java.sql.DriverManager;
import java.sql.ResultSet;
import java.sql.SQLException;
import java.sql.Statement;
import java.util.ArrayList;
import java.util.Calendar;
import java.util.Date;
import static javax.servlet.SessionTrackingMode.URL;
import javax.servlet.http.HttpSession;

public class Notification {

    private int pageID;
    private String pageType;
    private String ndate;
    private String ntime;
    private String ntype;
    private int notifierID;
    private int toNotifyID;

    public Notification() {
        Date date = new Date();
        Calendar cal = Calendar.getInstance();
        cal.setTime(date);
        String year = String.valueOf(cal.get(Calendar.YEAR));
        String month = String.valueOf(cal.get(Calendar.MONTH) + 1);
        String day = String.valueOf(cal.get(Calendar.DAY_OF_MONTH));

        String hour = String.valueOf(cal.get(Calendar.HOUR_OF_DAY));
        String min = String.valueOf(cal.get(Calendar.MINUTE));
        String sec = String.valueOf(cal.get(Calendar.SECOND));

        ndate = String.valueOf(year + "-" + month + "-" + day);
        ntime = String.valueOf(hour + ":" + min + ":" + sec);
    }

    public void notify(int pageId, int notifierId, int toNotifyId, String ntype, String pType) throws ClassNotFoundException, SQLException {
        String URL = "jdbc:mysql://localhost:3306/orgi";
        Class.forName("com.mysql.jdbc.Driver");

        Connection con = DriverManager.getConnection(URL, "root", "root");

        if (ntype.equals("dismiss")) {

            Statement st = con.createStatement();
            String sql = "DELETE FROM notification WHERE toNotify =" + toNotifyId;
            st.executeUpdate(sql);
            con.close();

        } else if (ntype.equals("completion")) {
            Statement st = con.createStatement();
            String sql = "DELETE FROM notification WHERE PageID =" + pageId;
            st.executeUpdate(sql);
            con.close();
        }

        con = DriverManager.getConnection(URL, "root", "root");
        Statement st = con.createStatement();
        String sql = "insert into notification values ('" + ntime + "','" + ndate + "','" + ntype + "','" + pType + "'," + pageId + "," + notifierId
                + "," + toNotifyId + ")";
        st.executeUpdate(sql);
        con.close();

    }

    public void delete_all_task_noti(int task_ID) throws ClassNotFoundException, SQLException {
        String URL = "jdbc:mysql://localhost:3306/orgi";
        Class.forName("com.mysql.jdbc.Driver");
        Connection con = DriverManager.getConnection(URL, "root", "root");
        Statement st = con.createStatement();
        String sql = "DELETE FROM notification WHERE PageID = " + task_ID;
        st.executeUpdate(sql);

    }

    public void notifyLateTask(int pageId, int toNotifyId, String ptype) throws ClassNotFoundException, SQLException {
        String URL = "jdbc:mysql://localhost:3306/orgi";
        Class.forName("com.mysql.jdbc.Driver");
        Connection con = DriverManager.getConnection(URL, "root", "root");
        boolean found = false;
        Statement st = con.createStatement();
        String sql = "select * from notification where toNotify = " + toNotifyId + " and ntype = 'LateTask' and PageID = " + pageId;

        ResultSet rs = st.executeQuery(sql);
        while (rs.next()) {
            found = true;
        }
        con.close();
        if (!found) {
            con = DriverManager.getConnection(URL, "root", "root");
            st = con.createStatement();
            sql = "insert into notification values ('" + ntime + "','" + ndate + "','LateTask','" + ptype + "'," + pageId + "," + toNotifyId
                    + "," + toNotifyId + ")";
            st.executeUpdate(sql);
            con.close();
        }
    }

    public ArrayList GetNotify(int toNotifyId, int saId, int depId) throws ClassNotFoundException, SQLException {
        String URL = "jdbc:mysql://localhost:3306/orgi";
        Class.forName("com.mysql.jdbc.Driver");
        Connection con = DriverManager.getConnection(URL, "root", "root");
        ArrayList<Notification> notifyList = new ArrayList<Notification>();

        Statement st = con.createStatement();
        String sql = "select * from notification where toNotify = " + toNotifyId + " order by ndate desc,ntime  asc";
        ResultSet rs = st.executeQuery(sql);
        while (rs.next()) {
            Notification noti = new Notification();
            noti.ndate = rs.getString("ndate");
            noti.ntime = rs.getString("ntime");
            noti.notifierID = rs.getInt("notifierID");
            noti.ntype = rs.getString("ntype");
            noti.pageType = rs.getString("pageType");
            noti.pageID = rs.getInt("PageID");
            noti.toNotifyID = rs.getInt("toNotify");
            notifyList.add(noti);
        }
        con.close();
        int notifierID = 0;
        con = DriverManager.getConnection(URL, "root", "root");
        st = con.createStatement();
        sql = "select * from notification where ntype = 'post' and pageType = 'SA' and notifierID <> " + toNotifyId + " and PageID = " + saId + " order by ndate desc,ntime  asc";
        rs = st.executeQuery(sql);
        while (rs.next()) {
            Notification noti = new Notification();

            noti.ndate = rs.getString("ndate");
            noti.notifierID = rs.getInt("notifierID");
            noti.ntime = rs.getString("ntime");
            notifierID = rs.getInt("notifierID");
            noti.ntype = rs.getString("ntype");
            noti.pageType = rs.getString("pageType");
            noti.pageID = rs.getInt("PageID");
            noti.toNotifyID = rs.getInt("toNotify");
            notifyList.add(noti);
        }
        con.close();
        con = DriverManager.getConnection(URL, "root", "root");
        st = con.createStatement();
        sql = "select * from notification where ntype = 'post' and pageType = 'dep' and notifierID <> " + toNotifyId + " and PageID = " + depId + " order by ndate desc,ntime  asc";
        rs = st.executeQuery(sql);
        while (rs.next()) {
            Notification noti = new Notification();
            noti.ndate = rs.getString("ndate");
            noti.ntime = rs.getString("ntime");
            notifierID = rs.getInt("notifierID");
            noti.ntype = rs.getString("ntype");
            noti.pageType = rs.getString("pageType");
            noti.pageID = rs.getInt("PageID");
            noti.toNotifyID = rs.getInt("toNotify");
            noti.notifierID = rs.getInt("notifierID");
            notifyList.add(noti);
        }
        con.close();
        con = DriverManager.getConnection(URL, "root", "root");
        st = con.createStatement();
        sql = "select * from notification , campagin where ntype = 'post' and pageType = 'camp' and notifierID <> "
                + toNotifyId + " and PageID = ID and SA_ID = " + saId + " order by ndate desc,ntime  asc";
        rs = st.executeQuery(sql);
        while (rs.next()) {
            Notification noti = new Notification();
            noti.ndate = rs.getString("ndate");
            noti.ntime = rs.getString("ntime");
            notifierID = rs.getInt("notifierID");
            noti.ntype = rs.getString("ntype");
            noti.pageType = rs.getString("pageType");
            noti.pageID = rs.getInt("PageID");
            noti.toNotifyID = rs.getInt("toNotify");
            noti.notifierID = rs.getInt("notifierID");
            notifyList.add(noti);
        }
        con.close();

        return notifyList;
    }

    public ArrayList GetNotify2() throws ClassNotFoundException, SQLException {
        String URL = "jdbc:mysql://localhost:3306/orgi";
        Class.forName("com.mysql.jdbc.Driver");
        Connection con = DriverManager.getConnection(URL, "root", "root");
        ArrayList<Notification> notifyList = new ArrayList<Notification>();

        Statement st = con.createStatement();
        String sql = "select * from notification order by ndate desc,ntime  desc";
        ResultSet rs = st.executeQuery(sql);
        while (rs.next()) {
            Notification noti = new Notification();
            noti.ndate = rs.getString("ndate");
            noti.ntime = rs.getString("ntime");
            noti.notifierID = rs.getInt("notifierID");
            noti.ntype = rs.getString("ntype");
            noti.pageType = rs.getString("pageType");
            noti.pageID = rs.getInt("PageID");
            noti.toNotifyID = rs.getInt("toNotify");
            notifyList.add(noti);
        }
        con.close();
        return notifyList;
    }

    public ArrayList AllNotify(int toNotifyId, int saId, int depId, int type4noti) throws ClassNotFoundException, SQLException {
        ArrayList<Notification> Notification = new ArrayList<>();
        ArrayList<String> Notifications = new ArrayList<>();
        String URL = "jdbc:mysql://localhost:3306/orgi";
        Class.forName("com.mysql.jdbc.Driver");
        Connection con = DriverManager.getConnection(URL, "root", "root");
        Notification = GetNotify2();
//          Notification = GetNotify(toNotifyId, saId, depId);

        String notification;
        for (int i = 0; i < Notification.size(); i++) {
            if (!Notification.get(i).ntype.equals("post")) {
                if (Notification.get(i).toNotifyID == toNotifyId) {
                    String nameNotify = "";
                     con = DriverManager.getConnection(URL, "root", "root");
                    Statement st2 = con.createStatement();
                    String sql2 = "select * from account where ID =" + Notification.get(i).notifierID;
                    ResultSet rs2 = st2.executeQuery(sql2);
                    while (rs2.next()) {

                        nameNotify = rs2.getString("FName") + " " + rs2.getString("LName");
                    }

                    con.close();
                    if (Notification.get(i).pageType.equals("taskD")) {
                         con = DriverManager.getConnection(URL, "root", "root");
                        Statement st = con.createStatement();
                        String sql = "select * from task where ID =" + Notification.get(i).pageID;
                        ResultSet rs = st.executeQuery(sql);
                        int found = 0;
                        while (rs.next()) {
                            int list;

                            String listNameTask;
                            String FileTask;
                            int listPercentage;

                            list = rs.getInt("ID");
                            listNameTask = rs.getString("Name");
                            listPercentage = rs.getInt("percentage");
                            String str = rs.getString("startDate");
                            String end = rs.getString("endDate");
                            String color = getColor(str, end, listPercentage);

                            if (Notification.get(i).ntype.equals("assign")) {

                                notification = "<a class=noti href=dep?param1=" + listNameTask.replace(" ", "+") + "&param2=" + list + "&param3="
                                        + listPercentage + "&param4=TaskDep&param6=" + color + "> A Departement task  "
                                        + " " + listNameTask + " is assigned by " + nameNotify + " "
                                        + Notification.get(i).ndate + " " + Notification.get(i).ntime + " </a>";
                                Notifications.add(notification);
                            } else if (Notification.get(i).ntype.equals("completion")) {
                                notification = "<a class=noti href=dep?param1=" + listNameTask.replace(" ", "+") + "&param2=" + list + "&param3="
                                        + listPercentage + "&param4=TaskDep&param6=" + color + "> A Departement task has been finished  "
                                        + listNameTask + " by " + nameNotify
                                        + " " + Notification.get(i).ndate + " " + Notification.get(i).ntime + " </a>";
                                Notifications.add(notification);

                            } else if (Notification.get(i).ntype.equals("LateTask")) {

                                notification = "<a class=noti href=dep?param1=" + listNameTask.replace(" ", "+") + "&param2=" + list + "&param3="
                                        + listPercentage + "&param4=TaskDep&param6=" + color + "> A Departement task  "
                                        + listNameTask + " is in critical zone  " + Notification.get(i).ndate + " " + Notification.get(i).ntime + " </a>";
                                Notifications.add(notification);

                            }

                        }
                        con.close();
                    } else if (Notification.get(i).pageType.equals("taskC")) {
                         con = DriverManager.getConnection(URL, "root", "root");
                        Statement st = con.createStatement();
                        String sql = "select * from task where ID =" + Notification.get(i).pageID;
                        ResultSet rs = st.executeQuery(sql);
                        int found = 0;
                        while (rs.next()) {

                            int list;
                            String listNameTask;
                            int listPercentage;
                            int listDuration;
                            String FileTask;
                            listNameTask = rs.getString("Name");
                            listPercentage = rs.getInt("percentage");
                            list = rs.getInt("ID");

                            String str = rs.getString("startDate");
                            String end = rs.getString("endDate");
                            String color = getColor(str, end, listPercentage);

                            if (Notification.get(i).ntype.equals("assign")) {
                                notification = "<a class=noti href=dep?param1=" + listNameTask.replace(" ", "+") + "&param2=" + list + "&param3="
                                        + listPercentage + "&param4=TaskCam&param6=" + color + "> A Campagin task  "
                                        + listNameTask + " is assigned by " + nameNotify
                                        + " " + Notification.get(i).ndate + " " + Notification.get(i).ntime + " </a>";
                                Notifications.add(notification);
                            } else if (Notification.get(i).ntype.equals("completion")) {

                                notification = "<a class=noti href=dep?param1=" + listNameTask.replace(" ", "+") + "&param2=" + list + "&param3="
                                        + listPercentage + "&param4=TaskCam&param6=" + color + "> A Campaign task has been finished  "
                                        + listNameTask + " by " + nameNotify
                                        + " " + Notification.get(i).ndate + " " + Notification.get(i).ntime + " </a>";
                                Notifications.add(notification);

                            } else if (Notification.get(i).ntype.equals("LateTask")) {

                                notification = "<a class=noti href=dep?param1=" + listNameTask.replace(" ", "+") + "&param2=" + list + "&param3="
                                        + listPercentage + "&param4=TaskCam&param6=" + color + "> A Campaign task   "
                                        + listNameTask + " is in critical zone  " + Notification.get(i).ndate + " " + Notification.get(i).ntime + " </a>";
                                Notifications.add(notification);

                            }
                        }
con.close();
                    } else if (Notification.get(i).ntype.equals("promotion")) {

                        String DepName = "";
                         con = DriverManager.getConnection(URL, "root", "root");
                        Statement st3 = con.createStatement();
                        String sql3 = "select * from departement where ID =" + Notification.get(i).pageID;
                        ResultSet rs3 = st3.executeQuery(sql3);

                        while (rs3.next()) {
                            DepName = rs3.getString("Name");

                        }con.close();

                        notification = "<a  class=noti href=dep.jsp?param1=" + DepName + "&param2=" + Notification.get(i).pageID + "> congrats " + nameNotify
                                + " promote you in Department '" + DepName + "' " + Notification.get(i).ndate + " " + Notification.get(i).ntime + " </a>";
                        Notifications.add(notification);

                    } else if (Notification.get(i).ntype.equals("dismiss")) {

                        notification = " <a class=noti href=#>You are dismissed from your Student Activity  "
                                + Notification.get(i).ndate + " " + Notification.get(i).ntime + " </a>";
                        Notifications.add(notification);

                    }
//
                }
            } else { // post // 3yza a3ml en  rabab aw menna  myzhrlhash el posts elly 3maloha oma el 2  
// head of dep
                if (type4noti == 0) {
                     con = DriverManager.getConnection(URL, "root", "root");
                    Statement st3 = con.createStatement();
                    String sql3 = " select FName , departement.Name , departement.Acc_ID "
                            + " from departement  , account "
                            + " where departement.ID = " + depId + " and account.ID = departement.Acc_ID";
                    int depatHeadID = 0;
                    String depname = "", depHeadName = "";
                    ResultSet rs3 = st3.executeQuery(sql3);
                    while (rs3.next()) {
                        depatHeadID = rs3.getInt("departement.Acc_ID");
                        depname = rs3.getString("departement.Name");
                        depHeadName = rs3.getString("account.FName");
                    }con.close();
                     con = DriverManager.getConnection(URL, "root", "root");
// presidant
                    st3 = con.createStatement();
                    sql3 = "select distinct Name ,cover, creationDate , FName , account.ID "
                            + "from account , acc_dep_sa , studentactivity "
                            + " where type = 1 and SA_ID = " + saId + " and Acc_ID = account.ID and"
                            + " studentactivity.ID = acc_dep_sa.SA_ID ";
                    rs3 = st3.executeQuery(sql3);
                    String SAname = "", pdate = "", presidant = "", Cover = "";
                    int presidantID = 0;
                    while (rs3.next()) {
                        SAname = rs3.getString("Name");
                        pdate = rs3.getString("creationDate");
                        presidant = rs3.getString("FName");
                        presidantID = rs3.getInt("account.ID");
                        Cover = rs3.getString("cover");
                    }
con.close(); con = DriverManager.getConnection(URL, "root", "root");
                    st3 = con.createStatement();
                    sql3 = "select distinct * "
                            + "from campagin  "
                            + " where SA_ID = " + saId;
                    rs3 = st3.executeQuery(sql3);
                    ArrayList<campaginModel> camp = new ArrayList<>();

                    while (rs3.next()) {
                        campaginModel camp2 = new campaginModel();
                        camp2.setCID(rs3.getInt("ID"));
                        camp2.setName(rs3.getString("Name"));
                        camp.add(camp2);
                    }
                    con.close();

////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////
// notifications in dep
// head posted in dep
                    if (Notification.get(i).toNotifyID == depatHeadID && Notification.get(i).pageType.equals("dep")) {
                        notification = "<a  class=noti href=dep.jsp?param1=" + depname + "&param2="
                                + depId + "> " + depHeadName
                                + " posted in " + depname + " department " + Notification.get(i).ndate
                                + " " + Notification.get(i).ntime + " </a>";

                        Notifications.add(notification);
                        //presid post in dep 
                    } else if (Notification.get(i).toNotifyID == presidantID && Notification.get(i).pageType.equals("dep")) {
                        notification = "<a  class=noti href=dep.jsp?param1=" + depname + "&param2="
                                + depId + "> " + presidant
                                + " posted in " + depname + " department " + Notification.get(i).ndate
                                + " " + Notification.get(i).ntime + " </a>";
                        if (!Notifications.contains(notification)) {
                            Notifications.add(notification);
                        }
//presid post in sa 
//                        SA.jsp?param1=<%=SAname%>&param2=<%=SAiD%>&param3=<%=Creation%>&param4=<%=cover%>">
                    } else if (Notification.get(i).toNotifyID == presidantID && Notification.get(i).pageType.equals("SA")) {
                        notification = "<a  class=noti href=SA.jsp?param1=" + SAname + "&param2="
                                + saId + "&param3=" + pdate + "&param4=" + Cover + "> " + presidant
                                + " posted in " + SAname + " " + Notification.get(i).ndate
                                + " " + Notification.get(i).ntime + " </a>";
                        Notifications.add(notification);
                    } else if (Notification.get(i).toNotifyID == presidantID && Notification.get(i).pageType.equals("camp")) {

                        for (int j = 0; j < camp.size(); j++) {

                            if (Notification.get(i).pageID == camp.get(j).getCID()) {
                                notification = "<a class=noti href=campaign.jsp?param1=" + camp.get(j).getName().replace(" ", "+")
                                        + "&param2=" + camp.get(j).getCID() + ">" + presidant
                                        + " posted in " + camp.get(j).getName() + "  " + Notification.get(i).ndate
                                        + " " + Notification.get(i).ntime + " </a>";
                                Notifications.add(notification);

                            }
                        }
                    }

                } else if (type4noti == 2) {
                     con = DriverManager.getConnection(URL, "root", "root");

                    Statement st3 = con.createStatement();
                    String sql3 = " select FName , departement.Name , departement.Acc_ID "
                            + " from departement  , account "
                            + " where departement.ID = " + depId + " and account.ID = departement.Acc_ID";
                    int depatHeadID = 0;
                    String depname = "", depHeadName = "";
                    ResultSet rs3 = st3.executeQuery(sql3);
                    while (rs3.next()) {
                        depatHeadID = rs3.getInt("departement.Acc_ID");
                        depname = rs3.getString("departement.Name");
                        depHeadName = rs3.getString("account.FName");
                    }con.close();
                     con = DriverManager.getConnection(URL, "root", "root");
// presidant
                    st3 = con.createStatement();
                    sql3 = "select distinct Name ,cover, creationDate , FName , account.ID "
                            + "from account , acc_dep_sa , studentactivity "
                            + " where type = 1 and SA_ID = " + saId + " and Acc_ID = account.ID and"
                            + " studentactivity.ID = acc_dep_sa.SA_ID ";
                    rs3 = st3.executeQuery(sql3);
                    String SAname = "", pdate = "", presidant = "", Cover = "";
                    int presidantID = 0;
                    while (rs3.next()) {
                        SAname = rs3.getString("Name");
                        pdate = rs3.getString("creationDate");
                        presidant = rs3.getString("FName");
                        presidantID = rs3.getInt("account.ID");
                        Cover = rs3.getString("cover");
                    }con.close(); con = DriverManager.getConnection(URL, "root", "root");

                    st3 = con.createStatement();
                    sql3 = "select distinct * "
                            + "from campagin  "
                            + " where SA_ID = " + saId;
                    rs3 = st3.executeQuery(sql3);
                    ArrayList<campaginModel> camp = new ArrayList<>();

                    while (rs3.next()) {
                        campaginModel camp2 = new campaginModel();
                        camp2.setCID(rs3.getInt("ID"));
                        camp2.setName(rs3.getString("Name"));
                        camp.add(camp2);
                    }
con.close();
////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////
// notifications in dep
// head posted in dep
                    if (Notification.get(i).toNotifyID == presidantID && Notification.get(i).pageType.equals("dep")) {
                        notification = "<a  class=noti href=dep.jsp?param1=" + depname + "&param2="
                                + depId + "> " + presidant
                                + " posted in " + depname + " department " + Notification.get(i).ndate
                                + " " + Notification.get(i).ntime + " </a>";
                        if (!Notifications.contains(notification)) {
                            Notifications.add(notification);
                        }
//presid post in sa
                    } else if (Notification.get(i).toNotifyID == presidantID && Notification.get(i).pageType.equals("SA")) {

                        notification = "<a  class=noti href=SA.jsp?param1=" + SAname + "&param2="
                                + saId + "&param3=" + pdate + "&param4=" + Cover + "> " + presidant
                                + " posted in " + SAname + " " + Notification.get(i).ndate
                                + " " + Notification.get(i).ntime + " </a>";
                        Notifications.add(notification);
                    } else if (Notification.get(i).toNotifyID == presidantID && Notification.get(i).pageType.equals("camp")) {

                        for (int j = 0; j < camp.size(); j++) {

                            if (Notification.get(i).pageID == camp.get(j).getCID()) {
                                notification = "<a class=noti href=campaign.jsp?param1=" + camp.get(j).getName().replace(" ", "+")
                                        + "&param2=" + camp.get(j).getCID() + ">" + presidant
                                        + " posted in " + camp.get(j).getName() + "  " + Notification.get(i).ndate
                                        + " " + Notification.get(i).ntime + " </a>";
                                Notifications.add(notification);

                            }
                        }
                    }

                }

            }
        }

        if (Notifications.isEmpty()) {
            Notifications.add("<a class=noti href=#>Don`t have Notifications </a>");

        }

        return Notifications;
    }

    public String getColor(String StartDate, String EndDate, int Percentage) {

        String color = null;
        int listDuration;
        int listDurationCur;
        Double listDurationLate;
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
        listDuration = durYear + durMonth + durDay;
        listDurationCur = durYearCur + durMonthCur + durDayCur;
        listDurationLate = (Double) ((durYear + durMonth + durDay) * .2);

        if (Percentage == 100) {
            color = "mediumvioletred";
        } else if (listDurationCur <= Math.ceil(listDurationLate)) {

            color = "red";

        } else if ((listDuration / 2) - 1 == listDurationCur || (listDuration / 2) == listDurationCur || (listDuration / 2) + 1 == listDurationCur) {
            color = "yellow";
        } else {
            color = "green";
        }

        return color;

    }

    /**
     * @return the pageID
     */
    public int getPageID() {
        return pageID;
    }

    /**
     * @param pageID the pageID to set
     */
    public void setPageID(int pageID) {
        this.pageID = pageID;
    }

    /**
     * @return the pageType
     */
    public String getPageType() {
        return pageType;
    }

    /**
     * @param pageType the pageType to set
     */
    public void setPageType(String pageType) {
        this.pageType = pageType;
    }

    /**
     * @return the ndate
     */
    public String getNdate() {
        return ndate;
    }

    /**
     * @param ndate the ndate to set
     */
    public void setNdate(String ndate) {
        this.ndate = ndate;
    }

    /**
     * @return the ntime
     */
    public String getNtime() {
        return ntime;
    }

    /**
     * @param ntime the ntime to set
     */
    public void setNtime(String ntime) {
        this.ntime = ntime;
    }

    /**
     * @return the ntype
     */
    public String getNtype() {
        return ntype;
    }

    /**
     * @param ntype the ntype to set
     */
    public void setNtype(String ntype) {
        this.ntype = ntype;
    }

    /**
     * @return the notifierID
     */
    public int getNotifierID() {
        return notifierID;
    }

    /**
     * @param notifierID the notifierID to set
     */
    public void setNotifierID(int notifierID) {
        this.notifierID = notifierID;
    }

    /**
     * @return the toNotifyID
     */
    public int getToNotifyID() {
        return toNotifyID;
    }

    /**
     * @param toNotifyID the toNotifyID to set
     */
    public void setToNotifyID(int toNotifyID) {
        this.toNotifyID = toNotifyID;
    }

}
