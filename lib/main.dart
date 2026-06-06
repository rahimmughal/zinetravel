import 'package:firebase_core/firebase_core.dart';
import 'package:flutter/material.dart';

import 'src/app.dart';

void main() async {
  WidgetsFlutterBinding.ensureInitialized();
  await Firebase.initializeApp(
    options: const FirebaseOptions(
      apiKey: 'AIzaSyDekCofR1DY86ntvclJ28rq9xkAsIXE_Vc',
      authDomain: 'zinetravel-753be.firebaseapp.com',
      projectId: 'zinetravel-753be',
      storageBucket: 'zinetravel-753be.firebasestorage.app',
      messagingSenderId: '174014631748',
      appId: '1:174014631748:web:c933e28e5fd1065bb3d111',
      measurementId: 'G-JTR5N9N2QD',
    ),
  );
  runApp(const SkyFlightMcrApp());
}
