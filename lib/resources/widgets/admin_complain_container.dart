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
    super.key,
    required this.title,
    required this.description,
    required this.timestamp,
    required this.name,
    required this.room,
    required this.docId,
    required this.status,
  });

  @override
  Widget build(BuildContext context) {
    CollectionReference<Map<String, dynamic>> collectionRef =
        FirebaseFirestore.instance.collection('complaints');
    DocumentReference<Map<String, dynamic>> docRef = collectionRef.doc(docId);
    return Padding(
      padding: const EdgeInsets.only(left: 12, right: 12, top: 12, bottom: 12),
      child: Container(
        padding: const EdgeInsets.all(16),
        decoration: BoxDecoration(
          color: primary.shade100.withOpacity(0.2),
          borderRadius: BorderRadius.circular(8),
        ),
        child: Column(crossAxisAlignment: CrossAxisAlignment.start, children: [
          Row(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            children: [
              Text(
                title,
                style: const TextStyle(
                  fontSize: 18,
                  fontWeight: FontWeight.bold,
                  decoration: TextDecoration.none,
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
                      decoration: TextDecoration.none,
                      color: Colors.black,
                    ),
                  ),
                  Text(
                    status,
                    style: TextStyle(
                      fontSize: 18,
                      fontWeight: FontWeight.w500,
                      decoration: TextDecoration.none,
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
          Text(
            description,
            style: const TextStyle(
              fontSize: 16,
              decoration: TextDecoration.none,
              color: Colors.black,
            ),
          ),
          const SizedBox(height: 8),
          Text(
            'Complain By: $name',
            style: const TextStyle(
              fontSize: 16,
              decoration: TextDecoration.none,
              color: Color.fromARGB(255, 133, 133, 133),
            ),
          ),
          const SizedBox(height: 2),
          Text(
            'Room Number: $room',
            style: const TextStyle(
              fontSize: 16,
              decoration: TextDecoration.none,
              color: Color.fromARGB(255, 133, 133, 133),
            ),
          ),
          const SizedBox(height: 2),
          Text(
            '${DateFormat('dd-MM-yyyy').format(timestamp).toString()}  ${DateFormat('HH:mm:ss').format(timestamp)}',
            style: const TextStyle(
              fontSize: 14,
              color: Color.fromARGB(255, 133, 133, 133),
            ),
          ),
          Row(
            mainAxisAlignment: MainAxisAlignment.spaceEvenly,
            children: [
              Row(
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
                        Utils.toastMessage("Staus updated");
                      } catch (e) {
                        Utils.flushBarErrorMessage(e.toString(), context);
                      }
                    },
                  ),
                  const Text('Received')
                ],
              ),
              Row(
                children: [
                  IconButton(
                    icon: const Icon(
                      Icons.done,
                      size: 30,
                      color: Colors.green,
                    ),
                    onPressed: () {
                      try {
                        docRef.update({'status': 'Completed'});
                        Utils.toastMessage("Staus updated");
                      } catch (e) {
                        Utils.flushBarErrorMessage(e.toString(), context);
                      }
                    },
                  ),
                  const Text('Completed')
                ],
              ),
            ],
          ),
        ]),
      ),
    );
  }
}
