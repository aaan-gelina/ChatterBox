package com.chatterbox;

import java.io.FileInputStream;
import java.util.ArrayList;
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

    public static Dm readDm(String dmKey) {    
        /* Function returns a dm object from database by key
        */

        DatabaseReference ref = createEntityRef("DMs");
        final CompletableFuture<Dm> future = new CompletableFuture<>();

        ref.child(dmKey).addListenerForSingleValueEvent(new ValueEventListener() {
            @Override
            public void onDataChange(DataSnapshot dataSnapshot) {
                Dm dm = dataSnapshot.getValue(Dm.class);
                dm.setKey(dataSnapshot.getKey());
                
                // Complete future with retrieved string
                future.complete(dm); 
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

    public static Dm readDm(int currentUser, int otherUser) {    
        /* Function returns a dm object from database given both userIds
        */
        
        final int currentU = currentUser;
        final int otherU = otherUser;

        DatabaseReference ref = createEntityRef("DMs");
        final CompletableFuture<Dm> future = new CompletableFuture<>();

        //find the right dm conversation by using both uids and iterating through existing DM chats
        ref.addValueEventListener(new ValueEventListener() {
            @Override
            public void onDataChange(DataSnapshot dataSnapshot) {
                for (DataSnapshot postSnapshot: dataSnapshot.getChildren()) {
                    Dm dm = postSnapshot.getValue(Dm.class);
                    dm.setKey(postSnapshot.getKey());
                    int userA = dm.getUserA();
                    int userB = dm.getUserB();
                    if((userA == otherU && userB == currentU)||(userB == otherU && userA == currentU)){
                        // Complete future with retrieved string
                        future.complete(dm);
                    }
                }
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

    public static ArrayList<Dm> getExistingDms(int uid){        
        //function returns an array of DM chat objects that exist and involve the given user

        DatabaseReference ref = createEntityRef("DMs");
    
        final int userId = uid;
        final ArrayList<Dm> chats = new ArrayList<Dm>();
        final CompletableFuture<Integer> future = new CompletableFuture<>();
    
        //iterate through existing DM chats, get the ones that the current user is part of 
        ref.addValueEventListener(new ValueEventListener() {
            @Override
            public void onDataChange(DataSnapshot dataSnapshot) {
                for (DataSnapshot postSnapshot: dataSnapshot.getChildren()) { 
                    Dm dm = postSnapshot.getValue(Dm.class);
                    dm.setKey(postSnapshot.getKey());
                    int userA = dm.getUserA();
                    int userB = dm.getUserB();
                    if ((userA == userId)||(userB == userId)){
                        chats.add(dm);
                    }
                }
                future.complete(1);
            }
            @Override
            public void onCancelled(DatabaseError databaseError) {
                // Handle errors
                System.out.println("Error reading available DM chats: " + databaseError.getMessage());
            }
        });
        future.join();
        return chats;
    }

    public static ArrayList<Integer> getPotDmPartners(int uid){             
        //returns a list of userIDs which whom the given userID does not yet have a DM chat

        //TODO: obtain a list of all userIDs from database using readUser(int uid) method, this is dummy data
        int[] allUsers = {1,2,3,4,5,6,7,8,9,10,11,12,13,14,15,16,17,18,19,20};

        //Obtain list of DM objects with dm chats that already exist for the given user
        ArrayList<Dm> existingDMs = getExistingDms(uid);

        ArrayList<Integer> potPartners = new ArrayList<Integer>();

        //loop over list of all users, for each user compare userIds to list of userIds in existingDMs list
        for (int i=0; i<allUsers.length; i++){
            boolean canAdd = true;
            for (Dm j: existingDMs){
                int userA = j.getUserA();
                int userB = j.getUserB();
                if((userA == allUsers[i]) || (userB == allUsers[i]) || (uid == allUsers[i])){
                     canAdd = false;
                }
            }
            if (canAdd){
                potPartners.add(allUsers[i]);
            }
        }
        return potPartners;
    }

   
}
