package com.chatterbox;

import java.util.ArrayList;
import java.util.HashMap;
import java.util.Map;
import javafx.util.Pair;
import com.google.firebase.database.DatabaseReference;

public class Channel {
    /* Class represents channels in the channel interface of ChatterBox
    */

    //Initialize class variables
    private int channelcount = 1;
    private final int cid;  
    private String name;
    private String desc;
    private String messages;
    private String admins;
    private String users;


    public Channel(String name, String desc, int admin) {
        /* Function to initialize each unique instance of the channel class
        */

        //  Initialize variables
        this.cid = channelcount;
        this.name = name;
        this.desc = desc;
        this.messages = "";
        this.admins = "`" + String.valueOf(admin);
        this.users = "`" + String.valueOf(admin);

        // Autoincrement channel id
        channelcount = channelcount + 1;

        // Add channel to database
        addChannel(this, cid);
    }

    private void addChannel(Channel mychannel, int mycid) {
        /* Function adds channel to database
        */

        // Create reference to channels in Firebase
        DatabaseReference channelref = FirebaseConnect.createEntityRef("Channels");

        // Create hashmap to store channel data
        Map<String, Channel> channels = new HashMap<>();
        channels.put(String.valueOf(mycid), mychannel);

        // Send channel data to database
        channelref.setValueAsync(channels);

        // Read back from database to store effectively
        Channel thischannel = FirebaseConnect.readChannel(mycid);
    }

    private void updateFirebase() {
        /* Function updates channel information in database
        */

        // Create reference to channels in Firebase
        DatabaseReference channelref = FirebaseConnect.createEntityRef("Channels");

        // Create hashmap to store channel data
        Map<String, Object> channelUpdates = new HashMap<>();
        channelUpdates.put(String.valueOf(this.cid), this);

        // Send channel data to database
        channelref.updateChildrenAsync(channelUpdates);
    }

    public int getId() {
        /* Function returns id of channel from database
        */

        return this.cid;
    }

    public String getName() {
        /* Function returns name of channel from database
        */

        return this.name;
    }

    public String getDesc() {
        /* Function returns desc of channel from database
        */

        return this.desc;
    }

    public String getMessages() {
        /* Function returns a string containing the current thread of messages sent within the channel 
        */

        return messages;
    }

    public String getAdmins() {
        /* Function returns admins of channel from database
        */

        return this.admins;
    }

    public String getUsers() {
        /* Function returns users of channel from database
        */

        return this.users;
    }

    public ArrayList<Pair<Integer, String>> getMessageArray() {
        /* Function returns an ArrayList of tuples containing the current thread of messages sent within the channel and the uid for 
        * the sender of each message
        */

        // Initialize variables
        int start = 1;
        int end;
        int count = 1;
        int uid = 0;
        ArrayList<Pair<Integer, String>> messageArray = new ArrayList<Pair<Integer, String>>();
        
        // Get messages from database
        String messages = getMessages();

        // Parse messages to break into uids and messages at delimator
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

    public ArrayList<Integer> getAdminArray() {
        /* Function returns administrator ArrayList
        */

        // Get admin arraylist
        ArrayList<Integer> admins = toArray(getAdmins());

        // Return admin arraylist
        return admins;
    }

    public ArrayList<Integer> getUserArray() {
        /* Function returns user ArrayList
        */

        // Get user arraylist
        ArrayList<Integer> users = toArray(getUsers());

        // Return user arraylist
        return users;
    }

    public void setName(String name) {
        /* Function updates channel name
        */

        // Update name within channel object
        this.name = name;

        // Update channel info in database
        updateFirebase();
    }

    public void setDesc(String desc) {
        /* Function updates channel description in database
        */

        // Update description within channel object
        this.desc = desc;

        // Update channel info in database
        updateFirebase();
    }

    public void addMessage(int uid, String message) {
        /* Function adds a new message to the channel log
        */

        // Initialize variables
        String newMessage = "`" + String.valueOf(uid) + "`" + message;

        // Add new message to thread within channel object
        this.messages = getMessages() + newMessage;

        // Update channel info in database
        updateFirebase();
    }

    public void removeMessage(int index) {
        /* Function removes a message from the channel messages
        */

        // Initialize variables
        ArrayList<Pair<Integer, String>> messagearray = getMessageArray();

        // Remove message from message array
        messagearray.remove(index);

        // Convert updated array to String and update messages within channel object
        this.messages = messageString(messagearray);

        // Update channel info in database
        updateFirebase();
    }

    public void addUser(int uid) {
        /* Function adds user to channel
        */

        // Add user to user list within channel object
        this.users = getUsers() + "`" + String.valueOf(uid);

        // Update channel info in database
        updateFirebase();
    }

    public void removeUser(int uid) {
        /* Function removes user from channel
        */
        
        // Initialize variables
        ArrayList<Integer> userarray = getUserArray();

        // Remove user from user array
        userarray.remove(uid);

        // Convert updated array to String and update users within channel object
        this.users = dataString(userarray);

        // Update channel info in database
        updateFirebase();
    }

    public void addAdmin(int uid) {
        /* Function adds administrator to channel
        */

        // Add administrator to administrator list within channel object
        this.admins = getAdmins() + "`" + String.valueOf(uid);

        // Update channel info in database
        updateFirebase();
    }

    public void removeAdmin(int uid) {
        /* Function removes administrator from channel
        */
        
        // Initialize variables
        ArrayList<Integer> adminarray = getAdminArray();

        // Remove administrator from administrator array
        adminarray.remove(uid);

        // Convert updated array to String and update administrators within channel object
        this.admins = dataString(adminarray);

        // Update channel info in database
        updateFirebase();
    }

    public boolean isUser(int uid) {
        /* Function checks if user is a member of a channel
        */

        // Check if uid is in channel user list
        if (getUserArray().contains(uid)) {
            // Return true if user is in user list
            return true;
        }

        // Return false otherwise
        return false;
    }

    public boolean isAdmin(int uid) {
        /* Function checks if user is an administrator of a channel
        */

        // Check if uid is in channel administrator list
        if (getAdminArray().contains(uid)) {
            // Return true if user is in administrator list
            return true;
        }
        // Return false otherwise
        return false;
    }

    private ArrayList<Integer> toArray(String str) {
        /* Function returns an ArrayList containing seperated values broken at delimator "`" from a String, returns ArrayList
        */

        // Initialize variables
        int start = 1;
        int end;
        ArrayList<Integer> array = new ArrayList<Integer>();

        // Iterate over string to break at delimator
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

    private String dataString(ArrayList<Integer> data) {
        /* Function converts ArrayList to a String, returns String
        */

        // Initialize variables
        String str = "";

        // Traverse ArrayList and store in a String with delimator "`"
        for (int i = 0; i < data.size() - 1; i++) {
            str = str + "`" + data.get(i).toString();
        }

        // Return String 
        return str;
    }

    private String messageString(ArrayList<Pair<Integer, String>> messageArray) {
        /* Function converts ArrayList of messages to a String containing the current thread of messages sent within the channel,
        * returns value string
        */

        // Initialize variables
        String messages = "";

        // Traverse messages ArrayList and store (key, value) Pairs in a string with delimator "`"
        for (int i = 0; i < messageArray.size() - 1; i++) {
            messages = messages + "`" + messageArray.get(i).getKey().toString() + "`" + messageArray.get(i).getValue().toString();
        }

        // Return String containing current thread of messages sent within channel
        return messages;
    }
}

