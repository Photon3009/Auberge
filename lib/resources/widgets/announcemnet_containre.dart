import 'package:auberge/resources/colors.dart';
import 'package:flutter/material.dart';
import 'package:intl/intl.dart';

class AnnouncementContainer extends StatelessWidget {
  final String title;
  final String description;
  final DateTime timestamp;

  const AnnouncementContainer({
    super.key,
    required this.title,
    required this.description,
    required this.timestamp,
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
                  style: const TextStyle(
                    fontSize: 18,
                    fontWeight: FontWeight.bold,
                  ),
                ),
                const Icon(
                  Icons.info_outline,
                  color: Colors.red,
                )
              ],
            ),
            const SizedBox(height: 8),
            Text(
              description,
              style: const TextStyle(
                fontSize: 16,
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
