import com.meterware.httpunit.*;
import org.junit.Test;
import static org.junit.Assert.*;

public class HomePageNavigationTest {
    //test for dm menu
    @Test
    public void testToDmMenu() throws Exception {
        WebClient client = new WebClient();
        WebResponse response = client.getResponse("http://localhost:8080/ChatterBox/WebContent/home.jsp");

        WebLink dmMenuLink = response.getLinkWithID("dmmenu");
        assertNotNull("DM Menu link not found", dmMenuLink);

        response = dmMenuLink.click();
        assertTrue("Should be on DM Menu page", response.getText().contains("Your DM Chats"));
    }

    //test for testchannels
    @Test
    public void testToChannelsLink() throws Exception {
        WebClient client = new WebClient();
        WebResponse response = client.getResponse("http://localhost:8080/ChatterBox/WebContent/home.jsp");

        WebLink channelLink = response.getLinkWithID("channel");
        assertNotNull("Channel link not found", channelLink);

        response = channelLink.click();
        assertTrue("Should be on Channel Menu Front page", response.getText().contains("Channels"));
    }


    //test for account setting
    @Test
    public void testToAccountSettings() throws Exception {
        WebClient client = new WebClient();
        WebResponse response = client.getResponse("http://localhost:8080/ChatterBox/WebContent/home.jsp");

        WebLink accountSettingsLink = response.getLinkWithID("accountsettings");
        assertNotNull("Account Settings link not found", accountSettingsLink);

        response = accountSettingsLink.click();
        assertTrue("Should be on Account Settings page", response.getText().contains("Account Settings"));
    }

    //test for logout
    @Test
    public void testToLogOut() throws Exception {
        WebClient client = new WebClient();
        WebResponse response = client.getResponse("http://localhost:8080/ChatterBox/WebContent/home.jsp");

        WebLink logoutLink = response.getLinkWithID("logout");
        assertNotNull("Logout link not found", logoutLink);

        response = logoutLink.click();
        assertTrue("Should be on Login page", response.getTitle().equals("ChatterBox Login Page"));
    }
}
