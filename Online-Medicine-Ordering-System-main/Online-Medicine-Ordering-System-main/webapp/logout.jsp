<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>
<%
    session.invalidate(); // Clear the session (logout)
    response.sendRedirect("Home.jsp"); // Redirect to homepage or login.jsp if you prefer
%>
