import 'package:firebase_core/firebase_core.dart';
import 'package:flutter/material.dart';
import 'package:hotel_pfa/firebase_options.dart';
import 'package:hotel_pfa/pages/main_page.dart';
import 'package:hotel_pfa/screens/login-screen.dart';
import 'screens/screens.dart';
Future<void>main() async{
  WidgetsFlutterBinding.ensureInitialized();

  await Firebase.initializeApp(
      options: DefaultFirebaseOptions.currentPlatform
  );
  runApp(const MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({Key? key}) : super(key: key);

  // This widget is the root of your application.
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'book hotel',
      theme: ThemeData(

        primarySwatch: Colors.blue,
      ),
      home: loginScreen(),
    );
  }
}

