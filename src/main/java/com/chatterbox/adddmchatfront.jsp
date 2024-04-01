<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
<%@ page import="java.util.Map" %>
<%@ page import="java.io.*,java.util.*,java.sql.*" %>
<%@ page import="java.util.ArrayList" %>

<%@ include file="dmmenuback.jsp" %>
<%@ include file="adddmchatback.jsp" %>

<!-- %@ include file="dmmenuback_test.jsp" % -->       <!-- for data display testing, import these files and comment out the actual backend files --> 
<!-- %@ include file="adddmchatback_test.jsp" % -->

<%! int uid; %>                            
<% uid = (Integer)request.getSession().getAttribute("currentUser"); %>      <!-- get uid of current logged-in user -->

<!DOCTYPE html>
<html>
<head>
<meta charset="UTF-8">
<title>Add Chat</title>
<style type="text/css">
	body {
       font-family: Arial, sans-serif;
       background-color: #f4f4f4;
       margin: 0;
       padding: 0;
    }
    .outside_container {
        width: 70%;
        margin: 0 auto;
        background-color: #ffffff;
        padding: 20px;
        border-radius: 8px;
        box-shadow: 0 2px 4px rgba(0, 0, 0, 0.1);
        margin-top: 10px;
        margin-bottom: 10px;
        height: fit-content;
     }
    .top_container{
        position: relative;
        text-align: center;
    }
    .back_button{
        background-color: #ccc;
        color: #333;
        padding: 10px 15px;
        border: none;
        border-radius: 4px;
        cursor: pointer;
        height: fit-content;
        position: absolute;
        left: 0;
    }
    .back_button:hover {
        background-color: #b3b3b3;
    }
    h1{
        text-align: center;
        margin: 0;
    }
    .chat_container{
    	font-family: Arial, sans-serif;
    	background-color: #f9e7fe;
        margin: 5%;
        margin-top: 25px;
        margin-bottom: 10px;
        padding: 2px;
        border-radius: 8px;
        box-shadow: 0 2px 4px rgba(0, 0, 0, 0.1);
    }
    #users {
        list-style-type:none;
        
    }
    #users li{
        font-family: Arial, sans-serif;
        padding:10px 30px;
        padding-left: 35px;
        margin:0;
        background-color: #ce3bf7;
        border-style: solid;
        border-width: 2px;
        border-color: #4e0462;
    }
</style>
</head>
<body>
    <div class = "outside_container">
        <div class="top_container">
            <button class = back_button onclick="goBack()">Go Back</button>
            <h1>Choose a User to Chat with:</h1>  
        </div>                  
        <div class = "list_container">                      <!--load available users (not already in a chat with me) into list-->          
            <ul id="users">
               <%! ArrayList<Integer> users = getPotPartners(uid);%>
               <% if (!users.isEmpty()) {
                    for(Integer i: users) { %>
                        <li>
                            <a href=<%="./dmpagefront.jsp?uid="+ i%>><%=getUsername(i)%></a>    <!-- TODO: handle creation of new DM chat -->
                        </li>
                    <% }
                } else { %>
                    <li>
                        <i> There are no new users for you to chat with. </i>
                    </li>
                <% } %>
            </ul>
        </div>
    </div>
</body>
<script>
    function goBack() {
        history.back();
    }                             
</script>
</html>
