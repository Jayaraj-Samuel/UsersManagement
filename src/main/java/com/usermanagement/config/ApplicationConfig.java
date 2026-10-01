package com.usermanagement.config;

import com.fasterxml.jackson.databind.ObjectMapper;
import com.fasterxml.jackson.datatype.jsr310.JavaTimeModule;
import jakarta.ws.rs.ApplicationPath;
import org.glassfish.jersey.jackson.internal.jackson.jaxrs.json.JacksonJsonProvider;
import org.glassfish.jersey.server.ResourceConfig;

@ApplicationPath("/api")
public class ApplicationConfig extends ResourceConfig {

    public ApplicationConfig() {

        ObjectMapper objectMapper = new ObjectMapper();

        // Support Java 8+ date/time types such as LocalDateTime
        objectMapper.registerModule(new JavaTimeModule());

        register(new JacksonJsonProvider(objectMapper));

        packages(
                "com.usermanagement.resource");
    }
}