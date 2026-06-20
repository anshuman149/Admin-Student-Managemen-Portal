<%@ page language="java" contentType="text" pageEncoding="UTF-8"%>
<!DOCTYPE html>
<html lang="en">
<head>
    <meta charset="UTF-8">
    <title>Reset Password - Student Portal</title>
    <style>
        body { font-family: 'Segoe UI', sans-serif; background-color: #f4f9f5; display: flex; justify-content: center; align-items: center; height: 100vh; margin: 0; }
        .reset-container { background: #fff; padding: 40px; border-radius: 8px; box-shadow: 0 4px 15px rgba(0,0,0,0.1); width: 100%; max-width: 400px; text-align: center; border-top: 5px solid #28a745; }
        .form-group { text-align: left; margin-bottom: 20px; }
        .form-group label { display: block; margin-bottom: 8px; font-weight: 500; }
        .form-group input { width: 100%; padding: 12px; border: 1px solid #ccc; border-radius: 4px; box-sizing: border-box; }
        .btn-update { background-color: #28a745; color: white; padding: 12px; border: none; border-radius: 4px; width: 100%; cursor: pointer; font-weight: bold; }
        .btn-update:hover { background-color: #218838; }
    </style>
</head>
<body>
    <div class="reset-container">
        <h2>Reset Password</h2>
        <p>Please enter your new password below.</p>
        <form action="ResetPasswordServlet" method="post">
            <div class="form-group">
                <label>New Password</label>
                <input type="password" name="newPassword" required>
            </div>
            <div class="form-group">
                <label>Confirm Password</label>
                <input type="password" name="confirmPassword" required>
            </div>
            <button type="submit" class="btn-update">Update Password</button>
        </form>
    </div>
</body>
</html>