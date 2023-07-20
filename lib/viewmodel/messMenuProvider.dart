import 'package:flutter/foundation.dart';
import 'package:cloud_firestore/cloud_firestore.dart';

class MMenuProvider extends ChangeNotifier {
  final FirebaseFirestore firestore = FirebaseFirestore.instance;
  DocumentSnapshot? _documentSnapshot;

  Future fetchMenu() async {
    DateTime now = DateTime.now();
    int currentDayOfWeek = now.weekday;
    String dayName = '';

    switch (currentDayOfWeek) {
      case 1:
        dayName = 'Monday';
        break;
      case 2:
        dayName = 'Tuesday';
        break;
      case 3:
        dayName = 'Wednesday';
        break;
      case 4:
        dayName = 'Thursday';
        break;
      case 5:
        dayName = 'Friday';
        break;
      case 6:
        dayName = 'Saturday';
        break;
      case 7:
        dayName = 'Sunday';
        break;
      default:
        dayName = 'Unknown';
        break;
    }
    try {
      _documentSnapshot =
          await firestore.collection('MessMenu').doc(dayName).get();
      notifyListeners();
    } catch (e) {
      if (kDebugMode) {
        print('Error fetching data: $e');
      }
    }
  }

  DocumentSnapshot? get documentSnapshot => _documentSnapshot;
}
