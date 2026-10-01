package com.usermanagement.config;

public final class DatabaseConfig {

    private DatabaseConfig() {
        // Prevent instantiation
    }

    public static final String URL = System.getenv("USER_DB_URL") != null && !System.getenv("USER_DB_URL").isBlank()
            ? System.getenv("USER_DB_URL")
            : "jdbc:mysql://localhost:3306/user_management?useSSL=false&serverTimezone=UTC&allowPublicKeyRetrieval=true";

    public static final String USERNAME = System.getenv("USER_DB_USER") != null && !System.getenv("USER_DB_USER").isBlank()
            ? System.getenv("USER_DB_USER")
            : "root";

    public static final String PASSWORD = System.getenv("USER_DB_PASSWORD");
}