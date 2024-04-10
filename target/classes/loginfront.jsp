<!DOCTYPE html>
<head>
        <!-- This is for the tab up top to look nice. Copy it into each page. -->
    <title>ChatterBox Login Page</title>
    <link rel="icon" href="img/logo.jpg" type="jpg"> 

<style>

        /* This is the background of page and general alignment */
        body {
            font-family: Arial, sans-serif;
            text-align: center;
            background-color: #C5EBFE; 
        }
        
        
        #login {
            display: block;
            margin: 20px auto;
            padding: 10px;
            width: 170px;
            background-color: #003366;
            border-radius: 5px;
            color: #f6f4f4;
            text-decoration: none;
			
			
        }
		#signup {
            display: block;
            margin: 20px auto;
            padding: 10px;
            width: 150px;
            background-color: #003366;
            border-radius: 5px;
            color: #f6f4f4;
            text-decoration: none;
			
					
        }
		#textbox{
            padding:10px;
            border:1px solid #a9a2a2;
            border-radius:5px;

        }
		#text {
            font-weight: bold;
            color: #173054;
        }
    </style>

<body>
<div id="logo">
        <img src="img/logo.jpg" alt="Logo" width="350">
    </div>
<br>
<form name="MyForm" method=post action="loginback.jsp">
<table style="display:inline">
<tr>
	<td><div align="right" id = "text">Username:</font></div></td>
	<td><input type="text" name="username"  size=30 maxlength=30 id = "textbox" required></td>
</tr>
<tr>
	<td><div align="right" id = "text"> Password:</font></div></td>
	<td><input type="password" name="password" size=30 maxlength=30 id = "textbox" required></td>
</tr>
</table>
<br/>
<input class="submit" type="submit" id = "login" value="Log In" >
</form>
<h3 align="center" id = "text" >New to Chatterbox?</h3>
<a href="signupfront.jsp" id = "signup" >Sign Up</a>
</div>

</body>
</head>