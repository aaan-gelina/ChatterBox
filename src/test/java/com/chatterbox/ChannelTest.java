package com.chatterbox;

import java.util.ArrayList;
import junit.framework.TestCase;
import junit.framework.TestSuite;
import javafx.util.Pair;

public class ChannelTest extends TestCase {

    public ChannelTest(String testName) {
        super(testName);
    }

    public static TestSuite suite() {
        return new TestSuite(ChannelTest.class);
    }

    public void testChannelInitialization() {
        Channel channel = new Channel("test", "test", 0);
        assertNotNull(channel);
    }

    public void testChannelName() {
        Channel channel = new Channel("test", "test", 0);
        channel.setName("Test Channel");
        assertEquals("Test Channel", channel.getName());
    }

    public void testChannelDescription() {
        Channel channel = new Channel("test", "test", 0);
        channel.setDesc("This is a test channel");
        assertEquals("This is a test channel", channel.getDesc());
    }

    public void testChannelAddUser() {
        Channel channel = new Channel("test", "test", 0);
        channel.addUser(1);
        assertEquals("`0`1", channel.getUsers());
    }

    public void testChannelAddAdmin() {
        Channel channel = new Channel("test", "test", 0);
        channel.addAdmin(1);
        assertEquals("`0`1", channel.getAdmins());
    }

    public void testChannelAddMessage() {
        Channel channel = new Channel("test", "test", 0);
        channel.addMessage(0, "Hello!");
        assertEquals("`0`Hello!", channel.getMessages());
    }

    public void testChannelRemoveUser() {
        Channel channel = new Channel("test", "test", 0);
        channel.addUser(1);
        channel.removeUser(1);
        assertEquals("`0", channel.getUsers());
    }

    public void testChannelRemoveAdmin() {
        Channel channel = new Channel("test", "test", 0);
        channel.addAdmin(1);
        channel.removeAdmin(1);
        assertEquals("`0", channel.getAdmins());
    }

    public void testChannelRemoveMessage() {
        Channel channel = new Channel("test", "test", 0);
        channel.addMessage(0, "Hello!");
        channel.removeMessage(0);
        assertEquals("", channel.getMessages());
    }

    public void testChannelUserArray() {
        Channel channel = new Channel("test", "test", 0);
        ArrayList<Integer> array = new ArrayList<>();
        array.add(0);
        assertEquals(array, channel.getUserArray());
    }

    public void testChannelAdminArray() {
        Channel channel = new Channel("test", "test", 0);
        ArrayList<Integer> array = new ArrayList<>();
        array.add(0);
        assertEquals(array, channel.getAdminArray());
    }

    public void testChannelMessageArray() {
        Channel channel = new Channel("test", "test", 0);
        channel.addMessage(0, "Hello!");
        ArrayList<Pair<Integer, String>> array = new ArrayList<>();
        Pair<Integer, String> pair = new Pair<Integer, String>(0, "Hello!");
        array.add(pair);
        assertEquals(array, channel.getMessageArray());
    }

    public void testChannelIsUser() {
        Channel channel = new Channel("test", "test", 0);
        assertEquals(true, channel.isUser(0));
    }

    public void testChannelIsAdmin() {
        Channel channel = new Channel("test", "test", 0);
        assertEquals(true, channel.isAdmin(0));
    }
}