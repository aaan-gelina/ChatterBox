package com.chatterbox;

import java.io.IOException;
import javax.servlet.*;
import javax.servlet.http.*;

import com.google.firebase.database.DataSnapshot;
import com.google.firebase.database.DatabaseError;
import com.google.firebase.database.DatabaseReference;
import com.google.firebase.database.ValueEventListener;
import java.util.concurrent.CompletableFuture;

public class Login extends HttpServlet {
    public void doPost(HttpServletRequest request, HttpServletResponse response) throws ServletException, IOException {

        // get input password and username
        String username = request.getParameter("username");
        String password = request.getParameter("password");

        if (getUserPassword(username) == password) {
            response.sendRedirect("home.jsp");
        } else {
            System.out.println("<meta http-equiv='refresh' content='3;URL=loginfront.jsp'>");// redirects after 3
                                                                                             // seconds
            System.out.println("<p style='color:red;'>Incorrect Password</p>");
        }
    }

    public String getUserPassword(String uname) {
        /*
         * Function to get user password that matches
         * username entered to check against database
         */

        DatabaseReference ref = FirebaseConnect.createEntityRef("User");
        CompletableFuture<String> future = new CompletableFuture<>();

        ref.child(uname).addListenerForSingleValueEvent(new ValueEventListener() {
            @Override
            public void onDataChange(DataSnapshot dataSnapshot) {
                User user = dataSnapshot.getValue(User.class);
                String password = user.getPassword();

                future.complete(password);
            }

            @Override
            public void onCancelled(DatabaseError databaseError) {
                future.completeExceptionally(databaseError.toException());
            }
        });

        return future.join();

    }

}
