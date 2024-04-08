package com.chatterbox;

import java.util.ArrayList;
import java.util.List;


public class Adminsettingsback {

    private List<String> channelList;
    private List<String> userList;
    private List<String> memberList;

    public Adminsettingsback() {
        channelList = new ArrayList<>();
        channelList.add("Channel 1");
        channelList.add("Channel 2");
        channelList.add("Channel 3");

        userList = new ArrayList<>();
        userList.add("User 1");
        userList.add("User 2");
        userList.add("User 3");

        memberList = new ArrayList<>();
        memberList.add("User 43");
        memberList.add("User 534");
        memberList.add("User 45");
    }

    public List<String> getChannelList() {
        return channelList;
    }

    public List<String> getUserList() {
        return userList;
    }

    public List<String> getMemberList() {
        return memberList;
    }
}
