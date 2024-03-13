<!DOCTYPE html>
<html>
<nav style="padding:1px">
</nav>
<style>
        h1 {color:rgb(137, 7, 173); font-family: Vivaldi, cursive; padding:50px; font-size: 65px;}
</style>
<head>
        <title>ChatterBox Login Page</title>
</head>
<body>
<div align="center" margin="0 auto" style="position: absolute; top: 10%; left: 37.5%; margin-top: -50px; margin-left: -50px; width: 500px; height: 660px; border: 1px solid #a9a2a2; background-color: #ffffff;">
<h1 align="center">ChatterBox</h1>
<br>
<form name="MyForm" method=post action="validateLogin.jsp">
<table style="display:inline">
<tr>
	<td><div align="right"><font face="Cambria, Cochin, Georgia, Times, 'Times New Roman', serif" size="3">Username:</font></div></td>
	<td><input type="text" name="username"  size=30 maxlength=30 style="padding:10px; border: 1px solid #a9a2a2;"></td>
</tr>
<tr>
	<td><div align="right"><font face="Cambria, Cochin, Georgia, Times, 'Times New Roman', serif" size="3">Password:</font></div></td>
	<td><input type="password" name="password" size=30 maxlength="30" style="padding:10px; border: 1px solid #a9a2a2;"></td>
</tr>
</table>
<br/>
<input class="submit" type="submit" name="Submit2" value="Log In" style="font-weight:bold; font-size: 20px; font-family: Cambria, Cochin, Georgia, Times, 'Times New Roman', serif; display: inline-block; padding: 10px 150px; background-color:#8907AD; color: #ffffff; text-decoration: none; border-radius: 20px; border: 1px solid #8907AD; margin-top: 20px;">
</form>
<h4 align="center" style="font-weight:normal; font-family: Cambria, Cochin, Georgia, Times, 'Times New Roman', serif">New to ChatterBox?</h4>
<h2 align="center"><a href="signupfront.jsp" style="font-weight:bold; font-size: 20px; font-family: Cambria, Cochin, Georgia, Times, 'Times New Roman', serif; display: inline-block; padding: 10px 145px; background-color:#8907AD; color: #ffffff; text-decoration: none; border-radius: 20px; border: 1px solid #8907AD;">Sign Up</a></h2>
</div>

</body>
</head>