import 'package:flutter/material.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:auberge/utils/routes/routes_names.dart';
import 'package:auberge/viewmodel/users.dart';
import 'package:auberge/resources/widgets/custom_button.dart';
import 'package:auberge/resources/widgets/custom_text_field.dart';
import 'package:auberge/utils/utils.dart';

class EditScreen extends StatefulWidget {
  const EditScreen({Key? key}) : super(key: key);

  @override
  State<EditScreen> createState() => _EditScreenState();
}

class _EditScreenState extends State<EditScreen> {
  TextEditingController _emailController = TextEditingController();
  TextEditingController _nameController = TextEditingController();
  TextEditingController _phoneController = TextEditingController();
  TextEditingController _roomController = TextEditingController();

  final GlobalKey<FormState> _formKey = GlobalKey<FormState>();
  final FirebaseAuth _auth = FirebaseAuth.instance;
  final UserServices _userServices = UserServices();
  bool _loading = false;

  @override
  Widget build(BuildContext context) {
    return SafeArea(
      child: Scaffold(
        backgroundColor: Theme.of(context).colorScheme.secondary,
        body: Column(
          children: [
            Form(
              key: _formKey,
              child: Column(
                children: [
                  const SizedBox(height: 100),
                  // Text field for name
                  CustomTextField(
                    hintText: 'Name',
                    color: Theme.of(context).colorScheme.secondary,
                    controller: _nameController,
                    icon: Icons.person,
                    keyboardType: TextInputType.text,
                    obscureText: false,
                    validator: (value) {
                      if (value!.isEmpty) {
                        return 'Enter name';
                      }
                      return null;
                    },
                  ),
                  const SizedBox(height: 5),
                  // Text field for email
                  CustomTextField(
                    hintText: 'Email',
                    color: Theme.of(context).colorScheme.secondary,
                    controller: _emailController,
                    icon: Icons.email,
                    keyboardType: TextInputType.emailAddress,
                    obscureText: false,
                    validator: (value) {
                      if (value!.isEmpty) {
                        return 'Enter email';
                      }
                      return null;
                    },
                  ),
                  const SizedBox(height: 5),
                  // Text field for phone number
                  CustomTextField(
                    hintText: 'Phone Number',
                    color: Theme.of(context).colorScheme.secondary,
                    controller: _phoneController,
                    icon: Icons.phone,
                    obscureText: true,
                    keyboardType: TextInputType.text,
                    validator: (value) {
                      if (value!.isEmpty) {
                        return 'Enter phone number';
                      }
                      return null;
                    },
                  ),
                  const SizedBox(height: 5),
                  // Text field for room number
                  CustomTextField(
                    hintText: 'Room No',
                    color: Theme.of(context).colorScheme.secondary,
                    controller: _roomController,
                    icon: Icons.room,
                    obscureText: false,
                    keyboardType: TextInputType.text,
                    validator: (value) {
                      if (value!.isEmpty) {
                        return 'Enter room no.';
                      }
                      return null;
                    },
                  ),
                ],
              ),
            ),
            // Button for editing details
            CustomButton(
              msg: 'Edit details',
              loading: _loading,
              onTap: () async {
                if (_formKey.currentState!.validate()) {
                  User? user = await _auth.currentUser;
                  setState(() {
                    _loading = true;
                  });
                  try {
                    // Create or update user details
                    _userServices.createUser({
                      "id": user?.uid.toString(),
                      "name": _nameController.text.toString(),
                      "email": _emailController.text.toString(),
                      "number": _phoneController.text.toString(),
                      "room": _roomController.text.toString(),
                      "userType": "Regular",
                    });
                    setState(() {
                      _loading = false;
                    });
                    // Navigate to post screen after successful update
                    Navigator.pushNamed(context, RoutesName.post, arguments: 0);
                    Utils.toastMessage('User details added Successfully😊');
                  } catch (e) {
                    // Display error message if update fails
                    Utils.flushBarErrorMessage(e.toString(), context);
                    setState(() {
                      _loading = false;
                    });
                  }
                }
              },
            ),
            const SizedBox(height: 20),
          ],
        ),
      ),
    );
  }
}
