<%@ page import="java.util.List" %>
<%@ page import="java.util.Map" %>
<%@ page import="java.util.Map.Entry" %>
<%@ page contentType="text/html;charset=UTF-8" language="java" %>
<%@ page import="com.chatterbox.Adminsettingsback" %>


<!DOCTYPE html>
<html>
<head>
    <title>ChatterBox</title>
    <link rel="icon" href="img/logo.jpg" type="image/jpg">
    <style>
        body {
            font-family: Arial, sans-serif;
            text-align: center;
            background-color: #C5EBFE; 
        }

        .container {
            display: flex;
            justify-content: center;
            flex-wrap: wrap;
        }

        .box {
            margin: 10px;
            padding: 20px;
            width: 30%;
            background-color: #003366;
            color: #f6f4f4;
            border-radius: 5px;
            box-sizing: border-box;
        }

        .delete-button {
            margin-top: 20px;
            padding: 10px 20px;
            background-color: red;
            color: white;
            border: none;
            border-radius: 5px;
            cursor: pointer;
        }

        .channel-button, .user-button, .moderator-button {
            display: block;
            margin: 5px auto;
            padding: 5px 10px;
            background-color: #007bff;
            color: white;
            border: none;
            border-radius: 5px;
            cursor: pointer;
        }

        .user-actions {
            display: flex;
            align-items: center;
            justify-content: center;
        }

        .user-name {
            margin-right: 10px;
        }

        .remove-button {
            margin-right: 5px;
            background-color: red;
            padding: 5px 10px;
            color: white;
            border: none;
            border-radius: 5px;
            cursor: pointer;
        }

        .member-actions button {
            margin-right: 10px; 
        }
    </style>
</head>
<body>

<%
    Adminsettingsback settings = new Adminsettingsback();
    
    // this part makes the webpage refresh when I remove a user or delete a channel to reflect it
    String action = request.getParameter("action");
    if (action != null) {
        int channelId = Integer.parseInt(request.getParameter("channelId"));
        if ("removeUser".equals(action)) {
            String userName = request.getParameter("userId");
            settings.removeUser(channelId, userName);
        } else if ("deleteChannel".equals(action)) {
            settings.deleteChannel(channelId);
        }
    }

    // get the data
    Map<Integer, List<String>> channelMembers = settings.getChannelMembers();

    // print out the data and pass them in the functions through the buttons    
    out.println("<div class='container'>");
    for(Map.Entry<Integer, List<String>> entry : channelMembers.entrySet()) {

        Integer channelId = entry.getKey();
        List<String> members = entry.getValue();

        out.println("<div class='box' id='Channel-" + channelId + "'>");
        out.println("<h2>Channel " + channelId + "</h2>");

        out.println("<div class='channel-members'><h3>Members:</h3>");

        for(String member : members) {
            out.println("<div class='user-actions'><span class='user-name'>" + member + "</span>"
            + "<button class='remove-button' onclick='removeUser(\"" + member + "\", " + channelId + ")'>Remove</button>"
            + "<button class='moderator-button user-button' onclick='appointModerator(\"" + member + "\", " + channelId + ")'>Appoint as Moderator</button></div>");
        }

        out.println("</div>");  
        out.println("<button class='delete-button' onclick='deleteChannel(" + channelId + ")'>Delete Channel</button>");
        out.println("</div>");  
    }
    out.println("</div>");
%>


<script>
    function removeUser(userName, channelId) {
        if (confirm('Are you sure you want to remove ' + userName + '?')) {
            document.getElementById('userToRemove').value = userName;
            document.getElementById('channelIdForUser').value = channelId;
            document.getElementById('removeUserForm').submit();
        }
    }

    function deleteChannel(channelId) {
        if (confirm('Are you sure you want to delete this channel?')) {
            document.getElementById('channelIdToDelete').value = channelId;
            document.getElementById('deleteChannelForm').submit();
        }
    }
</script>

<!-- I will use forms in order to pass data to Adminsettingsback.java and call the methods from there.
     I used this method becuause this way I can get around just using my backend 
     I dont know how exactly this works or what we are using. -->

<!-- Form to remove a user from a channel -->
<form id="removeUserForm" action="adminsettingsfront.jsp" method="post" style="display: none;">
    <input type="hidden" name="action" value="removeUser">
    <input type="hidden" name="userId" id="userToRemove">
    <input type="hidden" name="channelId" id="channelIdForUser">
</form>

<!-- Form that allows user to delete a channel -->
<form id="deleteChannelForm" action="adminsettingsfront.jsp" method="post" style="display: none;">
    <input type="hidden" name="action" value="deleteChannel">
    <input type="hidden" name="channelId" id="channelIdToDelete">
</form>

<!-- Form that allows the user to get back to the homepage -->
<div style="position: fixed; left: 0; bottom: 0; margin: 20px;">
    <a href="home.jsp">
        <button class="channel-button">Back to Homepage</button>
    </a>
</div>

</body>
<!-- 
    COMMENT/NOTE
    Some methods and ideas I could have implemented. Basically the adminsettings page if I could have fetched the channel object.
    
        FirebaseConnect.connectFirebase();
        int cid = 1; // You can dynamically assign or fetch this value
        CompletableFuture<Channel> future = FirebaseConnect.readChannel(cid);
        Channel channel = null;
        try {
            channel = future.get(10, TimeUnit.SECONDS); // Use get with timeout to avoid indefinite waiting
        } catch (TimeoutException te) {
            out.println("Request timed out. Please try again.");
        } catch (Exception e) {
            e.printStackTrace();
        }
        if (channel != null) {
    
        <div>
            <h2> channel.getName() </h2>
        </div>
    
        } else { 
    
        <p>Channel data not found.</p>
    
        } 


    If I could have retrieved the channel object I could have used channel.getName() to get the name.
    Then I would have used 
    Also could have used user.getName() 
-->
</html>


