import 'package:auberge/ghseets.dart';
import 'package:auberge/utils/routes/routes_names.dart';
import 'package:auberge/utils/utils.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/foundation.dart';
import 'package:flutter/material.dart';

class UserOneTimeDetailScreen extends StatefulWidget {
  const UserOneTimeDetailScreen({Key? key}) : super(key: key);

  @override
  State<UserOneTimeDetailScreen> createState() =>
      _UserOneTimeDetailScreenState();
}

class _UserOneTimeDetailScreenState extends State<UserOneTimeDetailScreen> {
  bool loading = false;
  final FirebaseAuth auth = FirebaseAuth.instance;
void _checkEmailExists() async {

    await Gsheets().storingDetails(context)  .then((value) {
      if (kDebugMode) {
        print('Stored');
      }
      Navigator.pushNamed(context, RoutesName.post,arguments:0 );
      
    }).onError((error, stackTrace) {
      Utils.toastMessage('Something went wrong!');
      setState(() {
        loading = false;
      });
    });
  }

  @override
  void initState() {
    super.initState();
    _checkEmailExists(); 
  }

  @override
  Widget build(BuildContext context) {


    return const SafeArea(
      child: Scaffold(
        backgroundColor: Colors.white,
        body: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          crossAxisAlignment: CrossAxisAlignment.center,
          children: [
            Center(child: Text('Fetching your deatils'),),
                        SizedBox(
              height: 20,
            ),
            CircularProgressIndicator(),
          ],
        ),
      ),
    );
  }
}
