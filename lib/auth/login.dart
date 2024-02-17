import 'package:awesome_dialog/awesome_dialog.dart';
import 'package:chat_app/compnent/custom_textform.dart';
import 'package:chat_app/compnent/customlogo.dart';
import 'package:chat_app/compnent/cutom_button.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:google_sign_in/google_sign_in.dart';

class Login extends StatefulWidget {
  const Login({Key? key}) : super(key: key);

  @override
  State<Login> createState() => _LoginState();
}

class _LoginState extends State<Login> {
  TextEditingController emailController = TextEditingController();
  TextEditingController passwordController = TextEditingController();
  GlobalKey<FormState> formstate = GlobalKey<FormState>();

  Future<void> signInWithGoogle() async {
    try {
      final GoogleSignInAccount? googleUser = await GoogleSignIn().signIn();
      if (googleUser == null) {
        return;
      }
      final GoogleSignInAuthentication googleAuth =
          await googleUser.authentication;

      final credential = GoogleAuthProvider.credential(
        accessToken: googleAuth.accessToken,
        idToken: googleAuth.idToken,
      );

      await FirebaseAuth.instance.signInWithCredential(credential);
      Navigator.pushReplacementNamed(context, 'homepage');
    } catch (e) {
      print("Google Sign-In Error: $e");
      // Handle Google sign-in errors
      // For example, show an error dialog or toast
      ScaffoldMessenger.of(context).showSnackBar(
        SnackBar(content: Text('Google sign-in failed. Please try again.')),
      );
    }
  }

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
                    style:
                        TextStyle(fontSize: 30.0, fontWeight: FontWeight.bold),
                  ),
                  const SizedBox(height: 20),
                  Text(
                    'Login In to Continue Using The App',
                    style: TextStyle(
                        color: Colors.grey, fontWeight: FontWeight.bold),
                  ),
                  const SizedBox(height: 20),
                  Text('Email', style: TextStyle(fontSize: 16)),
                  CustomTextFormField(
                    hinttext: 'Enter your Email',
                    myController: emailController,
                    validator: (val) {
                      if (val == "") return 'Please enter your email';
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
                      return null;
                    },
                  ),
                  InkWell(
                    onTap: () async {
                      if (emailController.text == "") {
                        AwesomeDialog(
                          context: context,
                          dialogType: DialogType.error,
                          animType: AnimType.rightSlide,
                          title: 'Error',
                          desc: 'Please Enter Valid Email address',
                          btnOkOnPress: () {},
                          btnOkIcon: Icons.cancel,
                          btnOkColor: Colors.red,
                        ).show();
                        return;
                      }
                      try {
                        await FirebaseAuth.instance.sendPasswordResetEmail(
                            email: emailController.text);
                        AwesomeDialog(
                          context: context,
                          dialogType: DialogType.success,
                          animType: AnimType.rightSlide,
                          title: 'Success',
                          desc: 'Email Reset Link was sent to your Email',
                          btnOkOnPress: () {},
                          btnOkIcon: Icons.check,
                          btnOkColor: Colors.green,
                        ).show();
                      } catch (e) {
                                                 AwesomeDialog(
                        context: context,
                        dialogType: DialogType.error,
                        animType: AnimType.rightSlide,
                        title: 'Error',
                        desc: 'Please enter valid Email',
                        btnOkOnPress: () {},
                        btnOkIcon: Icons.check,
                        btnOkColor: Colors.red,
                      ).show();
                        print(e);
                      }
                      // Navigate to password reset screen
                    },
                    child: const Padding(
                      padding: EdgeInsets.only(top: 10, bottom: 20),
                      child: Text(
                        'Forgot password?',
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
                    final credential =
                        await FirebaseAuth.instance.signInWithEmailAndPassword(
                      email: emailController.text,
                      password: passwordController.text,
                    );
                    if (credential.user != null) {
                      if (credential.user!.emailVerified) {
                        Navigator.pushReplacementNamed(context, 'homepage');
                      } else {
                        print('Please verify your email.');
                      }
                    }
                  } on FirebaseAuthException catch (e) {
                    if (e.code == 'user-not-found' ||
                        e.code == 'wrong-password') {
                      AwesomeDialog(
                        context: context,
                        dialogType: DialogType.error,
                        animType: AnimType.rightSlide,
                        title: 'Error',
                        desc: e.message ?? 'Authentication failed',
                        btnOkOnPress: () {},
                        btnOkIcon: Icons.cancel,
                        btnOkColor: Colors.red,
                      ).show();
                    }
                  } catch (e) {
                    print("Login Error: $e");
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
              onPressed: signInWithGoogle,
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
