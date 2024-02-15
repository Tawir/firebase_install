import 'package:chat_app/auth/login.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
class HomePage extends StatefulWidget {
  const HomePage({super.key});

  @override
  State<HomePage> createState() => _HomePageState();
}

class _HomePageState extends State<HomePage> {
  @override
  Widget build(BuildContext context) {
    return  Scaffold(
      appBar: AppBar(
        backgroundColor: Colors.blue,
        title: Text('Install FireBase'),
        actions: [
          IconButton(
            onPressed: ()async{
              await FirebaseAuth.instance.signOut();
              Navigator.pushAndRemoveUntil(
  context,
  MaterialPageRoute(builder: (context) => Login()), // Replace Login() with your login screen widget
  (route) => false,
);

            },
            icon: Icon(Icons.exit_to_app,)
            ),
        ],
      ),
    );
  }
}