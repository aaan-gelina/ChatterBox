<!DOCTYPE html>
<html>
<%@ page file="firebaseconnection.jsp" %>
<%@ page import="com.google.firebase.database.DataSnapshot" %>
<%@ page import="com.google.firebase.database.DatabaseReference" %>
<%@ page import="com.google.firebase.database.FirebaseDatabase" %>
<%@ page import="com.google.firebase.database.DatabaseError" %>
<%@ page import="com.google.firebase.database.ValueEventListener" %>
<%@ page import="java.util.Map" %>
<%@ page import="java.io.*,java.util.*,java.sql.*" %>
<%@ page import="java.util.ArrayList" %>
<%


        public class login extends User, HttpServlet{
            public void doPost(HttpServletRequest request, HttpServletResponse response) throws ServletException, IOException {

                //get input password and username
                String username = request.getParameter("username");
                String password = request.getParameter("password");

                //database connection    
                FirebaseDatabase database = FirebaseDatabase.getInstance();
                DatabaseReference ref = database.getReference("User");

                ref.addValueEventListener(new ValueEventListener(){
                    @Override
                    public void onDataChange(DataSnapshot dataSnapshot){
                        User u = dataSnapshot.getValue(User.class);
                        System.out.println(u);
                    }
                    @Override
                    public void onCancelled(DatabaseError dbError){
                        System.out.println('The read failed: ' + dbError.getCode());
                    }
                });
        
        

        if(username == u.getUName){
            if(password == u.getPassword){
                response.sendRedirect("home.jsp");
            }else{
                out.println("<meta http-equiv='refresh' content='3;URL=login.jsp'>");//redirects after 3 seconds
                out.println("<p style='color:red;'>Incorrect Password</p>")
            }

        }


           
        }
    }
        %>
</html>

