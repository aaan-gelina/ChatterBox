<!DOCTYPE html>
<html>
<%@ include file="firebaseconnection.jsp"%>
<%@ include file="channelreadback.jsp"%>
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
    currentChannel.child(messages).setValue(thread);
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
    currentChannel.child(messages).setValue(newThreadhread);
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