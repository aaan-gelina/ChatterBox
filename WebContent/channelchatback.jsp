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
public void writeMessage(cid, uid, message) {
    /* Function adds a new message to the chat log in the Firebase Database 
    */

    // Initialize variables
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

    // Set Messages value in database to update thread
    currentChannel.child("messages").setValue(thread);
}

public void deleteMessage(cid, uid, message) {
    /* Function removes a message from the chat log in the Firebase Database 
    */

    // Initialize variables
    ArrayList<Pair> messages = new ArrayList();
    String newThread;
    Pair<Integer, String> deletedmessage = new Pair<Integer, String>(uid, message);

    // Connect to Firebase
    connectdb();

    // Get previous message thread from database
    messages = getThreadArray(cid);

    // Remove message by value of uid and message
    messages.remove(deletedmessage);

    // Convert array without message to String
    newThread = getThreadString(messages);

    // Create database reference
    DatabaseReference root = FirebaseDatabase.getInstance().getReference();
    DatabaseReference currentChannel = root.child("Channels").child(cid);

    // Set Messages value in database to update thread
    currentChannel.child("messages").setValue(newThreadhread);
}

public String getThread(cid) {
    /* Function returns a string containing the current thread of messages sent within the channel 
    */

    // Connect to Firebase
    connectdb();

    // Create database reference
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
    int start = 1;
    int end;
    int count = 1;
    int uid = null;
    ArrayList<Pair> messages = new ArrayList();
    
    // Get message thread from database
    thread = getThread(cid);

    // Parse message thread to break into uids and messages at deliminator
    for (int i = 1; i < thread.length(); i++) {
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

public String getThreadString(messages) {
    /* Function converts ArrayList of messages to a String containing the current thread of messages sent within the channel,
     * returns value string
     */

    // Initialize variables
    ArrayList<Pair> messages = messages;
    String thread = "";

    // Traverse messages ArrayList and store (key, value) Pairs in a string with deliminator "`"
    for (int i = 0; i < messages.size() - 1; i++) {
        thread.append("`" + messages.get(i).getKey().toString() + "`" + messages.get(i).getValue().toString());
    }

    // Return String containing current thread of messages sent within channel
    return thread;
}
%>
</html>