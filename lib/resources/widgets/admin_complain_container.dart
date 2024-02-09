import 'package:auberge/resources/colors.dart';
import 'package:auberge/utils/utils.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/material.dart';
import 'package:intl/intl.dart';

class AdminComplainContainer extends StatelessWidget {
  final String title;
  final String description;
  final DateTime timestamp;
  final String docId;
  final String name;
  final String room;
  final String status;

  const AdminComplainContainer({
    Key? key,
    required this.title,
    required this.description,
    required this.timestamp,
    required this.name,
    required this.room,
    required this.docId,
    required this.status,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    // Collection reference to the Firestore complaints collection
    final CollectionReference<Map<String, dynamic>> collectionRef =
    FirebaseFirestore.instance.collection('complaints');
    // Document reference to the specific complaint document
    final DocumentReference<Map<String, dynamic>> docRef = collectionRef.doc(docId);

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
                  title,
                  style: const TextStyle(
                    fontSize: 18,
                    fontWeight: FontWeight.bold,
                    color: Colors.black,
                  ),
                ),
                Column(
                  mainAxisAlignment: MainAxisAlignment.center,
                  children: [
                    const Text(
                      'Status',
                      style: TextStyle(
                        fontSize: 18,
                        fontWeight: FontWeight.bold,
                        color: Colors.black,
                      ),
                    ),
                    Text(
                      status,
                      style: TextStyle(
                        fontSize: 18,
                        fontWeight: FontWeight.w500,
                        color: (status == "Pending")
                            ? Colors.red
                            : (status == "Received")
                            ? Colors.amber[700]
                            : Colors.green,
                      ),
                    )
                  ],
                )
              ],
            ),
            const SizedBox(height: 8),
            // Description of the complaint
            Text(
              description,
              style: const TextStyle(
                fontSize: 16,
                color: Colors.black,
              ),
            ),
            const SizedBox(height: 8),
            // Name of the complaint
            Text(
              'Complain By: $name',
              style: const TextStyle(
                fontSize: 16,
                color: Color.fromARGB(255, 133, 133, 133),
              ),
            ),
            const SizedBox(height: 2),
            Text(
              'Room Number: $room',
              style: const TextStyle(
                fontSize: 16,
                color: Color.fromARGB(255, 133, 133, 133),
              ),
            ),
            const SizedBox(height: 2),
            // Timestamp of the complaint
            Text(
              '${DateFormat('dd-MM-yyyy HH:mm:ss').format(timestamp)}',
              style: const TextStyle(
                fontSize: 14,
                color: Color.fromARGB(255, 133, 133, 133),
              ),
            ),
            // Action buttons for updating complaint status
            Row(
              mainAxisAlignment: MainAxisAlignment.spaceEvenly,
              children: [
                IconButton(
                  icon: const Icon(
                    Icons.call_received,
                    size: 30,
                    color: Colors.red,
                  ),
                  onPressed: () {
                    try {
                      docRef.update({'status': 'Received'});
                      Utils.toastMessage("Status updated");
                    } catch (e) {
                      Utils.flushBarErrorMessage(e.toString(), context);
                    }
                  },
                ),
                const Text('Received'),
                IconButton(
                  icon: const Icon(
                    Icons.done,
                    size: 30,
                    color: Colors.green,
                  ),
                  onPressed: () {
                    try {
                      docRef.update({'status': 'Completed'});
                      Utils.toastMessage("Status updated");
                    } catch (e) {
                      Utils.flushBarErrorMessage(e.toString(), context);
                    }
                  },
                ),
                const Text('Completed'),
              ],
            ),
          ],
        ),
      ),
    );
  }
}
