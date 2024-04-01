<%@ page import="com.google.firebase.database.*" %>
<%@ page import="java.util.HashMap" %>
<%@ page import="java.util.Map" %>
<%@ page import="javax.servlet.*" %>
<%@ page import="javax.servlet.http.*" %>
<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>
<%@ page file="firebaseconnection.jsp" %> 

<%
    if ("POST".equalsIgnoreCase(request.getMethod())) {
        //get data from the form
        String userId = request.getParameter("UID");
        String displayName = request.getParameter("displayName");
        String bio = request.getParameter("bio");
        String email = request.getParameter("email");
        String phone = request.getParameter("phone");
        String status = request.getParameter("status");

        //initialize firebase connection and get the reference to the user
        final FirebaseDatabase database = FirebaseDatabase.getInstance();
        DatabaseReference ref = database.getReference("User");
        DatabaseReference userRef = ref.child(UID);

        //create a map to update the user data
        Map<String, Object> userUpdates = new HashMap<>();
        userUpdates.put("displayName", displayName);
        userUpdates.put("bio", bio);
        userUpdates.put("email", email);
        userUpdates.put("phone", phone);
        userUpdates.put("status", status);

        //Update the user data in Firebase
        userRef.updateChildrenAsync(userUpdates);

        //redirect user to home page
        response.sendRedirect("home.jsp"); 
    }
%>
