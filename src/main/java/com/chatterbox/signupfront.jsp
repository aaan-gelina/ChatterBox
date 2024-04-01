<!DOCTYPE html>
<head>
        <!-- This is for the tab up top to look nice. Copy it into each page. -->
    <title>ChatterBox Signup Page</title>
    <link rel="icon" href="img/logo.jpg" type="jpg"> 

<style>

        /* This is the background of page and general alignment */
        body {
            font-family: Arial, sans-serif;
            text-align: center;
            background-color: #C5EBFE; 
        }

        #text {
            font-weight: bold;
            color: #173054;
        }

        #textbox{
            padding:10px;
            border:1px solid #a9a2a2;
            border-radius:5px;

        }
        
        
        #login {
            display: block;
            margin: 20px auto;
            padding: 10px;
            width: 150px;
            background-color: #003366;
            border-radius: 5px;
            color: #f6f4f4;
            text-decoration: none;
			
			
        }
		#signup {
            display: block;
            margin: 20px auto;
            padding: 10px;
            width: 160px;
            background-color: #003366;
            border-radius: 5px;
            color: #f6f4f4;
            text-decoration: none;
            
					
        }
    </style>

<body>
<div id="logo">
        <img src="img/logo.jpg" alt="Logo" width="350">
    </div>
<h2 align="center" id = "text" >Sign up to start chatting!</h2>
<br>
<form name="MyForm" method=post action="signupback.jsp">
<table style="display:inline">
    <tr>
        <td><div align="right" id = "text">Email:</div></td>
        <td><input type="email" name="email" size=30 maxlength="200" id = "textbox" required></td>
    </tr>
    <tr>
        <td><div align="right" id = "text">First Name:</div></td>
        <td><input type="text" name="firstName" size=30 maxlength="30" id = "textbox" required></td>
    </tr>
    <tr>
        <td><div align="right" id = "text">Last Name:</div></td>
        <td><input type="text" name="lastName" size=30 maxlength="30" id = "textbox" required></td>
    </tr>
    <tr>
	    <td><div align="right" id = "text">Username:</div></td>
	    <td><input type="text" name="username"  size=30 maxlength=30 id = "textbox" required></td>
    </tr>
    <tr>
	    <td><div align="right" id = "text">Password:</div></td>
	    <td><input type="password" name="password" size=30 maxlength="30" id = "textbox" required></td>
    </tr>
</table>
<br/>
<input class="submit" type="submit" value="Sign Up" id = "signup">
</form>
<h3 align="center" id = "text">Have an account?</h3>
<a href="loginfront.jsp" id = "login">Log In</a>
</div>

</body>
</head>
</html>