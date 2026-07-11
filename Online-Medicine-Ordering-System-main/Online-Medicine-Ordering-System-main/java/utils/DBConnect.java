package utils;

import java.sql.Connection;

import java.sql.DriverManager;

public class DBConnect {

	public static Connection getConnection() {
		
		try {
			
			String username = "root";
			String password = "12345";
			String url = "jdbc:mysql://localhost:3306/medicine?characterEncoding=utf8&useSSL=false&serverTimezone=UTC";
			
			Class.forName("com.mysql.jdbc.Driver");
			
			return DriverManager.getConnection(url, username, password);
			 
		} catch (Exception e) {
			e.printStackTrace();
			return null;
		}
		
		
		
	}
   
}
