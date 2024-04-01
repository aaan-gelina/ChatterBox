<%@ include file="firebaseconnection.jsp" %>
<%@ page import="com.google.firebase.database.DataSnapshot" %>
<%@ page import="com.google.firebase.database.DatabaseReference" %>
<%@ page import="com.google.firebase.database.FirebaseDatabase" %>
<%@ page import="com.google.firebase.database.DatabaseError" %>
<%@ page import="com.google.firebase.database.ValueEventListener" %>

<%!
public ArrayList<Integer> getDmPartners(int uid){
    //function returns an array of userIds with which the current user has a DM conversation with
    
    // Connect to Firebase
    connectdb();

    FirebaseDatabase database = FirebaseDatabase.getInstance();
    DatabaseReference ref = database.getReference("DMs");

    ArrayList<Integer> users = new ArrayList();

    //iterate through existing DM chats (unsure on syntax here)
    ref.addValueEventListener(new ValueEventListener() {
        @Override
        public void onDataChange(DataSnapshot dataSnapshot) {
            for (DataSnapshot postSnapshot: dataSnapshot.getChildren()) { //compare users in chats to current user, if present, save other user
                int userA = DataSnapshot.getValue("userA");
                int userB = DataSnapshot.getValue("userB");
                if (userA == uid){
                    users.add(userB);
                }
                if (userB == uid){
                    users.add(userA);
                }
            }
            return users;
        }

        @Override
        public void onCancelled(DatabaseError databaseError) {
            // Handle errors
            System.out.println("Error reading available DM chats: " + databaseError.getMessage());
        }
    });
} %>

<%!
public String getUsername(int uid){
    //this functions returns the username connected to given userID
    
    // Connect to Firebase
    connectdb();

    FirebaseDatabase database = FirebaseDatabase.getInstance();
    DatabaseReference ref = database.getReference("User");

    // Find the user using cid
    DatabaseReference userRef = ref.child(uid);

    // Read username
    userRef.child("username").addListenerForSingleValueEvent(new ValueEventListener() {
        @Override
        public void onDataChange(DataSnapshot dataSnapshot) {
            String username = dataSnapshot.getValue(String.class);
            return username;
        }

        @Override
        public void onCancelled(DatabaseError databaseError) {
            // Handle errors
            System.out.println("Error reading username: " + databaseError.getMessage());
        }
    });
} %>