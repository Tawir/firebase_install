import 'package:chat_app/auth/login.dart';
import 'package:chat_app/auth/signup.dart';
import 'package:flutter/material.dart';

void main() async {
  // WidgetsFlutterBinding.ensureInitialized();
  // await Firebase.initializeApp();

  runApp(const myApp());
}

class myApp extends StatefulWidget {
  const myApp({super.key});

  @override
  State<myApp> createState() => _myAppState();
}

class _myAppState extends State<myApp> {
  @override
  // void initState() {
  //   // TODO: implement initState
  //   super.initState();
  //   FirebaseAuth.instance
  // .authStateChanges()
  // .listen((User? user) {
  //   if (user == null) {
  //     print('========================================User is currently signed out!');
  //   } else {
  //     print('================================================User is signed in!');
  //   }
  // });
 // }
  @override
  Widget build(BuildContext context) {
    return  MaterialApp(
      debugShowCheckedModeBanner: false,
      home: const SingUp(),
            routes: {
        'login': (context) => const Login(),
        'signup': (context) => const SingUp(),
      },
    );
  }
}