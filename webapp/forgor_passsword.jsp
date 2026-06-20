<%@ page language="java" contentType="text" pageEncoding="UTF-8"%>
<!DOCTYPE html>
<html lang="en">
<head>
    <meta charset="UTF-8">
    <meta name="viewport" content="width=device-width, initial-scale=1.0">
    <title>Forgot Password - Student Portal</title>
    <style>
        body {
            font-family: 'Segoe UI', Tahoma, Geneva, Verdana, sans-serif;
            background-color: #f4f9f5; /* Thoda sa light greenish-gray background */
            display: flex;
            justify-content: center;
            align-items: center;
            height: 100vh;
            margin: 0;
        }
        .forgot-password-container {
            background-color: #ffffff;
            padding: 40px;
            border-radius: 8px;
            box-shadow: 0 4px 15px rgba(0, 0, 0, 0.1);
            width: 100%;
            max-width: 400px;
            text-align: center;
            border-top: 5px solid #28a745; /* Upar ek green line design ke liye */
        }
        .forgot-password-container h2 {
            color: #333333;
            margin-bottom: 10px;
        }
        .forgot-password-container p {
            color: #666666;
            font-size: 14px;
            margin-bottom: 25px;
            line-height: 1.5;
        }
        .form-group {
            text-align: left;
            margin-bottom: 20px;
        }
        .form-group label {
            display: block;
            color: #333333;
            font-weight: 500;
            margin-bottom: 8px;
        }
        .form-group input {
            width: 100%;
            padding: 12px;
            border: 1px solid #cccccc;
            border-radius: 4px;
            box-sizing: border-box;
            font-size: 14px;
        }
        .form-group input:focus {
            border-color: #28a745; /* Green border on focus */
            outline: none;
            box-shadow: 0 0 5px rgba(40, 167, 69, 0.3); /* Greenish glow */
        }
        .btn-submit {
            background-color: #28a745; /* Professional Green */
            color: white;
            padding: 12px 20px;
            border: none;
            border-radius: 4px;
            cursor: pointer;
            width: 100%;
            font-size: 16px;
            font-weight: bold;
            transition: background-color 0.3s;
        }
        .btn-submit:hover {
            background-color: #218838; /* Darker green on hover */
        }
        .back-link {
            display: block;
            margin-top: 20px;
            color: #28a745; /* Green link */
            text-decoration: none;
            font-size: 14px;
            font-weight: 500;
        }
        .back-link:hover {
            color: #1e7e34;
            text-decoration: underline;
        }
    </style>
</head>
<body>

    <div class="forgot-password-container">
        <h2>Forgot Your Password?</h2>
        <p>Enter your username below and we will send a password reset OTP to your registered email address.</p>

        <form action="ForgotPasswordServlet" method="post">
            <div class="form-group">
                <label for="enrollment_no">Enrollment Number</label>
               <input type="text" id="enrollment_no" name="enrollment_no" placeholder="Enter your Enrollment Number" required>
            </div>
            
            <button type="submit" class="btn-submit">Send OTP</button>
        </form>
        
        <a href="index.jsp" class="back-link">Back to Login</a>
    </div>

</body>
</html>