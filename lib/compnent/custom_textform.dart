import 'package:flutter/material.dart';

class CustomTextFormField extends StatelessWidget {
  const CustomTextFormField({super.key ,required this.hinttext , required this.myController});
  final String hinttext;
  final TextEditingController myController;


  @override
  Widget build(BuildContext context) {
    return TextFormField(
      controller:  myController,
      decoration: InputDecoration(
          hintText: hinttext,
          hintStyle: const TextStyle(
              fontSize: 14, fontWeight: FontWeight.bold, color: Colors.grey),
          contentPadding: const EdgeInsets.symmetric(vertical: 2, horizontal: 20),
          fillColor: Colors.grey,
          enabledBorder: OutlineInputBorder(
              borderRadius: BorderRadius.circular(20),
              borderSide: const BorderSide(
                color: Color.fromARGB(255, 184, 184, 184),
              )),
          border: OutlineInputBorder(
              borderRadius: BorderRadius.circular(20),
              borderSide: const BorderSide(
                color: Colors.grey,
              ))),
    );
  }
}
