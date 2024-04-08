
package com.chatterbox;

public class User {

    private static int count = 0;
    private int userID;
    private String fName, lName, uName, email, password, bio;

    //constructor to update account including bio
    public User(String uName, String fName, String lName, String email, String password, String bio) {
        this.userID = ++count;
        this.uName = uName;
        this.fName = fName;
        this.lName = lName;
        this.email = email;
        this.password = password;
        this.bio = bio;
    }

    //constructor for signup when bio isn't added
    public User(String uName, String fName, String lName, String email, String password) {
        this.userID = ++count;
        this.uName = uName;
        this.fName = fName;
        this.lName = lName;
        this.email = email;
        this.password = password;
    }

    public String getBio() {
        return this.bio;
    }

    public void setBio(String bio) {
        this.bio = bio;
    }

    public int getUserID() {
        return this.userID;
    }

    public String getFName() {
        return this.fName;
    }

    public void setFName(String fName) {
        this.fName = fName;
    }

    public String getLName() {
        return this.lName;
    }

    public void setLName(String lName) {
        this.lName = lName;
    }

    public String getUName() {
        return this.uName;
    }

    public void setUName(String uName) {
        this.uName = uName;
    }

    public String getEmail() {
        return this.email;
    }

    public void setEmail(String email) {
        this.email = email;
    }

    public String getPassword() {
        return this.password;
    }

    public void setPassword(String password) {
        this.password = password;
    }

}
