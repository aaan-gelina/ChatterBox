<!-- This a test file, which acts as a backend to dmpagefront.jsp, providing dummy data to the frontend. -->
<!-- The purpose of this file is for testing the frontend data display whithout having to access the database -->

<%!
public ArrayList<Message> getThreadArray(int currentUser, int otherUser) {
     /* Function returns a dummy string containing the current thread of DMs sent between the current logged-in user, 
    and a dummy other user*/
    String messages = "1`Hi!`2`Hi, how are you doing?`1`I'm doing good, wanna hang out tomorrow?`2`Sure, what time?`1`Any time works`2`Let's do 4pm then`1`Sounds good! See you then:)`2`Yup, cya";

    ArrayList<Message> result = new ArrayList();
    
    //to test for an empty string, comment out the for loop
    String[] parts = messages.split("`");
    for (int i = 0; i < parts.length; i += 2) {
        int userId = Integer.parseInt(parts[i]);
        String message = parts[i + 1];
        result.add(new Message(userId, message));
    }

    return result;
}
%>

<!-- NOTE: writeMessage function is not given for testing purposes, 
since it would include a reload of the page, and thus is not relevant for testing the layout -->