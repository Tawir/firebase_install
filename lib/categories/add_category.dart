
import 'package:chat_app/compnent/custom_textform.dart';
import 'package:chat_app/compnent/cutom_button.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/material.dart';

class AddCategories extends StatefulWidget {
  const AddCategories({super.key});

  @override
  State<AddCategories> createState() => _AddcategoriesState();
}

class _AddcategoriesState extends State<AddCategories> {
  TextEditingController nameController = TextEditingController();
  GlobalKey<FormState> formstate = GlobalKey<FormState>();
  CollectionReference categories =
      FirebaseFirestore.instance.collection('categories');
AddCategories() async {
  if (formstate.currentState!.validate()) {
    try {
      await categories.add({
        'name': nameController.text,
      });

      // Use a Builder to obtain a valid context within the Scaffold
      ScaffoldMessenger.of(context).showSnackBar(
        SnackBar(
          content: Text('Category added successfully.'),
        ),
      );

      // Navigate to the home page
      Navigator.pushReplacementNamed(context, 'homepage');
    } catch (e) {
      // Use a Builder to obtain a valid context within the Scaffold
      ScaffoldMessenger.of(context).showSnackBar(
        SnackBar(
          content: Text('Failed to add category. Please try again later.'),
        ),
      );
      print("Error adding category: $e");
    }
  }
}


  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        leading: IconButton
        (icon: Icon(Icons.arrow_back), onPressed: () { 
    Navigator.pushReplacementNamed(context, 'homepage');
          
         },
        ),
        title: Text('Add Category'),
      ),
      body: Padding(
        padding: const EdgeInsets.all(16.0),
        child: Form(
          key: formstate,
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.stretch,
            children: <Widget>[
              CustomTextFormField(
                myController: nameController,
                hinttext: 'add',
                validator: (value) {
                  if (value!.isEmpty) {
                    return 'Please enter a category name';
                  }
                  return null;
                },
              ),
              SizedBox(height: 20),
              CustomButton(title: 'Add', onPressed: (){
                AddCategories();
              }, color: Colors.orange)
            ],
          ),
        ),
      ),
    );
  }
}