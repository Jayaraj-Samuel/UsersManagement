package com.usermanagement.config;

import com.usermanagement.util.PasswordUtil;
import jakarta.servlet.ServletContextEvent;
import jakarta.servlet.ServletContextListener;
import jakarta.servlet.annotation.WebListener;

import java.sql.Connection;
import java.sql.PreparedStatement;
import java.sql.ResultSet;
import java.sql.SQLException;
import java.sql.Statement;
import java.util.logging.Level;
import java.util.logging.Logger;

/**
 * Automatically initializes database tables and seeds a default admin user
 * if the database is brand new. Essential for automated cloud deployments (Railway, Render, Docker).
 */
@WebListener
public class DatabaseInitializer implements ServletContextListener {

    private static final Logger LOGGER = Logger.getLogger(DatabaseInitializer.class.getName());

    private static final String CREATE_USERS_TABLE = """
            CREATE TABLE IF NOT EXISTS users (
                id BIGINT AUTO_INCREMENT PRIMARY KEY,
                name VARCHAR(100) NOT NULL,
                email VARCHAR(150) NOT NULL UNIQUE,
                password_hash VARCHAR(255) NOT NULL,
                role VARCHAR(20) DEFAULT 'USER',
                status VARCHAR(20) DEFAULT 'ACTIVE',
                created_at TIMESTAMP DEFAULT CURRENT_TIMESTAMP,
                updated_at TIMESTAMP DEFAULT CURRENT_TIMESTAMP ON UPDATE CURRENT_TIMESTAMP
            );
            """;

    private static final String COUNT_USERS = "SELECT COUNT(*) FROM users";

    private static final String INSERT_ADMIN = """
            INSERT INTO users (name, email, password_hash, role, status)
            VALUES (?, ?, ?, ?, ?)
            """;

    private Connection getConnectionWithRetry() {
        int maxRetries = 6;
        for (int attempt = 1; attempt <= maxRetries; attempt++) {
            try {
                Connection connection = DatabaseConnection.getConnection();
                if (connection != null) {
                    return connection;
                }
            } catch (Exception e) {
                LOGGER.warning("DatabaseInitializer: Connection attempt " + attempt + " of " + maxRetries + " failed: " + e.getMessage());
                if (attempt < maxRetries) {
                    try {
                        Thread.sleep(3000);
                    } catch (InterruptedException ignored) {
                        Thread.currentThread().interrupt();
                        break;
                    }
                }
            }
        }
        return null;
    }

    @Override
    public void contextInitialized(ServletContextEvent sce) {
        LOGGER.info("DatabaseInitializer: Checking database and running schema verification...");

        Connection connection = getConnectionWithRetry();
        if (connection == null) {
            LOGGER.severe("DatabaseInitializer: Could not connect to database after retries. Manual schema setup might be required.");
            return;
        }

        try (Connection conn = connection) {
            // 1. Ensure 'users' table exists
            try (Statement stmt = conn.createStatement()) {
                stmt.execute(CREATE_USERS_TABLE);
                LOGGER.info("DatabaseInitializer: 'users' table verified/created.");
            }

            // 2. Check if users already exist
            boolean hasUsers = false;
            try (Statement stmt = conn.createStatement();
                 ResultSet rs = stmt.executeQuery(COUNT_USERS)) {
                if (rs.next() && rs.getInt(1) > 0) {
                    hasUsers = true;
                }
            }

            // 3. Seed default administrator account if table is empty
            if (!hasUsers) {
                String adminEmail = "admin@example.com";
                String defaultPassword = "admin123";
                String hashedPassword = PasswordUtil.hashPassword(defaultPassword);

                try (PreparedStatement pstmt = conn.prepareStatement(INSERT_ADMIN)) {
                    pstmt.setString(1, "System Admin");
                    pstmt.setString(2, adminEmail);
                    pstmt.setString(3, hashedPassword);
                    pstmt.setString(4, "ADMIN");
                    pstmt.setString(5, "ACTIVE");
                    pstmt.executeUpdate();
                    LOGGER.info("DatabaseInitializer: Default admin created (" + adminEmail + " / " + defaultPassword + ").");
                }
            } else {
                LOGGER.info("DatabaseInitializer: Users already present in database. Skipping seed.");
            }
        } catch (SQLException e) {
            LOGGER.log(Level.SEVERE, "DatabaseInitializer: Error executing database setup SQL", e);
        }
    }

    @Override
    public void contextDestroyed(ServletContextEvent sce) {
        // No cleanup needed
    }
}
