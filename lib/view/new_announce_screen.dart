import 'package:auberge/resources/widgets/custom_button.dart';
import 'package:auberge/utils/routes/routes_names.dart';
import 'package:auberge/utils/utils.dart';
import 'package:auberge/viewmodel/users.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';

class CreateAnnouncementScreen extends StatefulWidget {
  const CreateAnnouncementScreen({super.key});

  @override
  // ignore: library_private_types_in_public_api
  _CreateAnnouncementScreenState createState() =>
      _CreateAnnouncementScreenState();
}

class _CreateAnnouncementScreenState extends State<CreateAnnouncementScreen> {
  final _formKey = GlobalKey<FormState>();
  final _titleController = TextEditingController();
  final _descriptionController = TextEditingController();
  bool loading = false;
  final user = FirebaseAuth.instance.currentUser;
  final UserServices _userServicse = UserServices();
  String? userType = "";

  _fetch() async {
    var userModel = await _userServicse.getUserById(user!.uid);
    final data = userModel?.userType;
    userType = data;
  }

  @override
  void initState() {
    _fetch();
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('Create Announcement'),
      ),
      body: Padding(
        padding: const EdgeInsets.all(16.0),
        child: Form(
          key: _formKey,
          child: Center(
            child: Column(
              children: [
                const SizedBox(height: 30,),
                TextFormField(
                  controller: _titleController,
                  decoration: const InputDecoration(
                    labelText: 'Title',
                  ),
                  validator: (value) {
                    if (value!.isEmpty) {
                      return 'Please enter the title';
                    }
                    return null;
                  },
                ),
                const SizedBox(height: 16.0),
                TextFormField(
                  controller: _descriptionController,
                  decoration: const InputDecoration(
                    labelText: 'Description',
                  ),
                  validator: (value) {
                    if (value!.isEmpty) {
                      return 'Please enter the description';
                    }
                    return null;
                  },
                ),
                const SizedBox(height: 30.0),
                CustomButton(
                  msg: 'Create Announcement',
                  loading: loading,
                  onTap: () {
                    if (_formKey.currentState!.validate()) {
                      if (userType == "Admin") {
                        createAnnouncement();
                      } else {
                        if (userType == "") {
                          Utils.toastMessage("Please try again!");
                        } else {
                          Utils.toastMessage(
                              "Sorry! You are not authorized user to add announcement");
                        }
                      }
                    }
                  },
                ),
              ],
            ),
          ),
        ),
      ),
    );
  }

  void createAnnouncement() {
    final title = _titleController.text.toString();
    final description = _descriptionController.text.toString();
    DateTime currentDate = DateTime.now();
    setState(() {
      loading = true;
    });

    FirebaseFirestore.instance
        .collection('announcements')
        .doc(currentDate.toString())
        .set({
      'title': title,
      'description': description,
      'date': currentDate.toString(),
    }).then((value) {
      Utils.toastMessage('Announcement created successfully');
      setState(() {
        loading = false;
      });
      _formKey.currentState!.reset();
      _titleController.clear();
      _descriptionController.clear();
      Navigator.pop(context);
      Navigator.pushNamed(context, RoutesName.post,arguments: 0);
    }).catchError((error) {
      setState(() {
        loading = false;
      });
      Utils.flushBarErrorMessage(
          'Failed to create announcement: $error', context);
    });
  }
}
