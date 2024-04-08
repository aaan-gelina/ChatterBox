package com.chatterbox;

import java.io.FileInputStream;
import java.util.concurrent.CompletableFuture;
import com.google.auth.oauth2.GoogleCredentials;
import com.google.firebase.FirebaseApp;
import com.google.firebase.FirebaseOptions;
import com.google.firebase.database.DataSnapshot;
import com.google.firebase.database.DatabaseReference;
import com.google.firebase.database.FirebaseDatabase;
import com.google.firebase.database.DatabaseError;
import com.google.firebase.database.ValueEventListener;

public class FirebaseConnect {
    public static void connectFirebase() {
        /*
         * Function connects to Firebase Database
         */

        try {
            FileInputStream serviceAccount = new FileInputStream(
                    "src\\main\\java\\com\\chatterbox\\lib\\chatterbox-a99b2-firebase-adminsdk-ygvbi-d459d7c613.json");

            @SuppressWarnings("deprecation")
            FirebaseOptions options = new FirebaseOptions.Builder()
                    .setCredentials(GoogleCredentials.fromStream(serviceAccount))
                    .setDatabaseUrl("https://chatterbox-a99b2-default-rtdb.firebaseio.com/")
                    .build();

            FirebaseApp.initializeApp(options);
        } catch (Exception e) {
            e.printStackTrace();
        }
    }

    public static DatabaseReference createEntityRef(String entity) {
        /*
         * Function creates reference to Firebase Database
         */

        // Connect to Firebase Database
        connectFirebase();

        // Create reference to entity
        DatabaseReference root = FirebaseDatabase.getInstance().getReference();
        DatabaseReference ref = root.child(entity);

        // Return reference
        return ref;
    }

    public static Channel readChannel(int cid) {
        /*
         * Function returns a channel from database by cid
         */

        DatabaseReference ref = createEntityRef("Channels");
        CompletableFuture<Channel> future = new CompletableFuture<>();

        ref.child(String.valueOf(cid)).addListenerForSingleValueEvent(new ValueEventListener() {
            @Override
            public void onDataChange(DataSnapshot dataSnapshot) {
                Channel channel = dataSnapshot.getValue(Channel.class);

                // Complete future with retrieved string
                future.complete(channel);
            }

            @Override
            public void onCancelled(DatabaseError databaseError) {
                // Handle errors
                future.completeExceptionally(databaseError.toException());
            }
        });

        // Wait for future completion, return result
        return future.join();
    }

    /* using username as it is easier to search since the uid is for database only and won't be known when searching
    feel free to change if needed */ 
    public static User readUser(String username) {

        DatabaseReference ref = createEntityRef("User");
        CompletableFuture<User> future = new CompletableFuture<>();

        ref.child(username).addListenerForSingleValueEvent(new ValueEventListener() {
            @Override
            public void onDataChange(DataSnapshot dataSnapshot) {
                User user = dataSnapshot.getValue(User.class);

                future.complete(user);
            }

            @Override
            public void onCancelled(DatabaseError databaseError) {
                future.completeExceptionally(databaseError.toException());
            }
        });
        return future.join();
    }

   
}
