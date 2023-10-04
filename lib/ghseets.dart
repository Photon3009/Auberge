import 'package:auberge/utils/routes/routes_names.dart';
import 'package:auberge/utils/utils.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:gsheets/gsheets.dart';
import 'viewmodel/users.dart';

class Gsheets {
  static const _credentials = r'''
{
 YOUR GSEETS CREDENTIALS
}
''';

  static const _spreadsheetID = 'YOUR SPREADSHEET ID';
  final UserServices _userServicse = UserServices();

  Future<bool> readDatafromGSheet(String email, String hostel) async {
    final gsheets = GSheets(_credentials);
    final ss = await gsheets.spreadsheet(_spreadsheetID);
    var sheet = ss.worksheetByTitle(hostel);
    final rows = await sheet!.values.allRows();
    bool check = false;

    int numberOfRowsWithData = 0;
    for (final row in rows) {
      if (row.isNotEmpty) {
        numberOfRowsWithData++;
      }
    }

    List<Cell> cellsRow;
    for (var i = 1; i < numberOfRowsWithData + 1; i++) {
      cellsRow = await sheet.cells.row(i);
      print(cellsRow.elementAt(1).value);
      if (cellsRow.elementAt(1).value == email) {
        check = true;
        break;
      }
    }
    print(check);
    return check;
  }

  storingDetails(BuildContext context) async {
    final gsheets = GSheets(_credentials);
    final ss = await gsheets.spreadsheet(_spreadsheetID);
    var sheet = ss.worksheetByTitle('Aryabhatt Hostel');
    final rows = await sheet!.values.allRows();
    final user = FirebaseAuth.instance.currentUser;

    int numberOfRowsWithData = 0;
    for (final row in rows) {
      if (row.isNotEmpty) {
        numberOfRowsWithData++;
      }
    }

    List<Cell> cellsRow;
    for (var i = 1; i < numberOfRowsWithData + 1; i++) {
      cellsRow = await sheet.cells.row(i);
      print(cellsRow.elementAt(1).value);
      if (cellsRow.elementAt(1).value == user!.email) {
        try {
          _userServicse.createUser({
            "id": user.uid.toString(),
            "name": cellsRow.elementAt(0).value.toString(),
            "email": cellsRow.elementAt(1).value.toString(),
            "number": cellsRow.elementAt(3).value.toString(),
            "room": cellsRow.elementAt(2).value.toString(),
            "userType": "Regular",
          });

          Navigator.pushNamed(context, RoutesName.post, arguments: 0);
          Utils.toastMessage('User details fetched Successfully😊');
        } catch (e) {
          Utils.flushBarErrorMessage(e.toString(), context);
        }
        break;
      }
    }
  }
}
