<!DOCTYPE html>
<html>
<%@ page import="java.io.FileInputStream" %>
<%@ page import="com.google.auth.oauth2.GoogleCredentials" %>
<%@ page import="com.google.firebase.FirebaseApp" %>
<%@ page import="com.google.firebase.FirebaseOptions" %>
<%@ page import="com.google.firebase.database.DataSnapshot" %>
<%@ page import="com.google.firebase.database.DatabaseReference" %>
<%@ page import="com.google.firebase.database.FirebaseDatabase" %>
<%@ page import="com.google.firebase.database.DatabaseError" %>
<%@ page import="com.google.firebase.database.ValueEventListener" %>
<%@ page import="java.util.Map" %>
<%@ page contentType="text/html; charset=UTF-8" pageEncoding="UTF8"%>
<%

//Import into jsp file and call function before using any Firebase services:

public class Chatterbase() {

    public void connectdb() {
    /* Function connects to Firebase Database
    */

    // TODO: change URL to correct file path when running...
    try {
        FileInputStream serviceAccount = new FileInputStream("C:\Program Files\Apache Software Foundation\Tomcat 9.0\webapps\ChatterBox\WebContent\chatterbox-a99b2-firebase-adminsdk-ygvbi-d459d7c613.json");

            FirebaseOptions options = new FirebaseOptions.Builder()
                .setCredentials(GoogleCredentials.fromStream(serviceAccount))
                .setDatabaseUrl("https://chatterbox-a99b2-default-rtdb.firebaseio.com/")
                .build();

            FirebaseApp.initializeApp(options);
        } catch (Exception e) {
            e.printStackTrace();
        }
    }

    public DatabaseReference createRef(entity, primarykey) {
        /* Function creates reference to Firebase Database
        */

        // Connect to Firebase
        connectdb();

        // Create target reference
        DatabaseReference root = FirebaseDatabase.getInstance().getReference();
        DatabaseReference currentRef = root.child(entity).child(primaryKey);

        // Return reference
        return currentRef;
    }

    public String readStr(ref, child) {
        /* Function returns String of data from child of database reference
        */

        ref.child(child).addListenerForSingleValueEvent(new ValueEventListener() {
            @Override
            public void onDataChange(DataSnapshot dataSnapshot) {
                String str = dataSnapshot.getValue(String.class);
                return str;
            }

            @Override
            public void onCancelled(DatabaseError databaseError) {
                // Handle errors
                System.out.println("Error reading messages: " + databaseError.getMessage());
            }
        });
    }
}
%>
</html>