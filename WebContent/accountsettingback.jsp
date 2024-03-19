<!DOCTYPE html>
<html>
<%@ page file="firebaseconnection.jsp" %>
<%@ page import="com.google.firebase.database.*" %>
<%@ page import="com.google.firebase.database.DataSnapshot" %>
<%@ page import="com.google.firebase.database.DatabaseReference" %>
<%@ page import="com.google.firebase.database.FirebaseDatabase" %>
<%@ page import="com.google.firebase.database.DatabaseError" %>
<%@ page import="com.google.firebase.database.ValueEventListener" %>
<%@ page import="java.util.Map" %>
<%@ page import="java.io.*,java.util.*,java.sql.*" %>
<%@ page import="javax.servlet.*"%>
<%@ page import="javax.servlet.http.*"%>
<%@ page import="java.util.regex.*" %>


<%
    public class AccountSettings extends HttpServlet {

        public void doGet(HttpServletRequest request, HttpServletResponse response) throws ServletException, IOException {

            // Initialize Firebase 
            final FirebaseDatabase database = FirebaseDatabase.getInstance(); //initial connection to firebase
            DatabaseReference ref = database.getReference("User"); //get a reference to the "User" node 

            // Assuming UID is passed as a parameter
            String UID = request.getParameter("UID"); //retrieve UID 
            DatabaseReference userRef = ref.child(UID); //get reference to the specific user's data using the UID

            userRef.addListenerForSingleValueEvent(new ValueEventListener() {
                @Override
                public void onDataChange(DataSnapshot dataSnapshot) { //triger when data is available
                    // Handle the user data snapshot
                    User user = dataSnapshot.getValue(User.class);
                    // Set user data as request attributes to be accessible in JSP
                    request.setAttribute("User", User); //Set the fetched User object as an attribute in the request
                    RequestDispatcher dispatcher = getServletContext().getRequestDispatcher("/accountSettings.jsp");
                    dispatcher.forward(request, response);
                }

                @Override 
                //Called if there's an error in fetching data from Firebase
                public void onCancelled(DatabaseError databaseError) {
                    System.out.println("The read failed: " + databaseError.getCode());
                }
            });
        }

        public void doPost(HttpServletRequest request, HttpServletResponse response) throws ServletException, IOException {
            // Get user input from the form
            String UID = request.getParameter("UID");
            String email = request.getParameter("email");
            String fName = request.getParameter("fName");
            String lName = request.getParameter("lName");
            String password = request.getParameter("password");
            String username = request.getParameter("username");

            // Initialize Firebase
            final FirebaseDatabase database = FirebaseDatabase.getInstance();
            DatabaseReference ref = database.getReference("User");

            // Update user data in Firebase
            DatabaseReference userRef = ref.child(userId);
            Map<String, Object> userUpdates = new HashMap<>();
            userUpdates.put("username", username);
            userUpdates.put("email", email);
            userUpdates.put("fName", fName);
            userUpdates.put("lName", lName);
            userUpdates.put("status", status);

            userRef.updateChildrenAsync(userUpdates);
            // Redirect to confirmation page or back to settings
            response.sendRedirect("home.jsp");
        }
    }
%>
</html>
