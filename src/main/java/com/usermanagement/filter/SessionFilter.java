package com.usermanagement.filter;

import jakarta.servlet.Filter;
import jakarta.servlet.FilterChain;
import jakarta.servlet.ServletException;
import jakarta.servlet.ServletRequest;
import jakarta.servlet.ServletResponse;
import jakarta.servlet.annotation.WebFilter;
import jakarta.servlet.http.HttpServletRequest;
import jakarta.servlet.http.HttpServletResponse;
import jakarta.servlet.http.HttpSession;

import java.io.IOException;

@WebFilter(urlPatterns = { "/api/users/*" })
public class SessionFilter implements Filter {

    @Override
    public void doFilter(
            ServletRequest request,
            ServletResponse response,
            FilterChain chain)
            throws IOException, ServletException {

        HttpServletRequest httpRequest = (HttpServletRequest) request;

        HttpServletResponse httpResponse = (HttpServletResponse) response;

        HttpSession session = httpRequest.getSession(false);

        boolean authenticated = session != null
                && session.getAttribute("userId") != null;

        if (!authenticated) {

            httpResponse.setStatus(
                    HttpServletResponse.SC_UNAUTHORIZED);

            httpResponse.setContentType(
                    "application/json");

            httpResponse.getWriter().write(
                    "{\"success\":false,\"message\":\"Authentication required\"}");

            return;
        }

        chain.doFilter(request, response);
    }
}