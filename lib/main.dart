import 'package:chat_app/auth/login.dart';
import 'package:chat_app/auth/signup.dart';
import 'package:chat_app/categories/add_category.dart';
import 'package:chat_app/firebase_options.dart';
import 'package:chat_app/home_page.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:firebase_core/firebase_core.dart';
import 'package:flutter/material.dart';

void main() async {
  WidgetsFlutterBinding.ensureInitialized();
  await Firebase.initializeApp(options: DefaultFirebaseOptions.currentPlatform);

  runApp(const myApp());
}

class myApp extends StatefulWidget {
  const myApp({super.key});

  @override
  State<myApp> createState() => _myAppState();
}

class _myAppState extends State<myApp> {
  @override
  void initState() {
    FirebaseAuth.instance.authStateChanges().listen((User? user) {
      if (user == null) {
        print(
            '========================================User is currently signed out!');
      } else {
        print(
            '================================================User is signed in!');
      }
    });
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      theme: ThemeData(
        appBarTheme:AppBarTheme(
          backgroundColor: Colors.grey[50],
          titleTextStyle: TextStyle(
            color: Colors.orange,
            fontSize: 17.0,
            fontWeight: FontWeight.bold
          ),
          iconTheme: IconThemeData(
            color: Colors.orange
          )
        )
      ),
      debugShowCheckedModeBanner: false,
      home: const HomePage(),
      // (FirebaseAuth.instance.currentUser != null && FirebaseAuth.instance.currentUser!.emailVerified)
      // ? const HomePage() : const Login(),
      routes: {
        'login': (context) => const Login(),
        'signup': (context) => const SignUp(),
        'homepage' : (context) => const HomePage(),
        'categories' : (context) => const AddCategories(),

      },
    );
  }
}
