package com.usermanagement.util;

import java.security.NoSuchAlgorithmException;
import java.security.SecureRandom;
import java.security.spec.InvalidKeySpecException;
import java.security.spec.KeySpec;
import java.util.Base64;

import javax.crypto.SecretKeyFactory;
import javax.crypto.spec.PBEKeySpec;

public final class PasswordUtil {

    private static final int SALT_LENGTH = 16;
    private static final int ITERATIONS = 210_000;
    private static final int KEY_LENGTH = 256;

    private PasswordUtil() {
    }

    public static String hashPassword(String password) {

        if (password == null || password.isBlank()) {
            throw new IllegalArgumentException("Password cannot be empty.");
        }

        byte[] salt = new byte[SALT_LENGTH];
        new SecureRandom().nextBytes(salt);

        byte[] hash = deriveKey(password, salt);

        return ITERATIONS + ":"
                + Base64.getEncoder().encodeToString(salt) + ":"
                + Base64.getEncoder().encodeToString(hash);
    }

    public static boolean verifyPassword(
            String password,
            String storedHash) {

        if (password == null || storedHash == null) {
            return false;
        }

        try {
            String[] parts = storedHash.split(":");

            if (parts.length != 3) {
                return false;
            }

            int iterations = Integer.parseInt(parts[0]);

            byte[] salt = Base64.getDecoder().decode(parts[1]);

            byte[] expectedHash = Base64.getDecoder().decode(parts[2]);

            byte[] actualHash = deriveKey(password, salt, iterations);

            return java.security.MessageDigest.isEqual(
                    expectedHash,
                    actualHash);

        } catch (Exception e) {
            return false;
        }
    }

    private static byte[] deriveKey(
            String password,
            byte[] salt) {

        return deriveKey(password, salt, ITERATIONS);
    }

    private static byte[] deriveKey(
            String password,
            byte[] salt,
            int iterations) {

        try {

            KeySpec spec = new PBEKeySpec(
                    password.toCharArray(),
                    salt,
                    iterations,
                    KEY_LENGTH);

            SecretKeyFactory factory = SecretKeyFactory.getInstance(
                    "PBKDF2WithHmacSHA256");

            return factory.generateSecret(spec)
                    .getEncoded();

        } catch (
                NoSuchAlgorithmException | InvalidKeySpecException e) {

            throw new IllegalStateException(
                    "Unable to hash password.",
                    e);
        }
    }
}