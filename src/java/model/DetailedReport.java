package model;

import java.sql.Connection;
import java.sql.ResultSet;
import java.sql.SQLException;
import java.sql.Statement;
import java.util.Calendar;
import java.util.Date;
import java.text.DateFormat;

public class DetailedReport {

    private String message;
    private String subject;
    private String date;
    private String time;
    private int from_id;
    private int to_id;
    private int dep_id;
    private Connection con;

    public DetailedReport() throws SQLException, ClassNotFoundException {
        con = model.connection.getConnection();
    }

    public void CreateReport(DetailedReport rep) throws SQLException {
        Date dat = new Date();
        Calendar cal = Calendar.getInstance();
        cal.setTime(dat);
        String year = String.valueOf(cal.get(Calendar.YEAR));
        String month = String.valueOf(cal.get(Calendar.MONTH) + 1);
        String day = String.valueOf(cal.get(Calendar.DAY_OF_MONTH));

        String hour = String.valueOf(cal.get(Calendar.HOUR_OF_DAY));
        String min = String.valueOf(cal.get(Calendar.MINUTE));
        String sec = String.valueOf(cal.get(Calendar.SECOND));

        setDate(String.valueOf(year + "-" + month + "-" + day));
        setTime(String.valueOf(hour + ":" + min + ":" + sec));

        Statement st = con.createStatement();

        String sql = "insert into DetailedReport ( from_id , to_id , message , Rep_Subject , depart_id , sent_date , sent_time)"
                + " values   (" + rep.getFrom_id() + "," + rep.getTo_id() + ",'" + rep.getMessage() + "','" + rep.getSubject() + "'"
                + "," + rep.getDep_id() + ",'" + rep.getDate() + "','" + rep.getTime() + "')";

        st.executeUpdate(sql);
        

    }

    /**
     * @return the message
     */
    public String getMessage() {
        return message;
    }

    /**
     * @param message the message to set
     */
    public void setMessage(String message) {
        this.message = message;
    }

    /**
     * @return the subject
     */
    public String getSubject() {
        return subject;
    }

    /**
     * @param subject the subject to set
     */
    public void setSubject(String subject) {
        this.subject = subject;
    }

    /**
     * @return the date
     */
    public String getDate() {
        return date;
    }

    /**
     * @param date the date to set
     */
    public void setDate(String date) {
        this.date = date;
    }

    /**
     * @return the time
     */
    public String getTime() {
        return time;
    }

    /**
     * @param time the time to set
     */
    public void setTime(String time) {
        this.time = time;
    }

    /**
     * @return the from_id
     */
    public int getFrom_id() {
        return from_id;
    }

    /**
     * @param from_id the from_id to set
     */
    public void setFrom_id(int from_id) {
        this.from_id = from_id;
    }

    /**
     * @return the to_id
     */
    public int getTo_id() {
        return to_id;
    }

    /**
     * @param to_id the to_id to set
     */
    public void setTo_id(int to_id) {
        this.to_id = to_id;
    }

    /**
     * @return the dep_id
     */
    public int getDep_id() {
        return dep_id;
    }

    /**
     * @param dep_id the dep_id to set
     */
    public void setDep_id(int dep_id) {
        this.dep_id = dep_id;
    }

    /**
     * @return the con
     */
    public Connection getCon() {
        return con;
    }

    /**
     * @param con the con to set
     */
    public void setCon(Connection con) {
        this.con = con;
    }

}
