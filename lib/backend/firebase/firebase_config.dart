import 'package:firebase_core/firebase_core.dart';
import 'package:flutter/foundation.dart';

Future initFirebase() async {
  if (kIsWeb) {
    await Firebase.initializeApp(
        options: FirebaseOptions(
            apiKey: "AIzaSyBmEN0v9rFohaG-WdAnZyt7K_LrJ3_Ilt8",
            authDomain: "ingo-brillate-ins-app.firebaseapp.com",
            projectId: "ingo-brillate-ins-app",
            storageBucket: "ingo-brillate-ins-app.appspot.com",
            messagingSenderId: "445780447373",
            appId: "1:445780447373:web:19fbf57fb9054abfa852c4",
            measurementId: "G-J0MCEY5Q9N"));
  } else {
    await Firebase.initializeApp();
  }
}
