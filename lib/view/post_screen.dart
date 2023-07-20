import 'package:auberge/resources/colors.dart';
import 'package:auberge/utils/routes/routes_names.dart';
import 'package:auberge/utils/utils.dart';
import 'package:auberge/view/nav_bar/home_screen.dart';
import 'package:auberge/view/nav_bar/m_complain_screen.dart';
import 'package:auberge/view/nav_bar/menu_screen.dart';
import 'package:auberge/view/user_one_time_details_screen.dart';
import 'package:auberge/view/nav_bar/user_profile_screen.dart';
import 'package:auberge/viewmodel/users.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:google_nav_bar/google_nav_bar.dart';

class PostScreen extends StatefulWidget {
  final int currentIndex;
  const PostScreen({Key? key, required this.currentIndex}) : super(key: key);

  @override
  State<PostScreen> createState() => _PostScreenState();
}

class _PostScreenState extends State<PostScreen> {
  final auth = FirebaseAuth.instance;
  final user = FirebaseAuth.instance.currentUser;
  final UserServices _userServicse = UserServices();
  var check = false;
  final PageStorageBucket pageStorageBucket = PageStorageBucket();

  void checkfun() async {
    if (user != null) {
      var userModel = await _userServicse.getUserById(user!.uid);
      final data = userModel?.name;
      print("data $data");
      if (data == "") {
        check = true;
        setState(() {});
        print(check);
      }
    }
  }

  int _currentIndex = 0;

  @override
  void initState() {
    _currentIndex = widget.currentIndex;
    checkfun();
    super.initState();
  }

  final List<String> _popupMenuList = [
    "Sign Out",
  ];

  void onTapChange(int index) {
    setState(() {
      _currentIndex = index;
    });
  }

  static final List<Widget> _widgetOptions = <Widget>[
    const HomeScreen(
      key: PageStorageKey("First Page"),
    ),
    const MComplainScreen(
      key: PageStorageKey("Second Page"),
    ),
    const MenuScreen(
      key: PageStorageKey("Third Page"),
    ),
    const ProfileScreen(
      key: PageStorageKey("Fourth Page"),
    )
  ];

  @override
  Widget build(BuildContext context) {
    double w = MediaQuery.of(context).size.width;
    double h = MediaQuery.of(context).size.height;
    return check
        ? UserOneTimeDetailScreen()
        : WillPopScope(
            onWillPop: () async {
              SystemNavigator.pop();
              return true;
            },
            child: SafeArea(
                child: Scaffold(
              body: Stack(children: [
                Scaffold(
                    appBar: AppBar(
                      automaticallyImplyLeading: false,
                      title: Center(
                        child: Column(
                          children: [
                            SizedBox(
                              height: h / 60,
                            ),
                            Row(
                              children: [
                                SizedBox(
                                  width: w / 4,
                                ),
                                Image.asset(
                                    'assets/images/aublogo3-removebg-preview.png',
                                    height: 80,
                                    fit: BoxFit.cover),
                              ],
                            ),
                          ],
                        ),
                      ),
                      backgroundColor: primary,
                      elevation: 0.0,
                      actions: [
                        PopupMenuButton(
                            icon: const Icon(
                              Icons.more_vert,
                              color: Colors.white,
                            ),
                            itemBuilder: (_) => _popupMenuList.map((menuItem) {
                                  return PopupMenuItem(
                                    child: Text(menuItem),
                                    onTap: () async {
                                      auth.signOut().then((value) {
                                        Navigator.pushNamed(
                                            context, RoutesName.login);
                                      }).onError((error, stackTrace) {
                                        Utils.flushBarErrorMessage(
                                            error.toString(), context);
                                      });
                                    },
                                  );
                                }).toList())
                      ],
                    ),
                    extendBody: true,
                    backgroundColor: primary,
                    bottomNavigationBar: Container(
                      decoration: BoxDecoration(
                          color: primary,
                          borderRadius: BorderRadius.circular(30)),
                      margin: const EdgeInsets.fromLTRB(15, 0, 15, 15),
                      child: Padding(
                        padding: const EdgeInsets.all(10),
                        child: GNav(
                            onTabChange: onTapChange,
                            backgroundColor: primary,
                            color: Colors.white,
                            activeColor: primary,
                            tabBackgroundColor: Colors.white,
                            padding: const EdgeInsets.all(5),
                            tabs: const [
                              GButton(
                                icon: Icons.home,
                                text: 'Home',
                              ),
                              GButton(
                                icon: Icons.app_registration_rounded,
                                text: 'Complain',
                                iconSize: 25,
                              ),
                              GButton(
                                icon: Icons.restaurant_menu,
                                text: 'Menu',
                              ),
                              GButton(
                                icon: Icons.account_circle,
                                text: 'User Profile',
                              ),
                            ]),
                      ),
                    ),
                    body: PageStorage(
                      bucket: pageStorageBucket,
                      child: _widgetOptions.elementAt(_currentIndex),
                    )
                    ),
              ]),
            )));
  }
}
