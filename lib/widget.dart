import 'package:flutter/material.dart';
import 'package:flutter/services.dart';

Widget sbh(double h) {
  return SizedBox(height: h,);
}

Widget formLogin({
  required TextEditingController controller,
  Widget? prefixIcon,
  Widget? suffixIcon,
  required String hint,
  required FormFieldValidator<String> validator,
  bool obscureText = false
}) {
  return TextFormField(
    obscureText: obscureText,
    controller: controller,
    validator: validator,
    style: const TextStyle(
      fontSize: 14,
    ),
    decoration: InputDecoration(
      filled: true,
      fillColor: Colors.grey.shade300,
      contentPadding: const EdgeInsets.symmetric(horizontal: 20.0),
      prefixIcon: prefixIcon,
      suffixIcon: suffixIcon,
      hintText: hint,
      hintStyle: const TextStyle(
        fontWeight: FontWeight.bold,
        fontSize: 14,
        color: Colors.grey,
      ),
      errorStyle: const TextStyle(
        color: Colors.red,
      ),
      border: InputBorder.none,
      enabledBorder: borderLogin(Colors.white),
      errorBorder: borderLogin(Colors.green),
      focusedBorder: borderLogin(Colors.white),
      focusedErrorBorder: borderLogin(Colors.green),
      disabledBorder: borderLogin(Colors.white),
    ),
  );
}

InputBorder borderLogin(Color color) {
  return OutlineInputBorder(
    borderSide: BorderSide(
      width: 1,
      color: color,
    ),
    borderRadius: BorderRadius.circular(10.0),
  );
}