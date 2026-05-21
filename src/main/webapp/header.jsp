<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>
<%
    String name = (String) session.getAttribute("fullName");
    if(name == null) { response.sendRedirect("index.jsp"); }
    response.setHeader("Cache-Control", "no-cache, no-store, must-revalidate");
    response.setHeader("Pragma", "no-cache");
    response.setDateHeader("Expires", 0);
%>
<!DOCTYPE html>
<html lang="en">
<head>
    <meta charset="UTF-8">
    <title>Student Dashboard</title>
    <link rel="stylesheet" type="text/css" href="${pageContext.request.contextPath}/style.css">
    <link rel="stylesheet" type="text/css" href="${pageContext.request.contextPath}/profile-style.css">
</head>
<body>
    <div class="header">
        <div class="university"><h3>University Portal</h3></div>
        <div class="profile">
           <p>Welcome, <%= name %></p>
            <img src="images/Profile.jpg" alt="profile">
        </div>
    </div>