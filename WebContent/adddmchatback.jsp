<!DOCTYPE html>
<html>
<%@ include file="firebaseconnection.jsp" %>
<%@ include file="dmmenuback.jsp" %>
<%@ page import="com.google.firebase.database.DataSnapshot" %>
<%@ page import="com.google.firebase.database.DatabaseReference" %>
<%@ page import="com.google.firebase.database.FirebaseDatabase" %>
<%@ page import="com.google.firebase.database.DatabaseError" %>
<%@ page import="com.google.firebase.database.ValueEventListener" %>
<%@ page import="java.util.Map" %>
<%@ page import="java.io.*,java.util.*,java.sql.*" %>
<%@ page import="java.util.ArrayList" %>
<%
public ArrayList<Integer> getPotPartners(uid){
    //function returns an array of userIds with which the current user does not yet have a DM conversation with

    //obtain list of users that current user already has a chat with
      ArrayList<Integer> alreadyExist = getDmPartners(uid);

    // Connect to Firebase
    connectdb();

    FirebaseDatabase database = FirebaseDatabase.getInstance();
    DatabaseReference ref = database.getReference("DMs");

    ArrayList<Integer> users = new ArrayList();
  
    //iterate through existing DM chats (unsure on syntax here)
    ref.addValueEventListener(new ValueEventListener() {
        @Override
        public void onDataChange(DataSnapshot dataSnapshot) {
            for (DataSnapshot postSnapshot: dataSnapshot.getChildren()) { 
                int userA = DataSnapshot.getValue("userA");
                int userB = DataSnapshot.getValue("userB");
                if (userA == uid && !alreadyExist.contains(userB)){
                    users.add(userB);
                }
                if (userB == uid && !alreadyExist.contains(userA)){
                    users.add(userA);
                }
            }
            return users;
        }

        @Override
        public void onCancelled(DatabaseError databaseError) {
            // Handle errors
            System.out.println("Error reading potential new DM chats: " + databaseError.getMessage());
        }
    });
}
%>
</html>