package model;

import java.sql.Connection;
import java.sql.DriverManager;
import java.sql.ResultSet;
import java.sql.SQLException;
import java.sql.Statement;
import java.util.ArrayList;

public class UserModel {

    private Connection con;
    private String FName;
    private String LName;
    private String email;
    private int day;
    private int month;
    private int year;
    private String mobile;
    private String password;
    private String address;
    private int type;
    private String gender;
    private int evaluations;
    private int ID;
    private String photo;

    private ArrayList<Integer> skills;

    public UserModel() throws SQLException, ClassNotFoundException {
        con = model.connection.getConnection();
    }

    public int head_Presid(int dep_ID, int sa, int type) throws SQLException {
        Statement st = con.createStatement();
        if (type == 0) {
            String sql = "select Acc_ID from departement where ID = " + dep_ID;
            ResultSet rs = st.executeQuery(sql);
            while (rs.next()) {

                return rs.getInt("Acc_ID");
            }
        } else {
            String sql = "select Acc_ID from account , acc_dep_sa where type = 1 and Acc_ID = ID and SA_ID = " + sa;
            ResultSet rs = st.executeQuery(sql);
            while (rs.next()) {

                return rs.getInt("Acc_ID");
            }
        }

        return 0;

    }

    public boolean login(UserModel user) throws SQLException {
        Statement st = con.createStatement();
        String sql = "select * from account where email ='" + user.getEmail() + "' and password='" + user.getPassword() + "'";
        ResultSet rs = st.executeQuery(sql);
        while (rs.next()) {

            return true;
        }
        return false;
    }

    public void updateSkill(ArrayList<Integer> skill, int id) throws SQLException{
        Statement st = con.createStatement();
       
            for (int i = 0; i < skill.size(); i++) {
                String sql = " insert into acc_skill ( acc_ID , skill_ID )values ( " + id + " , " + skill.get(i) + " )";
                st.executeUpdate(sql);
            }
    }
    public void update(UserModel user,  int id) throws SQLException, ClassNotFoundException {
        Statement st = con.createStatement();
        String sql = "select * from account where ID =" + id;
        ResultSet rs = st.executeQuery(sql);

        UserModel Olduser = new UserModel();
        String Sql = "";
        while (rs.next()) {
            Olduser.setFName(rs.getString("FName"));
            Olduser.setMobile(rs.getString("mobile"));
            Olduser.setPassword(rs.getString("password"));
            Olduser.setEmail(rs.getString("email"));
            Olduser.setDay(rs.getInt("day"));
            Olduser.setMonth(rs.getInt("month"));
            Olduser.setYear(rs.getInt("year"));
            Olduser.setAddress(rs.getString("address"));

        }
       
        String ad = user.getAddress();
        if (user.getAddress().equals("")) {
            user.setAddress(Olduser.getAddress());
        }
        if (user.getPassword().equals("")) {
            user.setPassword(Olduser.getPassword());
        }
        if (user.getFName().equals("")) {
            user.setFName(Olduser.getFName());
        }
        if (user.getMobile().equals("")) {
            user.setMobile(Olduser.getMobile());
        }
        if (user.getMonth() == 0) {
            user.setMonth(Olduser.getMonth());
        }
        if (user.getDay() == 0) {
            user.setDay(Olduser.getDay());
        }
        if (user.getYear() == 0) {
            user.setYear(Olduser.getYear());
        }
        if (user.getEmail().equals("")) {
            user.setEmail(Olduser.getEmail());
        }

        Sql = " update account set FName = '" + user.getFName() + "', password = '" + user.getPassword() + "', mobile = '"
                + user.getMobile() + "', email='"+user.getEmail()+"', address = '" + user.getAddress() + "', day = " + user.getDay()
                + ", month = " + user.getMonth() + " , year = " + user.getYear() + " where ID = " + id;
        st = con.createStatement();
        st.executeUpdate(Sql);

    }

    public int GetType(UserModel user) throws SQLException {
        Statement st = con.createStatement();
        String sql = "select * from account where email ='" + user.getEmail() + "' and password='" + user.getPassword() + "'";
        ResultSet rs = st.executeQuery(sql);
        int type = -1;
        while (rs.next()) {
            type = rs.getInt("type");
        }
        return type;

    }

    public boolean signUp(UserModel user) throws SQLException {
        Statement st = con.createStatement();
        String sql = "select email from account where email = '" + user.getEmail() + "'";
        ResultSet rs = st.executeQuery(sql);
        if (!rs.next()) {
//        while(rs.next()){
            if (user.getGender().equals("male")) {
                st = con.createStatement();
                sql = "insert into account (FName,LName,email,day,month,year,mobile,password,address,type,gender,photo)values( '"
                        + user.getFName() + "','" + user.getLName() + "','" + user.getEmail() + "'," + user.getDay() + "," + user.getMonth()
                        + "," + user.getYear() + ",'" + user.getMobile()
                        + "','" + user.getPassword() + "','" + user.getAddress() + "',-1,'" + user.getGender() + "','" + "man.jpg" + "')";
                st.executeUpdate(sql);
                return true;
            } else {

                st = con.createStatement();
                sql = "insert into account (FName,LName,email,day,month,year,mobile,password,address,type,gender,photo)values( '"
                        + user.getFName() + "','" + user.getLName() + "','" + user.getEmail() + "'," + user.getDay() + "," + user.getMonth()
                        + "," + user.getYear() + ",'" + user.getMobile()
                        + "','" + user.getPassword() + "','" + user.getAddress() + "',-1,'" + user.getGender() + "','" + "woman.png" + "')";
                st.executeUpdate(sql);
                return true;

            }

        }

        return false;
    }

    public boolean addSkills(int id) throws SQLException {

        Statement st;
        for (int i = 0; i < skills.size(); i++) {
            st = con.createStatement();
            String sql = "insert into acc_skill (acc_ID,skill_ID) values (" + id + "," + skills.get(i) + ")";
            st.executeUpdate(sql);
        }
        return false;

    }

    public int getID(String email) throws ClassNotFoundException, SQLException {
        Statement st = con.createStatement();
        String sql = "select ID from account where email = '" + email + "'";
        ResultSet rs = st.executeQuery(sql);
        int ID = 0;
        while (rs.next()) {
            ID = rs.getInt("ID");

        }

        return ID;
    }

    public String getName(String email) throws ClassNotFoundException, SQLException {
        Statement st = con.createStatement();
        String sql = "select FName from account where email = '" + email + "'";
        ResultSet rs = st.executeQuery(sql);
        String name = "";
        while (rs.next()) {
            name = rs.getString("FName");
        }

        return name;
    }

    public String getphotoP(String email) throws ClassNotFoundException, SQLException {
        Statement st = con.createStatement();
        String sql = "select photo from account where email = '" + email + "'";
        ResultSet rs = st.executeQuery(sql);
        String name = "";
        while (rs.next()) {
            name = rs.getString("photo");
        }

        return name;
    }

    public ArrayList<String> skills(int id) throws SQLException {
        Statement st = con.createStatement();
        String sql = "SELECT skill FROM orgi.acc_skill, skills where ID = skill_ID and acc_ID = " + id;
        ResultSet rs = st.executeQuery(sql);
        ArrayList<String> skills = new ArrayList();
        while (rs.next()) {
            skills.add(rs.getString("skill"));
        }
        return skills;

    }

    public void promote(int MID, int DID) throws SQLException {

        Statement st = con.createStatement();
        String sql = "Update account set Type=2 where ID = " + MID + "";
        st.executeUpdate(sql);

        st = con.createStatement();
        sql = "Update orgi.departement set Acc_ID=" + MID + " where ID = " + DID + "";
        st.executeUpdate(sql);
        st = con.createStatement();
        sql = "Update orgi.acc_dep_sa set Dep_ID = " + DID + " where Acc_ID = " + MID + "";
        st.executeUpdate(sql);

    }

    public UserModel GetInformation(String email) throws SQLException, ClassNotFoundException {
        UserModel user = new UserModel();
        Statement st = con.createStatement();
        String sql = "select * from account where email = '" + email + "'";
        ResultSet rs = st.executeQuery(sql);
        while (rs.next()) {
            user.ID = rs.getInt("ID");
            user.FName = rs.getString("FName");
            user.LName = rs.getString("LName");
            user.email = email;
            user.day = rs.getInt("day");
            user.month = rs.getInt("month");
            user.year = rs.getInt("year");
            user.mobile = rs.getString("mobile");
            user.setPassword(rs.getString("password"));
            user.address = rs.getString("address");
            user.type = rs.getInt("type");
            user.gender = rs.getString("gender");
            user.evaluations = rs.getInt("evaluations");
            user.photo = rs.getString("photo");
        }

        return user;

    }

    public UserModel GetInformationByID(int _ID) throws SQLException, ClassNotFoundException {
        UserModel user = new UserModel();
        Statement st = con.createStatement();
        String sql = "select * from account where ID = " + _ID + "";
        ResultSet rs = st.executeQuery(sql);
        while (rs.next()) {
            user.setID(rs.getInt("ID"));
            user.setFName(rs.getString("FName"));
            user.setLName(rs.getString("LName"));
            user.setEmail(rs.getString("email"));
            user.setDay(rs.getInt("day"));
            user.setMonth(rs.getInt("month"));
            user.setYear(rs.getInt("year"));
            user.setMobile(rs.getString("mobile"));
            user.setPassword(rs.getString("password"));
            user.setAddress(rs.getString("address"));
            user.setType(rs.getInt("type"));
            user.setGender(rs.getString("gender"));
            user.setEvaluation(rs.getInt("evaluations"));
            user.setPhoto(rs.getString("photo"));
        }

        return user;

    }

    public void dismiss(int MID, int SAID) throws SQLException {
        Statement st = con.createStatement();
        String sql = "delete from acc_dep_sa where Acc_ID = " + MID;
        st.executeUpdate(sql);
        st = con.createStatement();

        sql = "update acc_dep_task set Acc_ID = NULL  where Acc_ID = " + MID;
        st.executeUpdate(sql);

        st = con.createStatement();
        sql = "update acc_task_camp set Acc_ID = NULL  where finished = NULL and Acc_ID = " + MID;
        st.executeUpdate(sql);

        st = con.createStatement();
        sql = "select type from account where ID = " + MID;

        ResultSet rs = st.executeQuery(sql);
        int type = 0;
        while (rs.next()) {
            type = rs.getInt("type");
        }
        if (type == 2) {
            st = con.createStatement();
            sql = "select ID from account , acc_dep_sa where Acc_ID=ID and type = 1 and SA_ID = " + SAID;
            rs = st.executeQuery(sql);
            int Preseidant_ID = 0;
            while (rs.next()) {
                Preseidant_ID = rs.getInt("ID");
            }
            st = con.createStatement();
            sql = "update departement set Acc_ID = " + Preseidant_ID + " where Acc_ID = " + MID;
            st.executeUpdate(sql);

        }
        st = con.createStatement();
        sql = "update account set type = -1 where ID = " + MID;
        st.executeUpdate(sql);
    }

    public String getFName() {
        return FName;
    }

    public void setFName(String FName) {
        this.FName = FName;
    }

    public String getLName() {
        return LName;
    }

    public void setLName(String LName) {
        this.LName = LName;
    }

    public String getEmail() {
        return email;
    }

    public void setEmail(String email) {
        this.email = email;
    }

    /**
     * @return the day
     */
    public int getDay() {
        return day;
    }

    /**
     * @param day the day to set
     */
    public void setDay(int day) {
        this.day = day;
    }

    /**
     * @return the month
     */
    public int getMonth() {
        return month;
    }

    /**
     * @param month the month to set
     */
    public void setMonth(int month) {
        this.month = month;
    }

    /**
     * @return the year
     */
    public int getYear() {
        return year;
    }

    /**
     * @param year the year to set
     */
    public void setYear(int year) {
        this.year = year;
    }

    /**
     * @return the mobile
     */
    public String getMobile() {
        return mobile;
    }

    /**
     * @param mobile the mobile to set
     */
    public void setMobile(String mobile) {
        this.mobile = mobile;
    }

    /**
     * @return the password
     */
    public String getPassword() {
        return password;
    }

    /**
     * @param password the password to set
     */
    public void setPassword(String password) {
        this.password = password;
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
     * @return the type
     */
    public int getType() {
        return type;
    }

    /**
     * @param type the type to set
     */
    public void setType(int type) {
        this.type = type;
    }

    /**
     * @return the gender
     */
    public String getGender() {
        return gender;
    }

    /**
     * @param gender the gender to set
     */
    public void setGender(String gender) {
        this.gender = gender;
    }

    /**
     * @return the evaluation
     */
    public int getEvaluation() {
        return evaluations;
    }

    /**
     * @param evaluation the evaluation to set
     */
    public void setEvaluation(int evaluation) {
        this.evaluations = evaluation;
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
     * @return the photo
     */
    public String getPhoto() {
        return photo;
    }

    /**
     * @param photo the photo to set
     */
    public void setPhoto(String photo) {
        this.photo = photo;
    }

    public ArrayList getEv(int SAID, int type) throws SQLException, ClassNotFoundException {

        ArrayList<UserModel> ev = new ArrayList<>();
        Statement st = con.createStatement();
        String sql = " select FName,evaluations  from account,acc_dep_sa where  Acc_ID=ID and type =" + type + " and SA_ID =" + SAID;
        ResultSet rs = st.executeQuery(sql);
        while (rs.next()) {
            UserModel user = new UserModel();
            user.setFName(rs.getString("FName"));

            user.setEvaluation(rs.getInt("evaluations"));
            ev.add(user);

        }
        return ev;

    }

    public ArrayList getDepManger(int Dp) throws SQLException, ClassNotFoundException {

        ArrayList<UserModel> man = new ArrayList<>();
        Statement st = con.createStatement();
        String sql = "select * from account,departement where departement.ID = " + Dp
                + " and Acc_ID = account.ID";
        ResultSet rs = st.executeQuery(sql);
        while (rs.next()) {
            UserModel user = new UserModel();
            user.setFName(rs.getString("FName"));
            user.setID(rs.getInt("account.ID"));
            user.setPhoto(rs.getString("photo"));
            man.add(user);
        }
        return man;

    }

    public ArrayList getDepPersident(int Dp, int saID) throws SQLException, ClassNotFoundException {

        ArrayList<UserModel> man = new ArrayList<>();
        Statement st = con.createStatement();
        String sql = "select * from account,acc_dep_sa where Dep_ID = " + Dp + " and SA_ID = "
                + saID + " and type = 1  and Acc_ID = ID";

        ResultSet rs = st.executeQuery(sql);
        while (rs.next()) {
            UserModel user = new UserModel();
            user.setFName(rs.getString("FName"));
            user.setID(rs.getInt("ID"));
            user.setPhoto(rs.getString("photo"));
            man.add(user);
        }
        return man;

    }

}
