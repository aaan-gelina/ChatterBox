<!DOCTYPE html>

<!--I think it would make sense to not make a seperate validatelogin file and instead just do it here
    that is: connect to database, send the info, get back valid/not and if valid then login will send user to
    index.jsp 

        public class login{
        
            String username = request.getParameter("username");
            String password = request.getParameter("password");
        
        
            //todo, check password against user password in database
            //check, username agaisnt database for username
            //connect to firebase database
            //button functionality
            //loads to home.jsp
            //get text input from html/jsp file. 
            //add button to create account that leads to create account page
        }
 -->
<html>
<head>
    <title>ChatterBox Login Page</title>
    <link rel="icon" href="img/logo.jpg" type="jpg"> 

    <style>
        body {
            font-family: Arial, sans-serif;
            text-align: center;
            background-color: #C5EBFE; 
        }
        
        input[type=text], input[type=password] {
            display: block;
            margin: 1px auto; 
            padding: 10px;
            width: 150px; 
            background-color: #003366;
            border: none; 
            border-radius: 4px;
            color: #f6f4f4;
        }
         
        input[type=submit] {
            width: 150px;
            background-color: #003366;
            padding: 10px;
            margin: 20px auto; 
            border: none;
            border-radius: 4px;            
            color: white;
        }
        
        #signup {
            display: block;
            margin: 20px auto;
            padding: 10px;
            width: 150px; 
            background-color: #003366;
            color: #f6f4f4;
            border-radius: 5px;
            text-decoration: none;
        }
    </style>
</head>
<body>
<div id="logo">
    <img src="img/logo.jpg" alt="Logo" width="250">
</div>

<form name="MyForm" method="post" action="validateLogin.jsp">
    <div class="container">
        <input type="text" placeholder="Enter Username" name="username" required><br>
        <input type="password" placeholder="Enter Password" name="password" required><br>
        
        <input type="submit" value="Log In">
    </div>
</form>

<div>
    <h4>New to ChatterBox?</h4>
    <a href="signup.jsp" id="signup">Sign Up</a>
</div>

</body>
</html>
