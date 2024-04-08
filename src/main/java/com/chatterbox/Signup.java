package com.chatterbox;

import java.io.IOException;
import java.util.regex.Matcher;
import java.util.regex.Pattern;
import javax.servlet.*;
import javax.servlet.http.*;
import java.util.HashMap;
import java.util.Map;
import com.google.firebase.database.DataSnapshot;
import com.google.firebase.database.DatabaseError;
import com.google.firebase.database.DatabaseReference;
import com.google.firebase.database.ValueEventListener;

public class Signup extends HttpServlet {

    static boolean exists = true;

    public void doPost(HttpServletRequest request, HttpServletResponse response) throws ServletException, IOException {
        String email = request.getParameter("email");
        String firstName = request.getParameter("firstName");
        String lastName = request.getParameter("lastName");
        String username = request.getParameter("username");
        String password = request.getParameter("password");

        User nU = new User(username, firstName, lastName, email, password);


        /*check is password and email are of valid format and if username exists before sending data to the database */
        if (validateEmail(nU.getEmail()) == true) {
            if (passValidate(nU.getPassword()) == true) {
                if (userDuplicateCheck(nU.getUName()) == false) {
                    sendData(nU);
                    response.sendRedirect("home.jsp");
                } else if (password.length() < 8) {
                    System.out.println("<meta http-equiv='refresh' content='3;URL=signupfront.jsp'>");
                    System.out.println("<p style='color:red;'>Password must be 8 or more characters long</p>");
                } else {
                    System.out.println("<meta http-equiv='refresh' content='3;URL=signupfront.jsp'>");
                    System.out.println(
                            "<p style='color:red;'>Invlaid Password. Must containt at least one uppercase, lowercase and special character</p>");
                }
            } else {
                System.out.println("<meta http-equiv='refresh' content='3;URL=signupfront.jsp'>");
                System.out.println("<p style='color:red;'> Invalid email format.</p>");
            }
        }
    }

    // regex email validation
    public static boolean validateEmail(final String email) {

        final String email_regex = "^[_A-Za-z0-9-]+(\\.[_A-Za-z0-9-]+)*@[A-Za-z0-9]+(\\.[A-Za-z0-9]+)*(\\.[A-Za-z]{2,})$";
        Pattern pattern;
        Matcher matcher;

        pattern = Pattern.compile(email_regex);

        matcher = pattern.matcher(email);
        return matcher.matches();

    }

    // regex password validation for uppercase,lowercase, special character and
    // length
    public static boolean passValidate(final String password) {
        final String password_regex = "^(?=.*?[A-Z])(?=.*?[a-z])(?=.*?[0-9])(?=.*?[#?!@$%^&*-]).{8,}$";
        Pattern pattern;
        Matcher matcher;

        pattern = Pattern.compile(password_regex);
        matcher = pattern.matcher(password);
        return matcher.matches();
    }

    public static boolean userDuplicateCheck(final String username) {

        DatabaseReference userRef = FirebaseConnect.createEntityRef("User");

        userRef.orderByChild("username").equalTo(username).addListenerForSingleValueEvent(new ValueEventListener() {
            @Override
            public void onDataChange(DataSnapshot dataSnapshot) {
                if (dataSnapshot.exists()) {
                    System.out.println("<meta http-equiv='refresh' content='3;URL=signupfront.jsp'>");
                    System.out.println("<p style='color:red;'>Username not available. Please choose another one</p>");
                } else {
                    exists = false;
                }
            }

            @Override
            public void onCancelled(DatabaseError databaseError) {
                System.out.println("Error occurred while checking username existence: " + databaseError.getMessage());
            }
        });
        return exists;

    }

    // method to send data to firebase after validate email/password
    private static void sendData(User u) {

        DatabaseReference userRef = FirebaseConnect.createEntityRef("User");
        Map<String, User> users = new HashMap<>();
        users.put(String.valueOf(u.getUserID()), u);

        userRef.setValueAsync(users);

    }
}