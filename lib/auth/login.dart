import 'package:awesome_dialog/awesome_dialog.dart';
import 'package:chat_app/compnent/custom_textform.dart';
import 'package:chat_app/compnent/customlogo.dart';
import 'package:chat_app/compnent/cutom_button.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';

class Login extends StatefulWidget {
  const Login({Key? key}) : super(key: key);

  @override
  State<Login> createState() => _LoginState();
}

class _LoginState extends State<Login> {
  TextEditingController emailController = TextEditingController();
  TextEditingController passwordController = TextEditingController();
  GlobalKey<FormState> formstate = GlobalKey<FormState>();

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Padding(
        padding: const EdgeInsets.all(20.0),
        child: ListView(
          children: [
            Form(
              key: formstate,
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  const CustomLogo(),
                  const SizedBox(height: 20),
                  Text(
                    'Login',
                    style: TextStyle(fontSize: 30.0, fontWeight: FontWeight.bold),
                  ),
                  const SizedBox(height: 20),
                  Text(
                    'Login In to Continue Using The App',
                    style: TextStyle(color: Colors.grey, fontWeight: FontWeight.bold),
                  ),
                  const SizedBox(height: 20),
                  Text('Email', style: TextStyle(fontSize: 16)),
                  CustomTextFormField(
                    hinttext: 'Enter your Email',
                    myController: emailController,
                    validator: (val) {
                      if (val == "") return 'Please enter your email';
                      // Add additional validation if needed
                      return null;
                    },
                  ),
                  const SizedBox(height: 20),
                  Text('Password', style: TextStyle(fontSize: 16)),
                  CustomTextFormField(
                    hinttext: 'Enter your Password',
                    myController: passwordController,
                    validator: (val) {
                      if (val == "") return 'Please enter your password';
                      // Add additional validation if needed
                      return null;
                    },
                  ),
                  InkWell(
                    onTap: () {
                      // Navigate to password reset screen
                    },
                    child: const Padding(
                      padding: EdgeInsets.only(top: 10, bottom: 20),
                      child: Text(
                        'Forgot password?',
                        textAlign: TextAlign.right,
                        style: TextStyle(fontSize: 14, color: Colors.blue),
                      ),
                    ),
                  ),
                ],
              ),
            ),
            CustomButton(
              title: 'Login',
              onPressed: () async {
                if (formstate.currentState!.validate()) {
                  try {
                    final credential = await FirebaseAuth.instance.signInWithEmailAndPassword(
                      email: emailController.text,
                      password: passwordController.text,
                    );
                    // Navigate to home screen or show success message
                  } on FirebaseAuthException catch (e) {
                    String errorMessage = 'An error occurred';
                    if (e.code == 'user-not-found') {
                      errorMessage = 'No user found for that email.';
                    } else if (e.code == 'wrong-password') {
                      errorMessage = 'Wrong password provided for that user.';
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
            const SizedBox(height: 20),
            CustomButton(
              title: 'Login With Google',
              onPressed: () {
                // Implement Google sign-in functionality
              },
              color: Colors.red,
            ),
            const SizedBox(height: 20),
            InkWell(
              onTap: () {
                Navigator.pushReplacementNamed(context, 'signup');
              },
              child: Padding(
                padding: const EdgeInsets.symmetric(vertical: 20.0),
                child: Center(
                  child: RichText(
                    text: const TextSpan(
                      text: 'Don\'t Have an account? ',
                      style: TextStyle(
                        fontSize: 16,
                        color: Colors.black,
                      ),
                      children: <TextSpan>[
                        TextSpan(
                          text: 'Register',
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
