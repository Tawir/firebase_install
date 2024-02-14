import 'package:chat_app/compnent/constent.dart';
import 'package:chat_app/compnent/custom_textform.dart';
import 'package:chat_app/compnent/customlogo.dart';
import 'package:chat_app/compnent/cutom_button.dart';
import 'package:firebase_auth/firebase_auth.dart';

import 'package:flutter/material.dart';

class SingUp extends StatefulWidget {
  const SingUp({super.key});

  @override
  State<SingUp> createState() => _SingUpState();
}

class _SingUpState extends State<SingUp> {
  TextEditingController username = TextEditingController();
  TextEditingController email = TextEditingController();
  TextEditingController password = TextEditingController();

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Container(
        child: Padding(
          padding: const EdgeInsets.all(20.0),
          child: ListView(
            children: [
              Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  const CustomLogo(),
                  kSizedBox,
                  const Text(
                    'SignUp',
                    style:
                        TextStyle(fontSize: 30.0, fontWeight: FontWeight.bold),
                  ),
                  const SizedBox(
                    height: 20.0,
                  ),
                  const Text(
                    'Login In to Coniune Using The App',
                    style: TextStyle(
                        color: Colors.grey, fontWeight: FontWeight.bold),
                  ),
                  kSizedBox,
                  const Text(
                    'Username ',
                    style: kTextStyle,
                  ),
                  CustomTextFormField(
                    hinttext: 'Enter your username',
                    myController: username,
                  ),
                  kSizedBox,
                  const Text(
                    'Email ',
                    style: kTextStyle,
                  ),
                  CustomTextFormField(
                    hinttext: 'Enter your Email',
                    myController: email,
                  ),
                  kSizedBox,
                  const Text(
                    'Password',
                    style: TextStyle(fontWeight: FontWeight.bold, fontSize: 18),
                  ),
                  CustomTextFormField(
                    hinttext: 'Enter your Password',
                    myController: password,
                  ),
                ],
              ),
              kSizedBox,
              CustomButton(
                title: 'SingUp',
                onPressed: () async {
                  try {
                    final credential = await FirebaseAuth.instance
                        .createUserWithEmailAndPassword(
                      email: email.text,
                      password: password.text,
                    );
                  } on FirebaseAuthException catch (e) {
                    if (e.code == 'weak-password') {
                      print('The password provided is too weak.');
                    } else if (e.code == 'email-already-in-use') {
                      print('The account already exists for that email.');
                    }
                  } catch (e) {
                    print(e);
                  }
                },
                color: Colors.orange,
              ),
              kSizedBox,
              InkWell(
                onTap: () {
                  Navigator.pushNamed(context, 'login');
                },
                child: Center(
                  child: RichText(
                    text: const TextSpan(
                      text: 'Have an acount? ',
                      children: <TextSpan>[
                        TextSpan(
                            text: 'LogIn',
                            style: TextStyle(
                                fontWeight: FontWeight.bold,
                                color: Colors.orange)),
                      ],
                    ),
                  ),
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }
}
