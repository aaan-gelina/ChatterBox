<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>
<%@ page import="javax.servlet.*" %>
<%@ page import="javax.servlet.http.*" %>
<%@ page import="com.chatterbox.FirebaseConnect" %>

<%
    if ("POST".equalsIgnoreCase(request.getMethod())) {

        String userId = request.getParameter("userId");
        String userName = request.getParameter("userName");
        String firstName = request.getParameter("firstName");
        String lastName = request.getParameter("lastName");
        String bio = request.getParameter("bio");
        String email = request.getParameter("email");
        String phone = request.getParameter("phone");
        String status = request.getParameter("status");


        FirebaseConnect.connectFirebase();

        FirebaseConnect.updateUserSettings(userId, userName, firstName, lastName, bio, email, phone, status);

        response.sendRedirect("home.jsp");
    }
%>
