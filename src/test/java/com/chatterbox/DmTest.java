package com.chatterbox;

import java.util.ArrayList;
import junit.framework.TestCase;
import junit.framework.TestSuite;
import javafx.util.Pair;

public class DmTest extends TestCase {

    public DmTest(String testName) {
        super(testName);
    }

    public static TestSuite suite() {
        return new TestSuite(DmTest.class);
    }

    public void testDmInitialization() {
        Dm dm = new Dm(0, 1);
        assertNotNull(dm);
    }

    public void testDmGetUserA() {
        Dm dm = new Dm(0, 1);
        assertEquals(0, Dm.getUserA());
    }

    public void testDmGetUserB() {
        Dm dm = new Dm(0, 1);
        assertEquals(1, Dm.getUserB());
    }

    public void testDmSetUserA() {
        Dm dm = new Dm(0, 1);
        dm.setUserA(200);
        assertEquals(200, Dm.getUserA());
    }

    public void testDmSetUserB() {
        Dm dm = new Dm(0, 1);
        dm.setUserB(200);
        assertEquals(1, Dm.getUserB());
    }

    public void testDmMessage() {
        Dm dm = new Dm(0, 1);
        dm.setMessages("Hello");
        assertEquals("Hello", dm.getMessages());
    }

    public void testDmGetOtherUser() {
        Dm dm = new Dm(0, 1);
        assertEquals(1, dm.getOtherUser(0));
    }

    public void testDmSendMessage() {
        Dm dm = new Dm(0, 1);
        dm.sendMessage(0, "Hello!");
        assertEquals("`0`Hello!", dm.getMessages());
    }

    public void testDmMessageList() {
        Dm dm = new Dm(0, 1);
        dm.sendMessage(0, "Hello!");
        ArrayList<Message> array = new ArrayList<>();
        array.add(new Message(0, "Hello!"));
        assertEquals(array, dm.getMessageList());
    }
    
}