import 'package:auberge/utils/utils.dart';
import 'package:auberge/viewmodel/users.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';

import 'resources/widgets/custom_button.dart';
import 'resources/widgets/custom_text_field.dart';
import 'utils/routes/routes_names.dart';

class EditScreen extends StatefulWidget {
  const EditScreen({Key? key}) : super(key: key);

  @override
  State<EditScreen> createState() => _EditScreenState();
}

class _EditScreenState extends State<EditScreen> {
  TextEditingController emailController = TextEditingController();
  TextEditingController nameController = TextEditingController();
  TextEditingController phoneController = TextEditingController();
  TextEditingController roomController = TextEditingController();

  final _formKey = GlobalKey<FormState>();
  final FirebaseAuth auth = FirebaseAuth.instance;
  final UserServices _userServices = UserServices();
  bool loading = false;
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
                        const SizedBox(
                          height: 100,
                        ),
                        CustomTextField(
                            hintText: 'Name',
                            color: Theme.of(context).colorScheme.secondary,
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
                            hintText: 'Email',
                            color: Theme.of(context).colorScheme.secondary,
                            controller: emailController,
                            icon: Icons.email,
                            keyboardType: TextInputType.emailAddress,
                            obscureText: false,
                            validator: (value) {
                              if (value!.isEmpty) {
                                return 'Enter email';
                              }
                              return null;
                            }),
                        const SizedBox(
                          height: 5,
                        ),
                        CustomTextField(
                            hintText: 'Phone Number',
                            color: Theme.of(context).colorScheme.secondary,
                            controller: phoneController,
                            icon: Icons.phone,
                            obscureText: true,
                            keyboardType: TextInputType.text,
                            validator: (value) {
                              if (value!.isEmpty) {
                                return 'Enter phone number';
                              }
                              return null;
                            }),
                        const SizedBox(
                          height: 5,
                        ),
                        CustomTextField(
                            hintText: 'Room No',
                            color: Theme.of(context).colorScheme.secondary,
                            controller: roomController,
                            icon: Icons.room,
                            obscureText: false,
                            keyboardType: TextInputType.text,
                            validator: (value) {
                              if (value!.isEmpty) {
                                return 'Enter room no.';
                              }
                              return null;
                            }),
                      ],
                    )),
                CustomButton(
                    msg: 'Edit details',
                    loading: loading,
                    onTap: () async {
                      if (_formKey.currentState!.validate()) {
                        User? user = await auth.currentUser;
                        setState(() {
                          loading = true;
                        });
                        try {
                          _userServices.createUser({
                            "id": user?.uid.toString(),
                            "name": nameController.text.toString(),
                            "email": emailController.text.toString(),
                            "number": phoneController.text.toString(),
                            "room": roomController.text.toString(),
                            "userType": "Regular",
                          });
                          setState(() {
                            loading = false;
                          });
                          // ignore: use_build_context_synchronously
                          Navigator.pushNamed(context, RoutesName.post,
                              arguments: 0);
                          Utils.toastMessage(
                              'User details added Successfully😊');
                        } catch (e) {
                          // ignore: use_build_context_synchronously
                          Utils.flushBarErrorMessage(e.toString(), context);
                          setState(() {
                            loading = false;
                          });
                        }
                      }
                    }),
                const SizedBox(
                  height: 20,
                ),
              ],
            )));
  }
}
