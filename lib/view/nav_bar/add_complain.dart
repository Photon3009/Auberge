import 'package:auberge/resources/widgets/custom_button.dart';
import 'package:auberge/resources/widgets/custom_text_field.dart';
import 'package:auberge/utils/routes/routes_names.dart';
import 'package:auberge/utils/utils.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';

class AddComplain extends StatefulWidget {
  AddComplain({Key? key}) : super(key: key);

  @override
  State<AddComplain> createState() => _AddComplainState();
}

class _AddComplainState extends State<AddComplain> {
  final _formKey = GlobalKey<FormState>();
  TextEditingController titleController = TextEditingController();
  TextEditingController desController = TextEditingController();
  TextEditingController roomController = TextEditingController();
  TextEditingController nameController = TextEditingController();
  bool loading = false;
  final user = FirebaseAuth.instance.currentUser;

  @override
  Widget build(BuildContext context) {
    return SafeArea(
      child: Scaffold(
        backgroundColor: Colors.white,
        body: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          crossAxisAlignment: CrossAxisAlignment.center,
          children: [
            Form(
                key: _formKey,
                child: Column(
                  children: [
                    CustomTextField(
                        hintText: 'Name',
                        controller: nameController,
                        icon: Icons.person,
                        keyboardType: TextInputType.text,
                        obscureText: false,
                        validator: (value) {
                          if (value!.isEmpty) {
                            return 'Enter name';
                          }
                          return null;
                        }),
                    const SizedBox(
                      height: 5,
                    ),
                    CustomTextField(
                        hintText: 'Title',
                        controller: titleController,
                        icon: Icons.title,
                        keyboardType: TextInputType.text,
                        obscureText: false,
                        validator: (value) {
                          if (value!.isEmpty) {
                            return 'Enter title';
                          }
                          return null;
                        }),
                    const SizedBox(
                      height: 5,
                    ),
                    CustomTextField(
                        hintText: 'Description',
                        controller: desController,
                        icon: Icons.description,
                        keyboardType: TextInputType.text,
                        obscureText: false,
                        validator: (value) {
                          if (value!.isEmpty) {
                            return 'Enter description';
                          }
                          return null;
                        }),
                    const SizedBox(
                      height: 5,
                    ),
                    CustomTextField(
                        hintText: 'Room Number',
                        controller: roomController,
                        icon: Icons.room,
                        obscureText: false,
                        keyboardType: TextInputType.number,
                        validator: (value) {
                          if (value!.isEmpty) {
                            return 'Enter room number';
                          }
                          return null;
                        }),
                  ],
                )),
            const SizedBox(
              height: 30,
            ),
            CustomButton(
                msg: 'Add complain',
                loading: loading,
                onTap: () {
                  if (_formKey.currentState!.validate()) {
                    createComplain();
                  }
                }),
            const SizedBox(
              height: 20,
            ),
          ],
        ),
      ),
    );
  }

  void createComplain() {
    final title = titleController.text.toString();
    final description = desController.text.toString();
    final name = nameController.text.toString();
    final room = roomController.text.toString();
    DateTime currentDate = DateTime.now();
    setState(() {
      loading = true;
    });

    FirebaseFirestore.instance
        .collection('complaints')
        .doc(currentDate.toString())
        .set({
      'name': name,
      'room': room,
      'title': title,
      'description': description,
      'date': currentDate.toString(),
      'uid': user!.uid.toString(),
      'status': "Pending"
    }).then((value) {
      Utils.toastMessage('Complain added successfully');
      setState(() {
        loading = false;
      });
      _formKey.currentState!.reset();
      titleController.clear();
      desController.clear();
      Navigator.pop(context);
      Navigator.pushNamed(context, RoutesName.post, arguments: 2);
    }).catchError((error) {
      setState(() {
        loading = false;
      });
      Utils.flushBarErrorMessage('Failed to add complain: $error', context);
    });
  }
}
