<!-- This a test file, which acts as a backend to adddmchatfront.jsp, providing dummy data to the frontend. -->
<!-- The purpose of this file is for testing the frontend data display whithout having to access the database -->

<%!
public ArrayList<Integer> getPotPartners(int uid){
    //function returns a dummy array of userIds with which the current user does not yet have a DM conversation with

    //obtain dummy list of users that current user already has a chat with
    ArrayList<Integer> alreadyExist = getDmPartners(uid);

    //create dummy list of all existing users on the app (leave out current user (#1))
    ArrayList<Integer> users = new ArrayList();
    for (int i = 2; i<20; i++){
        users.add(i);
    }

    //create dummy list for users that current user (#1) could start a DM chat with
    ArrayList<Integer> newChat = new ArrayList();
    
    //iterate through all users (except current user (#1)) and save the users with which user #1 currently has no DM chat with
    for (Integer i: users){
        if (!alreadyExist.contains(i)){
            newChat.add(i);
        }
    }

    return newChat;
}
%>
