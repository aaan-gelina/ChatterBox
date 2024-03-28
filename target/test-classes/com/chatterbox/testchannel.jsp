<!DOCTYPE html>
<html>
<%@ page file="channelback.jsp" %>
<%@ page import="org.junit.Test;"%>
<%@ page import="java.io.*,java.util.*,java.sql.*" %>
<%@ page import="java.util.ArrayList" %>
<%
public class testchannel {
    // Initialize a test Channel object
    private Channel channel;

    @Before
    public void setUp() {
        // Set up a new Channel object before each test
        channel = new Channel("test", 0);
    }

    @Test
    public void testChannelInitialization() {
        assertNotNull(channel);
    }

    @Test
    public void testChannelName() {
        // Test setting and getting channel name
        channel.setName("Test Channel");
        assertEquals("Test Channel", channel.getName());
    }

    @Test
    public void testChannelDescription() {
        // Test setting and getting channel description
        channel.setDesc("This is a test channel");
        assertEquals("This is a test channel", channel.getDesc());
    }

    @Test
    public void testChannelAdmins() {
        // Test adding and getting channel admins
        channel.addAdmin(0);
        assertTrue(channel.getAdminArray().contains(0));
    }

    @Test
    public void testChannelUsers() {
        // Test adding and getting channel users
        channel.addUser(0);
        assertTrue(channel.getUserArray().contains(0));
    }

    @Test
    public void testChannelMessages() {
        // Test adding and getting channel messages
        channel.addMessage(0, "Hello, World!");
        assertTrue(channel.getMessages().contains("`0`Hello, World!"));
    }

    @Test
    public void testRemoveMessage() {
        // Test removing a user from the channel
        channel.addMessage(0, "Hi");
        channel.removeMessage(0, "Hi");
        assertFalse(channel.getMessages().contains("`0`Hi"));
    }

    @Test
    public void testRemoveUser() {
        // Test removing a user from the channel
        channel.addUser(100);
        channel.removeUser(100);
        assertFalse(channel.getUserArray().contains(100));
    }

    @Test
    public void testRemoveAdmin() {
        // Test removing an admin from the channel
        channel.addAdmin(100);
        channel.removeAdmin(100);
        assertFalse(channel.getAdminArray().contains(100));
    }
}
%>
</html>