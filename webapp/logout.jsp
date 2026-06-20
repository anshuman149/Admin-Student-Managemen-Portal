<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
<%
    // 1. Session ko poori tarah khatam kar do (Clear memory)
    session.invalidate();
    
    // 2. Wapas login page par bhej do ek message ke saath
    response.sendRedirect("index.jsp?msg=LoggedOut");
%>