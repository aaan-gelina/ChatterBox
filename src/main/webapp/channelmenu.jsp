<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
<!DOCTYPE html>
<%@ page import="com.chatterbox.Channel" %>
<%@ page import="com.chatterbox.FirebaseConnect" %>
<%@ page import="java.util.concurrent.CompletableFuture" %>
<%@ page import="java.util.ArrayList" %>
<%@ page import="java.io.IOException" %>
<%@ page import="java.util.concurrent.CompletionException" %>
<html>
<head>
<meta charset="UTF-8">
<title>Channel Menu</title>
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
    #channels {
        list-style-type:none;
        
    }
    #channels li{
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
            <h1>Channels</h1>
            <button class = add_button onclick="myChannelsButton()">My Channels</button>     
        </div>                  
        <div class = "list_container">                              
            <ul id="channels">
                <%
                    // Fake uid in place of system variable
                    int uid =1;

                    // Get list of channels from database
                    ArrayList<Integer> channels = FirebaseConnect.getChildren("Channels");

                    // Populate list of channels on menu
                    for (Integer cid : channels) {
                        Channel channel = FirebaseConnect.readChannel(cid);

                        if (channel.isUser(uid)) {
                            out.println("<li>");
                            out.println("<a href=\"./channel.jsp?channel=" + channel + "\">" + channel.getName() + "</a>");
                            out.println("</li>");
                        }
                    } 
                %>
        </div>
    </div>

</body>                                                                 
<script>
    function goBack() {
        history.back();
    }
    function goChatPage(string){
        window.location = "./dmpagefront.jsp";               
    }                               
    function myChannelsButton(){                                  
        window.location = "./adminfront.jsp";
    }
</script>
</html>