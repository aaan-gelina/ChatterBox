package com.chatterbox;

import org.junit.Test;
import static org.junit.Assert.*;

public class SignupValidatorTest {

    @Test
    public void testValidEmail() {
        assertTrue("Valid email should return true", SignupValidator.validateEmail("example@test.com"));
    }

    @Test
    public void testInvalidEmail() {
        assertFalse("Invalid email should return false", SignupValidator.validateEmail("example.com"));
    }

    @Test
    public void testEmptyEmail() {
        assertFalse("Empty email should return false", SignupValidator.validateEmail(""));
    }

    @Test
    public void testValidPassword() {
        assertTrue("Valid password should return true", SignupValidator.validatePassword("Password#1"));
    }

    @Test
    public void testInvalidPasswordMissingCharacter() {
        assertFalse("Invalid password missing character should return false", SignupValidator.validatePassword("password1"));
    }

    @Test
    public void testShortPassword() {
        assertFalse("Short password should return false", SignupValidator.validatePassword("Pass#1"));
    }

    @Test
    public void testEmptyPassword() {
        assertFalse("Empty password should return false", SignupValidator.validatePassword(""));
    }
}
