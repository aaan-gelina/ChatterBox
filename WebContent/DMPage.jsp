<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
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
        <button class = back_button onclick="goBack()">Go Back</button>
	    <h1>Your friend's name</h1>     <!-- TODO(JSP): Get current chat name from database or query -->
    </div>                  
	<div class = "chat_container">                                  <!--TODO(JSP): Load chat messages into list-->
        <main>
            <ul id="chat">
                <li class="you">
                    <div class="message">
                        Something you wrote
                    </div>
                </li>
                <li class="friend">
                    <div class="message">
                        Something your friend wrote
                    </div>
                </li>
                <li class="you">
                    <div class="message">
                        Something you wrote
                    </div>
                </li>
                <li class="friend">
                    <div class="message">
                        Something your friend wrote
                    </div>
                <li class="you">
                    <div class="message">
                        Something you wrote
                    </div>
                </li>
                <li class="friend">
                    <div class="message">
                        Something your friend wrote
                    </div>
                <li class="you">
                    <div class="message">
                        Something you wrote
                    </div>
                </li>
                <li class="friend">
                    <div class="message">
                        Something your friend wrote
                    </div>
                <li class="you">
                    <div class="message">
                        Something you wrote
                    </div>
                </li>
                <li class="friend">
                    <div class="message">
                        Something your friend wrote
                    </div>
                <li class="you">
                    <div class="message">
                        Something you wrote
                    </div>
                </li>
            </ul>
        </main>
        <footer>
            <form class="send_message">
                <input style="flex: 1;" name="usermessage" type="text" id="usermessage" placeholder="Type your message here..."/>
                <button>Send</button> <!-- TODO(JSP): handle sending of message to database, updating chat-->
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
