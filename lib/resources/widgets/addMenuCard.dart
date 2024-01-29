import 'package:auberge/resources/colors.dart';
import 'package:auberge/resources/widgets/custom_text_field.dart';
import 'package:auberge/utils/routes/routes_names.dart';
import 'package:auberge/utils/utils.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/material.dart';

class AddMessMenuCard extends StatefulWidget {
  final String day;

  const AddMessMenuCard({
    Key? key,
    required this.day,
  }) : super(key: key);

  @override
  State<AddMessMenuCard> createState() => _AddMessMenuCardState();
}

class _AddMessMenuCardState extends State<AddMessMenuCard> {
  late TextEditingController bController;
  late TextEditingController lController;
  late TextEditingController dController;
  bool loading = false;

  @override
  void initState() {
    super.initState();
    bController = TextEditingController();
    lController = TextEditingController();
    dController = TextEditingController();
  }

  @override
  void dispose() {
    bController.dispose();
    lController.dispose();
    dController.dispose();
    super.dispose();
  }

  void createMenu() {
    final brek = bController.text;
    final lun = lController.text;
    final din = dController.text;

    setState(() {
      loading = true;
    });

    FirebaseFirestore.instance
        .collection('MessMenu')
        .doc(widget.day)
        .set({
      'breakfast': brek,
      'lunch': lun,
      'dinner': din,
    }).then((value) {
      Utils.toastMessage('Menu added successfully');
      setState(() {
        loading = false;
      });
      bController.clear();
      lController.clear();
      dController.clear();

      Navigator.pop(context);
      Navigator.pushNamed(context, RoutesName.post, arguments: 1);
    }).catchError((error) {
      setState(() {
        loading = false;
      });
      Utils.flushBarErrorMessage('Failed to add menu: $error', context);
    });
  }

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.all(12),
      child: Container(
        padding: const EdgeInsets.all(16),
        decoration: BoxDecoration(
          color: primary.shade100.withOpacity(0.2),
          borderRadius: BorderRadius.circular(8),
        ),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Row(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: [
                Text(
                  widget.day,
                  style: const TextStyle(
                    fontSize: 22,
                    fontWeight: FontWeight.bold,
                    color: Colors.black,
                  ),
                ),
                IconButton(
                  onPressed: () {
                    showDialog(
                      context: context,
                      builder: (BuildContext context) {
                        return AlertDialog(
                          title: const Text('Change Mess Menu'),
                          actions: <Widget>[
                            Center(
                              child: ElevatedButton(
                                onPressed: () {
                                  createMenu();
                                },
                                child: loading
                                    ? CircularProgressIndicator(
                                    color: Colors.white)
                                    : Text('Add'),
                              ),
                               ),
                            ],
                            content: SingleChildScrollView(
                              child: Expanded(
                                child: Column(
                                  children: [
                                    CustomTextField(
                                        hintText: "Breakfast",
                                        controller: bController,
                                        obscureText: false,
                                        keyboardType: TextInputType.text),
                                CustomTextField(
                                  hintText: "Lunch",
                                  controller: lController,
                                  keyboardType: TextInputType.text,
                                  obscureText: false,
                                ),
                                CustomTextField(
                                  hintText: "Dinner",
                                  controller: dController,
                                  keyboardType: TextInputType.text,
                                  obscureText: false,
                                ),
                              ],
                            ),
                          ),
                        );
                      },
                    );
                  },
                  icon: const Icon(Icons.add),
                  color: Colors.black,
                )
              ],
            ),
          ],
        ),
      ),
    );
  }
}
