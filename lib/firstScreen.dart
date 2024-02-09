import 'package:auberge/resources/widgets/custom_button.dart';
import 'package:flutter/material.dart';

import 'resources/colors.dart';
import 'utils/routes/routes_names.dart';

class FirstScreen extends StatefulWidget {
  const FirstScreen({Key? key}) : super(key: key);

  @override
  State<FirstScreen> createState() => _FirstScreenState();
}

class _FirstScreenState extends State<FirstScreen> {
  @override
  Widget build(BuildContext context) {
    double h = MediaQuery.of(context).size.height;
    double w = MediaQuery.of(context).size.width;
    return SafeArea(child: LayoutBuilder(
        builder: (BuildContext context, BoxConstraints viewportConstraints) {
      return Scaffold(
        backgroundColor: Colors.white,
        body: SingleChildScrollView(
          child: ConstrainedBox(
            constraints: BoxConstraints(
              minHeight: viewportConstraints.maxHeight,
            ),
            child: Column(
              children: [
                const SizedBox(
                  height: 10,
                ),
                Image.asset(
                  'assets/images/Aub4.png',
                  width: w,
                  height: h / 1.5,
                  fit: BoxFit.scaleDown,
                ),
                const SizedBox(
                  height: 10,
                ),
                Column(
                  children: [
                    const Text("Choose your preference",
                        style: TextStyle(color: Colors.grey, fontSize: 18)),
                    const SizedBox(
                      height: 10,
                    ),
                    //mention hostel
                    const Text("What's your",
                        style: TextStyle(
                            color: primary,
                            fontSize: 38,
                            fontWeight: FontWeight.bold)),
                    const SizedBox(
                      height: 2,
                    ),
                    const Text("IET Hostel",
                        style: TextStyle(
                            color: Colors.grey,
                            fontSize: 38,
                            fontWeight: FontWeight.bold)),
                    const SizedBox(
                      height: 30,
                    ),
                    CustomButton(
                        msg: 'Get Started',
                        onTap: () {
                          Navigator.pushNamed(context, RoutesName.signUp);
                        }),
                    const SizedBox(
                      height: 30,
                    ),
                  ],
                )
              ],
            ),
          ),
        ),
      );
    }));
  }
}
