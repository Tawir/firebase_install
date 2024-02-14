import 'package:flutter/material.dart';

class CustomButton extends StatelessWidget {
  CustomButton({super.key , required this.title , required this.onPressed , required this.color});
  final String title ;
final Function onPressed;
final Color color;
  @override
  Widget build(BuildContext context) {
    return MaterialButton(
        child:  Text(title),
        height: 40.0,
        textColor: Colors.white,
        color: color,
        shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(20)),
        onPressed: () {}
        );
  }
}
