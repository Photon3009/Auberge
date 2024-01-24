import 'package:auberge/resources/widgets/addMenuCard.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';

class AddMessMenu extends StatefulWidget {
  AddMessMenu({Key? key}) : super(key: key);

  @override
  State<AddMessMenu> createState() => _AddMessMenu();
}

class _AddMessMenu extends State<AddMessMenu> {
  TextEditingController titleController = TextEditingController();
  TextEditingController desController = TextEditingController();
  TextEditingController roomController = TextEditingController();
  TextEditingController nameController = TextEditingController();
  bool loading = false;
  final user = FirebaseAuth.instance.currentUser;

  @override
  Widget build(BuildContext context) {
    double h = MediaQuery.of(context).size.height;
    return SafeArea(
      child: Scaffold(
        backgroundColor: Theme.of(context).colorScheme.secondary,
        appBar: AppBar(
          title: const Text('Change Mess Menu'),
        ),
        body: SingleChildScrollView(
          child: SizedBox(
            height: h / 1.1,
            child: const Column(
              mainAxisAlignment: MainAxisAlignment.center,
              crossAxisAlignment: CrossAxisAlignment.center,
              children: [
                SizedBox(
                  height: 20,
                ),
                AddMessMenuCard(day: 'Monday'),
                AddMessMenuCard(day: 'Tuesday'),
                AddMessMenuCard(day: 'Wednesday'),
                AddMessMenuCard(day: 'Thurday'),
                AddMessMenuCard(day: 'Firday'),
                AddMessMenuCard(day: 'Saturday'),
              ],
            ),
          ),
        ),
      ),
    );
  }
}
