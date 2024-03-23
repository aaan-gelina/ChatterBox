<!DOCTYPE html>
<html>
<%@ page import="java.io.FileInputStream" %>
<%@ page import="com.google.auth.oauth2.GoogleCredentials" %>
<%@ page import="com.google.firebase.FirebaseApp" %>
<%@ page import="com.google.firebase.FirebaseOptions" %>
<%@ page contentType="text/html; charset=UTF-8" pageEncoding="UTF8"%>
<%

//Import into jsp file and call function before using any Firebase services:

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
%>
</html>