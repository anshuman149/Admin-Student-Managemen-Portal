<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>
<!DOCTYPE html>
<html lang="en">
<head>
    <meta charset="UTF-8">
    <meta name="viewport" content="width=device-width, initial-scale=1.0">
    <title>Teacher Portal | Secure Access</title>
    <link href="https://fonts.googleapis.com/css2?family=Segoe+UI:wght@400;600&family=Roboto:wght@300;400;500&display=swap" rel="stylesheet">
    <style>
        :root {
            --primary-blue: #0d47a1; /* Deep Professional Blue */
            --secondary-blue: #1565c0;
            --bg-grey: #eceff1;      /* Light Blue-Grey Background */
            --text-grey: #455a64;    /* Slate Grey for text */
            --white: #ffffff;
            --error-red: #d32f2f;
        }

        body {
            font-family: 'Segoe UI', Tahoma, Geneva, Verdana, sans-serif;
            background-color: var(--bg-grey);
            margin: 0;
            display: flex;
            justify-content: center;
            align-items: center;
            height: 100vh;
        }

        .login-container {
            background-color: var(--white);
            width: 100%;
            max-width: 400px;
            padding: 0;
            border-radius: 12px;
            box-shadow: 0 10px 25px rgba(0,0,0,0.1);
            overflow: hidden;
        }

        .login-header {
            background-color: var(--primary-blue);
            color: var(--white);
            padding: 30px;
            text-align: center;
        }

        .login-header h2 {
            margin: 0;
            font-weight: 600;
            letter-spacing: 1px;
            text-transform: uppercase;
            font-size: 22px;
        }

        .login-header p {
            margin: 10px 0 0;
            font-size: 14px;
            opacity: 0.8;
        }

        .login-form {
            padding: 40px 30px;
        }

        .form-group {
            margin-bottom: 25px;
        }

        .form-group label {
            display: block;
            margin-bottom: 8px;
            color: var(--text-grey);
            font-weight: 500;
            font-size: 14px;
        }

        .form-group input {
            width: 100%;
            padding: 12px 15px;
            border: 2px solid #cfd8dc;
            border-radius: 6px;
            font-size: 16px;
            transition: all 0.3s ease;
            box-sizing: border-box;
            outline: none;
        }

        .form-group input:focus {
            border-color: var(--secondary-blue);
            box-shadow: 0 0 8px rgba(21, 101, 192, 0.2);
        }

        .btn-login {
            width: 100%;
            padding: 14px;
            background-color: var(--primary-blue);
            color: var(--white);
            border: none;
            border-radius: 6px;
            font-size: 16px;
            font-weight: 600;
            cursor: pointer;
            transition: background 0.3s ease;
            margin-top: 10px;
        }

        .btn-login:hover {
            background-color: var(--secondary-blue);
        }

        .error-msg {
            background-color: #ffebee;
            color: var(--error-red);
            padding: 12px;
            border-radius: 4px;
            margin-bottom: 20px;
            font-size: 14px;
            text-align: center;
            border: 1px solid #ffcdd2;
        }

        .footer {
            text-align: center;
            padding: 20px;
            font-size: 12px;
            color: #90a4ae;
            background-color: #f8f9fa;
        }
    </style>
</head>
<body>

<div class="login-container">
    <div class="login-header">
        <h2>Teacher Portal</h2>
        <p>Administrative Secure Gateway</p>
    </div>

    <div class="login-form">
        <% 
            String error = request.getParameter("error");
            if(error != null && error.equals("1")) { 
        %>
            <div class="error-msg">
                Access Denied: Invalid Credentials.
            </div>
        <% } %>

        <form action="TeacherLoginServlet" method="POST">
            <div class="form-group">
                <label for="username">Username</label>
                <input type="text" id="username" name="username" placeholder="Enter teacher ID" required>
            </div>
            
            <div class="form-group">
                <label for="password">Password</label>
                <input type="password" id="password" name="password" placeholder="Enter secure password" required>
            </div>

            <button type="submit" class="btn-login">Verify & Access Portal</button>
        </form>
    </div>

    <div class="footer">
        © 2024 Student Management System | Authorized Personnel Only
    </div>
</div>

</body>
</html>