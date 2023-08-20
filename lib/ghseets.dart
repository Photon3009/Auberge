import 'package:auberge/utils/routes/routes_names.dart';
import 'package:auberge/utils/utils.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:gsheets/gsheets.dart';
import 'viewmodel/users.dart';

class Gsheets {
  static const _credentials = r'''
{
  "type": "service_account",
  "project_id": "gsheets-hostel",
  "private_key_id": "ff560497895be0f6b8f6d9133d5b25aabfee1a41",
  "private_key": "-----BEGIN PRIVATE KEY-----\nMIIEvAIBADANBgkqhkiG9w0BAQEFAASCBKYwggSiAgEAAoIBAQCSSpmZsiPDRSBN\nydfqani5tHPqGfjnwdti9RxG602xmVi4k3Ky4+4P4VTNvAMcawxfLTBA574udQK2\nJbq5vbBx65scPJ//cr3+gQZU99yXVZ2ORbkwBjMQkyAzqYldHgDgzk9IRUVY2eUj\nUH0BCSEr29GD0gqHAaPD0Xsa7Yn/8R70DhVRduDOEojtNhk0eXC7uGPFxUyIS0ZA\nPGG9ydIHGnVGivfB6jfSehPBB1FLSqg586Nalx2TxyRbez7j5WS/l/0dbctdj7GC\nawcvLm/5sT8J6kl3t3/0upCzeXUEWHSHVwqovTHQLx75wzZPr2/IGhv6EW4Vb0D/\n6SZqKv2ZAgMBAAECggEAGtWXTlOYbsm/zrUPJ59HLN1Wg+MmvrBXI1RNzw57jm/Q\nD+9wEzNvKDePnDt4IJ7cQpsh5k38Gz54dFwAX/DVLFho9+mA+dUc19HoDO74ZkQc\npgvRF+eTN1+dgQyAt3V4+MOvVFTsjwtNFki93VJE5OwqBvGg37njxdgnqj1XWnyj\nu/1VEMte8NUWqARFoLIEhsWSSseXTpQb0zksOA2IiOpsNB2gN4HHDUvwep9jLxSx\nWbxG43eW5Rw6kCLFwOrDYYrnvKrLQ+i0I+h5IL4qbLwzFwdkJ77qw9z4E4jlNE7j\nUTNiA8KVOzFRI/Dijha2EgJCSgRccUu3BufwINzveQKBgQDKows9UpX1Q2Ysu9U0\n702TlQMu2VCvyUnOJ22GTnzRBgbBuoGROYj6McRGEOQXE+jSvrVdXFYk6Ziz7Ml8\noKQEFfyYFbjm8KItSwBCTMQEBbHhZ0sPU/asdMaCn1mvdZOgeiS+d8SGBsokO8NS\nYPbljVZIYf6u8hoH3tPrw8UcPQKBgQC40Pjwt3S22mQjRMTu8JVziBavHlpEr9sj\nzbMyKkyOCxNxelgUQYfpWbvIE0/l7kHUJulgpkisKFeRL/DkCGfiMdDGlO+COqaJ\n4OydnIz1esAyhK5tjc/0xzkrd0OxC80x1WjUejbMxxfynNI2WGypbtXV/ph96w6Z\n+iU7UHswjQKBgFKye5HJNH3lxbsX5Qk3aFeEhsoF0lILOd2yZZZcTcAYT4Wckegs\nrOQ+jzVxC0UH0QrA3c9+MYHa+4Dib9A21vj76BxBMTa+mdEWPMLSBWUG1fOBbjaR\nM6hp9+GzGqzqtRbXAkvhIQj5mGF1Kl9iRyCjr8TWiVPoZgs0OxSKztSZAoGAPxWF\ng5T7T9bny2oT1oNkYBUZuRihM0TbhjMWcY8ipnF9Z4SdP/zGSY6JnFeLNC7JZYMK\nsiTQNYNnsHUuwodj/j+GxeHchxVB91pBKeNf8gK+TAAiEd8QFrtR9lY1Ut92YQY5\nTB2TSv7CW9vPnSE9pe/hKbRHlOOBDmnl/4MPKZkCgYBLX0H1MB/b5TvfCIfqJlvy\n1v+fK4wd8lH+TuMzNtW57BBwp2ez4o3w6bLeEU65nxPX338KDEClwYWSyexnVfYt\nmnnqzbli+5sLl7hPe8Dzi4i8SQ10chr9j8rOw3Wmlb9oh5NBRJzOcBij1HOReyzx\nPGo4X+jJfWSY4XzBz/4l2g==\n-----END PRIVATE KEY-----\n",
  "client_email": "gsheets-for-flutter@gsheets-hostel.iam.gserviceaccount.com",
  "client_id": "107719268875423787685",
  "auth_uri": "https://accounts.google.com/o/oauth2/auth",
  "token_uri": "https://oauth2.googleapis.com/token",
  "auth_provider_x509_cert_url": "https://www.googleapis.com/oauth2/v1/certs",
  "client_x509_cert_url": "https://www.googleapis.com/robot/v1/metadata/x509/gsheets-for-flutter%40gsheets-hostel.iam.gserviceaccount.com",
  "universe_domain": "googleapis.com"
}
''';

  static const _spreadsheetID = '1rX7BMa4jcaxDDkCoV7Bsq7l_KLBfbkQvD1zUASBhUOc';
  final UserServices _userServicse = UserServices();

  Future<bool?> readDatafromGSheet(String email, String hostel) async {
    final gsheets = GSheets(_credentials);
    final ss = await gsheets.spreadsheet(_spreadsheetID); 
    var sheet = ss.worksheetByTitle(hostel);
    final rows = await sheet!.values.allRows();
    bool? check;

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
      print(cellsRow.elementAt(2).value);
      if (cellsRow.elementAt(2).value == user!.email) {
        try {
          _userServicse.createUser({
            "id": user.uid.toString(),
            "name": cellsRow.elementAt(1).value.toString(),
            "email": cellsRow.elementAt(2).value.toString(),
            "number": cellsRow.elementAt(4).value.toString(),
            "room": cellsRow.elementAt(3).value.toString(),
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
