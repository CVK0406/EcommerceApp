package com.conn;

import java.sql.Connection;
import java.sql.DriverManager;
import java.sql.SQLException;

public class DBConnect {
	private static Connection conn = null;
	
	public static Connection getConn() {
		try {
			// Load MySQL JDBC driver
			Class.forName("com.mysql.cj.jdbc.Driver");
			
			// Get database connection details from environment variables
			String dbHost = System.getenv("DB_HOST");
			String dbName = System.getenv("DB_NAME");
			String dbUser = System.getenv("DB_USER");
			String dbPassword = System.getenv("DB_PASSWORD");
			
			// If environment variables are not set, use default values for local development
			if (dbHost == null) {
				dbHost = "localhost:3306";
				dbName = "ecommerce_db";
				dbUser = "root";
				dbPassword = "admin";
			}
			
			// Construct the connection URL
			String connectionUrl = String.format("jdbc:mysql://%s/%s?useSSL=true&requireSSL=true&serverTimezone=UTC", 
				dbHost, dbName);
			
			// Create the connection
			conn = DriverManager.getConnection(connectionUrl, dbUser, dbPassword);
			
		} catch (ClassNotFoundException e) {
			System.err.println("MySQL JDBC Driver not found: " + e.getMessage());
			e.printStackTrace();
		} catch (SQLException e) {
			System.err.println("Database connection error: " + e.getMessage());
			e.printStackTrace();
		}
		return conn;
	}
	
	// Method to close the connection
	public static void closeConnection() {
		if (conn != null) {
			try {
				conn.close();
			} catch (SQLException e) {
				System.err.println("Error closing connection: " + e.getMessage());
				e.printStackTrace();
			}
		}
	}
}