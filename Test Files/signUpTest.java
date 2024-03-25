import static org.junit.Assert.*;
import org.junit.Test;

public class SignupTest {

    @Test
    public void testValidEmail() {
        assertTrue("Valid email should return true", signup.validateEmail("example@test.com"));
    }

    @Test
    public void testInvalidEmail() {
        assertFalse("Invalid email should return false", signup.validateEmail("example.com"));
    }

    @Test
    public void testEmptyEmail() {
        assertFalse("Empty email should return false", signup.validateEmail(""));
    }

    @Test
    public void testValidPassword() {
        assertTrue("Valid password should return true", signup.passValidate("Password#1"));
    }

    @Test
    public void testInvalidPasswordMissingCharacter() {
        assertFalse("Invalid password missing character should return false", signup.passValidate("password1"));
    }

    @Test
    public void testShortPassword() {
        assertFalse("Short password should return false", signup.passValidate("Pass#1"));
    }

    @Test
    public void testEmptyPassword() {
        assertFalse("Empty password should return false", signup.passValidate(""));
    }
}
