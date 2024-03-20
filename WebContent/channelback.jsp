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
public class Channel() {
    /* Class represents channels in the channel interface of ChatterBox
    */

    private int cid;    // TODO ---> Create some sort of auto-increment
    private String name;
    private String desc;
    private String admins;
    private String users;
    private String messages;

    public void Channel(name, admin) {
        /* Function to initialize each unique instance of the channel class
        */

        this.cid = 1;   // TODO ---> Add auto-increment for cid
        this.name = name;
        this.messages = "";
        this.admins = "`" + admin.toString();
        this.users = "`" + admin.toString();

        // Connect to Firebase
        connectdb();

        // Create database reference
        DatabaseReference root = FirebaseDatabase.getInstance().getReference();
        DatabaseReference currentChannel = root.child("Channels").child(cid);

        // Add channel to database and update values
        currentChannel.child("name").setValue(name);
        currentChannel.child("messages").setValue(messages);
        currentChannel.child("admins").setValue(admins);
        currentChannel.child("users").setValue(users);
    }

    public String getName(cid) {
        /* Function returns name of channel from database
        */

        // Connect to Firebase
        connectdb();

        // Create database reference
        FirebaseDatabase database = FirebaseDatabase.getInstance();
        DatabaseReference ref = database.getReference("Channels");

        // Find the channel using cid
        DatabaseReference channelRef = ref.child(cid);

        // Read name from the channel
        channelRef.child("name").addListenerForSingleValueEvent(new ValueEventListener() {
            @Override
            public void onDataChange(DataSnapshot dataSnapshot) {
                String name = dataSnapshot.getValue(String.class);
                return name;
            }

            @Override
            public void onCancelled(DatabaseError databaseError) {
                // Handle errors
                System.out.println("Error reading messages: " + databaseError.getMessage());
            }
        });
    }

    public String getDesc(cid) {
        /* Function returns desc of channel from database
        */

        // Connect to Firebase
        connectdb();

        // Create database reference
        FirebaseDatabase database = FirebaseDatabase.getInstance();
        DatabaseReference ref = database.getReference("Channels");

        // Find the channel using cid
        DatabaseReference channelRef = ref.child(cid);

        // Read description from the channel
        channelRef.child("desc").addListenerForSingleValueEvent(new ValueEventListener() {
            @Override
            public void onDataChange(DataSnapshot dataSnapshot) {
                String desc = dataSnapshot.getValue(String.class);
                return desc;
            }

            @Override
            public void onCancelled(DatabaseError databaseError) {
                // Handle errors
                System.out.println("Error reading messages: " + databaseError.getMessage());
            }
        });
    }

    public String getAdmins(cid) {
        /* Function returns admins of channel from database
        */

        // Connect to Firebase
        connectdb();

        // Create database reference
        FirebaseDatabase database = FirebaseDatabase.getInstance();
        DatabaseReference ref = database.getReference("Channels");

        // Find the channel using cid
        DatabaseReference channelRef = ref.child(cid);

        // Read admins from the channel
        channelRef.child("admins").addListenerForSingleValueEvent(new ValueEventListener() {
            @Override
            public void onDataChange(DataSnapshot dataSnapshot) {
                String admins = dataSnapshot.getValue(String.class);
                return admins;
            }

            @Override
            public void onCancelled(DatabaseError databaseError) {
                // Handle errors
                System.out.println("Error reading messages: " + databaseError.getMessage());
            }
        });
    }

    public String getUsers(cid) {
        /* Function returns users of channel from database
        */

        // Connect to Firebase
        connectdb();

        // Create database reference
        FirebaseDatabase database = FirebaseDatabase.getInstance();
        DatabaseReference ref = database.getReference("Channels");

        // Find the channel using cid
        DatabaseReference channelRef = ref.child(cid);

        // Read users from the channel
        channelRef.child("users").addListenerForSingleValueEvent(new ValueEventListener() {
            @Override
            public void onDataChange(DataSnapshot dataSnapshot) {
                String users = dataSnapshot.getValue(String.class);
                return users;
            }

            @Override
            public void onCancelled(DatabaseError databaseError) {
                // Handle errors
                System.out.println("Error reading messages: " + databaseError.getMessage());
            }
        });
    }

    public ArrayList<Integer> getAdminArray(cid) {
        /* Function returns administrator ArrayList
        */

        // Get admin arraylist
        ArrayList<Integer> admins = toArray(getAdmins());

        // Return admin arraylist
        return admins;
    }

    public ArrayList<Integer> getUserArray(cid) {
        /* Function returns user ArrayList
        */

        // Get user arraylist
        ArrayList<Integer> users = toArray(getUsers());

        // Return user arraylist
        return users;
    }

    public void setName(cid, name) {
        /* Function updates channel name in database
        */

        // Connect to Firebase
        connectdb();

        // Create database reference
        DatabaseReference root = FirebaseDatabase.getInstance().getReference();
        DatabaseReference currentChannel = root.child("Channels").child(cid);

        // Set name value in database
        currentChannel.child("name").setValue(name);
    }

    public void setDesc(cid, desc) {
        /* Function updates channel description in database
        */

        // Connect to Firebase
        connectdb();

        // Create database reference
        DatabaseReference root = FirebaseDatabase.getInstance().getReference();
        DatabaseReference currentChannel = root.child("Channels").child(cid);

        // Set description value in database
        currentChannel.child("desc").setValue(desc);
    }

    public void addUser(cid, uid) {
        /* Function adds user to channel
        */

        // Get user list from database
        String users = getUsers(cid);

        // Add user to user list
        users.append("`" + uid.toString());

        // Connect to Firebase
        connectdb();

        // Create database reference
        DatabaseReference root = FirebaseDatabase.getInstance().getReference();
        DatabaseReference currentChannel = root.child("Channels").child(cid);

        // Set users value in database to update thread
        currentChannel.child("users").setValue(users);
    }

    public void removeUser(cid, uid) {
        /* Function removes user from channel
        */
        
        // Get list of users
        ArrayList<Integer> users = getUserArray();

        // Remove user
        users.remove(uid);

        // Convert array to string to store in database
        String userdata = dataString(users);

        // Connect to Firebase
        connectdb();

        // Create database reference
        DatabaseReference root = FirebaseDatabase.getInstance().getReference();
        DatabaseReference currentChannel = root.child("Channels").child(cid);

        // Set users value in database to update thread
        currentChannel.child("users").setValue(userdata);
    }

    public void addAdmin(cid, uid) {
        /* Function adds admin to channel
        */

        // Get user list from database
        String admins = getAdmins(cid);

        // Add user to user list
        admins.append("`" + uid.toString());

        // Connect to Firebase
        connectdb();

        // Create database reference
        DatabaseReference root = FirebaseDatabase.getInstance().getReference();
        DatabaseReference currentChannel = root.child("Channels").child(cid);

        // Set admins value in database to update thread
        currentChannel.child("admins").setValue(admins);
    }

    public void removeAdmin(cid, uid) {
        /* Function removes administrator from channel
        */
        
        // Get list of admins
        ArrayList<Integer> admins = getAdminArray();

        // Remove admin
        admins.remove(uid);

        // Convert array to string to store in database
        String admindata = dataString(admins);

        // Connect to Firebase
        connectdb();

        // Create database reference
        DatabaseReference root = FirebaseDatabase.getInstance().getReference();
        DatabaseReference currentChannel = root.child("Channels").child(cid);

        // Set admins value in database to update thread
        currentChannel.child("admins").setValue(admindata);
    }

    public boolean isUser(uid, cid) {
        /* Function checks if user is a member of a channel
        */

        // Get channel user list
        private ArrayList<Integer> users = getUsers(cid);

        // Check if uid is in channel user list
        for (int i = 0; i < users.size() - 1; i++) {
            if users.get(i).equals(uid.toString()) {
                // Return true if user is in user list
                return true;
            }
        }
        // Return false otherwise
        return false;
    }

    public boolean isAdmin(uid, cid) {
        /* Function checks if user is an administrator of a channel
        */

        // Get channel admin list
        private ArrayList<Integer> admins = getAdmins(cid);

        // Check if uid is in channel user list
        for (int i = 0; i < admins.size() - 1; i++) {
            if admins.get(i).equals(uid.toString()) {
                // Return true if user is in user list
                return true;
            }
        }
        // Return false otherwise
        return false;
    }

    public ArrayList<Integer> toArray(str) {
        /* Function returns an ArrayList containing seperated values broken at deliminator "`" from a String, returns ArrayList
        */

        // Initialize variables
        int start = 1;
        int end;
        ArrayList<Integer> array = new ArrayList();

        // Iterate over string to break at deliminator
        for (int i = 1; i < str.length(); i++) {
            if (thread.charAt(i) == '`') {
                end = i - 1;
                
                // Add to ArrayList
                array.add(Integer.parseInt(str[start:end]));
                start = i + 1;
                count += 1;
            }
        }

        // Return Arraylist
        return array;
    }

    public String dataString(data) {
        /* Function converts ArrayList of Integers to a String, returns String
        */

        // Initialize variables
        String str = "";

        // Traverse ArrayList and store in a String with deliminator "`"
        for (int i = 0; i < data.size() - 1; i++) {
            str.append("`" + data.get(i));
        }

        // Return String containing integers
        return str;
    }
}
%>
</html>