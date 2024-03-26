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
public String getThread(int uid) {
    /* Function returns a string containing the current thread of DMs sent between the current logged-in user, and the given other user 
    */

    // Connect to Firebase
    connectdb();

    FirebaseDatabase database = FirebaseDatabase.getInstance();
    DatabaseReference ref = database.getReference("DMs");

    //TODO: get uid of current user
    int currentUser = 1;            //dummy variable

    //find the right dm conversation by using both uids and iterating through existing DM chats (unsure on syntax here)
    ref.addValueEventListener(new ValueEventListener() {
        @Override
        public void onDataChange(DataSnapshot dataSnapshot) {
            for (DataSnapshot postSnapshot: dataSnapshot.getChildren()) { 
                int userA = DataSnapshot.getValue("userA");
                int userB = DataSnapshot.getValue("userB");
                if((userA == uid && userB == currentUser)||(userB == uid && userA == currentUser)){
                    String messages = dataSnapshot.getValue("messages");
                    return messages;
                }
            }
        }

        @Override
        public void onCancelled(DatabaseError databaseError) {
            // Handle errors
            System.out.println("Error reading DM messages: " + databaseError.getMessage());
        }
    });
}

public ArrayList<Pair> getThreadArray(int uid) {
    /* Function returns an ArrayList of tuples containing the current thread of messages sent within the DM conversation and the userId for 
     * the sender of each message
     */

    // Initialize variables
    int start = 0;
    int end;
    int count = 1;
    int userId = null;
    ArrayList<Pair> messages = new ArrayList();
    
    // Get message thread from DM database
    thread = getThread(uid);

    // Parse message thread to break into uids and messages at deliminator
    for (int i = 0; i < thread.length(); i++) {
        if (count % 2 == 1) {
            if (thread.charAt(i) == '`') {
                end = i - 1;
                
                //Store userID to add to tuple arraylist
                userId  = Integer.parseInt(thread[start:end]);
                start = i + 1;
                count += 1;
            }
        }
        else {
            if (thread.charAt(i) == '`') {
                end = i - 1;

                // Add userID and message to arraylist
                messages.add(new Pair<Integer, String>(userId, thread[start:end]));
                start = i + 1;
                userId = null;
                count += 1;
            }
        }
    }
    return messages;
}

public void writeMessage(int cid, int uid, String message) {     //TODO: ADJUST TO DM SYSTEM (taken from channelwriteback.jsp)!!!
    /* Function adds a new message to the chat log in the Firebase Database 
    */

    //Initialize variables
    String newMessage = "`" + uid.toString() + "`" message;
    String thread;
    
    // Connect to Firebase
    connectdb();

    // Get previous message thread from database
    thread = getThread(cid);

    // Add new message to thread
    thread = thread.append(newMessage);

    // Create database reference
    DatabaseReference root = FirebaseDatabase.getInstance().getReference();
    DatabaseReference currentChannel = root.child("Channels").child(cid);

    //Set Messages value in database to update thread
    currentChannel.child("messages").setValue(thread);
}

%>
</html>