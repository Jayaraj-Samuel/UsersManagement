package com.usermanagement.resource;

import com.usermanagement.dao.UserDAO;
import com.usermanagement.model.User;
import com.usermanagement.util.PasswordUtil;

import jakarta.servlet.http.HttpServletRequest;
import jakarta.servlet.http.HttpSession;
import jakarta.ws.rs.Consumes;
import jakarta.ws.rs.POST;
import jakarta.ws.rs.Path;
import jakarta.ws.rs.Produces;
import jakarta.ws.rs.core.Context;
import jakarta.ws.rs.core.MediaType;
import jakarta.ws.rs.core.Response;
import jakarta.ws.rs.GET;

import java.sql.SQLException;
import java.util.Map;

@Path("/auth")
@Produces(MediaType.APPLICATION_JSON)
@Consumes(MediaType.APPLICATION_JSON)
public class AuthResource {

    private final UserDAO userDAO = new UserDAO();

    @POST
    @Path("/login")
    public Response login(
            LoginRequest request,
            @Context HttpServletRequest httpRequest) {

        try {

            if (request == null
                    || request.email == null
                    || request.email.isBlank()
                    || request.password == null
                    || request.password.isBlank()) {

                return Response.status(Response.Status.BAD_REQUEST)
                        .entity(Map.of(
                                "success", false,
                                "message", "Email and password are required"))
                        .build();
            }

            User user = userDAO.findByEmail(
                    request.email.trim());

            if (user == null
                    || !PasswordUtil.verifyPassword(
                            request.password,
                            user.getPasswordHash())) {

                return Response.status(Response.Status.UNAUTHORIZED)
                        .entity(Map.of(
                                "success", false,
                                "message", "Invalid email or password"))
                        .build();
            }

            if (!"ACTIVE".equalsIgnoreCase(user.getStatus())) {

                return Response.status(Response.Status.FORBIDDEN)
                        .entity(Map.of(
                                "success", false,
                                "message", "Account is inactive"))
                        .build();
            }

            HttpSession session = httpRequest.getSession(true);

            session.setAttribute("userId", user.getId());
            session.setAttribute("userName", user.getName());
            session.setAttribute("userEmail", user.getEmail());
            session.setAttribute("userRole", user.getRole());

            session.setMaxInactiveInterval(30 * 60);

            return Response.ok(
                    Map.of(
                            "success", true,
                            "message", "Login successful",
                            "user", Map.of(
                                    "id", user.getId(),
                                    "name", user.getName(),
                                    "email", user.getEmail(),
                                    "role", user.getRole())))
                    .build();

        } catch (SQLException e) {

            e.printStackTrace();

            return Response.status(
                    Response.Status.INTERNAL_SERVER_ERROR)
                    .entity(Map.of(
                            "success", false,
                            "message", "Unable to process login"))
                    .build();
        }
    }

    @GET
    @Path("/logout")
    public Response logout(
            @Context HttpServletRequest httpRequest) {

        HttpSession session = httpRequest.getSession(false);

        if (session != null) {
            session.invalidate();
        }

        return Response.ok(
                Map.of(
                        "success", true,
                        "message", "Logout successful"))
                .build();
    }

    public static class LoginRequest {

        public String email;
        public String password;

        public LoginRequest() {
        }
    }
}