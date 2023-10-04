import 'package:flutter/foundation.dart';
import 'package:flutter/material.dart';
import 'package:auberge/resources/widgets/messMenuCard.dart';
import 'package:auberge/resources/widgets/rating_slider.dart';
import 'package:auberge/resources/widgets/ratings_chart.dart';
import 'package:auberge/utils/routes/routes_names.dart';
import 'package:auberge/utils/utils.dart';
import 'package:auberge/viewmodel/currentUser_provider.dart';
import 'package:auberge/viewmodel/messMenuProvider.dart';
import 'package:provider/provider.dart';

class MenuScreen extends StatefulWidget {
  const MenuScreen({Key? key});

  @override
  _HomeState createState() => _HomeState();
}

class _HomeState extends State<MenuScreen> {
  @override
  Widget build(BuildContext context) {
    double screenHeight = MediaQuery.of(context).size.height;
    double screenWidth = MediaQuery.of(context).size.width;

    final userProvider = Provider.of<UserProvider>(context);
    userProvider.setUser();
    final userType = userProvider.user?.userType ?? 'Unknown';
    if (kDebugMode) {
      print('usertype:$userType');
    }

    final menuProvider = Provider.of<MMenuProvider>(context);
    menuProvider.fetchMenu();
    final data = menuProvider.documentSnapshot?.data() as Map<String, dynamic>?;
    final breakfast = data?['breakfast'] as String? ?? "Loading..";
    final lunch = data?['lunch'] as String? ?? "Loading..";
    final dinner = data?['dinner'] as String? ?? "Loading..";

    return Padding(
      padding: EdgeInsets.only(top: screenHeight / 30),
      child: Container(
        decoration: const BoxDecoration(
          color: Colors.white,
          borderRadius: BorderRadius.only(
            topLeft: Radius.circular(20),
            topRight: Radius.circular(20),
          ),
        ),
        child: SingleChildScrollView(
          child: SizedBox(
            height: screenHeight / 1.1,
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                const SizedBox(
                  height: 15,
                ),
                Row(
                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                  children: [
                    const Row(
                      children: [
                        SizedBox(
                          width: 20,
                        ),
                        Column(
                          crossAxisAlignment: CrossAxisAlignment.start,
                          children: [
                            Text(
                              'Mess Updates',
                              style: TextStyle(
                                color: Color.fromRGBO(139, 140, 142, 1),
                                fontFamily: "Sen",
                                fontSize: 25,
                              ),
                            ),
                          ],
                        ),
                      ],
                    ),
                    Row(
                      children: [
                        IconButton(
                          icon: const Icon(Icons.add, size: 30),
                          onPressed: () {
                            if (userType == "Admin") {
                              Navigator.pushNamed(context, RoutesName.mMenu);
                            } else {
                              Utils.toastMessage(
                                  "You don't have access to add mess menu");
                            }
                          },
                        ),
                        const SizedBox(
                          width: 20,
                        ),
                      ],
                    )
                  ],
                ),
                if (userType != "Admin")
                  Center(
                    child: Image.asset(
                      'assets/images/aubfoof.gif',
                      width: screenWidth * 0.75,
                      height: screenHeight * 0.3,
                      fit: BoxFit.fitWidth,
                    ),
                  ),
                MessMenuCard(
                  lunch: lunch,
                  breakfast: breakfast,
                  dinner: dinner,
                ),
                if (userType == "Admin")
                  SizedBox(
                    height: screenHeight / 2.2,
                    width: screenWidth,
                    child: Padding(
                      padding: const EdgeInsets.all(12),
                      child: StatisticsScreen(),
                    ),
                  )
                else if (userType == "Regular")
                  const RatingScreen(),
              ],
            ),
          ),
        ),
      ),
    );
  }
}
