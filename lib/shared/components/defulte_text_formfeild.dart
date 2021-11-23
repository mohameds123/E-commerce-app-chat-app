import 'package:flutter/material.dart';
class DefaultFormField extends StatelessWidget
{
  TextEditingController controller;
  String lable;
  IconData prefix;
  TextInputType type;
  FormFieldValidator<String>validator;
  DefaultFormField({
    required this.prefix,
    required this.lable,
    required this.controller,
    required this.type,
    required this.validator,
});
  @override
  Widget build(BuildContext context) {
    return TextFormField(
      style: TextStyle(
        //color: Colors.white,
      ),
      validator:validator,
      keyboardType: type,
      controller:controller,
      decoration: InputDecoration(
        // labelStyle: TextStyle(
        //   color: Colors.white
        // ),
        border: OutlineInputBorder(
          borderRadius: BorderRadius.circular(30.0),
        ),
        enabledBorder: OutlineInputBorder(
          borderSide: BorderSide(
            color: Colors.white,
          ),
          borderRadius: BorderRadius.circular(30.0)
        ),
        labelText: lable,
        prefixIcon: Icon(prefix),
      ),
    );
  }
}
