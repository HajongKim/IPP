package controller;

import java.sql.*;

public class DBConn {
    public static void main(String[] args) {
        try {
            // JDBC 드라이버를 로드합니다.
            Class.forName("org.mariadb.jdbc.Driver");

            // 데이터베이스에 연결합니다.
            Connection connection = DriverManager.getConnection("jdbc:mariadb://localhost:3306/test", "khj", "1234");

            // SQL 쿼리를 실행하여 결과를 얻습니다.
            Statement statement = connection.createStatement();
            ResultSet resultSet = statement.executeQuery("SELECT * FROM data");

            // 결과를 웹 페이지에 출력합니다.
            while (resultSet.next()) {
                String userid = resultSet.getString("userid");
                String password = resultSet.getString("password");
                String name = resultSet.getString("name");

                System.out.println("ID: " + userid + ", password: " + password + ", name: " + name);
            }

            // 연결과 리소스를 정리합니다.
            resultSet.close();
            statement.close();
            connection.close();
        } catch (ClassNotFoundException e) {
            e.printStackTrace();
        } catch (SQLException e) {
            e.printStackTrace();
        }
    }
}
