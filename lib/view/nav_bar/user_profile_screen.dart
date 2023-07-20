import 'package:auberge/utils/routes/routes_names.dart';
import 'package:auberge/viewmodel/currentUser_provider.dart';
import 'package:flutter/foundation.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

class ProfileScreen extends StatefulWidget {
  const ProfileScreen({super.key});

  @override
  // ignore: library_private_types_in_public_api
  _HomeState createState() => _HomeState();
}

class _HomeState extends State<ProfileScreen> {
  @override
  Widget build(BuildContext context) {
    final userProvider = Provider.of<UserProvider>(context);
    userProvider.setUser();
    final userType = userProvider.user?.userType ?? 'Unknown';
    if (kDebugMode) {
      print('usertype:$userType');
    }
    final name = userProvider.user?.name ?? 'Loading';
    final email = userProvider.user?.email ?? 'Loading';
    final phone = userProvider.user?.number ?? 'Loading';
    final room = userProvider.user?.room ?? 'Loading';

    return Padding(
      padding: const EdgeInsets.only(top: 28.0),
      child: Container(
        decoration: const BoxDecoration(
            image: DecorationImage(
              image: AssetImage('assets/images/zyro-image (2).png'),
              fit: BoxFit.cover,
            ),
            borderRadius: BorderRadius.only(
                topLeft: Radius.circular(20), topRight: Radius.circular(20))),
        child: SizedBox(
          height: MediaQuery.of(context).size.height / 1.1,
          child: SingleChildScrollView(
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.center,
              children: [
                const SizedBox(height: 40.0),
                Text(
                  name,
                  style: const TextStyle(
                    fontSize: 34.0,
                    fontFamily: "Sen",
                    fontWeight: FontWeight.bold,
                  ),
                ),
                const SizedBox(height: 8.0),
                Text(
                  "Room No. $room",
                  style: const TextStyle(
                    fontSize: 25.0,
                    fontFamily: "Sen",
                    color: Color.fromARGB(255, 78, 77, 77),
                  ),
                ),
                const SizedBox(height: 16.0),
                const Divider(),
                ListTile(
                  leading: const Icon(
                    Icons.email,
                    color: Color.fromARGB(255, 106, 131, 76),
                  ),
                  title: Text(email,
                      style: const TextStyle(fontFamily: "Sen", fontSize: 18)),
                ),
                const Divider(),
                ListTile(
                  leading: const Icon(
                    Icons.phone,
                    color: Color.fromARGB(255, 106, 131, 76),
                  ),
                  title: Text(phone,
                      style: const TextStyle(fontFamily: "Sen", fontSize: 18)),
                ),
                const Divider(),
                ListTile(
                  leading: const Icon(
                    Icons.edit,
                    color: Color.fromARGB(255, 106, 131, 76),
                  ),
                  title: const Text("Edit details",
                      style: TextStyle(fontFamily: "Sen", fontSize: 18)),
                  onTap: () {
                    Navigator.pushNamed(context, RoutesName.editScreen);
                  },
                ),
                const Divider(),
                const SizedBox(height: 250.0),
                const Text("Made for IETians with ❤️",
                    style: TextStyle(
                        color: Colors.white,
                        fontFamily: "Sen",
                        fontSize: 18,
                        fontWeight: FontWeight.bold)),
                const SizedBox(height: 10.0),
                const Padding(
                  padding: EdgeInsets.only(left: 20, right: 20, bottom: 20),
                  child: Center(
                    child: Text(
                        "If you would like to provide feedback or suggest new features, please send an email to aubergefeedback@gmail.com",
                        style: TextStyle(
                            color: Colors.white,
                            fontFamily: "Sen",
                            fontSize: 15)),
                  ),
                ),
              ],
            ),
          ),
        ),
      ),
    );
  }
}
