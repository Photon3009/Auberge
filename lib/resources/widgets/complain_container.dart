import 'package:auberge/resources/colors.dart';
import 'package:flutter/material.dart';
import 'package:intl/intl.dart';

class ComplainContainer extends StatelessWidget {
  final String title;
  final String description;
  final DateTime timestamp;
  final String name;
  final String room;
  final String status;

  const ComplainContainer({
    super.key,
    required this.title,
    required this.description,
    required this.timestamp,
    required this.name,
    required this.room,
    required this.status,
  });

  @override
  Widget build(BuildContext context) {
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
                  title,
                  style: TextStyle(
                    fontSize: 18,
                    fontWeight: FontWeight.bold,
                    decoration: TextDecoration.none,
                    color: Theme.of(context).colorScheme.tertiary,
                  ),
                ),
                Column(
                  mainAxisAlignment: MainAxisAlignment.center,
                  children: [
                    Text(
                      'Status',
                      style: TextStyle(
                        fontSize: 18,
                        fontWeight: FontWeight.bold,
                        decoration: TextDecoration.none,
                        color: Theme.of(context).colorScheme.tertiary,
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
              style: TextStyle(
                fontSize: 16,
                decoration: TextDecoration.none,
                color: Theme.of(context).colorScheme.tertiary,
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
            const SizedBox(height: 8),
            Text(
              'Room Number: $room',
              style: const TextStyle(
                fontSize: 16,
                decoration: TextDecoration.none,
                color: Color.fromARGB(255, 133, 133, 133),
              ),
            ),
            const SizedBox(height: 8),
            Text(
              '${DateFormat('dd-MM-yyyy').format(timestamp).toString()}  ${DateFormat('HH:mm:ss').format(timestamp)}',
              style: const TextStyle(
                fontSize: 14,
                color: Color.fromARGB(255, 133, 133, 133),
              ),
            ),
          ],
        ),
      ),
    );
  }
}
