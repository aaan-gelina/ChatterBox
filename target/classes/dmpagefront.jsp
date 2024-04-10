<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
          
<%@ page import="java.util.Map" %>
<%@ page import="java.io.*,java.util.*,java.sql.*" %>
<%@ page import="java.util.ArrayList" %>
<%@ page import="com.chatterbox.FirebaseConnect" %>
<%@ page import="com.chatterbox.Message" %>
<%@ page import="com.chatterbox.Dm" %>
<%@ page import="com.chatterbox.User" %>

<%! int uid; %>                            
<% uid = (Integer)request.getSession().getAttribute("currentUser"); %>      <!-- get uid of current logged-in user -->

<%! String dmKey; %>                            
<%! int otherUser; %> 
<%! Dm dm; %>  
<%! User otherUser; %>                                        

<!DOCTYPE html>
<html>
<head>
<meta charset="UTF-8">
<title>DM Chat</title>
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
        max-height: 90vh;
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
    #chat {
        list-style-type:none;
	    overflow-y:scroll;
        height: 70vh;
    }
    #chat li{
	padding:10px 30px;
    padding-left:0;
	margin:0;
    }
    #chat .message{
	padding:20px;
	color:#fff;
	line-height:25px;
	max-width:90%;
	display:inline-block;
	text-align:left;
	border-radius:5px;
    }
    #chat .you{
        text-align:right;
    }
    #chat .friend .message{
        background-color:#58b666;
    }
    #chat .you .message{
        background-color:#6fbced;
    }
    main footer{
        height: 30px;
    }
    .send_message{
        display: flex;
    }
    #usermessage{
         width: 100%;
        padding: 10px;
        border: 1px solid #ccc;
        border-radius: 4px;
        box-sizing: border-box;
    }
</style>
</head>

<body>
<div class = "outside_container">
    <div class="top_container">
        <% dmKey = request.getParameter("dmKey"); %>          <!-- get dmkey from url query-->
        <% otherUser = Integer.parseInt(request.getParameter("uid")); %>     <!-- get uid for other user from url query if redirected from adddmchat page-->

        <% if (otherUser != null){
            dm = new Dm(uid, otherUser);                          //if a uid was passed through url, create new chat
            session.setAttribute("dmKey", dm.getKey());                        //save dmKey in session storage
        } else{
            dm = FirebaseConnect.readDm(dmKey);                          //else, read existing Dm object from database by dmKey
            session.setAttribute("dmKey", dmKey);                           //save dmKey in session storage
        } %>
                           
        <button class = back_button onclick="goBack()">Go Back</button>
        <% otherUser = FirebaseConnect.readUser(dm.getOtherUser(uid)); %>
	    <h1><%= otherUser.getUName()%></h1>                           <!-- display username of conversation partner-->
    </div>                  
	<div class = "chat_container">                              
        <main>
            <ul id="chat">
                <%! ArrayList<Message> messages = dm.getMessageList();%>
                <% for(Message i: messages) { %>
                    <li class=<%= (i.getUserId()==uid) ? "you" : "friend" %>>       <!-- determine if sender is you or friend-->
                        <div class="message">
                            <%= i.getContent()%> 
                        </div>
                    </li>
                <% } %>
            </ul>
        </main>
        <footer>
            <form class="send_message" method="post" action="/senddm.jsp">
                <input style="flex: 1;" name="usermessage" type="text" id="usermessage" placeholder="Type your message here..."/>
                <button>Send</button>           
            </form>
        </footer>
	</div>
</div>

<script>
    function goBack() {
        history.back();
    }
</script>

</body>
</html>
