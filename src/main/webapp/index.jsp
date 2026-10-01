<%@ page contentType="text/html;charset=UTF-8" language="java" %>
<!DOCTYPE html>
<html lang="en">
<head>
    <meta charset="UTF-8">
    <meta name="viewport" content="width=device-width, initial-scale=1.0">

    <title>Sign In | User Management System</title>

    <!-- Bootstrap CSS -->
    <link
        href="https://cdn.jsdelivr.net/npm/bootstrap@5.3.3/dist/css/bootstrap.min.css"
        rel="stylesheet">

    <!-- Bootstrap Icons -->
    <link
        rel="stylesheet"
        href="https://cdn.jsdelivr.net/npm/bootstrap-icons@1.11.3/font/bootstrap-icons.min.css">

    <style>
        :root {
            --primary: #4f46e5;
            --primary-dark: #3730a3;
            --bg: #f5f7fb;
            --text: #111827;
            --muted: #6b7280;
        }

        * {
            box-sizing: border-box;
        }

        body {
            margin: 0;
            min-height: 100vh;
            font-family: Inter, system-ui, -apple-system, BlinkMacSystemFont,
                         "Segoe UI", sans-serif;
            background:
                radial-gradient(circle at 10% 20%,
                    rgba(79, 70, 229, 0.12),
                    transparent 30%),
                radial-gradient(circle at 90% 80%,
                    rgba(124, 58, 237, 0.10),
                    transparent 30%),
                var(--bg);
        }

        .login-wrapper {
            min-height: 100vh;
            display: flex;
            align-items: center;
            justify-content: center;
            padding: 24px;
        }

        .login-container {
            width: 100%;
            max-width: 1050px;
            min-height: 620px;
            display: grid;
            grid-template-columns: 1fr 1fr;
            background: rgba(255, 255, 255, 0.92);
            border-radius: 28px;
            overflow: hidden;
            box-shadow:
                0 25px 60px rgba(15, 23, 42, 0.12);
            border: 1px solid rgba(255, 255, 255, 0.8);
        }

        .login-brand {
            position: relative;
            padding: 55px;
            display: flex;
            flex-direction: column;
            justify-content: center;
            color: white;
            overflow: hidden;
            background:
                linear-gradient(145deg,
                    #312e81 0%,
                    #4f46e5 48%,
                    #7c3aed 100%);
        }

        .login-brand::before {
            content: "";
            position: absolute;
            width: 320px;
            height: 320px;
            border-radius: 50%;
            background: rgba(255, 255, 255, 0.08);
            top: -120px;
            right: -100px;
        }

        .login-brand::after {
            content: "";
            position: absolute;
            width: 260px;
            height: 260px;
            border-radius: 50%;
            background: rgba(255, 255, 255, 0.06);
            bottom: -100px;
            left: -100px;
        }

        .brand-content {
            position: relative;
            z-index: 2;
        }

        .brand-icon {
            width: 64px;
            height: 64px;
            display: flex;
            align-items: center;
            justify-content: center;
            border-radius: 18px;
            background: rgba(255, 255, 255, 0.16);
            backdrop-filter: blur(10px);
            font-size: 28px;
            margin-bottom: 28px;
        }

        .brand-title {
            font-size: 42px;
            font-weight: 800;
            line-height: 1.1;
            letter-spacing: -1.5px;
            margin-bottom: 18px;
        }

        .brand-description {
            max-width: 420px;
            color: rgba(255, 255, 255, 0.82);
            font-size: 16px;
            line-height: 1.7;
        }

        .feature-list {
            margin-top: 35px;
            display: flex;
            flex-direction: column;
            gap: 15px;
        }

        .feature-item {
            display: flex;
            align-items: center;
            gap: 12px;
            color: rgba(255, 255, 255, 0.92);
            font-size: 14px;
        }

        .feature-item i {
            color: #c4b5fd;
            font-size: 18px;
        }

        .login-form-section {
            padding: 55px;
            display: flex;
            align-items: center;
        }

        .login-form {
            width: 100%;
            max-width: 400px;
            margin: auto;
        }

        .welcome-text {
            color: var(--muted);
            font-size: 14px;
            margin-bottom: 8px;
        }

        .login-title {
            color: var(--text);
            font-size: 32px;
            font-weight: 750;
            letter-spacing: -1px;
            margin-bottom: 10px;
        }

        .login-subtitle {
            color: var(--muted);
            font-size: 14px;
            margin-bottom: 32px;
        }

        .form-label {
            color: #374151;
            font-weight: 600;
            font-size: 13px;
            margin-bottom: 8px;
        }

        .input-group {
            position: relative;
        }

        .form-control {
            height: 52px;
            border: 1px solid #e5e7eb;
            border-radius: 12px !important;
            padding: 0 16px;
            font-size: 14px;
            transition: all 0.2s ease;
        }

        .form-control:focus {
            border-color: var(--primary);
            box-shadow: 0 0 0 4px rgba(79, 70, 229, 0.10);
        }

        .password-toggle {
            position: absolute;
            right: 14px;
            top: 50%;
            transform: translateY(-50%);
            border: 0;
            background: transparent;
            color: #9ca3af;
            z-index: 5;
            cursor: pointer;
        }

        .password-toggle:hover {
            color: var(--primary);
        }

        .login-button {
            width: 100%;
            height: 52px;
            border: 0;
            border-radius: 12px;
            background: linear-gradient(
                135deg,
                var(--primary),
                #7c3aed
            );
            color: white;
            font-weight: 700;
            font-size: 14px;
            transition: all 0.2s ease;
            box-shadow: 0 10px 25px rgba(79, 70, 229, 0.22);
        }

        .login-button:hover {
            transform: translateY(-1px);
            box-shadow: 0 14px 30px rgba(79, 70, 229, 0.28);
        }

        .login-button:disabled {
            opacity: 0.7;
            transform: none;
        }

        .alert {
            border-radius: 12px;
            font-size: 13px;
        }

        .security-note {
            margin-top: 25px;
            text-align: center;
            color: #9ca3af;
            font-size: 12px;
        }

        .security-note i {
            margin-right: 4px;
        }

        .spinner-border {
            width: 18px;
            height: 18px;
            border-width: 2px;
        }

        @media (max-width: 850px) {
            .login-container {
                grid-template-columns: 1fr;
                max-width: 520px;
            }

            .login-brand {
                display: none;
            }

            .login-form-section {
                padding: 45px 30px;
            }
        }

        @media (max-width: 480px) {
            .login-wrapper {
                padding: 12px;
            }

            .login-container {
                border-radius: 20px;
            }

            .login-form-section {
                padding: 35px 22px;
            }
        }
    </style>
</head>

<body>

<div class="login-wrapper">

    <div class="login-container">

        <!-- Brand Panel -->
        <section class="login-brand">

            <div class="brand-content">

                <div class="brand-icon">
                    <i class="bi bi-grid-1x2-fill"></i>
                </div>

                <div class="brand-title">
                    User<br>
                    Management
                </div>

                <p class="brand-description">
                    A secure, modern platform for managing users,
                    roles and account status from one centralized
                    workspace.
                </p>

                <div class="feature-list">

                    <div class="feature-item">
                        <i class="bi bi-shield-check"></i>
                        Session-based security
                    </div>

                    <div class="feature-item">
                        <i class="bi bi-database-check"></i>
                        MySQL powered
                    </div>

                    <div class="feature-item">
                        <i class="bi bi-lightning-charge"></i>
                        Fast AJAX operations
                    </div>

                </div>

            </div>

        </section>

        <!-- Login Form -->
        <section class="login-form-section">

            <form id="loginForm" class="login-form">

                <div class="welcome-text">
                    Welcome back
                </div>

                <h1 class="login-title">
                    Sign in
                </h1>

                <p class="login-subtitle">
                    Enter your credentials to access the dashboard.
                </p>

                <div id="loginAlert"
                     class="alert alert-danger d-none"
                     role="alert">
                </div>

                <div class="mb-3">

                    <label
                        for="email"
                        class="form-label">
                        Email address
                    </label>

                    <input
                        type="email"
                        id="email"
                        class="form-control"
                        placeholder="admin@example.com"
                        autocomplete="username"
                        required>

                </div>

                <div class="mb-4">

                    <label
                        for="password"
                        class="form-label">
                        Password
                    </label>

                    <div class="input-group">

                        <input
                            type="password"
                            id="password"
                            class="form-control"
                            placeholder="Enter your password"
                            autocomplete="current-password"
                            required>

                        <button
                            type="button"
                            id="togglePassword"
                            class="password-toggle"
                            aria-label="Show password">

                            <i class="bi bi-eye"></i>

                        </button>

                    </div>

                </div>

                <button
                    type="submit"
                    id="loginButton"
                    class="login-button">

                    <span id="loginButtonText">
                        Sign In
                    </span>

                    <span
                        id="loginSpinner"
                        class="spinner-border d-none"
                        role="status">
                    </span>

                </button>

                <div class="security-note">
                    <i class="bi bi-lock-fill"></i>
                    Protected by session-based authentication
                </div>

            </form>

        </section>

    </div>

</div>

<!-- jQuery -->
<script src="https://code.jquery.com/jquery-3.7.1.min.js"></script>

<script>

    const contextPath = "${pageContext.request.contextPath}";

    $("#togglePassword").on("click", function () {

        const passwordInput = $("#password");
        const icon = $(this).find("i");

        if (passwordInput.attr("type") === "password") {

            passwordInput.attr("type", "text");

            icon.removeClass("bi-eye")
                .addClass("bi-eye-slash");

            $(this).attr("aria-label", "Hide password");

        } else {

            passwordInput.attr("type", "password");

            icon.removeClass("bi-eye-slash")
                .addClass("bi-eye");

            $(this).attr("aria-label", "Show password");
        }
    });

    $("#loginForm").on("submit", function (event) {

        event.preventDefault();

        const email = $("#email").val().trim();
        const password = $("#password").val();

        $("#loginAlert")
            .addClass("d-none")
            .text("");

        if (!email || !password) {
            showError("Please enter your email and password.");
            return;
        }

        setLoading(true);

        $.ajax({
            url: contextPath + "/api/auth/login",
            method: "POST",
            contentType: "application/json",
            data: JSON.stringify({
                email: email,
                password: password
            }),

            success: function (response) {

                if (response.success) {

                    $("#loginButtonText").text("Success!");

                    setTimeout(function () {
                        window.location.href =
                            contextPath + "/home.jsp";
                    }, 300);

                } else {
                    showError(
                        response.message ||
                        "Unable to sign in."
                    );
                    setLoading(false);
                }
            },

            error: function (xhr) {

                let message =
                    "Unable to sign in. Please try again.";

                if (xhr.responseJSON &&
                    xhr.responseJSON.message) {

                    message =
                        xhr.responseJSON.message;
                }

                showError(message);
                setLoading(false);
            }
        });
    });

    function showError(message) {

        $("#loginAlert")
            .removeClass("d-none")
            .text(message);
    }

    function setLoading(loading) {

        $("#loginButton").prop("disabled", loading);

        if (loading) {

            $("#loginButtonText")
                .addClass("d-none");

            $("#loginSpinner")
                .removeClass("d-none");

        } else {

            $("#loginButtonText")
                .removeClass("d-none");

            $("#loginSpinner")
                .addClass("d-none");
        }
    }

</script>

</body>
</html>