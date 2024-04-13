<%@ page contentType="text/html;charset=UTF-8" language="java" %>
<%@ page import="com.chatterbox.Channel" %>

<!DOCTYPE html>
<head>    

    <!-- This is for the tab up top to look nice. Copy it into each page. -->
    <title>ChatterBox</title>
    <link rel="icon" href="img/logo.jpg" type="jpg"> 

    <!-- This is the CSS styling we could use page background colore, buttons etc. -->
    <style>

        /* This is the background of page and general alignment */
        body {
            font-family: Arial, sans-serif;
            text-align: center;
            background-color: #C5EBFE; 
        }

        /* This is the styling for the buttons, they are separated into 2 blocks because 
           I like the 2 main options next to each other.*/
        #dmmenu, #channels {
            display: inblock;
            margin: 20px auto;
            padding: 8px;
            background-color: #003366;
            border-radius: 5px;
            color: #f6f4f4;
            text-decoration: none;  
        }

        #accountsettings, #logout, #adminsettings {
            display: block;
            margin: 20px auto;
            padding: 10px;
            width: 150px;
            background-color: #003366;
            border-radius: 5px;
            color: #f6f4f4;
            text-decoration: none;
        }
    </style>
</head>
<body>
    <div id="logo">
        <img src="img/logo.jpg" alt="Logo" width="350">
    </div>

    <!-- This is how to get a button to send you to another page. -->
    <a href="dmmenufront.jsp" id="dmmenu">DM Menu</a>
    <a href="channelmenu.jsp" id="channels">Channels</a>
    <a href="accountsettings.jsp" id="accountsettings">Account Settings</a>
    <a href="loginfront.jsp" id="logout">Logout</a>
    <a href='adminsettingsfront.jsp' id='adminsettings'>Admin Settings</a>

</body>
</html>
