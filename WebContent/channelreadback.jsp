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
public String getThread(cid) {
    /* Function returns a string containing the current thread of messages sent within the channel 
    */

    // Connect to Firebase
    connectdb();

    FirebaseDatabase database = FirebaseDatabase.getInstance();
    DatabaseReference ref = database.getReference("Channels");

    // Find the channel using cid
    DatabaseReference channelRef = ref.child(cid);

    // Read messages from the channel
    channelRef.child("messages").addListenerForSingleValueEvent(new ValueEventListener() {
        @Override
        public void onDataChange(DataSnapshot dataSnapshot) {
            String messages = dataSnapshot.getValue(String.class);
            return messages;
        }

        @Override
        public void onCancelled(DatabaseError databaseError) {
            // Handle errors
            System.out.println("Error reading messages: " + databaseError.getMessage());
        }
    });
}

public ArrayList<Pair> getThreadArray(cid) {
    /* Function returns an ArrayList of tuples containing the current thread of messages sent within the channel and the uid for 
     * the sender of each message
     */

    // Initialize variables
    int start = 0;
    int end;
    int count = 1;
    int uid = null;
    ArrayList<Pair> messages = new ArrayList();
    
    // Get message thread from database
    thread = getThread(cid);

    // Parse message thread to break into uids and messages at deliminator
    for (int i = 0; i < thread.length(); i++) {
        if (count % 2 == 1) {
            if (thread.charAt(i) == '`') {
                end = i - 1;
                
                //Store uid to add to tuple arraylist
                uid  = Integer.parseInt(thread[start:end]);
                start = i + 1;
                count += 1;
            }
        }
        else {
            if (thread.charAt(i) == '`') {
                end = i - 1;

                // Add uid and message to arraylist
                messages.add(new Pair<String, Integer>(uid, thread[start:end]));
                start = i + 1;
                uid = null;
                count += 1;
            }
        }
    }

    // Return Arraylist of messages
    return messages;
}
%>
</html>