import 'package:flutter/material.dart';
import 'package:firebase_core/firebase_core.dart';
import 'package:think_ninjas_app/app_router.dart';
import 'firebase_options.dart';

void main() async {
  WidgetsFlutterBinding.ensureInitialized();

  try {
    await Firebase.initializeApp(
      options: DefaultFirebaseOptions.currentPlatform,
    );
    runApp(MyApp());
  } catch (error) {
    print("Error initializing Firebase: $error");
  }
}

class MyApp extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'Waiter App',
      theme: ThemeData(
        primarySwatch: Colors.amber,
      ),
      onGenerateRoute: AppRouter.generateRoute,
      initialRoute: AppRouter.rollSelector,
    );
  }
}



