import 'package:flutter/material.dart';
import 'package:flutter/widgets.dart';

class MyButton {
  static var myButton = Container(
      decoration: BoxDecoration(
        borderRadius: BorderRadius.circular(12),
        color: Colors.blue,
      ),
      child: MaterialButton(
        onPressed: () {},
        child: const Text("data"),
      ));
}

Widget myTextFormField({
  required TextEditingController controller,
  required TextInputType,
  Function? onSubmit,
  Function? onChange,
  Function? onTap,
  bool isPassword = false,
  required Function validate,
  required String label,
  required Icon prefix,
  IconData? suffixPressed,
  bool isClickable = true,
}) =>
    TextFormField();
