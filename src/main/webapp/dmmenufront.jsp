<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
<%@ page import="java.util.Map" %>
<%@ page import="java.io.*,java.util.*,java.sql.*" %>
<%@ page import="java.util.ArrayList" %>
<%@ page import="com.chatterbox.FirebaseConnect" %>
<%@ page import="com.chatterbox.Dm" %> 
<%@ page import="com.chatterbox.User" %>                 

<%!  int uid = 1; %>                                    <!-- TODO: dummy userID for testing of DM system, is supposed to be set during login -->
<% session.setAttribute("currentUser", uid); %>
<%! int otherUser; %> 
<% String dmKey; %>

<!DOCTYPE html>
<html>
<head>
<meta charset="UTF-8">
<title>DM Menu</title>
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
        display: flex;
        flex-direction: row;
        justify-content: space-between;
    }
    .back_button{
        background-color: #ccc;
        color: #333;
        padding: 10px 15px;
        border: none;
        border-radius: 4px;
        cursor: pointer;
        height: fit-content;
    }
    .back_button:hover {
        background-color: #b3b3b3;
    }
    h1{
        text-align: center;
        margin: 0;
    }
    .add_button{
        background-color: #ffb3ec;
        color: #333;
        padding: 10px 15px;
        border: none;
        border-radius: 4px;
        cursor: pointer;
        height: fit-content;
    }
    .add_button:hover {
        background-color: #ff80df;
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
    #conversations {
        list-style-type:none;
        
    }
    #conversations li{
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
                <a href="home.jsp">
                    <button class="back_button">Go Back</button>
                </a>
            <h1>Your DM Chats</h1>
            <button class = add_button onclick="addChat()">Add Chat</button>     
        </div>                  
        <div class = "list_container">                          
            <ul id="conversations">
                <%! ArrayList<Dm> dms = FirebaseConnect.getExistingDms(uid);%>          <!--load existing Dms into list-->  
                <% if (!dms.isEmpty()) {
                    for(Dm i: dms) { 
                        otherUser = i.getOtherUser(uid);
                        dmKey = i.getKey(); %>
                        <li>
                            <a href=<%="./dmpagefront.jsp?dmKey="+ dmKey%>><%= "User #" + otherUser +"  (dmKey: " + dmKey + " )"%></a> 
                        </li>
                    <% }
                } else { %>
                    <li>
                        <i> You currently have no DM chats. </i>
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
    function addChat(){                                  
        window.location = "./adddmchatfront.jsp";
    }
</script>
</html>
