package com.chatterbox;

import java.io.FileInputStream;
import java.util.ArrayList;
import java.util.HashMap;
import java.util.Map;
import java.util.concurrent.CompletableFuture;
import java.util.concurrent.ExecutionException;

import com.google.auth.oauth2.GoogleCredentials;
import com.google.firebase.FirebaseApp;
import com.google.firebase.FirebaseOptions;
import com.google.firebase.database.ChildEventListener;
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

    public static ArrayList<Integer> getChildren(String entity) {
        /*
         * Function returns a list of all ids for the objects of type "entity" stored within firebase
         */

        // Create reference to the desired entity within firebase
        DatabaseReference ref = createEntityRef(entity);
        
        CompletableFuture<ArrayList<Integer>> future = new CompletableFuture<>();

        // Retrieve the data from the desired entity
        ref.addListenerForSingleValueEvent(new ValueEventListener() {
            @Override
            public void onDataChange(DataSnapshot dataSnapshot) {
                // Initialize ArrayList
                ArrayList<Integer> idarray = new ArrayList<>();

                // Iterate over each child in the snapshot
                for (DataSnapshot childSnapshot : dataSnapshot.getChildren()) {
                    // Get the key (auto-incrementing ID) of the child
                    int id = Integer.parseInt(childSnapshot.getKey());
                    idarray.add(id);
                }

                // Complete future with retrieved list
                future.complete(idarray);
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

        ref.orderByChild("uName").equalTo(username).addChildEventListener(new ChildEventListener() {
            @Override
            public void onChildAdded(DataSnapshot dataSnapshot, String prevChildKey) {
                User user = dataSnapshot.getValue(User.class);
                user.setUserID(Integer.parseInt(dataSnapshot.getKey()));
                future.complete(user);
            }

            @Override
            public void onCancelled(DatabaseError databaseError) {
                future.completeExceptionally(databaseError.toException());
            }

            @Override
            public void onChildChanged(DataSnapshot snapshot, String previousChildName) {
                throw new UnsupportedOperationException("Unimplemented method 'onChildChanged'");
            }

            @Override
            public void onChildRemoved(DataSnapshot snapshot) {
                throw new UnsupportedOperationException("Unimplemented method 'onChildRemoved'");
            }

            @Override
            public void onChildMoved(DataSnapshot snapshot, String previousChildName) {
                throw new UnsupportedOperationException("Unimplemented method 'onChildMoved'");
            }
        });
        return future.join();
    }

    public static User readUser(int uid) {
        /*
         * Function returns a user from database by uid
         */

        DatabaseReference ref = createEntityRef("User");
        CompletableFuture<User> future = new CompletableFuture<>();

        ref.child(String.valueOf(uid)).addListenerForSingleValueEvent(new ValueEventListener() {
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

    public static ArrayList<User> getPotDmPartners(int uid){           
        //returns a list of userIDs which whom the given userID does not yet have a DM chat

        //Obtain a list of all User objects from database
        ArrayList<User> allUsers = getAllUsers();

        //Obtain list of DM objects with dm chats that already exist for the given user
        ArrayList<Dm> existingDMs = getExistingDms(uid);

        ArrayList<User> potPartners = new ArrayList<User>();

        //loop over list of all users, for each user compare userId to list of userIds in existingDMs list
        for (User i: allUsers){
            int id = i.getUserID();
            boolean canAdd = true;
            for (Dm j: existingDMs){
                int userA = j.getUserA();
                int userB = j.getUserB();
                if((userA == id) || (userB == id) || (uid == id)){
                     canAdd = false;
                }
            }
            if (canAdd){
                potPartners.add(i);
            }
        }
        return potPartners;
    }

    public static ArrayList<User> getAllUsers(){                               
        //function returns a list of all existing user objects in the database 

        DatabaseReference ref = createEntityRef("User");
    
        final ArrayList<User> users = new ArrayList<User>();
        final CompletableFuture<Integer> future = new CompletableFuture<>();
    
        //iterate through User objects, add all to list
        ref.addValueEventListener(new ValueEventListener() {
            @Override
            public void onDataChange(DataSnapshot dataSnapshot) {
                for (DataSnapshot postSnapshot: dataSnapshot.getChildren()) { 
                    User i = postSnapshot.getValue(User.class);
                    i.setUserID(Integer.parseInt(dataSnapshot.getKey()));
                    users.add(i);
                }
                future.complete(1);
            }
            @Override
            public void onCancelled(DatabaseError databaseError) {
                // Handle errors
                System.out.println("Error reading all User objects: " + databaseError.getMessage());
            }
        });
        future.join();
        return users;
    }

    public static User readUserSettings(String uid) {
    
            DatabaseReference ref = createEntityRef("User");
            CompletableFuture<User> future = new CompletableFuture<>();
    
            ref.child(uid).addListenerForSingleValueEvent(new ValueEventListener() {
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
    public static void updateUserSettings(String userId, String userName, String firstName, 
                                          String lastName, String bio, String email, 
                                          String phone, String status) {
        try {
            DatabaseReference ref = createEntityRef("User");
            DatabaseReference userRef = ref.child(userId);

            Map<String, Object> userUpdates = new HashMap<>();
            userUpdates.put("username", userName);
            userUpdates.put("fName", firstName);
            userUpdates.put("lName", lastName);
            userUpdates.put("bio", bio);
            userUpdates.put("email", email);
            userUpdates.put("phoneNumber", phone);
            userUpdates.put("status", status);

            // Perform the update
            userRef.updateChildrenAsync(userUpdates).get();
        } catch (InterruptedException | ExecutionException e) {
            e.printStackTrace();
            // Handle the exception (e.g., log it, return error status, etc.)
        }
  }
   
}
