<!DOCTYPE html>
<html>
<%@ page import="com.google.firebase.database.*" %>
<%@ page import="java.util.Map" %>
<%@ page import="java.util.HashMap" %>
<%@ page import="java.io.*,java.util.*,java.sql.*" %>
<%@ page import="javax.servlet.*"%>
<%@ page import="javax.servlet.http.*"%>
<%@ page import="java.util.regex.*" %>


<%
    public class AccountSettings extends HttpServlet {

        public void doGet(HttpServletRequest request, HttpServletResponse response) throws ServletException, IOException {
            // Initialize Firebase 
            final FirebaseDatabase database = FirebaseDatabase.getInstance();
            DatabaseReference ref = database.getReference("User");

            String UID = request.getParameter("UID");
            DatabaseReference userRef = ref.child(UID);

            userRef.addListenerForSingleValueEvent(new ValueEventListener() {
                @Override
                public void onDataChange(DataSnapshot dataSnapshot) {
                    User user = dataSnapshot.getValue(User.class);
                    request.setAttribute("User", user);
                    RequestDispatcher dispatcher = getServletContext().getRequestDispatcher("accountsettings.jsp");
                    dispatcher.forward(request, response);
                }

                @Override 
                public void onCancelled(DatabaseError databaseError) {
                    System.out.println("The read failed: " + databaseError.getCode());
                }
            });
        }

        public void doPost(HttpServletRequest request, HttpServletResponse response) throws ServletException, IOException {
            String UID = request.getParameter("UID");
            String userName = request.getParameter("userName");
            String firstName = request.getParameter("firstName");
            String lastName = request.getParameter("lastName");
            String bio = request.getParameter("bio");
            String email = request.getParameter("email");
            String phone = request.getParameter("phone");
            String status = request.getParameter("status");

            final FirebaseDatabase database = FirebaseDatabase.getInstance();
            DatabaseReference ref = database.getReference("User");

            DatabaseReference userRef = ref.child(UID);
            Map<String, Object> userUpdates = new HashMap<>();
            userUpdates.put("username", userName);
            userUpdates.put("firstName", firstName);
            userUpdates.put("lastName", lastName);
            userUpdates.put("bio", bio);
            userUpdates.put("email", email);
            userUpdates.put("phone", phone);
            userUpdates.put("status", status);

            userRef.updateChildrenAsync(userUpdates);
            response.sendRedirect("home.jsp");
        }
    }
%>
</html>
