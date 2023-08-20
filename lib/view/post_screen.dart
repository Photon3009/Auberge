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
import 'package:flutter/foundation.dart';
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
  final PageController _pageController = PageController();

  void checkfun() async {
    if (user != null) {
      var userModel = await _userServicse.getUserById(user!.uid);
      final data = userModel?.name;
      if (kDebugMode) {
        print("data $data");
      }
      if (data == "") {
        check = true;
        setState(() {});
        if (kDebugMode) {
          print(check);
        }
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

  @override
  void dispose() {
    _pageController.dispose();
    super.dispose();
  }

  final List<String> _popupMenuList = [
    "Sign Out",
  ];

  void onTapChange(int index) {
    _pageController.animateToPage(
      index,
      duration: const Duration(milliseconds: 300),
      curve: Curves.easeInOut,
    );
  }

  void onPageChanged(int index) {
    setState(() {
      _currentIndex = index;
    });
  }

  @override
  Widget build(BuildContext context) {
    double w = MediaQuery.of(context).size.width;
    double h = MediaQuery.of(context).size.height;
    return check
        ? const UserOneTimeDetailScreen()
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
                          ],
                          selectedIndex: _currentIndex),
                    ),
                  ),
                  body: GestureDetector(
                    onHorizontalDragEnd: (details) {
                      // Detect the swipe direction and adjust the page index accordingly
                      if (details.primaryVelocity! > 0) {
                        if (_currentIndex > 0) {
                          _pageController.previousPage(
                              duration: const Duration(milliseconds: 300),
                              curve: Curves.easeInOut);
                        }
                      } else if (details.primaryVelocity! < 0) {
                        if (_currentIndex < 3) {
                          _pageController.nextPage(
                              duration: const Duration(milliseconds: 300),
                              curve: Curves.easeInOut);
                        }
                      }
                    },
                    child: PageView(
                      controller: _pageController,
                      physics:
                          const NeverScrollableScrollPhysics(), // Disable swipe gesture
                      onPageChanged: onPageChanged,
                      children: const [
                        HomeScreen(key: PageStorageKey("First Page")),
                        MComplainScreen(key: PageStorageKey("Second Page")),
                        MenuScreen(key: PageStorageKey("Third Page")),
                        ProfileScreen(key: PageStorageKey("Fourth Page")),
                      ],
                    ),
                  ),
                ),
              ]),
            )));
  }
}
