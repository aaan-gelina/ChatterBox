import static org.mockito.Mockito.*;
import org.junit.Before;
import org.junit.Test;
import org.mockito.InjectMocks;
import org.mockito.Mock;
import org.mockito.MockitoAnnotations;
import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;
import com.google.firebase.database.*;

public class AccountSettingsTest {
    @Before
    public void setUp() {
        when(database.getReference("User")).thenReturn(ref);
        when(ref.child(anyString())).thenReturn(userRef);
    }

    @Test
    public void testDoPostUpdatesUserInfo() throws Exception {
        // Define test data
        String testUID = "testUID";
        String testUserName = "testUserName";
        String testFirstName = "testFirstName";
        String testLastName = "testLastName";
        String testBio = "testBio";
        String testEmail = "testEmail";
        String testPhone = "testPhone";
        String testStatus = "testStatus";

        // Mocking request behavior
        when(request.getParameter("UID")).thenReturn(testUID);
        when(request.getParameter("userName")).thenReturn(testUserName);
        when(request.getParameter("firstName")).thenReturn(testFirstName);
        when(request.getParameter("lastName")).thenReturn(testLastName);
        when(request.getParameter("bio")).thenReturn(testBio);
        when(request.getParameter("email")).thenReturn(testEmail);
        when(request.getParameter("phone")).thenReturn(testPhone);
        when(request.getParameter("status")).thenReturn(testStatus);

        // Execute doPost method
        accountSettings.doPost(request, response);

        // Prepare expected user updates
        Map<String, Object> expectedUserUpdates = new HashMap<>();
        expectedUserUpdates.put("username", testUserName);
        expectedUserUpdates.put("firstName", testFirstName);
        expectedUserUpdates.put("lastName", testLastName);
        expectedUserUpdates.put("bio", testBio);
        expectedUserUpdates.put("email", testEmail);
        expectedUserUpdates.put("phone", testPhone);
        expectedUserUpdates.put("status", testStatus);

        // Verify that user information is updated correctly
        verify(userRef).updateChildrenAsync(argThat(new ArgumentMatcher<Map<String, Object>>() {
            @Override
            public boolean matches(Map<String, Object> argument) {
                return argument.entrySet().equals(expectedUserUpdates.entrySet());
            }
        }));
    }
}
