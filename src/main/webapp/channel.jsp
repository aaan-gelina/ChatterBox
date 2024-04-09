<!DOCTYPE html>
<%@ page import="com.chatterbox.Channel" %>
<html>
<head>
    <meta charset="UTF-8">
    <title>Channel Chat</title>
    <style type="text/css">
        body {
            font-family: Arial, sans-serif;
            background-color: #f4f4f4;
            margin: 0;
            padding: 0;
        }
        .main_container {
            width: 70%;
            margin: 0 auto;
            background-color: #ffffff;
            padding: 20px;
            border-radius: 8px;
            box-shadow: 0 2px 4px rgba(0, 0, 0, 0.1);
            margin-top: 10px;
            margin-bottom: 10px;
        }
        .top_container {
            text-align: left;
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
       
        .content_container {
            display: flex;
            max-height: 90vh;
        }
        .members_list {
            width: 20%;
            padding: 20px;
            border-right: 1px solid #ccc;
            overflow-y: auto;
        }
        .members_list h2 {
            margin-top: 0;
        }
        .chat_container {
            width: 80%;
            padding: 20px;
            overflow-y: auto;
        }
        h1 {
            text-align: center;
            margin: 0;
        }
        #chat {
            list-style-type: none;
            overflow-y: scroll;
            height: 70vh;
        }
        #chat li {
            padding: 10px 30px;
            margin: 0;
            display: flex;
            align-items: center;
        }
        .username {
            margin-right: 10px;
            font-weight: bold;
        }
        #chat .message {
            padding: 10px;
            color: #fff;
            line-height: 20px;
            max-width: 80%;
            display: inline-block;
            text-align: left;
            border-radius: 5px;
            background-color: #58b666;
        }
        .send_message {
            display: flex;
        }
        #usermessage {
            width: 100%;
            padding: 10px;
            border: 1px solid #ccc;
            border-radius: 4px;
            box-sizing: border-box;
        }
    </style>
</head>
<body>
    <div class="main_container">
        <div class="top_container">
            <button class="back_button" onclick="goBack()">Go Back</button>
        </div>
        <div class="content_container">
            <div class="members_list">
                <h2>Members</h2>
                <p>Member 1</p>
                <p>Member 2</p>
                <p>Member 3</p>
                <p>Member 4</p>
                <p>Member 5</p>
                <p>Member 6</p>
            </div>

            <div class="chat_container">
                <h1>Channel Name</h1> <!-- TODO: Get channel name from database or query -->
                <main> <!--TODO(JSP): Load chat messages into list-->
                    <ul id="chat">
                        <li>
                            <span class="username">John:</span>
                            <div class="message">heyyyyyyyy</div>
                        </li>
                        <li>
                            <span class="username">Emma:</span>
                            <div class="message">Hiiiiii</div>
                        </li>
                        <li>
                            <span class="username">Connor:</span>
                            <div class="message">how is it going</div>
                        </li>
                        <li>
                            <span class="username">Joe:</span>
                            <div class="message">Bye</div>
                        </li>
                        <li>
                            <span class="username">Connor:</span>
                            <div class="message">Byeeee</div>
                        </li>
                    </ul>
                </main>
                <footer>
                    <form class="send_message">
                        <input name="usermessage" type="text" id="usermessage" placeholder="Type your message here..."/>
                        <button>Send</button> <!-- TODO(JSP): handle sending of message to database, updating chat-->
                    </form>
                </footer>
            </div>
        </div>
    </div>

    <script>
        function goBack() {
            window.history.back();
        }
    </script>
</body>
</html>
