<!DOCTYPE html>
<html>
<head>
    <title>ChatterBox - Account Settings</title>
    <style>
        body {
            font-family: Arial, sans-serif;
            text-align: center;
            background-color: #C5EBFE; 
        }
        .container {
            width: 50%;
            margin: 0 auto;
            background-color: #ffffff;
            padding: 20px;
            border-radius: 8px;
            box-shadow: 0 2px 4px rgba(0, 0, 0, 0.1);
            margin-top: 50px;
        }
        h1 {
            color: #333;
            font-size: 24px;
        }
        .form-row {
            display: flex;
            margin-bottom: 10px;
            align-items: center;
        }
        label {
            color: #333;
            margin-right: 10px;
            min-width: 20%;
        }
        input[type=text], input[type=email], input[type=tel], select {
            width: 100%;
            padding: 10px;
            border: 1px solid #ccc;
            border-radius: 4px;
            box-sizing: border-box;
        }
        .button-row {
            display: flex;
            justify-content: space-between;
            align-items: center;
            margin-top: 20px;
        }
        input[type=submit], button {
            background-color: #8907AD;
            color: white;
            padding: 10px 15px;
            border: none;
            border-radius: 4px;
            cursor: pointer;
        }
        input[type=submit]:hover, button:hover {
            background-color: #763d8a;
        }
        .danger {
            background-color: #ff4d4d;
        }
        .danger:hover {
            background-color: #ff3333;
        }
        .readonly {
            background-color: #e9e9e9;
        }
        button[type="button"] {
            background-color: #ccc;
            color: #333;
        }
        button[type="button"]:hover {
            background-color: #b3b3b3;
        }
    </style>
</head>
<body>

<div class="container">
    <h1>Account Settings</h1>
    <form action="accountsettingback.jsp" method="post">
        <div class="form-row">
            <label for="userId">User ID:</label>
            <input type="text" id="userId" name="userId" value="123456" readonly class="readonly">
        </div>

        <div class="form-row">
            <label for="userName">User Name:</label>
            <input type="text" id="userName" name="userName" value="Mr.Example">
        </div>

        <div class="form-row">
            <label for="firstName">First Name:</label>
            <input type="text" id="firstName" name="firstName" value="John">
        </div>

        <div class="form-row">
            <label for="lastName">Last Name:</label>
            <input type="text" id="lastName" name="lastName" value="Doe">
        </div>

        <div class="form-row">
            <label for="bio">Bio:</label>
            <input type="text" id="bio" name="bio" value="I love this project">
        </div>

        <div class="form-row">
            <label for="email">Email:</label>
            <input type="email" id="email" name="email" value="email@example.com">
        </div>

        <div class="form-row">
            <label for="phone">Phone Number:</label>
            <input type="tel" id="phone" name="phone" value="+1234567890">
        </div>

        <div class="form-row">
            <label for="status">Online Status:</label>
            <select id="status" name="status">
                <option value="online" selected>Online</option>
                <option value="offline">Offline</option>
                <option value="busy">Busy</option>
                <option value="away">Away</option>
            </select>
        </div>

        <div class="button-row">
            <button class="danger" onclick="confirmDeleteAccount()">Delete Account</button>
            <div>
                <!-- Updated Go Back button -->
                <a href="home.jsp" style="text-decoration: none;">
                    <button type="button">Go Back</button>
                </a>
                <input type="submit" value="Update Settings">
            </div>
        </div>
        
   
