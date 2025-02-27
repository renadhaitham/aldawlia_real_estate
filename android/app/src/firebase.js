// Import Firebase SDK
import { initializeApp } from "firebase/app";
import { getFirestore } from "firebase/firestore";

// 🔹 Replace these with your Firebase project details
const firebaseConfig = {
   apiKey: "BBoarylIwUSfL_CFOZZ8806B7b5HE-1ffYhU1Rxz8LlYX4Yyb6cEiofM3_Gs5anUiYLB6ISXcqUsF-V-_YCExbQ",
   authDomain: "aldawlia-real-estate.firebaseapp.com",
   projectId: "aldawlia-real-estate",
   storageBucket: "aldawlia-real-estate.appspot.com",
   messagingSenderId: "499897107865",
   appId: "1:499897107865:android:33db26700398a5cce43f08"
};

// Initialize Firebase
const app = initializeApp(firebaseConfig);
const db = getFirestore(app);

export { db };
