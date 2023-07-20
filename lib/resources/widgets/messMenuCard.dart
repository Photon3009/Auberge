import 'package:auberge/resources/colors.dart';
import 'package:flutter/material.dart';

class MessMenuCard extends StatelessWidget {
  final String lunch;
  final String dinner;
  final String breakfast;

  const MessMenuCard({
    super.key,
    required this.lunch,
    required this.dinner,
    required this.breakfast,
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
            const Row(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: [
                Text(
                  "Today's Mess Menu 🍜",
                  style: TextStyle(
                    fontSize: 22,
                    fontWeight: FontWeight.bold,
                    decoration: TextDecoration.none,
                    color: Colors.black,
                  ),
                ),
              ],
            ),
            const SizedBox(height: 8),
            Text(
              'Breakfast: $breakfast',
              style: const TextStyle(
                fontSize: 16,
                decoration: TextDecoration.none,
                color: Colors.black,
              ),
            ),
            const SizedBox(height: 8),
            Text(
              'Lunch: $lunch',
              style: const TextStyle(
                fontSize: 16,
                decoration: TextDecoration.none,
                color: Colors.black,
              ),
            ),
            const SizedBox(height: 8),
            Text(
              'Dinner: $dinner',
              style: const TextStyle(
                fontSize: 16,
                decoration: TextDecoration.none,
                color: Colors.black,
              ),
            ),
          ],
        ),
      ),
    );
  }
}
