package com.usermanagement.util;

import java.io.Console;

public class PasswordHashGenerator {

    public static void main(String[] args) {

        Console console = System.console();

        if (console == null) {
            System.out.println(
                    "Run this class from a real terminal, not the VS Code Java console.");
            return;
        }

        char[] password = console.readPassword(
                "Enter admin password: ");

        String hash = PasswordUtil.hashPassword(
                new String(password));

        System.out.println();
        System.out.println("Generated password hash:");
        System.out.println(hash);
    }
}