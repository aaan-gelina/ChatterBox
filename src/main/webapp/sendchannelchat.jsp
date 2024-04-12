<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>
<%@ page import="com.chatterbox.Channel" %>
<%@ page import="com.chatterbox.FirebaseConnect" %>
<%@ page import="java.util.ArrayList" %>
<%
    // Fake uid in place of system variable
    int uid =1;

    // Get channel from channelmenu.jsp
    Channel channel = request.getParameter("channel");
    String message = request.getParameter("usermessage");

    // Send message to database
    channel.addMessage(uid, messsage);

    // Redirect to channel
    response.sendRedirect("channel.jsp?channel=" + channel);
%>