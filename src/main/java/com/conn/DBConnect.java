package com.conn;

import java.sql.Connection;
import java.sql.DriverManager;
import java.sql.SQLException;

public class DBConnect {
    private static Connection conn = null;
    private static String dbHostEnv;
    private static String dbNameEnv;
    private static String dbUserEnv;
    private static String dbPasswordEnv;

    // Static initializer to load environment variables once
    static {
        dbHostEnv = System.getenv("DB_HOST");
        dbNameEnv = System.getenv("DB_NAME");
        dbUserEnv = System.getenv("DB_USER");
        dbPasswordEnv = System.getenv("DB_PASSWORD");

        try {
            Class.forName("com.mysql.cj.jdbc.Driver");
        } catch (ClassNotFoundException e) {
            // This is a critical failure, app likely can't run
            System.err.println("FATAL: MySQL JDBC Driver not found: " + e.getMessage());
            e.printStackTrace();
            throw new RuntimeException("MySQL JDBC Driver not found", e);
        }
    }

    public static Connection getConn() throws SQLException { // Let SQLException propagate
        if (conn == null || conn.isClosed()) {
            try {
                String dbHost = (dbHostEnv != null) ? dbHostEnv : "localhost:3306";
                String dbName = (dbNameEnv != null) ? dbNameEnv : "ecommerce_db";
                String dbUser = (dbUserEnv != null) ? dbUserEnv : "root";
                String dbPassword = (dbPasswordEnv != null) ? dbPasswordEnv : "admin";

                String connectionUrl = String.format(
                        "jdbc:mysql://%s/%s?useSSL=true&requireSSL=true&serverTimezone=UTC",
                        dbHost, dbName);

                System.out.println("Attempting to connect to DB: " + connectionUrl + " with user: " + dbUser); // For debugging

                conn = DriverManager.getConnection(connectionUrl, dbUser, dbPassword);
                System.out.println("DB Connection successful."); // For debugging

            } catch (SQLException e) {
                System.err.println("Database connection error: " + e.getMessage());
                e.printStackTrace();
                conn = null; // Ensure conn is null if connection fails
                throw e; // Re-throw SQLException so caller can handle
            }
        }
        return conn;
    }

    public static void closeConnection() {
        if (conn != null) {
            try {
                if (!conn.isClosed()) {
                    conn.close();
                    System.out.println("DB Connection closed."); // For debugging
                }
                conn = null; // Set to null after closing
            } catch (SQLException e) {
                System.err.println("Error closing connection: " + e.getMessage());
                e.printStackTrace();
            }
        }
    }
}