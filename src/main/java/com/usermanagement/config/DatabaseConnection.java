package com.usermanagement.config;

import java.sql.Connection;
import java.sql.DriverManager;
import java.sql.SQLException;
import java.util.logging.Logger;

public final class DatabaseConnection {

    private static final Logger LOGGER = Logger.getLogger(DatabaseConnection.class.getName());

    private DatabaseConnection() {
        // Prevent instantiation
    }

    public static Connection getConnection() throws SQLException {
        String url = DatabaseConfig.getUrl();
        String username = DatabaseConfig.getUsername();
        String password = DatabaseConfig.getPassword();

        if (password == null || password.isBlank()) {
            LOGGER.severe("Database password is not configured! Please configure USER_DB_PASSWORD or MYSQLPASSWORD.");
            throw new SQLException(
                    "Database password is not configured. "
                            + "Please configure USER_DB_PASSWORD or MYSQLPASSWORD in your environment.");
        }

        try {
            Class.forName("com.mysql.cj.jdbc.Driver");
        } catch (ClassNotFoundException e) {
            throw new SQLException(
                    "MySQL JDBC driver was not found.",
                    e);
        }

        Connection conn = DriverManager.getConnection(url, username, password);

        // Ensure database table and default admin are initialized
        DatabaseInitializer.ensureInitialized(conn);

        return conn;
    }
}