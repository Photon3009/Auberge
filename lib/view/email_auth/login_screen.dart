import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:auberge/resources/widgets/custom_button.dart';
import 'package:auberge/resources/widgets/custom_text_field.dart';
import 'package:auberge/utils/routes/routes_names.dart';
import 'package:auberge/utils/utils.dart';

class LoginScreen extends StatefulWidget {
  const LoginScreen({Key? key}) : super(key: key);

  @override
  _LoginScreenState createState() => _LoginScreenState();
}

class _LoginScreenState extends State<LoginScreen> {
  final TextEditingController _emailController = TextEditingController();
  final TextEditingController _passwordController = TextEditingController();
  final FirebaseAuth _auth = FirebaseAuth.instance;
  final GlobalKey<FormState> _formKey = GlobalKey<FormState>();
  bool _loading = false;
  String? _hostel;

  final List<String> _hostelNames = [
    'Aryabhatt Hostel',
    'Ramanujan Hostel',
    'Vishveshwarya Bhawan - A Hostel',
    'Vishveshwarya Bhawan - B Hostel',
    'Raman Bhawan - A Hostel',
    'Raman Bhawan - B Hostel',
    'Bhabha Hostel',
  ];

  @override
  void dispose() {
    _emailController.dispose();
    _passwordController.dispose();
    super.dispose();
  }

  Future<void> _login() async {
    setState(() {
      _loading = true;
    });

    try {
      // Attempt to sign in with provided email and password
      final UserCredential userCredential =
      await _auth.signInWithEmailAndPassword(
        email: _emailController.text,
        password: _passwordController.text,
      );
      // If successful, navigate to the post screen
      Utils.toastMessage('Logged in as ${userCredential.user!.email}😊');
      Navigator.pushNamed(context, RoutesName.post, arguments: 0);
    } catch (e) {
      // If sign in fails, display an error message
      Utils.flushBarErrorMessage(e.toString(), context);
    } finally {
      // Regardless of success or failure, stop loading
      setState(() {
        _loading = false;
      });
    }
  }

  Widget _buildHostelDropdown() {
    // Widget for building the dropdown button for selecting hostel
    return Padding(
      padding: const EdgeInsets.symmetric(horizontal: 12.0),
      child: DropdownButton<String>(
        hint: const Text('Please choose a hostel'),
        value: _hostel,
        onChanged: (String? newValue) {
          setState(() {
            _hostel = newValue;
          });
        },
        items: _hostelNames.map((String hos) {
          return DropdownMenuItem<String>(
            child: Text(hos),
            value: hos,
          );
        }).toList(),
      ),
    );
  }
bool _isSecurePassword=true;
  Widget togglePassword(){
    return IconButton(onPressed: (){
      setState(() {
        _isSecurePassword=!_isSecurePassword;
      });

    }, icon: _isSecurePassword?Icon(Icons.visibility):Icon(Icons.visibility_off));
  }
  Widget _buildForm() {
    // Widget for building the login form
    return Form(
      key: _formKey,
      child: Column(
        children: [
          Padding(
            padding: const EdgeInsets.symmetric(horizontal: 10.0),
            child: TextFormField(
              //color: Colors.black,
              decoration: InputDecoration(
                border: OutlineInputBorder(
                  borderRadius: BorderRadius.circular(20),
                ),
                hintText: 'Email',
                hintStyle: TextStyle(color: Colors.grey),
                prefixIconColor: Colors.grey,
                prefixIcon: Icon(Icons.email),
              ),
              controller: _emailController,
              obscureText: false,
              keyboardType: TextInputType.text,
              validator: (String? value) {
                if (value!.isEmpty) {
                  return 'Enter password';
                }
                return null;
              },
            ),
          ),
          // CustomTextField(
          //   hintText: 'Email',
          //   color: Colors.black,
          //   controller: _emailController,
          //   icon: Icons.email,
          //   keyboardType: TextInputType.emailAddress,
          //   obscureText: false,
          //   validator: (String? value) {
          //     if (value!.isEmpty) {
          //       return 'Enter email';
          //     }
          //     return null;
          //   },
          // ),
          const SizedBox(height: 5),
         Padding(
           padding: const EdgeInsets.symmetric(horizontal: 10.0),
           child: TextFormField(
              //color: Colors.black,
              decoration: InputDecoration(
                border: OutlineInputBorder(
                  borderRadius: BorderRadius.circular(20),
                ),
                hintText: 'Password',
                hintStyle: TextStyle(color: Colors.grey),
                prefixIconColor: Colors.grey,
                suffixIconColor: Colors.grey,
                suffixIcon: togglePassword(),
                prefixIcon: Icon(Icons.password),
              ),
              controller: _passwordController,

              obscureText: _isSecurePassword,
              keyboardType: TextInputType.text,
              validator: (String? value) {
                if (value!.isEmpty) {
                  return 'Enter password';
                }
                return null;
              },
            ),
         ),
        ],
      ),
    );
  }

  @override
  Widget build(BuildContext context) {
    return WillPopScope(
      onWillPop: () async {
        // Handle back button press to exit the app
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
              height: MediaQuery.of(context).size.height,
              child: ConstrainedBox(
                constraints: BoxConstraints(
                  minHeight: MediaQuery.of(context).size.height,
                ),
                child: Column(
                  children: <Widget>[
                    // Logo images
                    Expanded(
                      child: Image.asset(
                        'assets/images/aub_logo4-removebg-preview.png',
                        width: MediaQuery.of(context).size.width * 0.7,
                        height: MediaQuery.of(context).size.height * 0.15,
                        fit: BoxFit.scaleDown,
                      ),
                    ),
                    Expanded(
                      child: Image.asset(
                        'assets/images/duck-dance-unscreen.gif',
                        width: MediaQuery.of(context).size.width * 0.7,
                        height: MediaQuery.of(context).size.height * 0.2,
                        fit: BoxFit.scaleDown,
                      ),
                    ),
                    Container(
                      // Login form container
                      padding: const EdgeInsets.only(top: 15),
                      decoration: BoxDecoration(
                        color: Theme.of(context).colorScheme.secondary,
                        borderRadius: BorderRadius.circular(30),
                      ),
                      child: Column(
                        mainAxisAlignment: MainAxisAlignment.center,
                        crossAxisAlignment: CrossAxisAlignment.center,
                        children: [
                          _buildHostelDropdown(), // Hostel dropdown
                          const SizedBox(height: 10),
                          _buildForm(), // Login form
                          const SizedBox(height: 30),
                          // Login button
                          CustomButton(
                            msg: 'Login',
                            loading: _loading,
                            onTap: () {
                              if (_formKey.currentState!.validate()) {
                                _login();
                              }
                            },
                          ),
                          Padding(
                            padding: const EdgeInsets.only(
                              left: 20,
                              right: 12,
                              bottom: 12,
                            ),
                            child: Row(
                              children: [
                                // Signup link
                                Text(
                                  "Don't have an account already?",
                                  style: TextStyle(
                                    color: Theme.of(context)
                                        .colorScheme
                                        .tertiary,
                                  ),
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
                                          .tertiary,
                                    ),
                                  ),
                                ),
                              ],
                            ),
                          ),
                        ],
                      ),
                    ),
                    const SizedBox(height: 20),
                    // Footer text
                    const Text(
                      "Made for IETians with ❤️",
                      style: TextStyle(color: Colors.grey, fontSize: 18),
                    ),
                    const SizedBox(height: 20),
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
