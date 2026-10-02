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
    private static volatile boolean isInitialized = false;

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

    public static synchronized void ensureInitialized(Connection conn) {
        if (isInitialized || conn == null) {
            return;
        }

        try {
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

            isInitialized = true;
        } catch (SQLException e) {
            LOGGER.log(Level.WARNING, "DatabaseInitializer: Schema auto-init warning: " + e.getMessage());
        }
    }

    @Override
    public void contextInitialized(ServletContextEvent sce) {
        LOGGER.info("DatabaseInitializer: Verifying database connection on startup...");
        try (Connection conn = DatabaseConnection.getConnection()) {
            LOGGER.info("DatabaseInitializer: Database connection and schema verified successfully.");
        } catch (Exception e) {
            LOGGER.warning("DatabaseInitializer: Startup connection test failed: " + e.getMessage() + ". Will retry upon first HTTP request.");
        }
    }

    @Override
    public void contextDestroyed(ServletContextEvent sce) {
        // No cleanup needed
    }
}
