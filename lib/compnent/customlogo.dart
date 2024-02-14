import 'package:flutter/material.dart';

class CustomLogo extends StatelessWidget {
  const CustomLogo({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Center(
      child: ClipRRect(
        borderRadius: BorderRadius.circular(70.0),
        child: Container(
          width: 100.0,
          height: 100.0,
          color: Colors.grey[200],
          child: Image.asset(
            'assets/accessories-notes-icon.png',
            fit: BoxFit.cover,
          ),
        ),
      ),
    );
  }
}
