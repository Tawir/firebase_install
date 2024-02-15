
import 'package:awesome_dialog/awesome_dialog.dart';
import 'package:chat_app/compnent/constent.dart';
import 'package:chat_app/compnent/custom_textform.dart';
import 'package:chat_app/compnent/customlogo.dart';
import 'package:chat_app/compnent/cutom_button.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';

class SignUp extends StatefulWidget {
  const SignUp({Key? key}) : super(key: key);

  @override
  _SignUpState createState() => _SignUpState();
}

class _SignUpState extends State<SignUp> {
  final TextEditingController _usernameController = TextEditingController();
  final TextEditingController _emailController = TextEditingController();
  final TextEditingController _passwordController = TextEditingController();
  final GlobalKey<FormState> _formKey = GlobalKey<FormState>();

  @override
  void dispose() {
    _usernameController.dispose();
    _emailController.dispose();
    _passwordController.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Padding(
        padding: const EdgeInsets.all(20.0),
        child: ListView(
          children: [
            Form(
              key: _formKey,
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  const CustomLogo(),
                  kSizedBox,
                  const Text(
                    'SignUp',
                    style: TextStyle(fontSize: 30.0, fontWeight: FontWeight.bold),
                  ),
                  const SizedBox(height: 20.0),
                  const Text(
                    'Login In to Continue Using The App',
                    style: TextStyle(color: Colors.grey, fontWeight: FontWeight.bold),
                  ),
                  kSizedBox,
                  const Text(
                    'Username',
                    style: kTextStyle,
                  ),
                  CustomTextFormField(
                    hinttext: 'Enter your username',
                    myController: _usernameController,
                    validator: (value) {
                      if (value == null || value.isEmpty) {
                        return 'Please enter your username';
                      }
                      return null;
                    }, 
                  ),
                  kSizedBox,
                  const Text(
                    'Email',
                    style: kTextStyle,
                  ),
                  CustomTextFormField(
                    hinttext: 'Enter your Email',
                    myController: _emailController,
                    validator: (value) {
                      if (value == null || value.isEmpty) {
                        return 'Please enter your email';
                      }
                      return null;
                    },
                  ),
                  kSizedBox,
                  const Text(
                    'Password',
                    style: TextStyle(fontWeight: FontWeight.bold, fontSize: 18),
                  ),
                  CustomTextFormField(
                    hinttext: 'Enter your Password',
                    myController: _passwordController,
                    validator: (value) {
                      if (value == null || value.isEmpty) {
                        return 'Please enter your password';
                      }
                      return null;
                    },
                  ),
                ],
              ),
            ),
            kSizedBox,
            CustomButton(
              title: 'SignUp',
              onPressed: () async {
                if (_formKey.currentState!.validate()) {
                  try {
                    final credential = await FirebaseAuth.instance.createUserWithEmailAndPassword(
                      email: _emailController.text,
                      password: _passwordController.text,
                    );
                    Navigator.pushReplacementNamed(context, 'homepage');
                  } on FirebaseAuthException catch (e) {
                    String errorMessage = 'An error occurred';
                    if (e.code == 'weak-password') {
                      errorMessage = 'The password provided is too weak.';
                    } else if (e.code == 'email-already-in-use') {
                      errorMessage = 'The account already exists for that email.';
                    }
                    AwesomeDialog(
                      context: context,
                      dialogType: DialogType.error,
                      animType: AnimType.rightSlide,
                      headerAnimationLoop: false,
                      title: 'Error',
                      desc: errorMessage,
                      btnOkOnPress: () {},
                      btnOkIcon: Icons.cancel,
                      btnOkColor: Colors.red,
                    ).show();
                  } catch (e) {
                    print(e);
                    ScaffoldMessenger.of(context).showSnackBar(
                      const SnackBar(
                        content: Text('An unexpected error occurred'),
                      ),
                    );
                  }
                }
              },
              color: Colors.orange,
            ),
            kSizedBox,
            InkWell(
              onTap: () {
                Navigator.pushReplacementNamed(context, 'login');
              },
              child: Padding(
                padding: const EdgeInsets.symmetric(vertical: 20.0),
                child: Center(
                  child: RichText(
                    text: const TextSpan(
                      text: 'Have an account? ',
                      style: TextStyle(fontSize: 16, color: Colors.black),
                      children: <TextSpan>[
                        TextSpan(
                          text: 'LogIn',
                          style: TextStyle(
                            fontWeight: FontWeight.bold,
                            color: Colors.orange,
                          ),
                        ),
                      ],
                    ),
                  ),
                ),
              ),
            ),
          ],
        ),
      ),
      );
   }
   }