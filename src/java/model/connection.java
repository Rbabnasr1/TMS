package model;


import java.sql.Connection;
import java.sql.DriverManager;
import java.sql.SQLException;

public class connection {

    private static Connection connection = null;

    public static Connection getConnection() throws SQLException, ClassNotFoundException {

        if (connection != null) {
            return connection;
        } else {

            try {

                String url = "jdbc:mysql://localhost:3306/orgi";
                Class.forName("com.mysql.jdbc.Driver");

                connection = DriverManager.getConnection(url, "root", "root");

                return connection;

            } catch (Exception e) {
                System.out.println("erorr in connection");

            }

        }
        return connection;

    }
}

