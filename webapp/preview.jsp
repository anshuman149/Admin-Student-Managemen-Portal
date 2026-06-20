<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>
<!DOCTYPE html>
<html lang="en">
<head>
    <meta charset="UTF-8">
    <meta name="viewport" content="width=device-width, initial-scale=1.0">
    <title>Registration Preview | IGNOU Portal</title>
    <link rel="stylesheet" type="text/css" href="${pageContext.request.contextPath}/style.css">
</head>
<body>

<div class="preview-wrapper">
    <div class="preview-card">
        <div class="preview-header" style="text-align: center; margin-bottom: 20px;">
            <h2 style="color: #4CAF50;">Review Your Details</h2>
            <p>Please check your information before proceeding to payment.</p>
        </div>

        <div class="details-section">
            <div class="detail-row"><strong>Full Name:</strong> <span>${param.fullName}</span></div>
            <div class="detail-row"><strong>Email ID:</strong> <span>${param.email}</span></div>
            <div class="detail-row"><strong>Phone Number:</strong> <span>${param.phone}</span></div>
            <div class="detail-row"><strong>Enrollment No:</strong> <span>${param.enrollmentNo}</span></div>
            <div class="detail-row"><strong>Course:</strong> <span>${param.course}</span></div>
            <div class="detail-row"><strong>Address:</strong> <span>${param.address}</span></div>
        </div>

        <div class="preview-actions">
            <button type="button" class="btn-edit" onclick="history.back()">Edit Details</button>
<form action="RegisterServlet" method="post" style="margin: 0;">
                <input type="hidden" name="fullName" value="${param.fullName}">
                <input type="hidden" name="email" value="${param.email}">
                <input type="hidden" name="phone" value="${param.phone}">
                <input type="hidden" name="enrollmentNo" value="${param.enrollmentNo}">
                <input type="hidden" name="course" value="${param.course}">
                <input type="hidden" name="address" value="${param.address}">
                <input type="hidden" name="password" value="${param.password}">
                
                <button type="submit" class="btn-confirm">Proceed to Pay</button>
            </form>
        </div>
    </div>
</div>

</body>
</html>