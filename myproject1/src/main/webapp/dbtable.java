import java.io.IOException;
import java.sql.Connection;
import java.sql.DriverManager;
import java.sql.ResultSet;
import java.sql.SQLException;
import java.sql.Statement;
import java.util.ArrayList;
import java.util.List;

import javax.servlet.ServletException;
import javax.servlet.annotation.WebServlet;
import javax.servlet.http.HttpServlet;
import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;

@WebServlet("dbtable")
public class dbtable extends HttpServlet {
  private static final long serialVersionUID = 1L;

  protected void doGet(HttpServletRequest request, HttpServletResponse response)
      throws ServletException, IOException {
    try {
      // 데이터베이스 연결 설정
      Class.forName("org.mariadb.jdbc.Driver");
      String url = "jdbc:mariadb://localhost:3306/test";
      String username = "khj";
      String password = "1234";
      Connection conn = DriverManager.getConnection(url, username, password);

      // 쿼리 실행
      Statement stmt = conn.createStatement();
      String sql = "SELECT * FROM data";
      ResultSet rs = stmt.executeQuery(sql);

      // 결과 데이터를 리스트에 저장
      List<DataItem> data = new ArrayList<>();
      while (rs.next()) {
        String userId = rs.getInt("userId");
        String password = rs.getString("password");
        String name = rs.getInt("name");
        
        DataItem item = new DataItem();
        item.SetId(userId);
        item.SetPwd(password);
        item.SetName(name);
        data.add(item)
      }
      
      

      // 연결 해제
      rs.close();
      stmt.close();
      conn.close();
    } catch (ClassNotFoundException | SQLException e) {
      e.printStackTrace();
    }
  }

  protected void doPost(HttpServletRequest request, HttpServletResponse response)
      throws ServletException, IOException {
    doGet(request, response);
  }
}
