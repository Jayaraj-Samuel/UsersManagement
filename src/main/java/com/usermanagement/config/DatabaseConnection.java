package com.usermanagement.config;

import java.sql.Connection;
import java.sql.DriverManager;
import java.sql.SQLException;

public final class DatabaseConnection {

    private DatabaseConnection() {
        // Prevent instantiation
    }

    public static Connection getConnection() throws SQLException {

        String password = DatabaseConfig.PASSWORD;

        if (password == null || password.isBlank()) {
            throw new SQLException(
                    "Database password is not configured. "
                            + "Set the USER_DB_PASSWORD environment variable.");
        }

        try {
            Class.forName("com.mysql.cj.jdbc.Driver");
        } catch (ClassNotFoundException e) {
            throw new SQLException(
                    "MySQL JDBC driver was not found.",
                    e);
        }

        return DriverManager.getConnection(
                DatabaseConfig.URL,
                DatabaseConfig.USERNAME,
                password);
    }
}