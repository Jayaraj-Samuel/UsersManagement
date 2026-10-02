<%@ page contentType="text/html;charset=UTF-8" language="java" %>

<!DOCTYPE html>
<html lang="en">

<head>
    <meta charset="UTF-8">
    <meta name="viewport" content="width=device-width, initial-scale=1.0">

    <title>User Management | Admin Dashboard</title>

    <!-- Bootstrap -->
    <link
        href="https://cdn.jsdelivr.net/npm/bootstrap@5.3.3/dist/css/bootstrap.min.css"
        rel="stylesheet">

    <!-- Bootstrap Icons -->
    <link
        href="https://cdn.jsdelivr.net/npm/bootstrap-icons@1.11.3/font/bootstrap-icons.css"
        rel="stylesheet">

    <!-- jQuery -->
    <script src="https://code.jquery.com/jquery-3.7.1.min.js"></script>

    <style>

        :root {
            --primary: #4f46e5;
            --primary-dark: #3730a3;
            --sidebar: #111827;
            --sidebar-hover: #1f2937;
            --background: #f5f7fb;
            --text-dark: #111827;
            --text-muted: #6b7280;
        }

        * {
            box-sizing: border-box;
        }

        body {
            margin: 0;
            background: var(--background);
            font-family: "Inter", "Segoe UI", Arial, sans-serif;
            color: var(--text-dark);
        }

        /* =========================
           SIDEBAR
        ========================== */

        .sidebar {
            position: fixed;
            top: 0;
            left: 0;
            width: 250px;
            height: 100vh;
            background: var(--sidebar);
            color: white;
            padding: 24px 16px;
            z-index: 1000;
        }

        .brand {
            display: flex;
            align-items: center;
            gap: 12px;
            padding: 0 12px 30px;
            font-size: 20px;
            font-weight: 700;
        }

        .brand-icon {
            width: 40px;
            height: 40px;
            border-radius: 12px;
            background: linear-gradient(135deg, #6366f1, #8b5cf6);
            display: flex;
            align-items: center;
            justify-content: center;
            font-size: 20px;
        }

        .nav-title {
            font-size: 11px;
            color: #9ca3af;
            text-transform: uppercase;
            letter-spacing: 1px;
            padding: 0 12px;
            margin-bottom: 10px;
        }

        .sidebar-link {
            display: flex;
            align-items: center;
            gap: 13px;
            color: #d1d5db;
            text-decoration: none;
            padding: 12px 14px;
            border-radius: 10px;
            margin-bottom: 6px;
            transition: 0.2s;
        }

        .sidebar-link:hover,
        .sidebar-link.active {
            background: var(--sidebar-hover);
            color: white;
        }

        .sidebar-link.active {
            background: linear-gradient(
                135deg,
                rgba(79, 70, 229, 0.9),
                rgba(99, 102, 241, 0.8)
            );
        }

        .sidebar-link i {
            font-size: 18px;
        }

        .sidebar-bottom {
            position: absolute;
            bottom: 25px;
            left: 16px;
            right: 16px;
        }

        /* =========================
           MAIN
        ========================== */

        .main {
            margin-left: 250px;
            min-height: 100vh;
        }

        /* =========================
           TOPBAR
        ========================== */

        .topbar {
            height: 72px;
            background: white;
            border-bottom: 1px solid #e5e7eb;
            display: flex;
            align-items: center;
            justify-content: space-between;
            padding: 0 32px;
        }

        .page-title {
            font-size: 20px;
            font-weight: 700;
            margin: 0;
        }

        .page-subtitle {
            font-size: 13px;
            color: var(--text-muted);
            margin-top: 3px;
        }

        .profile {
            display: flex;
            align-items: center;
            gap: 12px;
        }

        .profile-avatar {
            width: 40px;
            height: 40px;
            border-radius: 50%;
            background: linear-gradient(135deg, #6366f1, #8b5cf6);
            color: white;
            display: flex;
            align-items: center;
            justify-content: center;
            font-weight: 700;
        }

        .profile-name {
            font-size: 14px;
            font-weight: 600;
        }

        .profile-role {
            font-size: 12px;
            color: var(--text-muted);
        }

        /* =========================
           CONTENT
        ========================== */

        .content {
            padding: 30px 32px;
        }

        /* =========================
           STAT CARDS
        ========================== */

        .stat-card {
            background: white;
            border: none;
            border-radius: 16px;
            padding: 22px;
            box-shadow: 0 4px 18px rgba(0, 0, 0, 0.04);
            height: 100%;
        }

        .stat-icon {
            width: 46px;
            height: 46px;
            border-radius: 12px;
            display: flex;
            align-items: center;
            justify-content: center;
            font-size: 20px;
            margin-bottom: 15px;
        }

        .icon-purple {
            background: #ede9fe;
            color: #7c3aed;
        }

        .icon-green {
            background: #dcfce7;
            color: #16a34a;
        }

        .icon-blue {
            background: #dbeafe;
            color: #2563eb;
        }

        .stat-label {
            color: var(--text-muted);
            font-size: 13px;
            margin-bottom: 5px;
        }

        .stat-value {
            font-size: 27px;
            font-weight: 700;
        }

        /* =========================
           USER SECTION
        ========================== */

        .users-card {
            background: white;
            border-radius: 16px;
            border: none;
            box-shadow: 0 4px 18px rgba(0, 0, 0, 0.04);
            overflow: hidden;
        }

        .users-header {
            padding: 22px 24px;
            display: flex;
            justify-content: space-between;
            align-items: center;
            border-bottom: 1px solid #f0f0f0;
        }

        .users-title {
            font-size: 18px;
            font-weight: 700;
            margin: 0;
        }

        .users-description {
            font-size: 13px;
            color: var(--text-muted);
            margin-top: 4px;
        }

        .btn-add {
            background: var(--primary);
            color: white;
            border: none;
            border-radius: 9px;
            padding: 10px 17px;
            font-size: 14px;
            font-weight: 600;
        }

        .btn-add:hover {
            background: var(--primary-dark);
            color: white;
        }

        /* =========================
           SEARCH
        ========================== */

        .table-toolbar {
            padding: 18px 24px;
            display: flex;
            justify-content: space-between;
            align-items: center;
        }

        .search-box {
            position: relative;
            width: 300px;
        }

        .search-box i {
            position: absolute;
            left: 13px;
            top: 11px;
            color: #9ca3af;
        }

        .search-box input {
            padding-left: 38px;
            border-radius: 9px;
            border: 1px solid #e5e7eb;
            font-size: 14px;
            height: 40px;
        }

        .search-box input:focus {
            border-color: var(--primary);
            box-shadow: 0 0 0 3px rgba(79, 70, 229, 0.1);
        }

        /* =========================
           TABLE
        ========================== */

        .table {
            margin-bottom: 0;
        }

        .table thead th {
            background: #f9fafb;
            color: #6b7280;
            font-size: 12px;
            font-weight: 600;
            text-transform: uppercase;
            letter-spacing: .4px;
            padding: 15px 24px;
            border-bottom: 1px solid #e5e7eb;
        }

        .table tbody td {
            padding: 17px 24px;
            vertical-align: middle;
            font-size: 14px;
            border-bottom: 1px solid #f1f1f1;
        }

        .table tbody tr:hover {
            background: #fafaff;
        }

        .user-info {
            display: flex;
            align-items: center;
            gap: 12px;
        }

        .user-avatar {
            width: 38px;
            height: 38px;
            border-radius: 50%;
            background: #eef2ff;
            color: #4f46e5;
            display: flex;
            align-items: center;
            justify-content: center;
            font-weight: 700;
        }

        .user-name {
            font-weight: 600;
        }

        .user-email {
            font-size: 12px;
            color: var(--text-muted);
        }

        .badge-role {
            background: #ede9fe;
            color: #6d28d9;
            padding: 6px 10px;
            border-radius: 20px;
            font-size: 11px;
            font-weight: 600;
        }

        .badge-active {
            background: #dcfce7;
            color: #15803d;
            padding: 6px 10px;
            border-radius: 20px;
            font-size: 11px;
            font-weight: 600;
        }

        .action-btn {
            width: 34px;
            height: 34px;
            border: none;
            border-radius: 8px;
            background: #f3f4f6;
            margin-right: 5px;
            transition: .2s;
        }

        .action-btn:hover {
            background: #e5e7eb;
        }

        /* =========================
           MOBILE
        ========================== */

        @media (max-width: 900px) {

            .sidebar {
                width: 75px;
                padding: 20px 10px;
            }

            .brand span,
            .nav-title,
            .sidebar-link span {
                display: none;
            }

            .brand {
                justify-content: center;
                padding: 0 0 30px;
            }

            .sidebar-link {
                justify-content: center;
            }

            .sidebar-bottom {
                left: 10px;
                right: 10px;
            }

            .main {
                margin-left: 75px;
            }

            .content {
                padding: 20px;
            }
        }

        @media (max-width: 600px) {

            .topbar {
                padding: 0 15px;
            }

            .profile-name,
            .profile-role {
                display: none;
            }

            .content {
                padding: 15px;
            }

            .users-header {
                flex-direction: column;
                align-items: flex-start;
                gap: 15px;
            }

            .table-toolbar {
                flex-direction: column;
                align-items: stretch;
                gap: 12px;
            }

            .search-box {
                width: 100%;
            }

            .table-responsive {
                overflow-x: auto;
            }
        }

    </style>
</head>

<body>

<!-- =========================
     SIDEBAR
========================== -->

<aside class="sidebar">

    <div class="brand">
        <div class="brand-icon">
            <i class="bi bi-people-fill"></i>
        </div>
        <span>UserHub</span>
    </div>

    <div class="nav-title">
        Main Menu
    </div>

    <a href="#" id="navDashboard" class="sidebar-link active">
        <i class="bi bi-grid-1x2-fill"></i>
        <span>Dashboard</span>
    </a>

    <a href="#users" id="navUsers" class="sidebar-link">
        <i class="bi bi-people"></i>
        <span>Users</span>
    </a>

    <div class="nav-title mt-4">
        System
    </div>

    <a href="#" id="navSettings" class="sidebar-link">
        <i class="bi bi-gear"></i>
        <span>Settings</span>
    </a>

    <div class="sidebar-bottom">

        <a href="#" id="logoutBtn" class="sidebar-link">
            <i class="bi bi-box-arrow-right"></i>
            <span>Logout</span>
        </a>

    </div>

</aside>


<!-- =========================
     MAIN
========================== -->

<main class="main">

    <!-- TOPBAR -->

    <header class="topbar">

        <div>
            <h1 class="page-title" id="topbarTitle">
                Dashboard
            </h1>

            <div class="page-subtitle" id="topbarSubtitle">
                Manage your application users
            </div>
        </div>

        <div class="profile">

            <div class="profile-avatar">
                ${not empty sessionScope.userName ? sessionScope.userName.substring(0,1).toUpperCase() : 'U'}
            </div>

            <div>
                <div class="profile-name">
                    ${not empty sessionScope.userName ? sessionScope.userName : 'User'}
                </div>

                <div class="profile-role">
                    ${not empty sessionScope.userRole ? sessionScope.userRole : 'USER'}
                </div>
            </div>

        </div>

    </header>


    <!-- CONTENT -->

    <section class="content">

        <!-- DASHBOARD SECTION -->
        <div id="dashboardSection">

            <!-- STATISTICS -->

            <div class="row g-4 mb-4">

                <div class="col-lg-4 col-md-6">

                    <div class="stat-card">

                        <div class="stat-icon icon-purple">
                            <i class="bi bi-people-fill"></i>
                        </div>

                        <div class="stat-label">
                            Total Users
                        </div>

                        <div class="stat-value" id="totalUsers">
                            -
                        </div>

                    </div>

                </div>


                <div class="col-lg-4 col-md-6">

                    <div class="stat-card">

                        <div class="stat-icon icon-green">
                            <i class="bi bi-person-check-fill"></i>
                        </div>

                        <div class="stat-label">
                            Active Users
                        </div>

                        <div class="stat-value" id="activeUsers">
                            -
                        </div>

                    </div>

                </div>


                <div class="col-lg-4 col-md-6">

                    <div class="stat-card">

                        <div class="stat-icon icon-blue">
                            <i class="bi bi-shield-check"></i>
                        </div>

                        <div class="stat-label">
                            Administrators
                        </div>

                        <div class="stat-value" id="adminUsers">
                            -
                        </div>

                    </div>

                </div>

            </div>


            <!-- USERS -->

            <div class="users-card" id="users">

                <div class="users-header">

                    <div>
                        <h2 class="users-title">
                            User Management
                        </h2>

                        <div class="users-description">
                            View and manage registered users
                        </div>
                    </div>

                    <button class="btn btn-add" id="addUserBtn">
                        <i class="bi bi-plus-lg me-1"></i>
                        Add User
                    </button>

                </div>


                <!-- SEARCH -->

                <div class="table-toolbar">

                    <div class="search-box">

                        <i class="bi bi-search"></i>

                        <input
                            type="text"
                            id="searchInput"
                            class="form-control"
                            placeholder="Search users...">

                    </div>

                    <div class="text-muted small">
                        User directory
                    </div>

                </div>


                <!-- TABLE -->

                <div class="table-responsive">

                    <table class="table">

                        <thead>

                        <tr>

                            <th>User</th>

                            <th>Role</th>

                            <th>Status</th>

                            <th>Created</th>

                            <th class="text-end">Actions</th>

                        </tr>

                        </thead>

                        <tbody id="userTableBody">

                        <!-- Users will be loaded with AJAX -->

                        <tr>

                            <td colspan="5" class="text-center py-5">

                                <div class="spinner-border text-primary"
                                     role="status">
                                </div>

                                <div class="text-muted mt-2">
                                    Loading users...
                                </div>

                            </td>

                        </tr>

                        </tbody>

                    </table>

                </div>

            </div>

        </div>


        <!-- SETTINGS SECTION -->
        <div id="settingsSection" class="d-none">

            <div class="row g-4">

                <!-- Account & Security Card -->
                <div class="col-lg-7">
                    <div class="users-card p-4">
                        <h3 class="fw-bold mb-1 fs-5">
                            <i class="bi bi-person-badge text-primary me-2"></i>Account & Security
                        </h3>
                        <p class="text-muted small mb-4">Manage your profile and update your password</p>

                        <form id="changePasswordForm">

                            <div class="mb-3">
                                <label class="form-label fw-semibold text-secondary small">Logged-in User</label>
                                <input type="text" class="form-control bg-light" value="${not empty sessionScope.userName ? sessionScope.userName : 'User'} (${not empty sessionScope.userEmail ? sessionScope.userEmail : 'N/A'})" readonly>
                            </div>

                            <div class="mb-4">
                                <label class="form-label fw-semibold text-secondary small me-2">Role:</label>
                                <span class="badge-role">${not empty sessionScope.userRole ? sessionScope.userRole : 'USER'}</span>
                            </div>

                            <hr class="my-4">

                            <h4 class="fw-bold fs-6 mb-3"><i class="bi bi-key me-1"></i>Change Password</h4>

                            <div class="mb-3">
                                <label for="settingsNewPassword" class="form-label fw-semibold small">New Password</label>
                                <input type="password" class="form-control" id="settingsNewPassword" placeholder="Enter new password" minlength="6" required>
                                <div class="form-text">Minimum 6 characters. Securely hashed using PBKDF2.</div>
                            </div>

                            <div class="mb-3">
                                <label for="settingsConfirmPassword" class="form-label fw-semibold small">Confirm New Password</label>
                                <input type="password" class="form-control" id="settingsConfirmPassword" placeholder="Confirm new password" required>
                            </div>

                            <div id="changePasswordAlert" class="alert alert-danger d-none mb-3"></div>

                            <button type="submit" class="btn btn-primary fw-semibold px-4" id="changePasswordBtn">
                                <span id="changePasswordSpinner" class="spinner-border spinner-border-sm d-none me-1"></span>
                                Update Password
                            </button>

                        </form>
                    </div>
                </div>

                <!-- System Info Card -->
                <div class="col-lg-5">
                    <div class="users-card p-4">
                        <h3 class="fw-bold mb-1 fs-5">
                            <i class="bi bi-cpu text-primary me-2"></i>System & Environment
                        </h3>
                        <p class="text-muted small mb-4">Architecture & backend status</p>

                        <div class="list-group list-group-flush">
                            <div class="list-group-item d-flex justify-content-between align-items-center px-0 bg-transparent py-3">
                                <div>
                                    <div class="fw-semibold">Database Connection</div>
                                    <small class="text-muted">MySQL (user_management)</small>
                                </div>
                                <span class="badge-active" id="systemDbStatus">
                                    <i class="bi bi-check-circle-fill me-1"></i>CONNECTED
                                </span>
                            </div>

                            <div class="list-group-item d-flex justify-content-between align-items-center px-0 bg-transparent py-3">
                                <div>
                                    <div class="fw-semibold">REST API Framework</div>
                                    <small class="text-muted">Jersey REST /api/*</small>
                                </div>
                                <span class="badge bg-primary-subtle text-primary border px-2 py-1 rounded-pill small fw-semibold">
                                    ACTIVE
                                </span>
                            </div>

                            <div class="list-group-item d-flex justify-content-between align-items-center px-0 bg-transparent py-3">
                                <div>
                                    <div class="fw-semibold">Authentication</div>
                                    <small class="text-muted">HttpSession + SessionFilter</small>
                                </div>
                                <span class="badge bg-info-subtle text-info border px-2 py-1 rounded-pill small fw-semibold">
                                    PROTECTED
                                </span>
                            </div>

                            <div class="list-group-item d-flex justify-content-between align-items-center px-0 bg-transparent py-3">
                                <div>
                                    <div class="fw-semibold">Password Encryption</div>
                                    <small class="text-muted">PBKDF2 HMAC SHA-256</small>
                                </div>
                                <span class="badge bg-secondary-subtle text-dark border px-2 py-1 rounded-pill small fw-semibold">
                                    210k ITERATIONS
                                </span>
                            </div>

                            <div class="list-group-item d-flex justify-content-between align-items-center px-0 bg-transparent py-3">
                                <div>
                                    <div class="fw-semibold">Java Runtime</div>
                                    <small class="text-muted">Java 22 + Jakarta Servlet 6.0</small>
                                </div>
                                <span class="badge bg-dark text-white px-2 py-1 rounded-pill small fw-semibold">
                                    JDK 22
                                </span>
                            </div>
                        </div>
                    </div>
                </div>

            </div>

        </div>

    </section>

</main>

<!-- =========================
     ADD USER MODAL
========================== -->

<div class="modal fade" id="addUserModal" tabindex="-1"
     aria-labelledby="addUserModalLabel" aria-hidden="true">

    <div class="modal-dialog modal-dialog-centered">

        <div class="modal-content border-0 shadow">

            <div class="modal-header">

                <div>
                    <h5 class="modal-title fw-bold" id="addUserModalLabel">
                        Add New User
                    </h5>

                    <small class="text-muted">
                        Create a new application user
                    </small>
                </div>

                <button type="button"
                        class="btn-close"
                        data-bs-dismiss="modal">
                </button>

            </div>


            <form id="addUserForm">

                <div class="modal-body">

                    <!-- Name -->

                    <div class="mb-3">

                        <label for="userName" class="form-label fw-semibold">
                            Full Name
                        </label>

                        <input
                            type="text"
                            class="form-control"
                            id="userName"
                            name="name"
                            placeholder="Enter full name"
                            maxlength="100"
                            required>

                    </div>


                    <!-- Email -->

                    <div class="mb-3">

                        <label for="userEmail" class="form-label fw-semibold">
                            Email Address
                        </label>

                        <input
                            type="email"
                            class="form-control"
                            id="userEmail"
                            name="email"
                            placeholder="Enter email address"
                            maxlength="150"
                            required>

                    </div>


                    <!-- Password -->

                    <div class="mb-3">

                        <label for="userPassword" class="form-label fw-semibold">
                            Password
                        </label>

                        <input
                            type="password"
                            class="form-control"
                            id="userPassword"
                            name="password"
                            placeholder="Enter password"
                            required>

                        <div class="form-text">
                            Password will be securely hashed before database storage.
                        </div>

                    </div>


                    <div class="row">

                        <!-- Role -->

                        <div class="col-md-6 mb-3">

                            <label for="userRole" class="form-label fw-semibold">
                                Role
                            </label>

                            <select
                                class="form-select"
                                id="userRole"
                                name="role">

                                <option value="USER" selected>
                                    USER
                                </option>

                                <option value="ADMIN">
                                    ADMIN
                                </option>

                            </select>
                            <div id="addUserRoleHelp" class="form-text text-muted d-none mt-1"></div>

                        </div>


                        <!-- Status -->

                        <div class="col-md-6 mb-3">

                            <label for="userStatus" class="form-label fw-semibold">
                                Status
                            </label>

                            <select
                                class="form-select"
                                id="userStatus"
                                name="status">

                                <option value="ACTIVE" selected>
                                    ACTIVE
                                </option>

                                <option value="INACTIVE">
                                    INACTIVE
                                </option>

                            </select>

                        </div>

                    </div>


                    <!-- Error -->

                    <div id="addUserError"
                         class="alert alert-danger d-none mb-0">
                    </div>

                </div>


                <div class="modal-footer">

                    <button
                        type="button"
                        class="btn btn-light"
                        data-bs-dismiss="modal">

                        Cancel

                    </button>


                    <button
                        type="submit"
                        class="btn btn-primary"
                        id="createUserBtn">

                        <span id="createUserSpinner"
                              class="spinner-border spinner-border-sm d-none me-1">
                        </span>

                        Create User

                    </button>

                </div>

            </form>

        </div>

    </div>

</div>

<!-- =========================
     BOOTSTRAP JS
========================== -->

<!-- EDIT USER MODAL -->
<div class="modal fade" id="editUserModal" tabindex="-1"
     aria-labelledby="editUserModalLabel" aria-hidden="true">

    <div class="modal-dialog modal-dialog-centered">

        <div class="modal-content border-0 shadow">

            <div class="modal-header">

                <div>
                    <h5 class="modal-title fw-bold" id="editUserModalLabel">
                        Edit User
                    </h5>

                    <small class="text-muted">
                        Update user profile details
                    </small>
                </div>

                <button type="button"
                        class="btn-close"
                        data-bs-dismiss="modal">
                </button>

            </div>

            <form id="editUserForm">

                <input type="hidden" id="editUserId">

                <div class="modal-body">

                    <!-- Name -->

                    <div class="mb-3">

                        <label for="editUserName" class="form-label fw-semibold">
                            Full Name
                        </label>

                        <input
                            type="text"
                            class="form-control"
                            id="editUserName"
                            name="name"
                            placeholder="Enter full name"
                            maxlength="100"
                            required>

                    </div>


                    <!-- Email -->

                    <div class="mb-3">

                        <label for="editUserEmail" class="form-label fw-semibold">
                            Email Address
                        </label>

                        <input
                            type="email"
                            class="form-control"
                            id="editUserEmail"
                            name="email"
                            placeholder="Enter email address"
                            maxlength="150"
                            required>

                    </div>


                    <!-- Password -->

                    <div class="mb-3">

                        <label for="editUserPassword" class="form-label fw-semibold">
                            New Password (Optional)
                        </label>

                        <input
                            type="password"
                            class="form-control"
                            id="editUserPassword"
                            name="password"
                            placeholder="Leave blank to keep existing password">

                        <div class="form-text">
                            Password will be securely hashed with PBKDF2 if provided.
                        </div>

                    </div>


                    <div class="row">

                        <!-- Role -->

                        <div class="col-md-6 mb-3">

                            <label for="editUserRole" class="form-label fw-semibold">
                                Role
                            </label>

                            <select
                                class="form-select"
                                id="editUserRole"
                                name="role">

                                <option value="USER">USER</option>

                                <option value="ADMIN">ADMIN</option>

                            </select>
                            <div id="editUserRoleHelp" class="form-text text-muted d-none mt-1"></div>

                        </div>


                        <!-- Status -->

                        <div class="col-md-6 mb-3">

                            <label for="editUserStatus" class="form-label fw-semibold">
                                Status
                            </label>

                            <select
                                class="form-select"
                                id="editUserStatus"
                                name="status">

                                <option value="ACTIVE">ACTIVE</option>

                                <option value="INACTIVE">INACTIVE</option>

                            </select>

                        </div>

                    </div>


                    <!-- Error -->

                    <div id="editUserError"
                         class="alert alert-danger d-none mb-0">
                    </div>

                </div>


                <div class="modal-footer">

                    <button
                        type="button"
                        class="btn btn-light"
                        data-bs-dismiss="modal">

                        Cancel

                    </button>


                    <button
                        type="submit"
                        class="btn btn-primary"
                        id="updateUserBtn">

                        <span id="updateUserSpinner"
                              class="spinner-border spinner-border-sm d-none me-1">
                        </span>

                        Save Changes

                    </button>

                </div>

            </form>

        </div>

    </div>

</div>


<!-- DELETE CONFIRMATION MODAL -->
<div class="modal fade" id="deleteUserModal" tabindex="-1"
     aria-labelledby="deleteUserModalLabel" aria-hidden="true">

    <div class="modal-dialog modal-dialog-centered">

        <div class="modal-content border-0 shadow">

            <div class="modal-header">

                <h5 class="modal-title fw-bold text-danger" id="deleteUserModalLabel">
                    <i class="bi bi-exclamation-triangle-fill me-2"></i>Confirm Deletion
                </h5>

                <button type="button"
                        class="btn-close"
                        data-bs-dismiss="modal">
                </button>

            </div>

            <div class="modal-body">

                <p class="mb-2">Are you sure you want to delete <strong id="deleteUserNameText"></strong>?</p>
                <small class="text-muted">This action is permanent and cannot be undone.</small>

                <input type="hidden" id="deleteUserId">

                <div id="deleteUserError" class="alert alert-danger d-none mt-3 mb-0"></div>

            </div>

            <div class="modal-footer">

                <button
                    type="button"
                    class="btn btn-light"
                    data-bs-dismiss="modal">

                    Cancel

                </button>

                <button
                    type="button"
                    class="btn btn-danger"
                    id="confirmDeleteBtn">

                    <span id="deleteUserSpinner"
                          class="spinner-border spinner-border-sm d-none me-1">
                    </span>

                    Delete User

                </button>

            </div>

        </div>

    </div>

</div>


<!-- TOAST CONTAINER -->
<div class="toast-container position-fixed bottom-0 end-0 p-3" style="z-index: 1100;">
    <div id="appToast" class="toast align-items-center text-white border-0" role="alert" aria-live="assertive" aria-atomic="true">
        <div class="d-flex">
            <div class="toast-body fs-6" id="toastMessage"></div>
            <button type="button" class="btn-close btn-close-white me-2 m-auto" data-bs-dismiss="toast" aria-label="Close"></button>
        </div>
    </div>
</div>


<script
    src="https://cdn.jsdelivr.net/npm/bootstrap@5.3.3/dist/js/bootstrap.bundle.min.js">
</script>


<script>

    const contextPath = "${pageContext.request.contextPath}";
    const currentUserId = "${sessionScope.userId}";
    const currentUserRole = "${not empty sessionScope.userRole ? sessionScope.userRole : 'USER'}";
    const isCurrentAdmin = (currentUserRole.toUpperCase() === "ADMIN");

    let cachedUsers = [];
    let addUserModal;
    let editUserModal;
    let deleteUserModal;
    let appToast;

    $(document).ready(function() {

        addUserModal = new bootstrap.Modal(document.getElementById("addUserModal"));
        editUserModal = new bootstrap.Modal(document.getElementById("editUserModal"));
        deleteUserModal = new bootstrap.Modal(document.getElementById("deleteUserModal"));

        const toastEl = document.getElementById("appToast");
        if (toastEl) {
            appToast = new bootstrap.Toast(toastEl, { delay: 4000 });
        }

        loadUsers();

    });

    function showToast(message, isSuccess = true) {
        const toastEl = $("#appToast");
        toastEl.removeClass("bg-success bg-danger");
        toastEl.addClass(isSuccess ? "bg-success" : "bg-danger");
        $("#toastMessage").text(message);
        if (appToast) {
            appToast.show();
        }
    }


    /*
     * SIDEBAR NAVIGATION HANDLERS
     */

    $("#navDashboard").on("click", function(e) {
        e.preventDefault();
        $(".sidebar-link").removeClass("active");
        $(this).addClass("active");
        $("#settingsSection").addClass("d-none");
        $("#dashboardSection").removeClass("d-none");
        $("#topbarTitle").text("Dashboard");
        $("#topbarSubtitle").text("Manage your application users");
    });

    $("#navUsers").on("click", function(e) {
        e.preventDefault();
        $(".sidebar-link").removeClass("active");
        $(this).addClass("active");
        $("#settingsSection").addClass("d-none");
        $("#dashboardSection").removeClass("d-none");
        $("#topbarTitle").text("Dashboard");
        $("#topbarSubtitle").text("Manage your application users");
        $("html, body").animate({
            scrollTop: $("#users").offset().top - 20
        }, 300);
        $("#searchInput").focus();
    });

    $("#navSettings").on("click", function(e) {
        e.preventDefault();
        $(".sidebar-link").removeClass("active");
        $(this).addClass("active");
        $("#dashboardSection").addClass("d-none");
        $("#settingsSection").removeClass("d-none");
        $("#topbarTitle").text("Settings");
        $("#topbarSubtitle").text("Manage your account and system preferences");
        checkHealth();
    });

    function checkHealth() {
        $.ajax({
            url: contextPath + "/api/health",
            type: "GET",
            dataType: "json",
            success: function(res) {
                $("#systemDbStatus").html('<i class="bi bi-check-circle-fill me-1"></i>CONNECTED (' + (res.status || 'UP') + ')');
            },
            error: function() {
                $("#systemDbStatus").removeClass("badge-active").addClass("badge bg-danger text-white px-2 py-1 rounded-pill small").html('<i class="bi bi-exclamation-triangle-fill me-1"></i>DISCONNECTED');
            }
        });
    }


    /*
     * CHANGE PASSWORD IN SETTINGS
     */

    $("#changePasswordForm").on("submit", function(event) {
        event.preventDefault();

        const userId = "${sessionScope.userId}";
        const userName = "${not empty sessionScope.userName ? sessionScope.userName : 'User'}";
        const userEmail = "${not empty sessionScope.userEmail ? sessionScope.userEmail : ''}";
        const userRole = "${not empty sessionScope.userRole ? sessionScope.userRole : 'USER'}";
        const newPassword = $("#settingsNewPassword").val();
        const confirmPassword = $("#settingsConfirmPassword").val();

        $("#changePasswordAlert").addClass("d-none").removeClass("alert-danger alert-success").text("");

        if (!userId || userId === "") {
            $("#changePasswordAlert").addClass("alert-danger").removeClass("d-none").text("Session user ID not found. Please log in again.");
            return;
        }

        if (!newPassword || newPassword.length < 6) {
            $("#changePasswordAlert").addClass("alert-danger").removeClass("d-none").text("Password must be at least 6 characters long.");
            return;
        }

        if (newPassword !== confirmPassword) {
            $("#changePasswordAlert").addClass("alert-danger").removeClass("d-none").text("New password and confirm password do not match.");
            return;
        }

        $("#changePasswordBtn").prop("disabled", true);
        $("#changePasswordSpinner").removeClass("d-none");

        const payload = {
            id: parseInt(userId),
            name: userName,
            email: userEmail,
            passwordHash: newPassword,
            role: userRole,
            status: "ACTIVE"
        };

        $.ajax({
            url: contextPath + "/api/users/" + userId,
            type: "PUT",
            contentType: "application/json",
            dataType: "json",
            data: JSON.stringify(payload),

            success: function() {
                $("#settingsNewPassword").val("");
                $("#settingsConfirmPassword").val("");
                $("#changePasswordAlert").addClass("alert-success").removeClass("d-none").text("Password updated successfully!");
                showToast("Password updated successfully!", true);
            },

            error: function(xhr) {
                let msg = "Unable to update password.";
                if (xhr.responseJSON && (xhr.responseJSON.message || xhr.responseJSON.error)) {
                    msg = xhr.responseJSON.message || xhr.responseJSON.error;
                }
                $("#changePasswordAlert").addClass("alert-danger").removeClass("d-none").text(msg);
            },

            complete: function() {
                $("#changePasswordBtn").prop("disabled", false);
                $("#changePasswordSpinner").addClass("d-none");
            }
        });
    });


    /*
     * Load users via GET /api/users
     */

    function loadUsers() {

        $.ajax({

            url: contextPath + "/api/users",

            type: "GET",

            dataType: "json",

            success: function(users) {

                cachedUsers = users || [];

                renderUsers(users);

                updateStatistics(users);

            },

            error: function(xhr) {

                if (xhr.status === 401) {

                    window.location.href = contextPath + "/";

                    return;
                }

                $("#userTableBody").html(
                    '<tr>' +
                        '<td colspan="5" class="text-center text-danger py-5">' +
                            '<i class="bi bi-exclamation-triangle fs-3"></i>' +
                            '<div class="mt-2">' +
                                'Unable to load users. Please refresh or check connection.' +
                            '</div>' +
                        '</td>' +
                    '</tr>'
                );

            }

        });

    }


    /*
     * Render users into table
     */

    function renderUsers(users) {

        const tbody = $("#userTableBody");

        tbody.empty();

        if (!users || users.length === 0) {

            tbody.html(
                '<tr>' +
                    '<td colspan="5" class="text-center text-muted py-5">' +
                        '<i class="bi bi-people fs-2 d-block mb-2 text-secondary"></i>' +
                        'No users found in directory.' +
                    '</td>' +
                '</tr>'
            );

            return;
        }


        const adminCount = users.filter(function(u) {
            return u.role === "ADMIN";
        }).length;

        users.forEach(function(user) {

            const initial =
                user.name
                    ? escapeHtml(user.name.charAt(0).toUpperCase())
                    : "?";

            const safeName = escapeHtml(user.name);
            const safeEmail = escapeHtml(user.email);

            const createdDate =
                user.createdAt
                    ? formatDate(user.createdAt)
                    : "-";

            const roleBadge =
                user.role === "ADMIN"
                    ? '<span class="badge-role"><i class="bi bi-shield-lock-fill me-1"></i>ADMIN</span>'
                    : '<span class="badge bg-light text-dark border"><i class="bi bi-person me-1"></i>USER</span>';

            const statusBadge =
                user.status === "ACTIVE"
                    ? '<span class="badge-active"><i class="bi bi-check-circle-fill me-1"></i>ACTIVE</span>'
                    : '<span class="badge bg-secondary"><i class="bi bi-dash-circle-fill me-1"></i>INACTIVE</span>';

            const escapedJsName = safeName.replace(/'/g, "\\'");

            const isTargetAdmin = (user.role === "ADMIN");
            const isLastAdmin = isTargetAdmin && (adminCount <= 1);
            const isProtectedFromUser = isTargetAdmin && !isCurrentAdmin;

            let editButtonHtml = '';
            let deleteButtonHtml = '';

            if (isProtectedFromUser) {
                editButtonHtml =
                    '<button class="action-btn text-secondary" disabled title="Regular users cannot edit administrator accounts" style="opacity: 0.45; cursor: not-allowed;">' +
                        '<i class="bi bi-lock-fill"></i>' +
                    '</button>';

                deleteButtonHtml =
                    '<button class="action-btn text-secondary" disabled title="Regular users cannot delete administrator accounts" style="opacity: 0.45; cursor: not-allowed;">' +
                        '<i class="bi bi-shield-x"></i>' +
                    '</button>';
            } else {
                editButtonHtml =
                    '<button class="action-btn text-primary" title="Edit User" onclick="editUser(' + user.id + ')">' +
                        '<i class="bi bi-pencil"></i>' +
                    '</button>';

                if (isLastAdmin) {
                    deleteButtonHtml =
                        '<button class="action-btn text-warning" disabled title="Cannot delete the last remaining administrator (System must always have at least 1 admin)" style="opacity: 0.6; cursor: not-allowed;">' +
                            '<i class="bi bi-shield-lock-fill"></i>' +
                        '</button>';
                } else {
                    deleteButtonHtml =
                        '<button class="action-btn text-danger" title="Delete User" onclick="deleteUser(' + user.id + ', \'' + escapedJsName + '\')">' +
                            '<i class="bi bi-trash"></i>' +
                        '</button>';
                }
            }

            tbody.append(
                '<tr>' +
                    '<td>' +
                        '<div class="user-info">' +
                            '<div class="user-avatar">' + initial + '</div>' +
                            '<div>' +
                                '<div class="user-name">' + safeName + '</div>' +
                                '<div class="user-email">' + safeEmail + '</div>' +
                            '</div>' +
                        '</div>' +
                    '</td>' +
                    '<td>' + roleBadge + '</td>' +
                    '<td>' + statusBadge + '</td>' +
                    '<td>' + createdDate + '</td>' +
                    '<td class="text-end">' +
                        editButtonHtml +
                        deleteButtonHtml +
                    '</td>' +
                '</tr>'
            );

        });

    }


    /*
     * Dashboard statistics
     */

    function updateStatistics(users) {

        $("#totalUsers").text(users.length);

        const active =
            users.filter(function(user) {
                return user.status === "ACTIVE";
            }).length;

        const admins =
            users.filter(function(user) {
                return user.role === "ADMIN";
            }).length;

        $("#activeUsers").text(active);

        $("#adminUsers").text(admins);

    }


    /*
     * Date formatting
     */

    function formatDate(dateValue) {

        let date;

        if (Array.isArray(dateValue)) {

            date = new Date(
                dateValue[0],
                dateValue[1] - 1,
                dateValue[2],
                dateValue[3] || 0,
                dateValue[4] || 0
            );

        } else {

            date = new Date(dateValue);

        }

        if (isNaN(date.getTime())) {
            return "-";
        }

        return date.toLocaleDateString(
            "en-IN",
            {
                day: "2-digit",
                month: "short",
                year: "numeric"
            }
        );

    }


    /*
     * Prevent HTML injection
     */

    function escapeHtml(value) {

        if (value === null || value === undefined) {
            return "";
        }

        return $("<div>")
            .text(value)
            .html();

    }


    /*
     * EDIT USER - Load existing user with GET /api/users/{id}
     */

    function editUser(id) {

        const targetUser = cachedUsers.find(function(u) { return u.id === id; });

        // Condition 2: Regular user accounts cannot edit administrator details
        if (targetUser && targetUser.role === "ADMIN" && !isCurrentAdmin) {
            showToast("Permission denied: Regular users cannot edit administrator accounts.", false);
            return;
        }

        $("#editUserForm")[0].reset();
        $("#editUserError").addClass("d-none").text("");

        $.ajax({
            url: contextPath + "/api/users/" + id,
            type: "GET",
            dataType: "json",

            success: function(user) {
                $("#editUserId").val(user.id);
                $("#editUserName").val(user.name);
                $("#editUserEmail").val(user.email);
                $("#editUserPassword").val("");
                $("#editUserRole").val(user.role || "USER");
                $("#editUserStatus").val(user.status || "ACTIVE");

                const adminCount = cachedUsers.filter(function(u) { return u.role === "ADMIN"; }).length;
                const isTargetLastAdmin = (user.role === "ADMIN" && adminCount <= 1);

                if (!isCurrentAdmin) {
                    // Regular user cannot change account roles
                    $("#editUserRole").prop("disabled", true);
                    $("#editUserRoleHelp").removeClass("d-none").text("Regular users cannot modify account roles.");
                } else if (isTargetLastAdmin) {
                    // Cannot demote the last remaining admin
                    $("#editUserRole").prop("disabled", true);
                    $("#editUserRoleHelp").removeClass("d-none").text("Cannot demote the last remaining administrator account.");
                    $("#editUserStatus").find("option[value='INACTIVE']").prop("disabled", true);
                } else {
                    $("#editUserRole").prop("disabled", false);
                    $("#editUserRoleHelp").addClass("d-none").text("");
                    $("#editUserStatus").find("option[value='INACTIVE']").prop("disabled", false);
                }

                editUserModal.show();
            },

            error: function(xhr) {
                let msg = "Unable to fetch user details.";
                if (xhr.responseJSON && (xhr.responseJSON.message || xhr.responseJSON.error)) {
                    msg = xhr.responseJSON.message || xhr.responseJSON.error;
                }
                showToast(msg, false);
            }
        });

    }


    /*
     * UPDATE USER - PUT /api/users/{id}
     */

    $("#editUserForm").on("submit", function(event) {

        event.preventDefault();

        const id = $("#editUserId").val();
        const targetUser = cachedUsers.find(function(u) { return u.id == id; });

        // Condition 2 check
        if (targetUser && targetUser.role === "ADMIN" && !isCurrentAdmin) {
            $("#editUserError").removeClass("d-none").text("Permission denied: Regular users cannot edit administrator accounts.");
            return;
        }

        const name = $("#editUserName").val().trim();
        const email = $("#editUserEmail").val().trim();
        const password = $("#editUserPassword").val();
        let role = $("#editUserRole").val();
        if (!role && targetUser) {
            role = targetUser.role;
        }
        const status = $("#editUserStatus").val();

        $("#editUserError").addClass("d-none").text("");

        if (!name || !email) {
            $("#editUserError").removeClass("d-none").text("Name and email are required fields.");
            return;
        }

        if (password && password.length < 6) {
            $("#editUserError").removeClass("d-none").text("Password must be at least 6 characters long.");
            return;
        }

        const userData = {
            id: parseInt(id),
            name: name,
            email: email,
            passwordHash: password ? password : null,
            role: role,
            status: status
        };

        $("#updateUserBtn").prop("disabled", true);
        $("#updateUserSpinner").removeClass("d-none");

        $.ajax({
            url: contextPath + "/api/users/" + id,
            type: "PUT",
            contentType: "application/json",
            dataType: "json",
            data: JSON.stringify(userData),

            success: function(response) {
                editUserModal.hide();
                showToast("User updated successfully!", true);
                loadUsers();
            },

            error: function(xhr) {
                let message = "Unable to update user.";
                if (xhr.responseJSON && (xhr.responseJSON.message || xhr.responseJSON.error)) {
                    message = xhr.responseJSON.message || xhr.responseJSON.error;
                }
                $("#editUserError").removeClass("d-none").text(message);
            },

            complete: function() {
                $("#updateUserBtn").prop("disabled", false);
                $("#updateUserSpinner").addClass("d-none");
            }
        });

    });


    /*
     * DELETE USER - Open confirmation modal
     */

    function deleteUser(id, userName) {

        const targetUser = cachedUsers.find(function(u) { return u.id === id; });

        // Condition 2: Regular user accounts cannot delete administrator accounts
        if (targetUser && targetUser.role === "ADMIN" && !isCurrentAdmin) {
            showToast("Permission denied: Regular users cannot delete administrator accounts.", false);
            return;
        }

        // Condition 1: Check whether it's the last admin
        const adminCount = cachedUsers.filter(function(u) { return u.role === "ADMIN"; }).length;
        if (targetUser && targetUser.role === "ADMIN" && adminCount <= 1) {
            showToast("Cannot delete the last remaining administrator account. There must always be at least one admin in the dashboard.", false);
            return;
        }

        $("#deleteUserId").val(id);
        $("#deleteUserNameText").text(userName);
        $("#deleteUserError").addClass("d-none").text("");

        deleteUserModal.show();

    }


    /*
     * CONFIRM DELETE - DELETE /api/users/{id}
     */

    $("#confirmDeleteBtn").on("click", function() {

        const id = $("#deleteUserId").val();

        if (!id) return;

        const targetUser = cachedUsers.find(function(u) { return u.id == id; });

        if (targetUser && targetUser.role === "ADMIN" && !isCurrentAdmin) {
            $("#deleteUserError").removeClass("d-none").text("Permission denied: Regular users cannot delete administrator accounts.");
            return;
        }

        const adminCount = cachedUsers.filter(function(u) { return u.role === "ADMIN"; }).length;
        if (targetUser && targetUser.role === "ADMIN" && adminCount <= 1) {
            $("#deleteUserError").removeClass("d-none").text("Cannot delete the last remaining administrator account. There must always be at least one admin in the dashboard.");
            return;
        }

        $("#confirmDeleteBtn").prop("disabled", true);
        $("#deleteUserSpinner").removeClass("d-none");
        $("#deleteUserError").addClass("d-none").text("");

        $.ajax({
            url: contextPath + "/api/users/" + id,
            type: "DELETE",
            dataType: "json",

            success: function(response) {
                deleteUserModal.hide();
                showToast("User deleted successfully!", true);
                loadUsers();
            },

            error: function(xhr) {
                let message = "Unable to delete user.";
                if (xhr.responseJSON && (xhr.responseJSON.message || xhr.responseJSON.error)) {
                    message = xhr.responseJSON.message || xhr.responseJSON.error;
                }
                $("#deleteUserError").removeClass("d-none").text(message);
            },

            complete: function() {
                $("#confirmDeleteBtn").prop("disabled", false);
                $("#deleteUserSpinner").addClass("d-none");
            }
        });

    });


    /*
     * Search filter by name / email / role / status
     */

    $("#searchInput").on("keyup", function() {

        const search = $(this).val().toLowerCase().trim();
        let visibleCount = 0;

        $("#userTableBody tr").each(function() {

            // Skip empty/error row
            if ($(this).find("td").length === 1) {
                return;
            }

            const rowText = $(this).text().toLowerCase();

            const isMatch = rowText.indexOf(search) !== -1;
            $(this).toggle(isMatch);

            if (isMatch) {
                visibleCount++;
            }

        });

        if (visibleCount === 0 && search.length > 0) {
            if ($("#noSearchMatchRow").length === 0) {
                $("#userTableBody").append(
                    '<tr id="noSearchMatchRow">' +
                        '<td colspan="5" class="text-center text-muted py-4">' +
                            'No users match search criteria "' + escapeHtml(search) + '".' +
                        '</td>' +
                    '</tr>'
                );
            }
        } else {
            $("#noSearchMatchRow").remove();
        }

    });


    /*
     * ADD USER - Open modal
     */

    $("#addUserBtn").on("click", function() {

        $("#addUserForm")[0].reset();

        $("#userRole").val("USER");

        if (!isCurrentAdmin) {
            $("#userRole option[value='ADMIN']").prop("disabled", true);
            $("#addUserRoleHelp").removeClass("d-none").text("Only administrators can create admin accounts.");
        } else {
            $("#userRole option[value='ADMIN']").prop("disabled", false);
            $("#addUserRoleHelp").addClass("d-none").text("");
        }

        $("#userStatus").val("ACTIVE");

        $("#addUserError")
            .addClass("d-none")
            .text("");

        addUserModal.show();

    });


    /*
     * CREATE USER - POST /api/users
     */

    $("#addUserForm").on("submit", function(event) {

        event.preventDefault();

        const name = $("#userName").val().trim();
        const email = $("#userEmail").val().trim();
        const password = $("#userPassword").val();
        const role = $("#userRole").val();
        const status = $("#userStatus").val();

        $("#addUserError").addClass("d-none").text("");

        if (!isCurrentAdmin && role === "ADMIN") {
            $("#addUserError")
                .removeClass("d-none")
                .text("Permission denied: Regular users cannot create administrator accounts.");
            return;
        }

        if (!name || !email || !password) {
            $("#addUserError")
                .removeClass("d-none")
                .text("Please fill in all required fields (Name, Email, Password).");
            return;
        }

        if (password.length < 6) {
            $("#addUserError")
                .removeClass("d-none")
                .text("Password must be at least 6 characters long.");
            return;
        }

        const userData = {
            name: name,
            email: email,
            passwordHash: password,
            role: role,
            status: status
        };

        /*
         * Show loading state
         */

        $("#createUserBtn").prop("disabled", true);
        $("#createUserSpinner").removeClass("d-none");


        /*
         * Send AJAX request
         */

        $.ajax({

            url: contextPath + "/api/users",

            type: "POST",

            contentType: "application/json",

            dataType: "json",

            data: JSON.stringify(userData),


            success: function(response) {

                /*
                 * Close modal
                 */

                addUserModal.hide();

                showToast("User created successfully!", true);

                /*
                 * Reload users from database
                 */

                loadUsers();

            },


            error: function(xhr) {

                let message = "Unable to create user.";

                if (xhr.responseJSON && (xhr.responseJSON.message || xhr.responseJSON.error)) {
                    message = xhr.responseJSON.message || xhr.responseJSON.error;
                }

                $("#addUserError")
                    .removeClass("d-none")
                    .text(message);

            },


            complete: function() {

                $("#createUserBtn").prop("disabled", false);

                $("#createUserSpinner").addClass("d-none");

            }

        });

    });


    /*
     * Logout
     */

    $("#logoutBtn").on("click", function(event) {

        event.preventDefault();

        $.ajax({

            url: contextPath + "/api/auth/logout",

            type: "GET",

            success: function() {

                window.location.href = contextPath + "/";

            },

            error: function() {

                window.location.href = contextPath + "/";

            }

        });

    });

</script>

</body>
</html>