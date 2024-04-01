<%@ page file="firebaseconnection.jsp" %>
<%@ page import="com.google.firebase.database.DataSnapshot" %>
<%@ page import="com.google.firebase.database.DatabaseReference" %>
<%@ page import="com.google.firebase.database.FirebaseDatabase" %>
<%@ page import="com.google.firebase.database.DatabaseError" %>
<%@ page import="com.google.firebase.database.ValueEventListener" %>

<%!
public String getThread(int currentUser, int otherUser) {
    /* Function returns a string containing the current thread of DMs sent between the current logged-in user, and the given other user 
    */

    // Connect to Firebase
    connectdb();

    FirebaseDatabase database = FirebaseDatabase.getInstance();
    DatabaseReference ref = database.getReference("DMs");

    //find the right dm conversation by using both uids and iterating through existing DM chats (unsure on syntax here)
    ref.addValueEventListener(new ValueEventListener() {
        @Override
        public void onDataChange(DataSnapshot dataSnapshot) {
            for (DataSnapshot postSnapshot: dataSnapshot.getChildren()) { 
                int userA = DataSnapshot.getValue("userA");
                int userB = DataSnapshot.getValue("userB");
                if((userA == otherUser && userB == currentUser)||(userB == otherUser && userA == currentUser)){
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
} %>

<%!
public ArrayList<Pair> getThreadArray(int currentUser, int otherUser) {
    /* Function returns an ArrayList of tuples containing the current thread of messages sent within the DM conversation and the userId for 
     * the sender of each message
     */

    ArrayList<Pair> messages = new ArrayList();
    
    // Get message thread from DM database
    String thread = getThread(currentUser, otherUser);

    String[] parts = thread.split("`");
    for (int i = 0; i < parts.length; i += 2) {
        int userId = Integer.parseInt(parts[i]);
        String message = parts[i + 1];
        messages.add(new Message(userId, message));
    }

    return messages;
} %>

<%!
public void writeMessage(int currentUser, int otherUser, String message) {    
    // Function adds a new message to the chat log in the Firebase Database 

    //Initialize variables
    String newMessage = "`" + currentUser.toString() + "`" message;
    String thread;
   
    // Get previous message thread from database
    thread = getThread(currentUser, otherUser);

    // Add new message to thread
    thread = thread.append(newMessage);

     // Connect to Firebase
    connectdb();

    FirebaseDatabase database = FirebaseDatabase.getInstance();
    DatabaseReference ref = database.getReference("DMs");

    //find the right dm conversation by using both uids and iterating through existing DM chats (unsure on syntax here)
    ref.addValueEventListener(new ValueEventListener() {
        @Override
        public void onDataChange(DataSnapshot dataSnapshot) {
            for (DataSnapshot postSnapshot: dataSnapshot.getChildren()) { 
                int userA = DataSnapshot.getValue("userA");
                int userB = DataSnapshot.getValue("userB");
                if((userA == otherUser && userB == currentUser)||(userB == otherUser && userA == currentUser)){
                    // Set messages value in database
                    ref.child("messages").setValue(thread);
                }
            }
        }

        @Override
        public void onCancelled(DatabaseError databaseError) {
            // Handle errors
            System.out.println("Error writing DM messages: " + databaseError.getMessage());
        }
    });

} %>
