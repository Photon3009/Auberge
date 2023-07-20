import 'package:auberge/resources/widgets/custom_button.dart';
import 'package:auberge/resources/widgets/custom_text_field.dart';
import 'package:auberge/utils/routes/routes_names.dart';
import 'package:auberge/utils/utils.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';

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
    'Bhabha Hostel'
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
      Utils.toastMessage('LogedIn as ${value.user!.email.toString()}😊');
    }).onError((error, stackTrace) {
      Utils.flushBarErrorMessage(error.toString(), context);
      setState(() {
        loading = false;
      });
    });
  }

  @override
  Widget build(BuildContext context) {
    double h = MediaQuery.of(context).size.height;
    // double w = MediaQuery.of(context).size.width;
    return WillPopScope(
      onWillPop: () async {
        SystemNavigator.pop();
        return true;
      },
      child: SafeArea(child: LayoutBuilder(
          builder: (BuildContext context, BoxConstraints viewportConstraints) {
        return Scaffold(
          appBar: AppBar(
            automaticallyImplyLeading: false,
            title: const Text('Login'),
          ),
          body: SingleChildScrollView(
            child: SizedBox(
              height: h / 1.1,
              child: ConstrainedBox(
                constraints: BoxConstraints(
                  minHeight: viewportConstraints.maxHeight,
                ),
                child: Column(
                  // mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                  children: [
                    Expanded(
                      child: Image.asset(
                        'assets/images/aub_logo4-removebg-preview.png',
                        width: 300,
                        height: 150,
                        fit: BoxFit.scaleDown,
                      ),
                    ),
                    Expanded(
                      child: Image.asset(
                        'assets/images/duck-dance-unscreen.gif',
                        width: 300,
                        height: 200,
                        fit: BoxFit.scaleDown,
                      ),
                    ),
                    Column(
                      mainAxisAlignment: MainAxisAlignment.center,
                      crossAxisAlignment: CrossAxisAlignment.center,
                      children: [
                        Padding(
                          padding: const EdgeInsets.only(
                              left: 12, right: 12, bottom: 12),
                          child: Container(
                            decoration: BoxDecoration(
                                color: Colors.white,
                                border:
                                    Border.all(color: Colors.black, width: 0.2),
                                borderRadius: BorderRadius.circular(20),
                                boxShadow: [
                                  BoxShadow(
                                      color: Colors.grey.withOpacity(0.3),
                                      offset: const Offset(2, 1),
                                      blurRadius: 2)
                                ]),
                            child: Padding(
                              padding: const EdgeInsets.only(left: 8.0),
                              child: DropdownButton(
                                hint: const Text(
                                    'Please choose a hostel'), // Not necessary for Option 1
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
                                    controller: emailController,
                                    icon: Icons.email,
                                    keyboardType: TextInputType.emailAddress,
                                    obscureText: false,
                                    validator: (value) {
                                      if (value!.isEmpty) {
                                        return 'Enter email';
                                      }
                                      return null;
                                    }),
                                const SizedBox(
                                  height: 5,
                                ),
                                CustomTextField(
                                    hintText: 'Password',
                                    controller: passwordController,
                                    icon: Icons.password,
                                    obscureText: true,
                                    keyboardType: TextInputType.text,
                                    validator: (value) {
                                      if (value!.isEmpty) {
                                        return 'Enter password';
                                      }
                                      return null;
                                    }),
                              ],
                            )),
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
                            }),
                        Padding(
                          padding: const EdgeInsets.only(
                              left: 20, right: 12, bottom: 12),
                          child: Row(
                            children: [
                              const Text("Don't have an account already?"),
                              TextButton(
                                  onPressed: () {
                                    Navigator.pushNamed(
                                        context, RoutesName.signUp);
                                  },
                                  child: const Text(
                                    'SignUp',
                                    style:
                                        TextStyle(fontWeight: FontWeight.bold),
                                  ))
                            ],
                          ),
                        ),
                      ],
                    ),
                    const SizedBox(
                      height: 20,
                    ),
                    const Text("Made for IETians with ❤️",
                        style: TextStyle(color: Colors.grey, fontSize: 18)),
                    const SizedBox(
                      height: 20,
                    ),
                  ],
                ),
              ),
            ),
          ),
        );
      })),
    );
  }
}
