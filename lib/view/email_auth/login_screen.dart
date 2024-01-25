import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:auberge/resources/widgets/custom_button.dart';
import 'package:auberge/resources/widgets/custom_text_field.dart';
import 'package:auberge/utils/routes/routes_names.dart';
import 'package:auberge/utils/utils.dart';

class LoginScreen extends StatefulWidget {
  const LoginScreen({super.key});

  @override
  _LoginScreenState createState() => _LoginScreenState();
}

class _LoginScreenState extends State<LoginScreen> {
  TextEditingController emailController = TextEditingController();
  TextEditingController passwordController = TextEditingController();
  final FirebaseAuth _auth = FirebaseAuth.instance;
  final _formKey = GlobalKey<FormState>();
  bool loading = false;
  final List<String> hostelNames = [
    'Aryabhatt Hostel',
    'Ramanujan Hostel',
    'Vishveshwarya Bhawan - A Hostel',
    'Vishveshwarya Bhawan - B Hostel',
    'Raman Bhawan - A Hostel',
    'Raman Bhawan - B Hostel',
    'Bhabha Hostel',
  ];

  String? hostel;

  @override
  void dispose() {
    super.dispose();
    emailController.dispose();
    passwordController.dispose();
  }

  void login() {
    setState(() {
      loading = true;
    });
    _auth
        .signInWithEmailAndPassword(
            email: emailController.text.toString(),
            password: passwordController.text.toString())
        .then((value) {
      setState(() {
        loading = false;
      });
      Navigator.pushNamed(context, RoutesName.post, arguments: 0);
      Utils.toastMessage('Logged in as ${value.user!.email.toString()}😊');
    }).onError((error, stackTrace) {
      Utils.flushBarErrorMessage(error.toString(), context);
      setState(() {
        loading = false;
      });
    });
  }

  @override
  Widget build(BuildContext context) {
    double screenHeight = MediaQuery.of(context).size.height;
    double screenWidth = MediaQuery.of(context).size.width;

    return WillPopScope(
      onWillPop: () async {
        SystemNavigator.pop();
        return true;
      },
      child: SafeArea(
        child: Scaffold(
          backgroundColor: Colors.white,
          appBar: AppBar(
            automaticallyImplyLeading: false,
            title: const Text('Login'),
          ),
          body: SingleChildScrollView(
            child: SizedBox(
              height: screenHeight,
              child: ConstrainedBox(
                constraints: BoxConstraints(
                  minHeight: screenHeight,
                ),
                child: Column(
                  children: <Widget>[
                    Expanded(
                      child: Image.asset(
                        'assets/images/aub_logo4-removebg-preview.png',
                        width: screenWidth * 0.7,
                        height: screenHeight * 0.15,
                        fit: BoxFit.scaleDown,
                      ),
                    ),
                    Expanded(
                      child: Image.asset(
                        'assets/images/duck-dance-unscreen.gif',
                        width: screenWidth * 0.7,
                        height: screenHeight * 0.2,
                        fit: BoxFit.scaleDown,
                      ),
                    ),
                    Container(
                      padding: const EdgeInsets.only(top: 15),
                      decoration: BoxDecoration(
                        color: Theme.of(context).colorScheme.secondary,
                        borderRadius: BorderRadius.circular(30),
                      ),
                      child: Column(
                        mainAxisAlignment: MainAxisAlignment.center,
                        crossAxisAlignment: CrossAxisAlignment.center,
                        children: [
                          Padding(
                            padding: const EdgeInsets.only(
                                left: 12, right: 12, bottom: 12),
                            child: Container(
                              decoration: BoxDecoration(
                                color: Theme.of(context).colorScheme.secondary,
                                border:
                                    Border.all(color: Colors.black, width: 0.2),
                                borderRadius: BorderRadius.circular(20),
                                boxShadow: [
                                  BoxShadow(
                                    color: Colors.grey.withOpacity(0.3),
                                    offset: const Offset(2, 1),
                                    blurRadius: 2,
                                  ),
                                ],
                              ),
                              child: Padding(
                                padding: const EdgeInsets.only(left: 8.0),
                                child: DropdownButton(
                                  hint: const Text('Please choose a hostel'),
                                  value: hostel,
                                  onChanged: (newValue) {
                                    setState(() {
                                      hostel = newValue;
                                    });
                                  },
                                  items: hostelNames.map((hos) {
                                    return DropdownMenuItem(
                                      child: Text(hos),
                                      value: hos,
                                    );
                                  }).toList(),
                                ),
                              ),
                            ),
                          ),
                          const SizedBox(
                            height: 10,
                          ),
                          Form(
                            key: _formKey,
                            child: Column(
                              children: [
                                CustomTextField(
                                  hintText: 'Email',
                                  color: Colors.black,
                                  controller: emailController,
                                  icon: Icons.email,
                                  keyboardType: TextInputType.emailAddress,
                                  obscureText: false,
                                  validator: (value) {
                                    if (value!.isEmpty) {
                                      return 'Enter email';
                                    }
                                    return null;
                                  },
                                ),
                                const SizedBox(
                                  height: 5,
                                ),
                                CustomTextField(
                                  hintText: 'Password',
                                  color: Colors.black,
                                  controller: passwordController,
                                  icon: Icons.password,
                                  obscureText: true,
                                  keyboardType: TextInputType.text,
                                  validator: (value) {
                                    if (value!.isEmpty) {
                                      return 'Enter password';
                                    }
                                    return null;
                                  },
                                ),
                              ],
                            ),
                          ),
                          const SizedBox(
                            height: 30,
                          ),
                          CustomButton(
                            msg: 'Login',
                            loading: loading,
                            onTap: () {
                              if (_formKey.currentState!.validate()) {
                                login();
                              }
                            },
                          ),
                          Padding(
                            padding: const EdgeInsets.only(
                                left: 20, right: 12, bottom: 12),
                            child: Row(
                              children: [
                                Text(
                                  "Don't have an account already?",
                                  style: TextStyle(
                                      color: Theme.of(context)
                                          .colorScheme
                                          .tertiary),
                                ),
                                TextButton(
                                  onPressed: () {
                                    Navigator.pushNamed(
                                        context, RoutesName.signUp);
                                  },
                                  child: Text(
                                    'SignUp',
                                    style: TextStyle(
                                        fontWeight: FontWeight.bold,
                                        color: Theme.of(context)
                                            .colorScheme
                                            .tertiary),
                                  ),
                                ),
                              ],
                            ),
                          ),
                        ],
                      ),
                    ),
                    const SizedBox(
                      height: 20,
                    ),
                    const Text(
                      "Made for IETians with ❤️",
                      style: TextStyle(color: Colors.grey, fontSize: 18),
                    ),
                    const SizedBox(
                      height: 20,
                    ),
                  ],
                ),
              ),
            ),
          ),
        ),
      ),
    );
  }
}
