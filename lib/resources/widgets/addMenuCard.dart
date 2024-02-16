import 'package:auberge/resources/colors.dart';
import 'package:auberge/resources/widgets/custom_text_field.dart';
import 'package:auberge/utils/routes/routes_names.dart';
import 'package:auberge/utils/utils.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/material.dart';

class AddMessMenuCard extends StatefulWidget {
  final String day;

  const AddMessMenuCard({
    super.key,
    required this.day,
  });

  @override
  State<AddMessMenuCard> createState() => _AddMessMenuCardState();
}

class _AddMessMenuCardState extends State<AddMessMenuCard> {
  @override
  Widget build(BuildContext context) {
    TextEditingController bController = TextEditingController();
    TextEditingController lController = TextEditingController();
    TextEditingController dController = TextEditingController();
    bool loading = false;

    void createComplain() {
      final brek = bController.text.toString();
      final lun = lController.text.toString();
      final din = dController.text.toString();

      setState(() {
        loading = true;
      });

      FirebaseFirestore.instance.collection('MessMenu').doc(widget.day).set({
        'brekfast': brek,
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

    return Padding(
      padding: const EdgeInsets.only(left: 12, right: 12, top: 12, bottom: 12),
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
                    decoration: TextDecoration.none,
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
                                    createComplain();
                                    // Navigator.of(context).pop();
                                  },
                                  child: loading
                                      ? CircularProgressIndicator(
                                    color: Colors.white,
                                  )
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
                                        color: Theme.of(context).colorScheme.secondary,
                                        controller: bController,
                                        obscureText: false,
                                        keyboardType: TextInputType.text),
                                    CustomTextField(
                                        hintText: "Lunch",
                                        color: Theme.of(context).colorScheme.secondary,
                                        controller: lController,
                                        obscureText: false,
                                        keyboardType: TextInputType.text),
                                    CustomTextField(
                                        hintText: "Dinner",
                                        color: Theme.of(context).colorScheme.secondary,
                                        controller: dController,
                                        obscureText: false,
                                        keyboardType: TextInputType.text),
                                  ],
                                ),
                              ),
                            ),
                          );
                        });
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
