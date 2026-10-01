package com.usermanagement.resource;

import com.usermanagement.dao.UserDAO;
import com.usermanagement.model.User;
import com.usermanagement.model.UserResponse;
import com.usermanagement.util.PasswordUtil;

import jakarta.ws.rs.*;
import jakarta.ws.rs.core.MediaType;
import jakarta.ws.rs.core.Response;

import java.sql.SQLException;
import java.util.List;
import java.util.Map;
import java.util.regex.Pattern;
import java.util.stream.Collectors;

@Path("/users")
@Produces(MediaType.APPLICATION_JSON)
@Consumes(MediaType.APPLICATION_JSON)
public class UserResource {

    private final UserDAO userDAO = new UserDAO();
    private static final Pattern EMAIL_PATTERN = Pattern.compile("^[A-Za-z0-9._%+-]+@[A-Za-z0-9.-]+\\.[A-Za-z]{2,}$");

    @GET
    public Response getAllUsers() {

        try {

            List<UserResponse> users = userDAO.findAll()
                    .stream()
                    .map(UserResponse::from)
                    .collect(Collectors.toList());

            return Response.ok(users).build();

        } catch (SQLException e) {

            e.printStackTrace();

            return Response.status(
                    Response.Status.INTERNAL_SERVER_ERROR)
                    .entity(Map.of("message", "Unable to retrieve users"))
                    .build();
        }
    }

    @GET
    @Path("/{id}")
    public Response getUserById(
            @PathParam("id") Long id) {

        try {

            User user = userDAO.findById(id);

            if (user == null) {

                return Response.status(
                        Response.Status.NOT_FOUND)
                        .entity(Map.of("message", "User not found"))
                        .build();
            }

            return Response.ok(
                    UserResponse.from(user))
                    .build();

        } catch (SQLException e) {

            e.printStackTrace();

            return Response.status(
                    Response.Status.INTERNAL_SERVER_ERROR)
                    .entity(Map.of("message", "Unable to retrieve user"))
                    .build();
        }
    }

    @POST
    public Response createUser(User user) {

        try {

            /*
             * Validate request
             */

            if (user == null ||
                    user.getName() == null ||
                    user.getName().trim().isEmpty() ||
                    user.getEmail() == null ||
                    user.getEmail().trim().isEmpty() ||
                    user.getPasswordHash() == null ||
                    user.getPasswordHash().trim().isEmpty()) {

                return Response.status(
                        Response.Status.BAD_REQUEST)
                        .entity(Map.of("message", "Name, email and password are required"))
                        .build();
            }

            String trimmedEmail = user.getEmail().trim().toLowerCase();

            if (!EMAIL_PATTERN.matcher(trimmedEmail).matches()) {
                return Response.status(Response.Status.BAD_REQUEST)
                        .entity(Map.of("message", "Invalid email address format"))
                        .build();
            }

            if (user.getPasswordHash().length() < 6) {
                return Response.status(Response.Status.BAD_REQUEST)
                        .entity(Map.of("message", "Password must be at least 6 characters long"))
                        .build();
            }

            /*
             * Check whether email already exists
             */

            User existingUser = userDAO.findByEmail(trimmedEmail);

            if (existingUser != null) {

                return Response.status(
                        Response.Status.CONFLICT)
                        .entity(Map.of("message", "Email address already exists"))
                        .build();
            }

            /*
             * Normalize basic fields
             */

            user.setName(user.getName().trim());
            user.setEmail(trimmedEmail);

            /*
             * Generate secure PBKDF2 password hash.
             */

            String plainPassword = user.getPasswordHash();
            String secureHash = PasswordUtil.hashPassword(plainPassword);

            /*
             * Replace plain password with secure hash.
             */

            user.setPasswordHash(secureHash);

            /*
             * Set safe defaults if they weren't supplied.
             */

            if (user.getRole() == null ||
                    user.getRole().isBlank()) {

                user.setRole("USER");
            }

            if (user.getStatus() == null ||
                    user.getStatus().isBlank()) {

                user.setStatus("ACTIVE");
            }

            /*
             * Insert into MySQL.
             */

            long generatedId = userDAO.create(user);

            User createdUser = userDAO.findById(generatedId);
            if (createdUser == null) {
                user.setId(generatedId);
                createdUser = user;
            }

            /*
             * Return created response without password_hash.
             */

            return Response.status(
                    Response.Status.CREATED)
                    .entity(UserResponse.from(createdUser))
                    .build();

        } catch (SQLException e) {

            e.printStackTrace();

            return Response.status(
                    Response.Status.INTERNAL_SERVER_ERROR)
                    .entity(Map.of("message", "Unable to create user"))
                    .build();
        }
    }

    @PUT
    @Path("/{id}")
    public Response updateUser(
            @PathParam("id") Long id,
            User user) {

        try {

            User existingUser = userDAO.findById(id);

            if (existingUser == null) {

                return Response.status(
                        Response.Status.NOT_FOUND)
                        .entity(Map.of("message", "User not found"))
                        .build();
            }

            if (user == null ||
                    user.getName() == null ||
                    user.getName().trim().isEmpty() ||
                    user.getEmail() == null ||
                    user.getEmail().trim().isEmpty()) {

                return Response.status(
                        Response.Status.BAD_REQUEST)
                        .entity(Map.of("message", "Name and email are required"))
                        .build();
            }

            String trimmedEmail = user.getEmail().trim().toLowerCase();

            if (!EMAIL_PATTERN.matcher(trimmedEmail).matches()) {
                return Response.status(Response.Status.BAD_REQUEST)
                        .entity(Map.of("message", "Invalid email address format"))
                        .build();
            }

            /*
             * Check duplicate email for another user
             */

            User emailOwner = userDAO.findByEmail(trimmedEmail);

            if (emailOwner != null && !emailOwner.getId().equals(id)) {

                return Response.status(
                        Response.Status.CONFLICT)
                        .entity(Map.of("message", "Email address already exists"))
                        .build();
            }

            user.setId(id);
            user.setName(user.getName().trim());
            user.setEmail(trimmedEmail);

            if (user.getRole() == null || user.getRole().isBlank()) {
                user.setRole(existingUser.getRole());
            }

            if (user.getStatus() == null || user.getStatus().isBlank()) {
                user.setStatus(existingUser.getStatus());
            }

            /*
             * Password update: hash if provided, otherwise leave as null so DAO won't overwrite existing hash
             */
            if (user.getPasswordHash() != null && !user.getPasswordHash().trim().isEmpty()) {
                if (user.getPasswordHash().length() < 6) {
                    return Response.status(Response.Status.BAD_REQUEST)
                            .entity(Map.of("message", "Password must be at least 6 characters long"))
                            .build();
                }
                user.setPasswordHash(PasswordUtil.hashPassword(user.getPasswordHash()));
            } else {
                user.setPasswordHash(null);
            }

            boolean updated = userDAO.update(user);

            if (!updated) {

                return Response.status(
                        Response.Status.INTERNAL_SERVER_ERROR)
                        .entity(Map.of("message", "Unable to update user"))
                        .build();
            }

            User updatedUser = userDAO.findById(id);

            return Response.ok(
                    UserResponse.from(updatedUser != null ? updatedUser : user))
                    .build();

        } catch (SQLException e) {

            e.printStackTrace();

            return Response.status(
                    Response.Status.INTERNAL_SERVER_ERROR)
                    .entity(Map.of("message", "Unable to update user"))
                    .build();
        }
    }

    @DELETE
    @Path("/{id}")
    public Response deleteUser(
            @PathParam("id") Long id) {

        try {

            User existingUser = userDAO.findById(id);

            if (existingUser == null) {

                return Response.status(
                        Response.Status.NOT_FOUND)
                        .entity(Map.of("message", "User not found"))
                        .build();
            }

            boolean deleted = userDAO.delete(id);

            if (!deleted) {

                return Response.status(
                        Response.Status.INTERNAL_SERVER_ERROR)
                        .entity(Map.of("message", "Unable to delete user"))
                        .build();
            }

            return Response.ok(Map.of("message", "User deleted successfully")).build();

        } catch (SQLException e) {

            e.printStackTrace();

            return Response.status(
                    Response.Status.INTERNAL_SERVER_ERROR)
                    .entity(Map.of("message", "Unable to delete user"))
                    .build();
        }
    }
}