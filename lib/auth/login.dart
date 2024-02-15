import 'package:chat_app/compnent/constent.dart';
import 'package:chat_app/compnent/custom_textform.dart';
import 'package:chat_app/compnent/customlogo.dart';
import 'package:chat_app/compnent/cutom_button.dart';
import 'package:flutter/material.dart';

class Login extends StatefulWidget {
  const Login({super.key});

  @override
  State<Login> createState() => _LoginState();
}

class _LoginState extends State<Login> {
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
                    'Login',
                    style:
                        TextStyle(fontSize: 30.0, fontWeight: FontWeight.bold),
                  ),
                  kSizedBox,
                  const Text(
                    'Login In to Coniune Using The App',
                    style: TextStyle(
                        color: Colors.grey, fontWeight: FontWeight.bold),
                  ),
                  kSizedBox,
                  const Text('Email ', style: kTextStyle),
                  kSizedBox,
                  CustomTextFormField(
                    hinttext: 'Enter your Email',
                    myController: email,
                  ),
                  kSizedBox,
                  const Text(
                    'Password',
                    style: kTextStyle,
                  ),
                  CustomTextFormField(
                    hinttext: 'Enter your Password',
                    myController: password,
                  ),
                  Container(
                    margin: const EdgeInsets.only(top: 10, bottom: 20),
                    alignment: Alignment.topRight,
                    child: const Text(
                      'Forget password ?',
                      textAlign: TextAlign.right,
                      style: TextStyle(fontSize: 14),
                    ),
                  ),
                ],
              ),
              CustomButton(
                title: 'Login',
                onPressed: () {},
                color: Colors.orange,
              ),
              kSizedBox,
              CustomButton(
                  title: 'LogIn With Google',
                  onPressed: () {},
                  color: Colors.red),
              kSizedBox,
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
                          fontSize: 16, // Adjust the font size as needed
                          color: Colors.black, // Change the color if desired
                        ),
                        children: <TextSpan>[
                          TextSpan(
                            text: 'Register',
                            style: TextStyle(
                              fontWeight: FontWeight.bold,
                              color: Colors.orange,
                              fontSize: 16, // Adjust the font size as needed
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
      ),
    );
  }
}
