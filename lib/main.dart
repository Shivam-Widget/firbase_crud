import 'package:firebase_core/firebase_core.dart';
import 'package:firebase_crud/pages/home.dart';
import 'package:flutter/material.dart';

void main() async {
  WidgetsFlutterBinding.ensureInitialized();
  await Firebase.initializeApp(
      options: const FirebaseOptions(
    apiKey: "AIzaSyCkuDxZVlyuAIJmZdxl8mOemj1ybG-K_H0",
    appId: "1:202894940432:android:d3dc514d92cfd19fb86d95",
    messagingSenderId: "202894940432",
    projectId: "basicapp-32c88",
  ));
  runApp(const MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  @override
  Widget build(BuildContext context) {x
    return MaterialApp(
      debugShowCheckedModeBanner: false,
      title: 'Flutter Demo',
      theme: ThemeData(
        colorScheme: ColorScheme.fromSeed(seedColor: Colors.deepPurple),
        useMaterial3: true,
      ),
      home: const HomeScreen(),
    );
  }
}
