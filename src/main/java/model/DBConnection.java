package model;

import java.sql.Connection;
import java.sql.DriverManager;
import java.sql.ResultSet;
import java.sql.SQLException;
import java.sql.Statement;

public class DBConnection {
	private DBConnection() {
		
	}
	
	static Connection getConnection() {
		Connection con = null;
		
		String url = "jdbc:mariadb://130.162.144.171:3306/gdudb2";
		
		try {
			Class.forName("org.mariadb.jdbc.Driver");
			con = DriverManager.getConnection(url,"gdu2","0113");
		} catch (Exception e) {
			e.printStackTrace();
		}
		return con;
	}// getConnection() 종료
	
	static void close(Connection con, Statement stmt, ResultSet rs) {
		try {
			if(rs != null) rs.close();
			if(stmt != null) stmt.close();
			if(con != null) con.close();
		} catch (SQLException e) {
			e.printStackTrace();
		}
	}// close() 종료
	
}// class 종료
