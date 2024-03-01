//Import code into java file before using any Firebase services:

// Import functions from SDKs
import { initializeApp } from "https://www.gstatic.com/firebasejs/10.8.0/firebase-app.js";
import { getAnalytics } from "https://www.gstatic.com/firebasejs/10.8.0/firebase-analytics.js";
import { getDatabase } from "https://www.gstatic.com/firebasejs/10.8.0/firebase-database.js";
// TODO: Add SDKs for Firebase products that you want to use
// https://firebase.google.com/docs/web/setup#available-libraries

// Firebase configuration
const firebaseConfig = {
    apiKey: "AIzaSyA0viLLs6CrOHAGsn9nsSGEKaIEMglaYxw",
    authDomain: "chatterbox-a99b2.firebaseapp.com",
    projectId: "chatterbox-a99b2",
    storageBucket: "chatterbox-a99b2.appspot.com",
    messagingSenderId: "42972061739",
    appId: "1:42972061739:web:ab04b53bbbe6a4839b4a6e",
    measurementId: "G-2T1PY8LDDY"
    databaseURL: "https://chatterbox-a99b2-default-rtdb.firebaseio.com/",
};

// Initialize Firebase
const app = initializeApp(firebaseConfig);
const analytics = getAnalytics(app);

// Initialize Realtime Database
const database = getDatabase(app);
