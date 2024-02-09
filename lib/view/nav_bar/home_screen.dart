import 'package:auberge/resources/colors.dart';
import 'package:auberge/resources/widgets/announcemnet_containre.dart';
import 'package:auberge/utils/routes/routes_names.dart';
import 'package:auberge/viewmodel/users.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:flutter_spinkit/flutter_spinkit.dart';

class HomeScreen extends StatefulWidget {
  const HomeScreen({super.key});

  @override
  _HomeState createState() => _HomeState();
}

class _HomeState extends State<HomeScreen> {
  final user = FirebaseAuth.instance.currentUser;
  final UserServices _userServices = UserServices();
  String? name = "";

  Future<String?> _fetchName() async {
    try {
      var userModel = await _userServices.getUserById(user!.uid);
      return userModel?.name;
    } catch (e) {
      // Handle the error here, e.g., log it or return a default value
      print('Error fetching name: $e');
      return null;
    }
  }

  @override
  void initState() {
    super.initState();
    _fetchName().then((data) {
      setState(() {
        name = data;
      });
    });
  }

  @override
  Widget build(BuildContext context) {
    double h = MediaQuery.of(context).size.height;
    return SingleChildScrollView(
      child: Padding(
        padding: EdgeInsets.only(top: h / 50),
        child: Container(
          decoration: BoxDecoration(
              color: Theme.of(context).colorScheme.secondary,
              borderRadius: BorderRadius.only(
                  topLeft: Radius.circular(20), topRight: Radius.circular(20))),
          child: SizedBox(
            height: MediaQuery.of(context).size.height / 1.1,
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                const SizedBox(
                  height: 30,
                ),
                Row(
                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                  children: [
                    Row(
                      children: [
                        const SizedBox(
                          width: 20,
                        ),
                        Column(
                          crossAxisAlignment: CrossAxisAlignment.start,
                          children: [
                            if (name != null)
                              Text('Hi $name 👋',
                                  overflow: TextOverflow.ellipsis,
                                  style: TextStyle(
                                      color:Theme.of(context).colorScheme.tertiary,
                                      fontFamily: "Sen",
                                      fontSize: 30,
                                      fontWeight: FontWeight.w500)),
                            const SizedBox(
                              height: 8,
                            ),
                            const Text('Hostel Announcements',
                                style: TextStyle(
                                    color: Color.fromRGBO(139, 140, 142, 1),
                                    fontFamily: "Sen",
                                    fontSize: 25)),
                          ],
                        ),
                      ],
                    ),
                    Row(
                      children: [
                        IconButton(
                          icon: const Icon(Icons.add, size: 30),
                          onPressed: () {
                            // Perform search operation
                            Navigator.pushNamed(context, RoutesName.addAnnounce);
                          },
                        ),
                        const SizedBox(
                          width: 20,
                        ),
                      ],
                    )
                  ],
                ),
                // const SizedBox(
                //   height: 30,
                // ),
                SizedBox(
                    height: h / 1.36,
                    child: Column(
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: [
                          Expanded(
                            child: StreamBuilder<QuerySnapshot>(
                              stream: FirebaseFirestore.instance
                                  .collection('announcements')
                                  .snapshots(),
                              builder: (context, snapshot) {
                                if (snapshot.hasError) {
                                  return Text('Error: ${snapshot.error}');
                                }

                                if (!snapshot.hasData) {
                                  return Container(
                                      color: Theme.of(context).colorScheme.secondary,
                                      child: Center(
                                          child: SpinKitFadingCube(
                                              color: Theme.of(context)
                                                  .colorScheme
                                                  .primary, size: 100.0)));
                                }

                                // Data is available
                                final announcementDocs = snapshot.data!.docs;

                                if (announcementDocs.isEmpty) {
                                  return Center(
                                    child: Column(
                                      children: [
                                        const SizedBox(
                                          height: 70,
                                        ),
                                        Image.asset(
                                          'assets/images/aano.png',
                                          width: 270,
                                          height: 370,
                                          fit: BoxFit.scaleDown,
                                        ),
                                      ],
                                    ),
                                  );
                                }

                                return ListView.builder(
                                  itemCount: announcementDocs.length,
                                  reverse: false,
                                  itemBuilder: (context, index) {
                                    final announcement =
                                    announcementDocs[index].data()
                                    as Map<String, dynamic>?;
                                    final title =
                                        announcement?['title'] as String? ??
                                            "";
                                    final description =
                                        announcement?['description']
                                        as String? ??
                                            "";
                                    final timestamp = announcement?['date'];
                                    final time = DateTime.parse(timestamp);

                                    return AnnouncementContainer(
                                      title: title,
                                      description: description,
                                      timestamp: time,
                                    );
                                  },
                                );
                              },
                            ),
                          ),
                          // const SizedBox(
                          //   height: 10,
                          // ),
                        ]))
              ],
            ),
          ),
        ),
      ),
    );
  }
}