<!DOCTYPE html>
<html>
<%@ include file="firebaseconnection.jsp"%>
<%@ include file="channelreadback.jsp"%>
<%
public void writeMessage(cid, uid, message) {
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
    currentChannel.child(messages).setValue(thread);
}
%>
</html>