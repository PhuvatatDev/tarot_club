// 🌩️ Firebase Cloud Function – index.ts
// This file defines backend logic triggered by Firebase events.
// In this case, we automatically create a Firestore "AppUser" document
// whenever a new user registers via Firebase Authentication.

import * as functions from "firebase-functions"; // Used to define Cloud Functions (auth, firestore, http, etc.)
import * as admin from "firebase-admin"; // Used to access Firestore, Auth, and other Firebase services

// 🚀 Initialize Firebase Admin SDK
admin.initializeApp();

// 🔥 Shortcut for accessing Firestore
const db = admin.firestore();

// ✅ Triggered when a new user account is created via Firebase Auth
export const createAppUser = functions.auth.user().onCreate(async (user) => {
  // ✨ Extract key user information provided by Firebase Auth
  const { uid, email, displayName } = user;

  try {
    // 📄 Create a Firestore document in the "users" collection using the UID as document ID
    await db.collection("users").doc(uid).set({
      uid: uid,                                // Unique identifier from Firebase Auth
      email: email,                            // User's email address
      name: displayName ?? "",                 // Optional display name (fallback to empty string)
      createdAt: admin.firestore.FieldValue.serverTimestamp(), // Server-side timestamp
    });

    // 🟢 Log success (visible in Firebase Console > Functions > Logs)
    console.log(`AppUser created in Firestore for UID: ${uid}`);
  } catch (error) {
    // 🔴 Log any errors (also visible in the logs for debugging)
    console.error("Failed to create AppUser in Firestore", error);
  }
});
