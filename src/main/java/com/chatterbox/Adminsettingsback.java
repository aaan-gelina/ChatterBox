package com.chatterbox;

import java.util.ArrayList;
import java.util.HashMap;
import java.util.List;
import java.util.Map;

public class Adminsettingsback {

    // using a map to store channel ids and the associated members
    private Map<Integer, List<String>> channelMembers;

    
    public Adminsettingsback() {
        channelMembers = new HashMap<>();
        
        // Populate channels with members
        List<String> Channel1Members = new ArrayList<>();
        Channel1Members.add("Adam456");
        Channel1Members.add("David56");
        Channel1Members.add("HansNigel");
        channelMembers.put(1, Channel1Members); 

        List<String> Channel2Members = new ArrayList<>();
        Channel2Members.add("Jose1");
        Channel2Members.add("Leo");
        Channel2Members.add("April");
        Channel2Members.add("Kevin");
        channelMembers.put(2, Channel2Members);
    }

    public Map<Integer, List<String>> getChannelMembers() {
        return channelMembers;
    }

    public void removeUser(int channelId, String user) {
        if (channelMembers.containsKey(channelId)) {
            channelMembers.get(channelId).remove(user);
        }
    }

    public void deleteChannel(int channelId) {
        channelMembers.remove(channelId);
    }
}
/*     
 COMMENT/NOTE 
 Some of the ideas I had on how to implement the methods if I could have fetched the users and the channel objects properly
 
 after the frontend form passes the method 'appointModerator' it will be executed here. should work once methods are implemented in channel.java
  
 
    public void appointModerator(int userId){
        if(Channel.isAdmin(user) == true){
            Channel.addAdmin(user);   
            alert("Appointed as Moderator!");
        } else {  
            alert("This user is already a moderator.");
        }   
    } 

    public void deleteChannel(int channelId){
        Channel.deleteChannel(channelId);
        alert("Channel is deleted!");
    }




*/
