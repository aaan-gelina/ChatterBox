package com.chatterbox;

import java.util.ArrayList;
import java.util.HashMap;
import java.util.Map;
import com.google.firebase.database.DatabaseReference;

public class Dm {
    
    //parameters correspond to firebase DM parameters
    private int userA;
    private int userB;
    private String key;
    private String messages;

    //empty constructor to be used with com.google.firebase.database.DataSnapshot.getValue(Class<Dm> valueType) to load existing DM chat
    public Dm(){}           

    //constructor to be used when a new DM chat is created from the application side
    public Dm (int currentUser, int otherUser){        
        this.userA = currentUser;
        this.userB = otherUser;
        this.messages = "";
        // Add dm conversation to database
        String newKey = addDm(this);
        this.key = newKey;
        //read newly created Dm from database to ensure proper save
        Dm temp = FirebaseConnect.readDm(currentUser, otherUser);                                                  
    }

    private String addDm(Dm myDm) {           
        /* Function adds dm conversation to database, returns string of unique key which is generated by firebase
        */

        // Create reference to DMs in Firebase
        DatabaseReference dmRef = FirebaseConnect.createEntityRef("DMs");
        
        //Create a new child for the Firebase DMs
        DatabaseReference newDmRef = dmRef.push();

        // Send channel data to database
        newDmRef.setValueAsync(myDm);

        //return unique key of DM instance in databae
        return newDmRef.getKey();
    }

    //default getters and setters to be used with com.google.firebase.database.DataSnapshot.getValue(Class<Dm> valueType)
    public int getUserA() {
        return userA;
    }

    public void setUserA(int userA) {
        this.userA = userA;
    }

    public int getUserB() {
        return userB;
    }

    public void setUserB(int userB) {
        this.userB = userB;
    }

    public String getMessages() {
        return messages;
    }

    public void setMessages(String messages) {
        this.messages = messages;
    }

    public String getKey() {
        return key;
    }

    public void setKey(String key) {
        this.key = key;
    }

    public ArrayList<Message> messageStringToList(String messagesString){           
        //method converts given string of messages to an Arraylist of message objects
        ArrayList<Message> messages = new ArrayList<Message>();

        if (messagesString.equals("")){
            return messages;
        }
    
        String[] parts = messagesString.split("`");

        for (int i = 0; i < parts.length; i += 2) {
            if (parts[i].equals("")){
                i++;
                continue;
            }
            int userId = Integer.parseInt(parts[i]);
            String content = parts[i + 1];
            messages.add(new Message(userId, content));
        }
        return messages;
    }

    public String messageListToString(ArrayList<Message> messagesList){             
        //method converts given list of message objects to concatenated string of messages

        String messages = "";

        // Traverse messages ArrayList and store (userId, content) Pairs in a string with delimator "`"
        for (int i = 0; i < messagesList.size() - 1; i++) {
            messages = messages + "`" + messagesList.get(i).getUserId() + "`" + messagesList.get(i).getContent();
        }

        // Return String containing current thread of messages sent within DM conversation
        return messages;
    }

    public int getOtherUser(int currentUser){
        //return the userId of the other user in a specific DM conversation given the current userId
        
        if(this.userA==currentUser) return userB;
        else return userA;
    }

    public ArrayList<Message> getMessageList(){             
        //returns a list of messages of this DM conversation
        return messageStringToList(this.messages);
    }

    public void sendMessage(int currentUser, String content){           
        //add message to message list of current DM conversation object
        String newMessage;
        if(this.messages.equals("")){
            newMessage = currentUser + "`" + content;
        }else{
            newMessage = "`" + currentUser + "`" + content;
        }

        // Add new message to thread
        this.messages += newMessage;

        //update the changed DM object in firebase
        updateFirebase();
        //read newly updated Dm from database to ensure proper save
        Dm temp = FirebaseConnect.readDm(this.key);

    }

    private void updateFirebase() {                                     
        /* Function updates dm information in database
        */

        // Create reference to DMs in Firebase
        DatabaseReference dmref = FirebaseConnect.createEntityRef("DMs");

        // Create hashmap to store dm data
        Map<String, Object> dmUpdates = new HashMap<>();
        dmUpdates.put(this.key, this);

        // Send dm data to database
        dmref.updateChildrenAsync(dmUpdates);
    }


}
