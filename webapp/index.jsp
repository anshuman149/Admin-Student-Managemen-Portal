<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>
<%
    // 1. SESSION CHECK (Isse mat hatana, ye dashboard ke liye zaroori hai)
    if(session.getAttribute("fullName") != null) {
        response.sendRedirect("dashboard.jsp");
        return; 
    }

    // 2. CACHE CONTROL (Security ke liye zaroori hai)
    response.setHeader("Cache-Control", "no-cache, no-store, must-revalidate"); 
    response.setHeader("Pragma", "no-cache"); 
    response.setDateHeader("Expires", 0); 
%>

<%
    // 3. SMART MESSAGE LOGIC (Ab sirf ek hi patti dikhegi)
    String msg = request.getParameter("msg");
    String loginErr = request.getParameter("error");

    if("Done".equals(msg)) { 
%>
    <div style="color: #155724; background-color: #d4edda; border: 1px solid #c3e6cb; padding: 10px; text-align: center; font-weight: bold;">
        ✅ Registration Successful! Admin approval pending.
    </div>
<% 
    } else if("Account_Pending_Approval".equals(msg)) { 
%>
    <div style="color: #856404; background-color: #fff3cd; padding: 12px; text-align: center; border-bottom: 2px solid #ffeeba; font-weight: bold;">
        ⚠️ Status: Under Pending!<br>
        <span style="font-weight: normal; font-size: 13px;">Aapka registration verification ke liye gaya hai. Approval ke baad hi login ho payega.</span>
    </div>
<% 
    }

    if("Invalid_Credentials".equals(loginErr)) { 
%>
    <div style="color: #721c24; background-color: #f8d7da; padding: 12px; border-radius: 5px; text-align: center; border: 1px solid #f5c6cb; font-weight: bold;">
        ❌ Login Failed!<br>
        <span style="font-weight: normal; font-size: 13px;">Invalid Id or Password.</span>
    </div>
<% } %>

<!DOCTYPE html>
<html lang="en">
<head>
    <meta charset="UTF-8">
    <title>Student Portal | Login</title>
    <link rel="stylesheet" href="style.css">
    <script type="text/javascript">
    function preback() { window.history.forward(); }
    setTimeout("preback()", 0);
    window.onunload = function () { null };
</script>
</head>
<body style="margin: 0; padding: 0; font-family: Arial, sans-serif; text-align: center; background-color: #f4f4f4;">

    <header style="background-color: #5cb85c; color: white; padding: 25px 0; position: relative;">
        <h1 style="margin: 0;">Welcome to the Student Portal</h1>
        <button class="notice-btn" style="position: absolute; right: 20px; top: 25px; background: #4cae4c; border: 1px solid white; color: white; padding: 5px 10px; cursor: pointer;">Public Notice</button>
    </header>   
    
    <hr style="margin: 0; border: 0; height: 1px; background: #eee;">

    <div class="logo-container" style="margin: 30px auto;">
        <img src="${pageContext.request.contextPath}/images/university.png" alt="University Logo" style="width: 140px;">
    </div>

    <div class="info" style="margin-top: 20px;">
        <h2 style="text-transform: capitalize; margin-bottom: 25px;">Login Page</h2>
        
        <form action="LoginServlet" method="post">
            
            <div style="display: flex; align-items: center; justify-content: center; gap: 15px; margin-bottom: 15px;">
                <label style="font-weight: bold; width: 160px; text-align: right;">Enrollment Number</label>
                <input type="text" name="enrollID" placeholder="Enter Enrollment Number" required 
                       style="padding: 10px; width: 250px; border: 1px solid #ccc; border-radius: 4px;">
            </div>

            <div style="display: flex; align-items: center; justify-content: center; gap: 15px; margin-bottom: 25px;">
                <label style="font-weight: bold; width: 160px; text-align: right;">Password</label>
                <input type="password" name="pass" placeholder="Enter Password" required 
                       style="padding: 10px; width: 250px; border: 1px solid #ccc; border-radius: 4px;">
            </div>

            <div class="buttons" style="display: flex; justify-content: center; gap: 15px; margin-bottom: 15px;">
                <button type="submit" class="login-btn" onclick="location.href='index.jsp'"
                        style="background-color: #5cb85c; color: white; border: none; padding: 10px 30px; border-radius: 4px; cursor: pointer; font-weight: bold;">
                    Login
                </button>
                <button type="button" class="signup-btn" onclick="location.href='signup.jsp'"
                        style="background-color: #5cb85c; color: white; border: none; padding: 10px 30px; border-radius: 4px; cursor: pointer; font-weight: bold;">
                    Sign Up
                </button>
            </div>

            <div class="reset-btn">
                <button type="button" class="reset" onclick="location.href='forgor_passsword.jsp'"
                        style="background-color: #5cb85c; color: white; border: none; padding: 10px; width: 440px; border-radius: 4px; cursor: pointer; font-weight: bold;">
                    Reset Password
                </button>
            </div>
            
        </form>
    </div>

    <footer style="background-color: #5cb85c; color: white; padding: 15px 0; position: fixed; bottom: 0; width: 100%; display: flex; justify-content: center; align-items: center;">
        <p style="margin: 0;">Copyright &copy; 2026 Student Portal. All rights reserved.</p>
        <button class="contact-btn" onclick="location.href='teacher_login.jsp'"style="position: absolute; right: 20px; background: #4cae4c; border: 1px solid white; color: white; padding: 5px 10px; cursor: pointer;">Teacher Portal</button>
    </footer>

</body>


</html>