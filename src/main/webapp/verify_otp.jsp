<%@ page language="java" contentType="text" pageEncoding="UTF-8"%>
<!DOCTYPE html>
<html lang="en">
<head>
    <meta charset="UTF-8">
    <meta name="viewport" content="width=device-width, initial-scale=1.0">
    <title>Verify OTP - Student Portal</title>
    <style>
        body {
            font-family: 'Segoe UI', Tahoma, Geneva, Verdana, sans-serif;
            background-color: #f4f9f5; 
            display: flex;
            justify-content: center;
            align-items: center;
            height: 100vh;
            margin: 0;
        }
        .otp-container {
            background-color: #ffffff;
            padding: 40px;
            border-radius: 8px;
            box-shadow: 0 4px 15px rgba(0, 0, 0, 0.1);
            width: 100%;
            max-width: 400px;
            text-align: center;
            border-top: 5px solid #28a745; 
        }
        .otp-container h2 {
            color: #333333;
            margin-bottom: 10px;
        }
        .otp-container p {
            color: #666666;
            font-size: 14px;
            margin-bottom: 25px;
            line-height: 1.5;
        }
        .error-msg {
            color: #d9534f;
            background-color: #f2dede;
            padding: 10px;
            border-radius: 4px;
            font-size: 13px;
            margin-bottom: 20px;
            border: 1px solid #ebccd1;
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
            font-size: 18px;
            letter-spacing: 4px;
            text-align: center;
        }
        .form-group input:focus {
            border-color: #28a745; 
            outline: none;
            box-shadow: 0 0 5px rgba(40, 167, 69, 0.3); 
        }
        .btn-submit {
            background-color: #28a745; 
            color: white;
            padding: 12px 20px;
            border: none;
            border-radius: 4px;
            cursor: pointer;
            width: 100%;
            font-size: 16px;
            font-weight: bold;
            transition: background-color 0.3s;
            margin-bottom: 15px;
        }
        .btn-submit:hover {
            background-color: #218838; 
        }
        .resend-link {
            color: #28a745;
            text-decoration: none;
            font-size: 14px;
            font-weight: 500;
        }
        .resend-link:hover {
            text-decoration: underline;
        }
    </style>
</head>
<body>

    <div class="otp-container">
        <h2>Verify OTP</h2>
        <p>A 6-digit OTP has been sent to your registered email address. Please enter it below to proceed.</p>

        <%-- Display error if the OTP is incorrect --%>
        <% 
            String error = request.getParameter("error");
            if(error != null && error.equals("wrong_otp")) { 
        %>
            <div class="error-msg">Invalid OTP! Please enter the correct code.</div>
        <% } %>

        <form action="VerifyOTPServlet" method="post">
            <div class="form-group">
                <label for="otp">Enter 6-Digit OTP</label>
                <input type="text" id="otp" name="otp" placeholder="XXXXXX" maxlength="6" required autofocus>
            </div>
            
            <button type="submit" class="btn-submit">Verify OTP</button>
        </form>

       <!-- Link ko ek span ya div mein rakho taaki hum timer dikha sakein -->
<p id="resend-container" style="font-size: 13px; color: #666;">
    Didn't receive the OTP? 
    <span id="timer-text">Wait <span id="seconds">60</span>s to Resend</span>
    <a href="ForgotPasswordServlet?resend=true" id="resend-link" class="resend-link" style="display: none;">Resend OTP</a>
</p>
    </div>
<script>
    let timeLeft = 60; // 60 seconds ka timer
    let timerElement = document.getElementById('seconds');
    let timerText = document.getElementById('timer-text');
    let resendLink = document.getElementById('resend-link');

    let countdown = setInterval(function() {
        timeLeft--;
        timerElement.innerText = timeLeft;

        if (timeLeft <= 0) {
            clearInterval(countdown);
            timerText.style.display = 'none'; // Timer hide kar do
            resendLink.style.display = 'inline'; // Resend link show kar do
        }
    }, 1000);
</script>
</body>

</html>