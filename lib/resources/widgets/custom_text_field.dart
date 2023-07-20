import 'package:flutter/material.dart';

class CustomTextField extends StatelessWidget {
  final String hintText;
  final TextEditingController controller;
  final bool obscureText;
  final validator;
  final keyboardType;
  final icon;

  const CustomTextField(
      {Key? key,
      required this.hintText,
      required this.controller,
      required this.obscureText,
      this.validator,
      required this.keyboardType,
      this.icon= Icons.view_day})
      : super(key: key);
  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.only(left: 12, right: 12, bottom: 12),
      child: Container(
        decoration: BoxDecoration(
            color: Colors.white,
            border: Border.all(color: Colors.black, width: 0.2),
            borderRadius: BorderRadius.circular(20),
            boxShadow: [
              BoxShadow(
                  color: Colors.grey.withOpacity(0.3),
                  offset: const Offset(2, 1),
                  blurRadius: 2)
            ]),
        child: Padding(
          padding: const EdgeInsets.only(left: 8.0),
          child: TextFormField(
            keyboardType: keyboardType,
            controller: controller,
            obscureText: obscureText,
            validator: validator,
            decoration: InputDecoration(
                icon: Icon(icon, color: Colors.grey),
                border: InputBorder.none,
                hintText: hintText,
                hintStyle: const TextStyle(
                    color: Colors.grey, fontFamily: "Sen", fontSize: 18)),
          ),
        ),
      ),
    );
  }
}
