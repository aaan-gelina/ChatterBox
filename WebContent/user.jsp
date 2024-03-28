<!DOCTYPE html>
<html>
    <%
    public class User{

        private static long count = 0;
        private long userID;
        private String fName, lName, uName, email, password;
    
        public user(String uName, String fName, String lName, String email, String password){
            this.userID = ++count;
            this.uName = uName;
            this.fName = fName;
            this.lName = lName;
            this.email = email;
            this.password = password;
        }
    
    
        public long getUserID() {
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
    %>
    </html>