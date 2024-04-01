<!-- This a test file, which acts as a backend to dmmenufront.jsp, providing dummy data to the frontend. -->
<!-- The purpose of this file is for testing the frontend data display whithout having to access the database -->

<%!
public ArrayList<Integer> getDmPartners(int uid){
    //function returns an dummy array of userIds with which the current user has a DM conversation with

    ArrayList<Integer> users = new ArrayList();

    //use this for loop when user already has DM conversations
    for (int i = 2; i<6; i++){
        users.add(i);
    }
    //to test for the case of "no DM conversations found", comment out loop and return empty list

    return users;
}
%>

<%!
public String getUsername(int uid){
    //this dummy functions returns a dummy username connected to given userID for testing
    int userId = uid;
    String username = "User #" + userId;

    return username;
}
%>
