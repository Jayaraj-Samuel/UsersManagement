package com.usermanagement.dao;

import com.usermanagement.config.DatabaseConnection;
import com.usermanagement.model.User;

import java.sql.*;
import java.util.ArrayList;
import java.util.List;

public class UserDAO {

    private static final String SELECT_ALL_USERS = """
            SELECT id, name, email, password_hash, role, status,
                   created_at, updated_at
            FROM users
            ORDER BY created_at DESC
            """;

    private static final String SELECT_USER_BY_ID = """
            SELECT id, name, email, password_hash, role, status,
                   created_at, updated_at
            FROM users
            WHERE id = ?
            """;

    private static final String SELECT_USER_BY_EMAIL = """
            SELECT id, name, email, password_hash, role, status,
                   created_at, updated_at
            FROM users
            WHERE email = ?
            """;

    private static final String INSERT_USER = """
            INSERT INTO users
                (name, email, password_hash, role, status)
            VALUES (?, ?, ?, ?, ?)
            """;

    private static final String UPDATE_USER = """
            UPDATE users
            SET name = ?,
                email = ?,
                role = ?,
                status = ?
            WHERE id = ?
            """;

    private static final String UPDATE_USER_WITH_PASSWORD = """
            UPDATE users
            SET name = ?,
                email = ?,
                password_hash = ?,
                role = ?,
                status = ?
            WHERE id = ?
            """;

    private static final String DELETE_USER = """
            DELETE FROM users
            WHERE id = ?
            """;

    public List<User> findAll() throws SQLException {

        List<User> users = new ArrayList<>();

        try (
                Connection connection = DatabaseConnection.getConnection();
                PreparedStatement statement = connection.prepareStatement(SELECT_ALL_USERS);
                ResultSet resultSet = statement.executeQuery()) {

            while (resultSet.next()) {
                users.add(mapUser(resultSet));
            }
        }

        return users;
    }

    public User findById(Long id) throws SQLException {

        try (
                Connection connection = DatabaseConnection.getConnection();
                PreparedStatement statement = connection.prepareStatement(SELECT_USER_BY_ID)) {

            statement.setLong(1, id);

            try (ResultSet resultSet = statement.executeQuery()) {

                if (resultSet.next()) {
                    return mapUser(resultSet);
                }
            }
        }

        return null;
    }

    public User findByEmail(String email) throws SQLException {

        try (
                Connection connection = DatabaseConnection.getConnection();
                PreparedStatement statement = connection.prepareStatement(SELECT_USER_BY_EMAIL)) {

            statement.setString(1, email);

            try (ResultSet resultSet = statement.executeQuery()) {

                if (resultSet.next()) {
                    return mapUser(resultSet);
                }
            }
        }

        return null;
    }

    public long create(User user) throws SQLException {

        try (
                Connection connection = DatabaseConnection.getConnection();
                PreparedStatement statement = connection.prepareStatement(
                        INSERT_USER,
                        Statement.RETURN_GENERATED_KEYS)) {

            statement.setString(1, user.getName());
            statement.setString(2, user.getEmail());
            statement.setString(3, user.getPasswordHash());
            statement.setString(4, user.getRole());
            statement.setString(5, user.getStatus());

            int affectedRows = statement.executeUpdate();

            if (affectedRows == 0) {
                throw new SQLException("Creating user failed.");
            }

            try (ResultSet keys = statement.getGeneratedKeys()) {

                if (keys.next()) {
                    return keys.getLong(1);
                }

                throw new SQLException(
                        "Creating user failed. No generated ID returned.");
            }
        }
    }

    public boolean update(User user) throws SQLException {

        boolean hasPassword = user.getPasswordHash() != null && !user.getPasswordHash().isBlank();
        String sql = hasPassword ? UPDATE_USER_WITH_PASSWORD : UPDATE_USER;

        try (
                Connection connection = DatabaseConnection.getConnection();
                PreparedStatement statement = connection.prepareStatement(sql)) {

            statement.setString(1, user.getName());
            statement.setString(2, user.getEmail());

            if (hasPassword) {
                statement.setString(3, user.getPasswordHash());
                statement.setString(4, user.getRole());
                statement.setString(5, user.getStatus());
                statement.setLong(6, user.getId());
            } else {
                statement.setString(3, user.getRole());
                statement.setString(4, user.getStatus());
                statement.setLong(5, user.getId());
            }

            return statement.executeUpdate() > 0;
        }
    }

    public boolean delete(Long id) throws SQLException {

        try (
                Connection connection = DatabaseConnection.getConnection();
                PreparedStatement statement = connection.prepareStatement(DELETE_USER)) {

            statement.setLong(1, id);

            return statement.executeUpdate() > 0;
        }
    }

    private User mapUser(ResultSet resultSet) throws SQLException {

        Timestamp createdAtTs = resultSet.getTimestamp("created_at");
        Timestamp updatedAtTs = resultSet.getTimestamp("updated_at");

        return new User(
                resultSet.getLong("id"),
                resultSet.getString("name"),
                resultSet.getString("email"),
                resultSet.getString("password_hash"),
                resultSet.getString("role"),
                resultSet.getString("status"),
                createdAtTs != null ? createdAtTs.toLocalDateTime() : null,
                updatedAtTs != null ? updatedAtTs.toLocalDateTime() : null);
    }
}