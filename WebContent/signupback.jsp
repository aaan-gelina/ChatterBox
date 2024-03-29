<!DOCTYPE html>
<html>
<%@ include file="firebaseconnection.jsp" %>
<%@ page import="com.google.firebase.database.DataSnapshot" %>
<%@ page import="com.google.firebase.database.DatabaseReference" %>
<%@ page import="com.google.firebase.database.FirebaseDatabase" %>
<%@ page import="com.google.firebase.database.DatabaseError" %>
<%@ page import="com.google.firebase.database.ValueEventListener" %>
<%@ page import="java.util.Map" %>
<%@ page import="java.io.*,java.util.*,java.sql.*" %>
<%@ page import="java.util.ArrayList" %>
<%@ page import="javax.servlet.*"%>
<%@ page import="javax.servlet.http.*"%>
<%@ page import="java.util.regex.Matcher"%>
<%@ page import="java.util.regex.Pattern"%>
<%

public class signup extends User, HttpServlet{
    public void doPost(HttpServletRequest request, HttpServletResponse response) throws ServletException, IOException {
        String email = request.getParameter("email");
        String firstName = request.getParameter("firstName");
        String lastName = request.getParameter("lastName");
        String username = request.getParameter("username");
        String password = request.getParameter("password");

        User nU = new User(username, firstName, lastName, email, password);
    
    final FirebaseDatabase database = FirebaseDatabase.getInstance();
    DatabaseReference ref = database.getReference("User");

       
    if(validateEmail(nU.getEmail())== true){
        if(passValidate(nU.getPassword(password)) ==true){
            sendData(nU);
            response.sendRedirect("home.jsp");
        }
        else if(password.length < 8) {
            out.println("<meta http-equiv='refresh' content='3;URL=signupfront.jsp'>");//redirects after 3 seconds
            out.println("<p style='color:red;'>Password must be 8 or more characters long</p>");
         }
         else{
            out.println("<meta http-equiv='refresh' content='3;URL=signupfront.jsp'>");//redirects after 3 seconds
            out.println("<p style='color:red;'>Invlaid Password. Must containt at least one uppercase, lowercase and special character</p>");
         }
    }else{
        out.println("<meta http-equiv='refresh' content='3;URL=signupfront.jsp'>");//redirects after 3 seconds
        out.println("<p style='color:red;'> Invalid email format.</p>");
    }
        

    
    }
    
    //regex email validation
    public static boolean validateEmail(final String email){

        final String email_regex ="^[_A-Za-z0-9-]+(\\.[_A-Za-z0-9-]+)*@[A-Za-z0-9]+(\\.[A-Za-z0-9]+)*(\\.[A-Za-z]{2,})$";
        Pattern pattern;
        Matcher matcher;

        pattern = Pattern.compile(email_regex);

        matcher = pattern.matcher(email);
        return matcher.matches();

    }
    //regex password validation for uppercase,lowercase, special character and length
    public static boolean passValidate(final String password){
        final String password_regex = "^(?=.*?[A-Z])(?=.*?[a-z])(?=.*?[0-9])(?=.*?[#?!@$%^&*-]).{8,}$";
        Pattern pattern;
        Matcher matcher;

        pattern = Pattern.compile(password_regex);
        matcher = pattern.matcher(password);
        return matcher.matches();
    }
    //method to send data to firebase after validate email/password
    private static sendData(user u){
        DatabaseReference userRef = ref.child("User");
        Map<int, user> users = new HashMap<>();
        users.put(u.userID, u);
        userRef.setValueAsync(users);
    }


}
%>
    </html>