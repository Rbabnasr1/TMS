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
public class PostModel {

    private int ID;
    private String message;
    private String postDate;
    private String postTime;
    private int CID;
    private int DID;
    private int SID;
    private int AID;
    private String Name;
    private String DepName;
    private String SAName;

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
     * @return the postDate
     */
    public String getPostDate() {
        return postDate;
    }

    /**
     * @param postDate the postDate to set
     */
    public void setPostDate(String postDate) {
        this.postDate = postDate;
    }

    /**
     * @return the postTime
     */
    public String getPostTime() {
        return postTime;
    }

    /**
     * @param postTime the postTime to set
     */
    public void setPostTime(String postTime) {
        this.postTime = postTime;
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

    /**
     * @return the DID
     */
    public int getDID() {
        return DID;
    }

    /**
     * @param DID the DID to set
     */
    public void setDID(int DID) {
        this.DID = DID;
    }

    /**
     * @return the SID
     */
    public int getSID() {
        return SID;
    }

    /**
     * @param SID the SID to set
     */
    public void setSID(int SID) {
        this.SID = SID;
    }

    /**
     * @return the AID
     */
    public int getAID() {
        return AID;
    }

    /**
     * @param AID the AID to set
     */
    public void setAID(int AID) {
        this.AID = AID;
    }

    public ArrayList get_Post(int type, int said, int DepID) throws ClassNotFoundException, SQLException {
        ArrayList<PostModel> post = new ArrayList<>();

        String URL = "jdbc:mysql://localhost:3306/orgi";
        Class.forName("com.mysql.jdbc.Driver");
        Connection con = DriverManager.getConnection(URL, "root", "root");
        Statement st = con.createStatement();
        if (type == 2) {
            String sql = "select *  from post,account where   post.sa_ID=" + said + " and account.ID=acc_ID and account.type=1 order by  postDate desc,postTime desc";
            ResultSet rs = st.executeQuery(sql);
            while (rs.next()) {

                PostModel po = new PostModel();
                po.setAID(rs.getInt("acc_ID"));
                po.setMessage(rs.getString("message"));

                po.setPostTime(rs.getString("postTime"));

                po.setPostDate(rs.getString("postDate"));
              post.add(po);
            }
        
        con.close();
        
        }else {
             con = DriverManager.getConnection(URL, "root", "root");
                     String sql = "select *  from post,account where   post.dep_ID=" + DepID + " and account.ID=acc_ID and account.type=2 order by  postDate desc,postTime desc";
            ResultSet rs = st.executeQuery(sql);
            while (rs.next()) {

                PostModel po = new PostModel();
                po.setAID(rs.getInt("acc_ID"));
                po.setMessage(rs.getString("message"));

                po.setPostTime(rs.getString("postTime"));

                po.setPostDate(rs.getString("postDate"));
              post.add(po);
                    
                    }
            con.close();
        }
        return post;

    }

    /**
     * @return the Name
     */
    public String getName() {
        return Name;
    }

    /**
     * @return the DepName
     */
    public String getDepName() {
        return DepName;
    }

    /**
     * @param DepName the DepName to set
     */
    public void setDepName(String DepName) {
        this.DepName = DepName;
    }

    /**
     * @return the SAName
     */
    public String getSAName() {
        return SAName;
    }

    /**
     * @param SAName the SAName to set
     */
    public void setSAName(String SAName) {
        this.SAName = SAName;
    }

}
