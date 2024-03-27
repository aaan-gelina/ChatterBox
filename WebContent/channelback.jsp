<!DOCTYPE html>
<html>
<%@ page file="firebaseconnection.jsp" %>
<%@ page import="java.io.*,java.util.*,java.sql.*" %>
<%@ page import="java.util.ArrayList" %>
<%
public class Channel {
    /* Class represents channels in the channel interface of ChatterBox
    */

    //Initialize class variables
    private int globalcid = 1;  

    public void Channel(String name, int admin) {
        /* Function to initialize each unique instance of the channel class
        */

        final int cid = globalcid;
        globalcid += 1;
        String messages = "";
        String admins = "`" + String.valueOf(admin);
        String users = "`" + String.valueOf(admin);

        // Connect to firebase
        DatabaseReference currentChannel = channel.createChannelRef("Channels", cid);

        // Add channel to database and update values
        currentChannel.child("name").setValue(name);
        currentChannel.child("messages").setValue(messages);
        currentChannel.child("admins").setValue(admins);
        currentChannel.child("users").setValue(users);
    }

    public String getName(int cid) {
        /* Function returns name of channel from database
        */

        // Connect to firebase
        DatabaseReference ref = firebaseconnect.createChannelRef("Channels", cid);

        // Find the channel using cid
        DatabaseReference channelRef = ref.child(cid);

        // Read name from the channel
        return Chatterbase.readStr(channelRef, "name");
    }

    public String getDesc(int cid) {
        /* Function returns desc of channel from database
        */

        // Connect to firebase
        DatabaseReference ref = firebaseconnect.createChannelRef("Channels", cid);

        // Find the channel using cid
        DatabaseReference channelRef = ref.child(cid);

        // Read desc from the channel
        return Chatterbase.readStr(channelRef, "desc");
    }

    public String getAdmins(int cid) {
        /* Function returns admins of channel from database
        */

        // Connect to firebase
        DatabaseReference ref = firebaseconnect.createChannelRef("Channels", cid);

        // Find the channel using cid
        DatabaseReference channelRef = ref.child(cid);

        // Read admins from the channel
        return Chatterbase.readStr(channelRef, "admins");
    }

    public String getUsers(int cid) {
        /* Function returns users of channel from database
        */

        // Connect to firebase
        DatabaseReference ref = firebaseconnect.createChannelRef("Channels", cid);

        // Find the channel using cid
        DatabaseReference channelRef = ref.child(cid);

        // Read users from the channel
        return Chatterbase.readStr(channelRef, "users");
    }

    public String getMessages(int cid) {
        /* Function returns a string containing the current thread of messages sent within the channel 
        */

        // Connect to firebase
        DatabaseReference ref = firebaseconnect.createChannelRef("Channels", cid);

        // Find the channel using cid
        DatabaseReference channelRef = ref.child(cid);

        // Read messages from the channel
        return Chatterbase.readStr(channelRef, "messages");
    }

    public ArrayList<Integer> getAdminArray(int cid) {
        /* Function returns administrator ArrayList
        */

        // Get admin arraylist
        ArrayList<Integer> admins = toArray(getAdmins(cid));

        // Return admin arraylist
        return admins;
    }

    public ArrayList<Integer> getUserArray(int cid) {
        /* Function returns user ArrayList
        */

        // Get user arraylist
        ArrayList<Integer> users = toArray(getUsers(cid));

        // Return user arraylist
        return users;
    }

    public ArrayList<Pair> getMessageArray(int cid) {
        /* Function returns an ArrayList of tuples containing the current thread of messages sent within the channel and the uid for 
        * the sender of each message
        */

        // Initialize variables
        int start = 1;
        int end;
        int count = 1;
        int uid = 0;
        ArrayList<Pair> messageArray = new ArrayList<Pair>();
        
        // Get messages from database
        String messages = getMessages(cid);

        // Parse messages to break into uids and messages at deliminator
        for (int i = 1; i < messages.length(); i++) {
            if (count % 2 == 1) {
                if (messages.charAt(i) == '`') {
                    end = i - 1;
                    
                    //Store uid to add to tuple arraylist
                    uid  = Integer.parseInt(messages.substring(start, end));
                    start = i + 1;
                    count += 1;
                }
            }
            else {
                if (messages.charAt(i) == '`') {
                    end = i - 1;

                    // Add uid and message to arraylist
                    messageArray.add(new Pair<Integer, String>(uid, messages.substring(start, end)));
                    start = i + 1;
                    uid = 0;
                    count += 1;
                }
            }
        }

        // Return Arraylist of messages
        return messageArray;
    }

    public void setName(int cid, String name) {
        /* Function updates channel name in database
        */

        // Connect to firebase
        DatabaseReference ref = firebaseconnect.createChannelRef("Channels", cid);

        // Find the channel using cid
        DatabaseReference channelRef = ref.child(cid);

        // Set name value in database
        channelRef.child("name").setValue(name);
    }

    public void setDesc(int cid, String desc) {
        /* Function updates channel description in database
        */

        // Connect to firebase
        DatabaseReference ref = firebaseconnect.createChannelRef("Channels", cid);

        // Find the channel using cid
        DatabaseReference channelRef = ref.child(cid);

        // Set description value in database
        channelRef.child("desc").setValue(desc);
    }

    public void addMessage(int cid, int uid, String message) {
        /* Function adds a new message to the channel log
        */

        // Initialize variables
        String newMessage = "`" + String.valueOf(uid) + "`" + message;
        String thread;

        // Get previous message thread from database
        String messages = getMessages(cid);

        // Add new message to thread
        messages = messages + newMessage;

        // Connect to firebase
        DatabaseReference ref = firebaseconnect.createChannelRef("Channels", cid);

        // Find the channel using cid
        DatabaseReference channelRef = ref.child(cid);

        // Set messages value in database
        channelRef.child("messages").setValue(messages);
    }

    public void removeMessage(int cid, int uid, String message) {
        /* Function removes a message from the chat log in the Firebase Database 
        */

        // Initialize variables
        ArrayList<Pair> messages = new ArrayList<Pair>();
        String newMessages;
        Pair<Integer, String> deletedMessage = new Pair<Integer, String>(uid, message);

        // Get previous message thread from database
        messages = getMessageArray(cid);

        // Remove message by value of uid and message
        messages.remove(deletedMessage);

        // Convert array without message to String
        newMessages = messageString(messages);

        // Connect to firebase
        DatabaseReference ref = firebaseconnect.createChannelRef("Channels", cid);

        // Find the channel using cid
        DatabaseReference channelRef = ref.child(cid);

        // Set Messages value in database to update thread
        channelRef.child("messages").setValue(newMessages);
    }

    public void addUser(int cid, int uid) {
        /* Function adds user to channel
        */

        // Get user list from database
        String users = getUsers(cid);

        // Add user to user list
        users = users + "`" + String.valueOf(uid);

        // Connect to firebase
        DatabaseReference ref = firebaseconnect.createChannelRef("Channels", cid);

        // Find the channel using cid
        DatabaseReference channelRef = ref.child(cid);

        // Set users value in database to update thread
        channelRef.child("users").setValue(users);
    }

    public void removeUser(int cid, int uid) {
        /* Function removes user from channel
        */
        
        // Get list of users
        ArrayList<Integer> users = getUserArray(cid);

        // Remove user
        users.remove(uid);

        // Convert array to string to store in database
        String userdata = dataString(users);

        // Connect to firebase
        DatabaseReference ref = firebaseconnect.createChannelRef("Channels", cid);

        // Find the channel using cid
        DatabaseReference channelRef = ref.child(cid);

        // Set users value in database to update thread
        channelRef.child("users").setValue(userdata);
    }

    public void addAdmin(int cid, int uid) {
        /* Function adds admin to channel
        */

        // Get user list from database
        String admins = getAdmins(cid);

        // Add user to user list
        admins = admins + "`" + String.valueOf(uid);

        // Connect to firebase
        DatabaseReference ref = firebaseconnect.createChannelRef("Channels", cid);

        // Find the channel using cid
        DatabaseReference channelRef = ref.child(cid);

        // Set admins value in database to update thread
        channelRef.child("admins").setValue(admins);
    }

    public void removeAdmin(int cid, int uid) {
        /* Function removes administrator from channel
        */
        
        // Get list of admins
        ArrayList<Integer> admins = getAdminArray(cid);

        // Remove admin
        admins.remove(uid);

        // Convert array to string to store in database
        String admindata = dataString(admins);

        // Connect to firebase
        DatabaseReference ref = firebaseconnect.createChannelRef("Channels", cid);

        // Find the channel using cid
        DatabaseReference channelRef = ref.child(cid);

        // Set admins value in database to update thread
        currentChannel.child("admins").setValue(admindata);
    }

    public boolean isUser(int uid, int cid) {
        /* Function checks if user is a member of a channel
        */

        // Get channel user list
        ArrayList<Integer> users = getUserArray(cid);

        // Check if uid is in channel user list
        for (int i = 0; i < users.size() - 1; i++) {
            if (users.get(i) == uid) {
                // Return true if user is in user list
                return true;
            }
        }
        // Return false otherwise
        return false;
    }

    public boolean isAdmin(int uid, int cid) {
        /* Function checks if user is an administrator of a channel
        */

        // Get channel admin list
        ArrayList<Integer> admins = getAdminArray(cid);

        // Check if uid is in channel user list
        for (int i = 0; i < admins.size() - 1; i++) {
            if (admins.get(i) == uid) {
                // Return true if user is in user list
                return true;
            }
        }
        // Return false otherwise
        return false;
    }

    public ArrayList<Integer> toArray(String str) {
        /* Function returns an ArrayList containing seperated values broken at deliminator "`" from a String, returns ArrayList
        */

        // Initialize variables
        int start = 1;
        int end;
        ArrayList<Integer> array = new ArrayList<Integer>();

        // Iterate over string to break at deliminator
        for (int i = 1; i < str.length(); i++) {
            if (str.charAt(i) == '`') {
                end = i - 1;
                
                // Add to ArrayList
                array.add(Integer.parseInt(str.substring(start), end));
                start = i + 1;
            }
        }

        // Return Arraylist
        return array;
    }

    public String dataString(ArrayList<Integer> data) {
        /* Function converts ArrayList to a String, returns String
        */

        // Initialize variables
        String str = "";

        // Traverse ArrayList and store in a String with deliminator "`"
        for (int i = 0; i < data.size() - 1; i++) {
            str = str + "`" + data.get(i).toString();
        }

        // Return String 
        return str;
    }

    public String messageString(ArrayList<Pair> messageArray) {
        /* Function converts ArrayList of messages to a String containing the current thread of messages sent within the channel,
        * returns value string
        */

        // Initialize variables
        String messages = "";

        // Traverse messages ArrayList and store (key, value) Pairs in a string with deliminator "`"
        for (int i = 0; i < messageArray.size() - 1; i++) {
            messages = messages + "`" + messageArray.get(i).getKey().toString() + "`" + messageArray.get(i).getValue().toString();
        }

        // Return String containing current thread of messages sent within channel
        return messages;
    }
}
%>
</html>