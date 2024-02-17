import 'dart:js_util';

import 'package:chat_app/auth/login.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:firebase_core/firebase_core.dart';
import 'package:flutter/material.dart';
import 'package:google_sign_in/google_sign_in.dart';

class HomePage extends StatefulWidget {
  const HomePage({super.key});

  @override
  State<HomePage> createState() => _HomePageState();
}

class _HomePageState extends State<HomePage> {
  List <QueryDocumentSnapshot> data =[];
  getData()async{
   QuerySnapshot querySnapshot = await FirebaseFirestore.instance.collection('categories').get();
   data.addAll(querySnapshot.docs);
   setState(() {
     
   });
  }
  @override
  void initState() {
    getData();
    // TODO: implement initState
    super.initState();
  }
  @override
  Widget build(BuildContext context) {
    return Scaffold(
floatingActionButton: FloatingActionButton(
  onPressed: (){},
  child: IconButton
  (icon: Icon(Icons.add , color: Colors.orange,),
  onPressed: (){
    Navigator.pushReplacementNamed(context, 'categories');
  },
  ),
),
      appBar: AppBar(
          backgroundColor: Colors.grey[50],
        title: Text('Categories', style: TextStyle(
                      color: Colors.orange,
            fontSize: 17.0,
            fontWeight: FontWeight.bold
        ),),
        actions: [
          IconButton(
              onPressed: () async {
                GoogleSignIn googleSignIn = GoogleSignIn();
                googleSignIn.disconnect();
                await FirebaseAuth.instance.signOut();
                Navigator.pushAndRemoveUntil(
                  context,
                  MaterialPageRoute(
                      builder: (context) =>
                          Login()), // Replace Login() with your login screen widget
                  (route) => false,
                );
              },
              icon: Icon(
                Icons.exit_to_app,
                color: Colors.orange,

              )),
        ],
      ),
      body: GridView.builder(
        itemCount: data.length,
          gridDelegate: SliverGridDelegateWithFixedCrossAxisCount
        (crossAxisCount: 2 ,mainAxisExtent: 160),
        itemBuilder: (BuildContext context, int index) {  
        return  Card(
            child: Container(
              padding: EdgeInsets.all(10.0),
              child: Column(
                children: [
                  Image.asset('20-folder-png-image.png',
                  height: 100.0,
                  ),
                  Text('${data[index]['name']}')
                ],
              ),
            ),
          ); 
        },
        ),
    );
  }
}
