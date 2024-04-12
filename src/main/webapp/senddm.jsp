<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>
<%@ page import="javax.servlet.*" %>
<%@ page import="javax.servlet.http.*" %>
<%@ page import="com.chatterbox.FirebaseConnect" %>
<%@ page import="com.chatterbox.Dm" %>

<%! int uid; %>                            
<% uid = (Integer)request.getSession().getAttribute("currentUser"); %>      <!-- get uid of current logged-in user -->
<%! String dmKey; %>                            
<% dmKey = (String)request.getSession().getAttribute("dmKey"); %>            <!-- get dmKey of current dm chat -->

<%
    if ("POST".equalsIgnoreCase(request.getMethod())) {

        //read DM object from database
        Dm dm2 = FirebaseConnect.readDm(dmKey);

        //add the message contents to the DM object, and update it in the database
        dm2.sendMessage(uid, request.getParameter("usermessage"));

        response.sendRedirect("./dmpagefront.jsp?dmKey=" + dmKey);
    }
%>
