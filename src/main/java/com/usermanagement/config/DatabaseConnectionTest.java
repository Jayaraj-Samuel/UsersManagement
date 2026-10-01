package com.usermanagement.config;

import java.sql.Connection;

public class DatabaseConnectionTest {

    public static void main(String[] args) {

        try (Connection connection = DatabaseConnection.getConnection()) {

            System.out.println(
                    "Database connection successful!");

            System.out.println(
                    "Database: "
                            + connection.getCatalog());

        } catch (Exception e) {

            System.err.println(
                    "Database connection failed.");

            e.printStackTrace();
        }
    }
}