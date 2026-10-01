package com.usermanagement.dao;

import com.usermanagement.model.User;

import java.util.List;

public class UserDAOTest {

    public static void main(String[] args) {

        UserDAO userDAO = new UserDAO();

        try {
            System.out.println("===== GET ALL USERS =====");

            List<User> users = userDAO.findAll();

            for (User user : users) {
                System.out.println(
                        user.getId() + " | "
                                + user.getName() + " | "
                                + user.getEmail() + " | "
                                + user.getRole() + " | "
                                + user.getStatus());
            }

            System.out.println();
            System.out.println("===== FIND BY EMAIL =====");

            User user = userDAO.findByEmail("admin@example.com");

            if (user != null) {
                System.out.println(
                        "Found: "
                                + user.getName()
                                + " (" + user.getEmail() + ")");
            } else {
                System.out.println("User not found.");
            }

            System.out.println();
            System.out.println("DAO test completed successfully.");

        } catch (Exception e) {
            System.err.println("DAO test failed.");
            e.printStackTrace();
        }
    }
}