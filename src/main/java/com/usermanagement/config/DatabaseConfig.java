package com.usermanagement.config;

import java.net.URI;
import java.util.logging.Logger;

public final class DatabaseConfig {

    private static final Logger LOGGER = Logger.getLogger(DatabaseConfig.class.getName());

    private DatabaseConfig() {
        // Prevent instantiation
    }

    public static String getUrl() {
        // 1. Railway native MYSQL_URL (mysql://user:pass@host:port/db) - Highest priority if valid
        String mysqlUrl = System.getenv("MYSQL_URL");
        if (isValidValue(mysqlUrl)) {
            try {
                if (mysqlUrl.startsWith("jdbc:")) {
                    return mysqlUrl.trim();
                }
                URI uri = new URI(mysqlUrl.replace("mysql://", "http://"));
                String host = uri.getHost();
                int port = uri.getPort() != -1 ? uri.getPort() : 3306;
                String path = uri.getPath() != null && uri.getPath().length() > 1 ? uri.getPath().substring(1) : "railway";
                if (isValidHost(host)) {
                    return "jdbc:mysql://" + host + ":" + port + "/" + path + "?useSSL=false&allowPublicKeyRetrieval=true&serverTimezone=UTC";
                }
            } catch (Exception e) {
                LOGGER.warning("DatabaseConfig: Failed to parse MYSQL_URL: " + e.getMessage());
            }
        }

        // 2. Explicit USER_DB_URL (only if it has a non-empty hostname)
        String userDbUrl = System.getenv("USER_DB_URL");
        if (isValidValue(userDbUrl) && isValidJdbcUrl(userDbUrl)) {
            return userDbUrl.trim();
        }

        // 3. Railway native individual variables: MYSQLHOST, MYSQLPORT, MYSQLDATABASE
        String host = System.getenv("MYSQLHOST");
        if (isValidValue(host) && isValidHost(host)) {
            String port = isValidValue(System.getenv("MYSQLPORT")) ? System.getenv("MYSQLPORT") : "3306";
            String db = isValidValue(System.getenv("MYSQLDATABASE")) ? System.getenv("MYSQLDATABASE") : "railway";
            return "jdbc:mysql://" + host.trim() + ":" + port.trim() + "/" + db.trim() + "?useSSL=false&allowPublicKeyRetrieval=true&serverTimezone=UTC";
        }

        // 4. Default fallback (Localhost)
        return "jdbc:mysql://localhost:3306/user_management?useSSL=false&serverTimezone=UTC&allowPublicKeyRetrieval=true";
    }

    public static String getUsername() {
        // 1. Try extracting from MYSQL_URL first
        String mysqlUrl = System.getenv("MYSQL_URL");
        if (isValidValue(mysqlUrl)) {
            try {
                URI uri = new URI(mysqlUrl.replace("mysql://", "http://"));
                if (uri.getUserInfo() != null && uri.getUserInfo().contains(":")) {
                    String user = uri.getUserInfo().split(":")[0];
                    if (!user.isBlank()) return user.trim();
                }
            } catch (Exception ignored) {}
        }

        String user = System.getenv("USER_DB_USER");
        if (isValidValue(user)) return user.trim();

        String mysqlUser = System.getenv("MYSQLUSER");
        if (isValidValue(mysqlUser)) return mysqlUser.trim();

        return "root";
    }

    public static String getPassword() {
        // 1. Try extracting from MYSQL_URL first
        String mysqlUrl = System.getenv("MYSQL_URL");
        if (isValidValue(mysqlUrl)) {
            try {
                URI uri = new URI(mysqlUrl.replace("mysql://", "http://"));
                if (uri.getUserInfo() != null && uri.getUserInfo().contains(":")) {
                    String pass = uri.getUserInfo().split(":")[1];
                    if (!pass.isBlank()) return pass.trim();
                }
            } catch (Exception ignored) {}
        }

        String pass = System.getenv("USER_DB_PASSWORD");
        if (isValidValue(pass)) return pass.trim();

        String mysqlPassword = System.getenv("MYSQLPASSWORD");
        if (isValidValue(mysqlPassword)) return mysqlPassword.trim();

        return null;
    }

    private static boolean isValidValue(String val) {
        if (val == null || val.isBlank()) {
            return false;
        }
        // If Railway template string was not resolved by Railway
        if (val.contains("${{")) {
            LOGGER.warning("DatabaseConfig: Detected unresolved template variable: " + val);
            return false;
        }
        return true;
    }

    private static boolean isValidHost(String host) {
        return host != null && !host.isBlank() && !host.equals(":") && !host.equals("/");
    }

    private static boolean isValidJdbcUrl(String url) {
        if (url == null || url.isBlank()) return false;
        // Rejects broken URLs like jdbc:mysql://:/ or jdbc:mysql://:3306/
        if (url.contains("://:/") || url.contains(":////") || url.matches(".*://:[0-9]*/.*")) {
            LOGGER.warning("DatabaseConfig: Detected empty host in JDBC URL: " + url);
            return false;
        }
        return true;
    }

    public static final String URL = getUrl();
    public static final String USERNAME = getUsername();
    public static final String PASSWORD = getPassword();
}