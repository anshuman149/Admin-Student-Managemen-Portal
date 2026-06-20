<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>
<!DOCTYPE html>
<html lang="en">
<head>
    <meta charset="UTF-8">
    <meta name="viewport" content="width=device-width, initial-scale=1.0">
    <title>Student Registration | IGNOU Portal</title>
    
    <link rel="stylesheet" type="text/css" href="${pageContext.request.contextPath}/style.css">
</head>
<body>

    <header>
        <h3>Sign Up Page</h3>
        <button class="sign-contact-btn">Contact Us</button>
    </header>

    <div class="gen-instruction">
        <h4>Registration Instructions for Students</h4>
        <div class="instructions">
            <p>1. Fill out the registration form with accurate information.</p>
            <p>2. Create a strong password for account security.</p>
            <h6>Nb: Please ensure all information provided is accurate and up-to-date.</h6>
        </div>
    </div>

    <form action="preview.jsp" method="post" class="sign-up-form">
        <div class="form-details">
            <h3 style="text-align: center; color: #4CAF50;">Student Registration Form</h3>

            <div class="form-body-wrapper">
                <div class="personal-details">
                    <h4>Personal Details</h4>
                    <div class="input-group">
                        <label>Full Name</label>
                        <input type="text" name="fullName" placeholder="Enter full name" required>
                    </div>
                    <div class="input-group">
                        <label>Email ID</label>
                        <input type="email" name="email" placeholder="Enter email address" required>
                    </div>
                    <div class="input-group">
                        <label>Phone Number</label>
                        <input type="text" name="phone" placeholder="Enter phone number">
                    </div>
                </div>

                <div class="academic-details">
                    <h4>Academic Details</h4>
                   <div class="input-group">
    <label>Enrollment Number</label>
    <div style="display: flex; gap: 10px;">
        <input type="text" name="enrollmentNo" id="enroll-input" placeholder="Enter Enrollment No" required>
        <button type="button" onclick="checkEnrollment()" style="padding: 5px 12px; background: #4CAF50; color: white; border: none; border-radius: 4px; cursor: pointer;">
            Check
        </button>
    </div>
    <span id="statusMsg" style="display:block; margin-top:5px; font-size:13px; font-weight: bold;"></span>
</div>
                    <div class="input-group">
                    <style> 
                    .input-group select {
    width: 100%;
    padding: 10px; 
    border: 1px solid #ccc;
    border-radius: 4px;
    box-sizing: border-box;
    font-size: 15px;
    background-color: white;
    cursor: pointer;
    height: 42px; /* Exact height match karne ke liye */
}

/* Jab uspe click karein toh border green ho jaye */
.input-group select:focus {
    border-color: #4CAF50;
    outline: none;
}</style>
                        <label>Course Name</label>
                        <select name="course" required>
                            <option value="">Select Course</option>
                            <option value="BCA">BCA</option>
                            <option value="BTech">BTech</option>
                            <option value="BCom">BCom</option>
                        </select>
                    </div>
                    <div class="input-group">
                        <label>Password</label>
                        <input type="password" name="password" placeholder="Create Password" required>
                    </div>
                </div>
            </div>

            <div class="address-section">
                <h4>Communication Address</h4>
                <div class="input-group">
                    <label>Permanent Address</label>
                    <input type="text" name="address" placeholder="Enter your full address here..." style="width: 100%;">
                </div>
            </div>

            <div class="button-container" style="display: flex; gap: 20px; margin-top: 20px; justify-content: center;">
                <button type="submit" class="signup-btn">Register Now</button>
                <button type="reset" class="reset">Clear Form</button>
            </div>

            <div style="text-align: center; margin-top: 15px;">
                <p>Already have an account? <a href="index.jsp">Login</a></p>
            </div>
        </div>
    </form>
<script>
    function checkEnrollment() {
        var enroll = document.getElementById("enroll-input").value;
        var msg = document.getElementById("statusMsg");

        if(enroll.trim() === "" || enroll.length < 8) {
            msg.innerHTML = "❌ Minimum 8 digits required!";
            msg.style.color = "red";
            return;
        }

        msg.innerHTML = "⏳ Checking availability...";
        msg.style.color = "orange";

        var xhttp = new XMLHttpRequest();
        xhttp.onreadystatechange = function() {
            if (this.readyState == 4 && this.status == 200) {
                var response = this.responseText.trim();
                if(response === "available") {
                    msg.innerHTML = "✅ Enrollment Available!";
                    msg.style.color = "green";
                } else if(response === "taken") {
                    msg.innerHTML = "❌ Already taken! Try another.";
                    msg.style.color = "red";
                } else {
                    msg.innerHTML = "⚠️ Error checking database.";
                    msg.style.color = "red";
                }
            }
        };
        // Yahan tere backend servlet ko call ja rahi hai
        xhttp.open("GET", "${pageContext.request.contextPath}/CheckEnrollAvailability?enrollID=" + enroll, true);
        xhttp.send();
    }
</script>

</body>
</html>