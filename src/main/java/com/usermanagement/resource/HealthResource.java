package com.usermanagement.resource;

import com.usermanagement.config.DatabaseConfig;
import com.usermanagement.config.DatabaseConnection;
import jakarta.ws.rs.GET;
import jakarta.ws.rs.Path;
import jakarta.ws.rs.Produces;
import jakarta.ws.rs.core.MediaType;
import jakarta.ws.rs.core.Response;

import java.sql.Connection;
import java.util.LinkedHashMap;
import java.util.Map;

@Path("/health")
public class HealthResource {

    @GET
    @Produces(MediaType.APPLICATION_JSON)
    public Response health() {
        Map<String, Object> response = new LinkedHashMap<>();
        response.put("application", "User Management System");

        boolean dbConnected = false;
        String dbMessage = "Connected successfully";

        try (Connection conn = DatabaseConnection.getConnection()) {
            dbConnected = conn != null && !conn.isClosed();
        } catch (Exception e) {
            dbMessage = e.getMessage();
        }

        response.put("status", dbConnected ? "UP" : "DEGRADED");
        response.put("database_status", dbConnected ? "CONNECTED" : "ERROR");
        response.put("database_message", dbMessage);
        response.put("database_user", DatabaseConfig.getUsername());
        response.put("database_url", DatabaseConfig.getUrl());
        response.put("password_configured", DatabaseConfig.getPassword() != null && !DatabaseConfig.getPassword().isBlank());

        return Response.ok(response).build();
    }
}